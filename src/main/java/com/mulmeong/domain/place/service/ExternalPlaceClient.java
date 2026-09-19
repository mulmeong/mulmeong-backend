package com.mulmeong.domain.place.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mulmeong.domain.place.dto.request.PoiCategory;
import com.mulmeong.domain.place.dto.response.ExternalCategoryPlaceResponse;
import com.mulmeong.domain.place.dto.response.ExternalKeywordSearchResponse;
import com.mulmeong.domain.place.dto.response.NearbyPlaceResponse;
import com.mulmeong.domain.place.dto.response.CoordinateAddressResponse;
import com.mulmeong.domain.place.dto.response.TourNearbyResponse;
import com.mulmeong.domain.place.entity.Place;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClient;

import java.util.ArrayList;
import java.util.List;

/**
 * Kakao Local과 TourAPI의 외부 응답을 nearby 공통 응답으로 변환한다.
 */
@Component
@Slf4j
public class ExternalPlaceClient {
    private static final String TOUR_URL = "https://apis.data.go.kr/B551011/KorService2/locationBasedList2";
    private static final String KAKAO_URL = "https://dapi.kakao.com/v2/local/search/category.json";

    private final RestClient restClient;
    private final ObjectMapper objectMapper;

    @Value("${external.kakao.rest-api-key:}")
    private String kakaoKey;
    @Value("${external.tour-api.service-key:}")
    private String tourKey;

    public ExternalPlaceClient(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
        this.restClient = RestClient.builder().build();
    }

    public List<NearbyPlaceResponse.Content> findNearby(double lat, double lng, int radius, String category) {
        List<NearbyPlaceResponse.Content> result = new ArrayList<>();
        if (("all".equals(category) || "tour".equals(category)) && !tourKey.isBlank()) {
            result.addAll(findTour(lat, lng, radius));
        }
        if (("all".equals(category) || "food".equals(category) || "cafe".equals(category))
                && !kakaoKey.isBlank()) {
            result.addAll(findKakao(lat, lng, radius, category));
        }
        return result;
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

    /**
     * 904 카테고리 POI 토글. 프론트가 직접 호출하는 API라 nearby(204)와 달리 실패를 그대로 노출한다.
     */
    public ExternalCategoryPlaceResponse findByCategory(double lat, double lng, int radius, PoiCategory category, int size) {
        if (kakaoKey.isBlank()) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
        try {
            String body = category.getKakaoGroupCode() != null
                    ? categorySearch(lat, lng, radius, category.getKakaoGroupCode(), size)
                    : keywordSearch(lat, lng, radius, "공원", size);
            JsonNode documents = objectMapper.readTree(body).path("documents");
            List<ExternalCategoryPlaceResponse.Item> items = new ArrayList<>();
            if (documents.isArray()) {
                for (JsonNode item : documents) {
                    items.add(new ExternalCategoryPlaceResponse.Item(
                            text(item, "id"), text(item, "place_name"), text(item, "category_name"),
                            text(item, "road_address_name"), text(item, "phone"),
                            decimal(item, "y"), decimal(item, "x"), integer(item, "distance"),
                            text(item, "place_url")));
                }
            }
            return new ExternalCategoryPlaceResponse(category.name(), items);
        } catch (HttpClientErrorException.TooManyRequests e) {
            throw new BusinessException(ErrorCode.EXTERNAL_QUOTA_EXCEEDED);
        } catch (Exception e) {
            log.warn("Kakao category search failed: {}", e.getMessage());
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
    }

    public ExternalKeywordSearchResponse searchKeyword(String keyword, Double lat, Double lng, int size) {
        if (kakaoKey.isBlank()) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
        try {
            String body = restClient.get().uri(uri -> {
                        var builder = uri.scheme("https").host("dapi.kakao.com")
                                .path("/v2/local/search/keyword.json").queryParam("query", keyword)
                                .queryParam("size", size);
                        if (lat != null && lng != null) {
                            builder.queryParam("x", lng).queryParam("y", lat).queryParam("sort", "distance");
                        }
                        return builder.build();
                    }).header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey).retrieve().body(String.class);
            JsonNode documents = objectMapper.readTree(body).path("documents");
            List<ExternalKeywordSearchResponse.Item> places = new ArrayList<>();
            if (documents.isArray()) {
                for (JsonNode item : documents) {
                    places.add(new ExternalKeywordSearchResponse.Item("KAKAO_" + text(item, "id"),
                            text(item, "place_name"), text(item, "category_name"), text(item, "road_address_name"),
                            decimal(item, "y"), decimal(item, "x"), integer(item, "distance")));
                }
            }
            return new ExternalKeywordSearchResponse(places);
        } catch (HttpClientErrorException.TooManyRequests e) {
            throw new BusinessException(ErrorCode.EXTERNAL_QUOTA_EXCEEDED);
        } catch (Exception e) {
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
                            .path("/v2/local/geo/coord2address.json").queryParam("x", lng).queryParam("y", lat).build())
                    .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey).retrieve().body(String.class);
            JsonNode document = objectMapper.readTree(body).path("documents").path(0);
            JsonNode address = document.path("address");
            JsonNode road = document.path("road_address");
            String roadAddress = text(road, "address_name");
            String jibunAddress = text(address, "address_name");
            String label = roadAddress == null ? jibunAddress : roadAddress;
            // 법정동 코드(b_code)는 coord2address 응답에 없다. 시도 정식명칭도 여기선 "서울"처럼 줄어서 온다.
            Region region = region(lat, lng);
            return new CoordinateAddressResponse(lat, lng, roadAddress, jibunAddress,
                    region.sido(), region.sigungu(), region.code(), label);
        } catch (HttpClientErrorException.TooManyRequests e) {
            throw new BusinessException(ErrorCode.EXTERNAL_QUOTA_EXCEEDED);
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
    }

