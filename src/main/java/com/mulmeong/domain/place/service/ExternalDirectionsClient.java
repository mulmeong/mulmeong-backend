package com.mulmeong.domain.place.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mulmeong.domain.place.dto.response.ExternalDirectionsResponse;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClient;

import java.util.List;
import java.util.Locale;

/**
 * 903 길찾기 프록시. 카카오모빌리티(CAR)와 카카오맵(TRANSIT·WALK·BIKE) 응답을 정규화된 형태로 합쳐준다.
 */
@Component
@Slf4j
public class ExternalDirectionsClient {

    private final RestClient restClient;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${external.kakao.rest-api-key:}")
    private String kakaoKey;

    public ExternalDirectionsClient() {
        this.restClient = RestClient.builder().build();
    }

    public ExternalDirectionsResponse route(String mode, double originLat, double originLng,
                                            double destLat, double destLng, boolean includePath) {
        String normalized = normalizeMode(mode);
        if (kakaoKey.isBlank()) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
        try {
            return switch (normalized) {
                case "CAR" -> carRoute(originLat, originLng, destLat, destLng, includePath);
                case "WALK" ->
                        simpleRoute("WALK", "/v2/routing/walk", originLat, originLng, destLat, destLng, includePath);
                case "BICYCLE" ->
                        simpleRoute("BICYCLE", "/v2/routing/bicycle", originLat, originLng, destLat, destLng, includePath);
                default -> transitRoute(originLat, originLng, destLat, destLng, includePath);
            };
        } catch (BusinessException e) {
            throw e;
        } catch (HttpClientErrorException.TooManyRequests e) {
            throw new BusinessException(ErrorCode.EXTERNAL_QUOTA_EXCEEDED);
        } catch (Exception e) {
            log.warn("Kakao directions request failed: {}", e.getMessage());
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
    }

    private String normalizeMode(String mode) {
        String normalized = mode == null ? "TRANSIT" : mode.toUpperCase(Locale.ROOT);
        if ("BIKE".equals(normalized)) normalized = "BICYCLE";
        if (!List.of("CAR", "TRANSIT", "WALK", "BICYCLE").contains(normalized)) {
            throw new BusinessException(ErrorCode.INVALID_MODE);
        }
        return normalized;
    }

    private ExternalDirectionsResponse carRoute(double originLat, double originLng,
                                                double destLat, double destLng, boolean includePath) throws Exception {
        String body = restClient.get().uri(uri -> uri.scheme("https")
                        .host("apis-navi.kakaomobility.com").path("/v1/directions")
                        .queryParam("origin", point(originLng, originLat))
                        .queryParam("destination", point(destLng, destLat))
                        .queryParam("summary", true).build())
                .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                .retrieve().body(String.class);
        JsonNode routes = objectMapper.readTree(body).path("routes");
        if (!routes.isArray() || routes.isEmpty()) throw new BusinessException(ErrorCode.ROUTE_NOT_FOUND);
        JsonNode route = routes.path(0);
        JsonNode summary = route.path("summary");
        int distanceM = summary.path("distance").asInt(0);
        int durationSec = summary.path("duration").asInt(0);
        Integer fare = summary.has("fare") ? summary.path("fare").path("toll").asInt(0) : null;
        List<List<Double>> path = includePath ? straightPath(originLat, originLng, destLat, destLng) : List.of();
        return new ExternalDirectionsResponse("CAR", distanceM, minutes(durationSec), null, minutes(durationSec),
                fare, null, List.of(), path);
    }

    private ExternalDirectionsResponse simpleRoute(String responseMode, String path, double originLat, double originLng,
                                                   double destLat, double destLng, boolean includePath) {
        Leg leg = kakaoMapRoute(path, originLat, originLng, destLat, destLng);
        List<List<Double>> routePath = includePath ? straightPath(originLat, originLng, destLat, destLng) : List.of();
        return new ExternalDirectionsResponse(responseMode, leg.distanceM(), leg.durationMin(), null,
                leg.durationMin(), null, null, List.of(), routePath);
    }

    private ExternalDirectionsResponse transitRoute(double originLat, double originLng,
                                                    double destLat, double destLng, boolean includePath) throws Exception {
        String body = restClient.get().uri(uri -> uri.scheme("https")
                        .host("dapi.kakao.com").path("/v2/routing/publictraffic")
                        .queryParam("start_x", originLng).queryParam("start_y", originLat)
                        .queryParam("end_x", destLng).queryParam("end_y", destLat)
                        .queryParam("input_coord", "WGS84").queryParam("output_coord", "WGS84").build())
                .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                .retrieve().body(String.class);
        JsonNode routes = objectMapper.readTree(body).path("routes");
        if (!routes.isArray() || routes.isEmpty()) throw new BusinessException(ErrorCode.ROUTE_NOT_FOUND);
        JsonNode properties = routes.path(0).path("properties");
        int distanceM = properties.path("totalDistance").asInt(0);
        int durationMin = minutes(properties.path("totalTime").asInt(0));
        String summary = properties.path("summary").asText(null);
        Integer fare = properties.has("payment") ? properties.path("payment").path("regular").path("totalFare").asInt(0) : null;

        // 대중교통 응답엔 첫 승차/마지막 하차 정류장 좌표가 없어 도보 구간을 보정할 수 없다.
        // 명세의 실패 폴백(walkDurationMin: null, totalDurationMin = durationMin)을 그대로 적용한다.
        Integer walkDurationMin = null;
        int totalDurationMin = durationMin;
        List<ExternalDirectionsResponse.Step> steps = List.of(
                new ExternalDirectionsResponse.Step(1, "TRANSIT", durationMin, distanceM, summary)
        );
        List<List<Double>> path = includePath ? straightPath(originLat, originLng, destLat, destLng) : List.of();
        return new ExternalDirectionsResponse("TRANSIT", distanceM, durationMin, walkDurationMin, totalDurationMin,
                fare, summary, steps, path);
    }

    private Leg kakaoMapRoute(String path, double originLat, double originLng, double destLat, double destLng) {
        String body = restClient.get().uri(uri -> uri.scheme("https")
                        .host("dapi.kakao.com").path(path)
                        .queryParam("start_x", originLng).queryParam("start_y", originLat)
                        .queryParam("end_x", destLng).queryParam("end_y", destLat)
                        .queryParam("input_coord", "WGS84").queryParam("output_coord", "WGS84").build())
                .header(HttpHeaders.AUTHORIZATION, "KakaoAK " + kakaoKey)
                .retrieve().body(String.class);
        JsonNode parsed;
        try {
            parsed = objectMapper.readTree(body);
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.EXTERNAL_API_FAILED);
        }
        JsonNode properties = parsed.path("route").path("properties");
        int distanceM = properties.path("totalDistance").asInt(0);
        int durationMin = minutes(properties.path("totalTime").asInt(0));
        return new Leg(distanceM, durationMin);
    }

    private record Leg(int distanceM, int durationMin) {
    }

    private static int minutes(int seconds) {
        return seconds <= 0 ? 0 : (int) Math.max(1, Math.round(seconds / 60f));
    }

    private static List<List<Double>> straightPath(double originLat, double originLng, double destLat, double destLng) {
        return List.of(List.of(originLat, originLng), List.of(destLat, destLng));
    }

    private static String point(Double lng, Double lat) {
        return String.format(Locale.ROOT, "%.7f,%.7f", lng, lat);
    }
}
