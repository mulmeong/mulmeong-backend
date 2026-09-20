package com.mulmeong.domain.place.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mulmeong.domain.place.dto.request.PoiCategory;
import com.mulmeong.domain.place.dto.response.CoordinateAddressResponse;
import com.mulmeong.domain.place.dto.response.ExternalCategoryPlaceResponse;
import com.mulmeong.domain.place.dto.response.ExternalKeywordSearchResponse;
import com.mulmeong.domain.place.dto.response.NearbyPlaceResponse;
import com.mulmeong.domain.place.dto.response.TourNearbyResponse;
import com.mulmeong.domain.place.dto.response.TourPlaceDetailResponse;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClient;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

// TourAPI의 외부 응답을 서비스 응답으로 변환한다.
@Component
@Slf4j
public class ExternalPlaceClient {
    private final RestClient restClient;
    private final ObjectMapper objectMapper;

    @Value("${external.tour-api.service-key:}")
    private String tourKey;

    @Value("${external.kakao.rest-api-key:}")
    private String kakaoKey;

    public ExternalPlaceClient(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
        this.restClient = RestClient.builder().build();
    }

    public List<NearbyPlaceResponse.Content> findNearby(double lat, double lng, int radius, String category) {
        if (tourKey.isBlank()) {
            return List.of();
        }
        return findTour(lat, lng, radius, category);
    }

    /**
     * TourAPI의 온천 검색 결과를 정기 동기화할 때 사용하는 최소 데이터만 반환한다.
     */
    public List<TourOnsenData> findOnsensForSync(int maxPages, int pageSize) {
        if (tourKey.isBlank()) return List.of();
        List<TourOnsenData> result = new ArrayList<>();
        try {
            for (int page = 1; page <= maxPages; page++) {
                int pageNo = page;
                String body = restClient.get().uri(uri -> uri.scheme("https").host("apis.data.go.kr")
                        .path("/B551011/KorService2/searchKeyword2")
                        .queryParam("serviceKey", tourKey).queryParam("MobileOS", "ETC")
                        .queryParam("MobileApp", "mulmeong").queryParam("keyword", "온천")
                        .queryParam("contentTypeId", 12).queryParam("arrange", "E")
                        .queryParam("numOfRows", pageSize).queryParam("pageNo", pageNo)
                        .queryParam("_type", "json").build()).retrieve().body(String.class);
                JsonNode items = objectMapper.readTree(body).path("response").path("body").path("items").path("item");
                if (!items.isArray() || items.isEmpty()) break;
                for (JsonNode item : items) {
                    String id = text(item, "contentid");
                    Double lat = decimal(item, "mapy");
                    Double lng = decimal(item, "mapx");
                    String name = text(item, "title");
                    if (id != null && name != null) {
                        result.add(new TourOnsenData(id, name, joinAddress(item), lat, lng,
                                text(item, "tel"), text(item, "homepage")));
                    }
                }
                if (items.size() < pageSize) break;
            }
            return result;
        } catch (Exception e) {
            log.warn("TourAPI onsen sync failed: {}", e.getMessage());
            return List.of();
        }
    }

    private static String joinAddress(JsonNode item) {
        String address = text(item, "addr1");
        String detail = text(item, "addr2");
        return address == null ? detail : detail == null ? address : address + " " + detail;
    }

    public record TourOnsenData(String externalId, String name, String address, Double lat, Double lng,
                                String phone, String homepageUrl) {
    }

    // 904 카테고리 POI 토글은 TourAPI를 실시간 호출한다.
    public ExternalCategoryPlaceResponse findByCategory(double lat, double lng, int radius,
                                                        PoiCategory category, int size) {
        int fetchSize = Math.min(Math.max(size * 3, size), 100);
        TourNearbyResponse response = findTourNearby(
                lat, lng, radius, category.getTourContentTypeId(), false, fetchSize
        );
        List<ExternalCategoryPlaceResponse.Item> items = response.items().stream()
                .filter(item -> category.matchesTitle(item.name()))
                .limit(size)
                .map(item -> new ExternalCategoryPlaceResponse.Item(
                        item.externalId(), item.contentTypeId(), item.name(), tourCategoryName(item.contentTypeId()), item.imageUrl(),
                        item.address(), item.phone(), item.lat(), item.lng(), item.distanceM(), item.description(),
                        item.homepageUrl()))
                .toList();
        return new ExternalCategoryPlaceResponse(category.name(), items);
    }

