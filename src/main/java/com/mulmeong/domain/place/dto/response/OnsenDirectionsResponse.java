package com.mulmeong.domain.place.dto.response;

import java.util.List;

/**
 * 203 가는 법 응답. 출발지→거점역은 903(카카오)에 위임하고, 거점역→온천은 팀 수기 데이터를 쓴다.
 */
public record OnsenDirectionsResponse(
        Long onsenId,
        NearestStation nearestStation,
        List<Leg> legs,
        Integer totalDurationMin,
        String kakaoDeepLink
) {

    public record NearestStation(String name, Double lat, Double lng) {
    }

    public record Leg(
            int seq,
            String type,
            String source,
            String mode,
            Integer distanceM,
            Integer durationMin,
            String summary,
            List<List<Double>> path
    ) {
    }
}
