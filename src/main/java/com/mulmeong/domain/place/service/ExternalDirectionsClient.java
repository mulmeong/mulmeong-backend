package com.mulmeong.domain.place.service;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mulmeong.domain.place.dto.response.OnsenDirectionsResponse;
import lombok.extern.slf4j.Slf4j;

/** 카카오모빌리티 자동차 길찾기 응답을 온천 API의 originToStation으로 변환한다. */
@Component
@Slf4j
public class ExternalDirectionsClient {
    private final RestClient restClient;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${external.kakao.rest-api-key:}") private String kakaoKey;

    public ExternalDirectionsClient() {
        this.restClient = RestClient.builder().build();
    }

    public OnsenDirectionsResponse.OriginToStation route(String mode,
            Double originLat, Double originLng, Double destinationLat, Double destinationLng) {
        if (kakaoKey.isBlank()) {
            log.warn("Kakao directions skipped: API key is not configured");
            return null;
        }
        if (originLat == null || originLng == null || destinationLat == null || destinationLng == null) {
            log.warn("Kakao directions skipped: coordinates are missing");
            return null;
        }
        try {
            String normalized = mode == null ? "TRANSIT" : mode.toUpperCase(Locale.ROOT);
            String body;
            JsonNode root;
            if ("CAR".equals(normalized)) {
                body = restClient.get().uri(uri -> uri.scheme("https")
                        .host("apis-navi.kakaomobility.com").path("/v1/directions")
                        .queryParam("origin", point(originLng, originLat))
                        .queryParam("destination", point(destinationLng, destinationLat))
                        .queryParam("summary", true).build())
                        .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                        .retrieve().body(String.class);
                root = objectMapper.readTree(body).path("routes").path(0).path("summary");
            } else {
                String path = switch (normalized) {
                    case "TRANSIT" -> "/v2/routing/publictraffic";
                    case "WALK" -> "/v2/routing/walk";
                    case "BICYCLE", "BIKE" -> "/v2/routing/bicycle";
                    default -> throw new IllegalArgumentException("unsupported mode");
                };
                body = restClient.get().uri(uri -> uri.scheme("https")
                        .host("dapi.kakao.com").path(path)
                        .queryParam("start_x", originLng).queryParam("start_y", originLat)
                        .queryParam("end_x", destinationLng).queryParam("end_y", destinationLat)
                        .queryParam("input_coord", "WGS84").queryParam("output_coord", "WGS84").build())
                        .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                        .retrieve().body(String.class);
                JsonNode parsed = objectMapper.readTree(body);
                root = "TRANSIT".equals(normalized)
                        ? parsed.path("routes").path(0).path("properties")
                        : parsed.path("route").path("properties");
                String landingUrl = root.path("landingUrl").asText(null);
                if (landingUrl == null) {
                    landingUrl = root.path("landingURL").asText(null);
                }
                if (landingUrl != null) {
                    return toOriginToStation(normalized, root, landingUrl);
                }
            }
            if (root.isMissingNode()) return null;
            int distanceM = root.has("distance") ? root.path("distance").asInt(0)
                    : root.path("totalDistance").asInt(0);
            int durationSec = root.has("duration") ? root.path("duration").asInt(0)
                    : root.path("totalTime").asInt(0);
            String deepLink = String.format(Locale.ROOT,
                    "https://map.kakao.com/link/from/출발지,%f,%f/to/거점역,%f,%f",
                    originLat, originLng, destinationLat, destinationLng);
            return toOriginToStation(normalized, root, deepLink, distanceM, durationSec);
        } catch (Exception e) {
            log.warn("Kakao directions request failed: {}", e.getMessage());
            return null;
        }
    }

    private OnsenDirectionsResponse.OriginToStation toOriginToStation(String mode, JsonNode root, String deepLink) {
        int distanceM = root.path("totalDistance").asInt(0);
        int durationSec = root.path("totalTime").asInt(0);
        if (distanceM <= 0 || durationSec <= 0) return null;
        return toOriginToStation(mode, root, deepLink, distanceM, durationSec);
    }

        private OnsenDirectionsResponse.OriginToStation toOriginToStation(String mode, JsonNode root,
            String deepLink, int distanceM, int durationSec) {
            return new OnsenDirectionsResponse.OriginToStation(
                    "BIKE".equals(mode) ? "BICYCLE" : mode,
                    distanceM / 1000.0, (int) Math.max(1, Math.round(durationSec / 60f)), deepLink);
    }

    private static String point(Double lng, Double lat) {
        return String.format(Locale.ROOT, "%.7f,%.7f", lng, lat);
    }
}