    public ExternalKeywordSearchResponse searchKeyword(String keyword, Double lat, Double lng, int size) {
        if (tourKey.isBlank()) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
        try {
            String body = restClient.get().uri(uri -> uri.scheme("https").host("apis.data.go.kr")
                    .path("/B551011/KorService2/searchKeyword2")
                    .queryParam("serviceKey", tourKey).queryParam("MobileOS", "ETC")
                    .queryParam("MobileApp", "mulmeong").queryParam("keyword", keyword)
                    .queryParam("arrange", "A").queryParam("numOfRows", size).queryParam("pageNo", 1)
                    .queryParam("_type", "json").build()).retrieve().body(String.class);
            JsonNode documents = objectMapper.readTree(body).path("response").path("body").path("items").path("item");
            List<ExternalKeywordSearchResponse.Item> places = new ArrayList<>();
            if (documents.isArray()) {
                for (JsonNode item : documents) {
                    places.add(new ExternalKeywordSearchResponse.Item("TOUR_" + text(item, "contentid"),
                            text(item, "title"), tourCategoryName(integer(item, "contenttypeid")), joinAddress(item),
                            decimal(item, "mapy"), decimal(item, "mapx"), meters(item, "dist")));
                }
            }
            return new ExternalKeywordSearchResponse(places);
        } catch (HttpClientErrorException.TooManyRequests e) {
            throw new BusinessException(ErrorCode.EXTERNAL_QUOTA_EXCEEDED);
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
    }

    public TourNearbyResponse findTourNearby(double lat, double lng, int radius, Integer contentTypeId,
                                             boolean withImageOnly, int size) {
        if (tourKey.isBlank()) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
        try {
            String body = restClient.get().uri(uri -> {
                        var builder = uri.scheme("https").host("apis.data.go.kr")
                                .path("/B551011/KorService2/locationBasedList2")
                                .queryParam("serviceKey", tourKey).queryParam("MobileOS", "ETC")
                                .queryParam("MobileApp", "mulmeong").queryParam("mapX", lng).queryParam("mapY", lat)
                                .queryParam("radius", radius).queryParam("numOfRows", size).queryParam("pageNo", 1)
                                .queryParam("_type", "json");
                        if (contentTypeId != null) {
                            builder.queryParam("contentTypeId", contentTypeId);
                        }
                        return builder.build();
                    }).retrieve().body(String.class);
            JsonNode responseBody = objectMapper.readTree(body).path("response").path("body");
            List<TourNearbyResponse.Item> items = new ArrayList<>();
            // 결과가 0건이면 TourAPI가 items를 배열이 아니라 빈 문자열로 준다.
            JsonNode source = responseBody.path("items").path("item");
            if (source.isArray()) {
                for (JsonNode item : source) {
                    String image = secureImageUrl(text(item, "firstimage"));
                    if (withImageOnly && image == null) {
                        continue;
                    }
                    items.add(new TourNearbyResponse.Item("TOUR_" + text(item, "contentid"),
                            text(item, "contentid"), integer(item, "contenttypeid"), text(item, "title"),
                            text(item, "overview"), image, secureImageUrl(text(item, "firstimage2")), joinAddress(item),
                            text(item, "tel"), text(item, "homepage"), decimal(item, "mapy"), decimal(item, "mapx"),
                            meters(item, "dist")));
                }
            }
            return new TourNearbyResponse(items, responseBody.path("totalCount").asInt());
        } catch (HttpClientErrorException.TooManyRequests e) {
            throw new BusinessException(ErrorCode.EXTERNAL_QUOTA_EXCEEDED);
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
    }

    public TourPlaceDetailResponse findTourDetail(String externalId, Integer contentTypeId) {
        if (tourKey.isBlank()) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
        String contentId = externalId.replaceFirst("^TOUR_", "");
        String body = null;
        try {
            body = restClient.get().uri(uri -> uri.scheme("https").host("apis.data.go.kr")
                    .path("/B551011/KorService2/detailCommon2")
                    .queryParam("serviceKey", tourKey).queryParam("MobileOS", "ETC")
                    .queryParam("MobileApp", "mulmeong").queryParam("contentId", contentId)
                    .queryParam("_type", "json").build()).retrieve().body(String.class);
            JsonNode source = objectMapper.readTree(body).path("response").path("body").path("items").path("item");
            JsonNode item = source.isArray() ? source.path(0) : source;
            if (item.isMissingNode() || item.isNull() || item.isTextual()) {
                log.warn("TourAPI detail returned no item for contentId={}, contentTypeId={}: {}",
                        contentId, contentTypeId, oneLine(body));
                throw new BusinessException(ErrorCode.PLACE_NOT_FOUND);
            }
            return new TourPlaceDetailResponse(
                    "TOUR_" + contentId, contentId, integer(item, "contenttypeid"), text(item, "title"),
                    text(item, "overview"), secureImageUrl(text(item, "firstimage")),
                    secureImageUrl(text(item, "firstimage2")), joinAddress(item),
                    text(item, "tel"), text(item, "homepage"), decimal(item, "mapy"), decimal(item, "mapx")
            );
        } catch (BusinessException e) {
            throw e;
        } catch (HttpClientErrorException.TooManyRequests e) {
            throw new BusinessException(ErrorCode.EXTERNAL_QUOTA_EXCEEDED);
        } catch (Exception e) {
            log.warn("TourAPI detail request failed for contentId={}, contentTypeId={}: {}",
                    contentId, contentTypeId, oneLine(body), e);
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
    }

    public CoordinateAddressResponse coord2address(double lat, double lng) {
        if (lat < 33 || lat > 39 || lng < 124 || lng > 132) {
            throw new BusinessException(ErrorCode.OUT_OF_SERVICE_AREA);
        }
        if (kakaoKey.isBlank()) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
        try {
            String body = restClient.get().uri(uri -> uri.scheme("https").host("dapi.kakao.com")
                            .path("/v2/local/geo/coord2address.json")
                            .queryParam("x", lng).queryParam("y", lat).build())
                    .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                    .retrieve().body(String.class);
            JsonNode document = objectMapper.readTree(body).path("documents").path(0);
            JsonNode address = document.path("address");
            JsonNode road = document.path("road_address");
            String roadAddress = text(road, "address_name");
            String jibunAddress = text(address, "address_name");
            String label = roadAddress == null ? jibunAddress : roadAddress;
            Region region = region(lat, lng);
            return new CoordinateAddressResponse(lat, lng, roadAddress, jibunAddress,
                    region.sido(), region.sigungu(), region.code(), label);
        } catch (HttpClientErrorException.TooManyRequests e) {
            throw new BusinessException(ErrorCode.EXTERNAL_QUOTA_EXCEEDED);
        } catch (Exception e) {
            log.warn("Kakao coord2address request failed for lat={}, lng={}: {}", lat, lng, e.getMessage());
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
    }

    private Region region(double lat, double lng) throws Exception {
        String body = restClient.get().uri(uri -> uri.scheme("https").host("dapi.kakao.com")
                        .path("/v2/local/geo/coord2regioncode.json")
                        .queryParam("x", lng).queryParam("y", lat).build())
                .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                .retrieve().body(String.class);
        JsonNode documents = objectMapper.readTree(body).path("documents");
        JsonNode legal = documents.path(0);
        for (JsonNode document : documents) {
            if ("B".equals(text(document, "region_type"))) {
                legal = document;
                break;
            }
        }
        String bCode = text(legal, "code");
        String regionCode = bCode == null || bCode.length() < 5 ? bCode : bCode.substring(0, 5);
        return new Region(text(legal, "region_1depth_name"), text(legal, "region_2depth_name"), regionCode);
    }

    private static String oneLine(String body) {
        if (body == null) {
            return "null";
        }
        String normalized = body.replaceAll("\\s+", " ");
        return normalized.length() <= 2_000 ? normalized : normalized.substring(0, 2_000) + "...";
    }

    private record Region(String sido, String sigungu, String code) {
    }

    private List<NearbyPlaceResponse.Content> findTour(double lat, double lng, int radius, String category) {
        try {
            Integer contentTypeId = nearbyContentTypeId(category);
            String body = restClient.get().uri(uri -> {
                var builder = uri.scheme("https").host("apis.data.go.kr")
                        .path("/B551011/KorService2/locationBasedList2")
                        .queryParam("serviceKey", tourKey).queryParam("MobileOS", "ETC")
                        .queryParam("MobileApp", "mulmeong").queryParam("mapX", lng).queryParam("mapY", lat)
                        .queryParam("radius", radius).queryParam("arrange", "E")
                        .queryParam("numOfRows", 20).queryParam("pageNo", 1).queryParam("_type", "json");
                if (contentTypeId != null) {
                    builder.queryParam("contentTypeId", contentTypeId);
                }
                return builder.build();
            }).retrieve().body(String.class);
            JsonNode items = objectMapper.readTree(body).path("response").path("body").path("items").path("item");
            List<NearbyPlaceResponse.Content> result = new ArrayList<>();
            if (!items.isArray()) {
                return result;
            }
            for (JsonNode item : items) {
                String image = secureImageUrl(text(item, "firstimage"));
                if (image == null || ("cafe".equals(category) && !isCafe(item))) {
                    continue;
                }
                result.add(new NearbyPlaceResponse.Content(
                        "TOUR", tourCategoryName(integer(item, "contenttypeid")), text(item, "contentid"), null,
                        text(item, "title"), image, decimal(item, "mapy"), decimal(item, "mapx"),
                        meters(item, "dist"), joinAddress(item), text(item, "tel"), text(item, "homepage"), null
                ));
            }
            return result.stream().sorted(Comparator.comparing(NearbyPlaceResponse.Content::distanceM,
                    Comparator.nullsLast(Comparator.naturalOrder()))).toList();
        } catch (Exception e) {
            log.warn("TourAPI nearby request failed: {}", e.getMessage());
            return List.of();
        }
    }

    private Integer nearbyContentTypeId(String category) {
        return switch (category) {
            case "tour" -> 12;
            case "food", "cafe" -> 39;
            default -> null;
        };
    }

    private boolean isCafe(JsonNode item) {
        String title = text(item, "title");
        return title != null && (title.contains("카페") || title.toLowerCase().contains("cafe"));
    }

    private String tourCategoryName(Integer contentTypeId) {
        if (contentTypeId == null) return "관광";
        return switch (contentTypeId) {
            case 12 -> "관광지";
            case 14 -> "문화시설";
            case 15 -> "축제·행사";
            case 25 -> "여행코스";
            case 28 -> "레저";
            case 32 -> "숙소";
            case 38 -> "쇼핑";
            case 39 -> "맛집";
            default -> "관광";
        };
    }

    private static String text(JsonNode node, String field) {
        String value = node.path(field).asText(null);
        return value == null || value.isBlank() ? null : value;
    }

    private static String secureImageUrl(String imageUrl) {
        if (imageUrl != null && imageUrl.startsWith("http://tong.visitkorea.or.kr/")) {
            return "https://" + imageUrl.substring("http://".length());
        }
        return imageUrl;
    }

    private static Double decimal(JsonNode node, String field) {
        String value = text(node, field);
        try {
            return value == null ? null : Double.valueOf(value);
        } catch (NumberFormatException ignored) {
            return null;
        }
    }

    /**
     * TourAPI의 dist는 "329.3718495180123"처럼 소수 문자열로 와서 정수 파싱이 실패한다.
     */
    private static Integer meters(JsonNode node, String field) {
        Double value = decimal(node, field);
        return value == null ? null : (int) Math.round(value);
    }

    private static Integer integer(JsonNode node, String field) {
        String value = text(node, field);
        try {
            return value == null ? null : Integer.valueOf(value);
        } catch (NumberFormatException ignored) {
            return null;
        }
    }
}