    /**
     * 좌표의 행정구역. 902가 내려주는 sido·sigungu·regionCode는 서로 어긋나지 않게 모두 여기서 받는다.
     */
    private Region region(double lat, double lng) throws Exception {
        String body = restClient.get().uri(uri -> uri.scheme("https").host("dapi.kakao.com")
                        .path("/v2/local/geo/coord2regioncode.json")
                        .queryParam("x", lng).queryParam("y", lat).build())
                .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey).retrieve().body(String.class);
        JsonNode documents = objectMapper.readTree(body).path("documents");
        JsonNode legal = documents.path(0);
        for (JsonNode document : documents) {
            // region_type B가 법정동이다 (H는 행정동이라 코드 체계가 다르다).
            if ("B".equals(text(document, "region_type"))) {
                legal = document;
                break;
            }
        }
        String bCode = text(legal, "code");
        // 명세의 regionCode는 시도(2) + 시군구(3) 5자리다. b_code는 법정동까지 10자리로 온다.
        String regionCode = bCode == null || bCode.length() < 5 ? bCode : bCode.substring(0, 5);
        return new Region(text(legal, "region_1depth_name"), text(legal, "region_2depth_name"), regionCode);
    }

    private record Region(String sido, String sigungu, String code) {
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
                    String image = text(item, "firstimage");
                    if (withImageOnly && image == null) {
                        continue;
                    }
                    items.add(new TourNearbyResponse.Item("TOUR_" + text(item, "contentid"),
                            text(item, "contentid"), integer(item, "contenttypeid"), text(item, "title"),
                            text(item, "overview"), image, text(item, "firstimage2"), joinAddress(item),
                            decimal(item, "mapy"), decimal(item, "mapx"), meters(item, "dist")));
                }
            }
            return new TourNearbyResponse(items, responseBody.path("totalCount").asInt());
        } catch (HttpClientErrorException.TooManyRequests e) {
            throw new BusinessException(ErrorCode.EXTERNAL_QUOTA_EXCEEDED);
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
    }

    private String categorySearch(double lat, double lng, int radius, String groupCode, int size) {
        return restClient.get().uri(uri -> uri.scheme("https").host("dapi.kakao.com")
                        .path("/v2/local/search/category.json").queryParam("category_group_code", groupCode)
                        .queryParam("x", lng).queryParam("y", lat).queryParam("radius", radius)
                        .queryParam("sort", "distance").queryParam("size", size).build())
                .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                .retrieve().body(String.class);
    }

    private String keywordSearch(double lat, double lng, int radius, String keyword, int size) {
        return restClient.get().uri(uri -> uri.scheme("https").host("dapi.kakao.com")
                        .path("/v2/local/search/keyword.json").queryParam("query", keyword)
                        .queryParam("x", lng).queryParam("y", lat).queryParam("radius", radius)
                        .queryParam("sort", "distance").queryParam("size", size).build())
                .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                .retrieve().body(String.class);
    }

    /**
     * 주소 좌표가 비어 있는 온천을 지도 응답 전에 보정한다. 성공한 좌표는 DB에도 저장해 재호출 비용을 줄인다.
     */
    public void geocode(Place place) {
        if (place.getAddress() == null || place.getAddress().isBlank() || kakaoKey.isBlank()) return;
        try {
            String body = restClient.get().uri(uri -> uri.scheme("https").host("dapi.kakao.com")
                            .path("/v2/local/search/address.json").queryParam("query", place.getAddress()).build())
                    .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                    .retrieve().body(String.class);
            JsonNode document = objectMapper.readTree(body).path("documents").path(0);
            Double lat = decimal(document, "y");
            Double lng = decimal(document, "x");
            if (lat != null && lng != null) place.updateCoordinates(lat, lng);
        } catch (Exception e) {
            log.warn("Kakao geocoding failed for place {}: {}", place.getId(), e.getMessage());
        }
    }

    private List<NearbyPlaceResponse.Content> findTour(double lat, double lng, int radius) {
        try {
            String body = restClient.get().uri(uri -> uri.scheme("https").host("apis.data.go.kr")
                    .path("/B551011/KorService2/locationBasedList2")
                    .queryParam("serviceKey", tourKey).queryParam("MobileOS", "ETC")
                    .queryParam("MobileApp", "mulmung").queryParam("mapX", lng).queryParam("mapY", lat)
                    .queryParam("radius", radius).queryParam("contentTypeId", 12)
                    .queryParam("arrange", "E").queryParam("numOfRows", 20).queryParam("pageNo", 1)
                    .queryParam("_type", "json").build()).retrieve().body(String.class);
            JsonNode items = objectMapper.readTree(body).path("response").path("body").path("items").path("item");
            List<NearbyPlaceResponse.Content> result = new ArrayList<>();
            if (!items.isArray()) return result;
            for (JsonNode item : items) {
                String image = text(item, "firstimage");
                if (image == null) continue;
                result.add(new NearbyPlaceResponse.Content("TOUR", "관광지", text(item, "contentid"), null,
                        text(item, "title"), image, decimal(item, "mapy"), decimal(item, "mapx"),
                        integer(item, "dist"), text(item, "addr1"), null, null, null));
            }
            return result;
        } catch (Exception e) {
            log.warn("TourAPI nearby request failed: {}", e.getMessage());
            return List.of();
        }
    }

    private List<NearbyPlaceResponse.Content> findKakao(double lat, double lng, int radius, String category) {
        try {
            List<String> groups = "food".equals(category) ? List.of("FD6")
                    : "cafe".equals(category) ? List.of("CE7") : List.of("FD6", "CE7");
            List<NearbyPlaceResponse.Content> result = new ArrayList<>();
            for (String group : groups) {
                String body = restClient.get().uri(uri -> uri.scheme("https").host("dapi.kakao.com")
                                .path("/v2/local/search/category.json").queryParam("category_group_code", group)
                                .queryParam("x", lng).queryParam("y", lat).queryParam("radius", radius)
                                .queryParam("sort", "distance").queryParam("size", 15).build())
                        .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                        .retrieve().body(String.class);
                JsonNode documents = objectMapper.readTree(body).path("documents");
                if (!documents.isArray()) continue;
                for (JsonNode item : documents) {
                    // 카카오 로컬은 사진을 주지 않는다 (응답에 이미지 필드 자체가 없음).
                    // place_url을 image에 넣으면 프론트의 <img>가 깨지므로 null로 둬서 폴백을 태운다.
                    result.add(new NearbyPlaceResponse.Content("KAKAO",
                            "FD6".equals(group) ? "맛집" : "카페", null, text(item, "id"),
                            text(item, "place_name"), null, decimal(item, "y"), decimal(item, "x"),
                            integer(item, "distance"), text(item, "road_address_name"), text(item, "phone"),
                            text(item, "place_url"), text(item, "category_name")));
                }
            }
            return result;
        } catch (Exception e) {
            log.warn("Kakao Local nearby request failed: {}", e.getMessage());
            return List.of();
        }
    }

    private static String text(JsonNode node, String field) {
        String value = node.path(field).asText(null);
        return value == null || value.isBlank() ? null : value;
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
