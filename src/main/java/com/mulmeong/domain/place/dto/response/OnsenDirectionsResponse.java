package com.mulmeong.domain.place.dto.response;

/** PAM-02 가는 법 응답. */
public record OnsenDirectionsResponse(
        String nearestStation,
        StationToOnsen stationToOnsen,
        OriginToStation originToStation
) {
    public record StationToOnsen(String description, Integer durationMin) {}
    public record OriginToStation(
            String transport, Double distanceKm, Integer durationMin, String kakaoDeepLink) {}
}
