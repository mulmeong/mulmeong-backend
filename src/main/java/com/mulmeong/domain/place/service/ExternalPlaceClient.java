package com.mulmeong.domain.place.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mulmeong.domain.place.dto.response.NearbyPlaceResponse;
import com.mulmeong.domain.place.entity.Place;
import lombok.extern.slf4j.Slf4j;

/** Kakao Local과 TourAPI의 외부 응답을 nearby 공통 응답으로 변환한다. */
@Component
@Slf4j
public class ExternalPlaceClient {
    private static final String TOUR_URL = "https://apis.data.go.kr/B551011/KorService2/locationBasedList2";
    private static final String KAKAO_URL = "https://dapi.kakao.com/v2/local/search/category.json";

    private final RestClient restClient;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${external.kakao.rest-api-key:}") private String kakaoKey;
    @Value("${external.tour-api.service-key:}") private String tourKey;

    public ExternalPlaceClient() {
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

    /** 주소 좌표가 비어 있는 온천을 지도 응답 전에 보정한다. 성공한 좌표는 DB에도 저장해 재호출 비용을 줄인다. */
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
                    result.add(new NearbyPlaceResponse.Content("KAKAO",
                            "FD6".equals(group) ? "맛집" : "카페", null, text(item, "id"),
                            text(item, "place_name"), text(item, "place_url"), decimal(item, "y"), decimal(item, "x"),
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
        try { return value == null ? null : Double.valueOf(value); }
        catch (NumberFormatException ignored) { return null; }
    }

    private static Integer integer(JsonNode node, String field) {
        String value = text(node, field);
        try { return value == null ? null : Integer.valueOf(value); }
        catch (NumberFormatException ignored) { return null; }
    }
}
