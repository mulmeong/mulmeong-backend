package com.mulmeong.domain.place.dto.response;

import java.util.List;

/** 903 길찾기 프록시 응답(정규화). mode와 무관하게 프론트는 같은 필드로 렌더링한다. */
public record ExternalDirectionsResponse(
        String mode,
        Integer distanceM,
        Integer durationMin,
        Integer walkDurationMin,
        Integer totalDurationMin,
        Integer fare,
        String summary,
        List<Step> steps,
        List<List<Double>> path
) {

    public record Step(int seq, String type, Integer durationMin, Integer distanceM, String description) {
    }
}
