package com.mulmeong.domain.place.dto.response;

/**
 * PAM-01 카드 "한눈에" 응답.
 */
public record OnsenCardResponse(
        Long onsenId,
        String name,
        SpecBadges specBadges,
        String benefitOneLine,
        String courseSummary,
        String directionsSummary
) {

    public record SpecBadges(
            Double waterTemp,
            String waterType,
            String accessLevel,
            Integer estimatedDurationMin
    ) {
    }
}
