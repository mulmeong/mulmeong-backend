package com.mulmeong.domain.review.dto.response;

import java.time.LocalDate;
import java.time.OffsetDateTime;

public record ReviewCreateResponse(Long reviewId, Long onsenId, LocalDate visitedAt, OffsetDateTime createdAt,
                                   Reward reward) {
    public record Reward(boolean isFirstVisit, String sidoCode, String sigunguCode, String regionName,
                         int grapeCountAfter, int visitedOnsenCount, boolean levelUp, int levelBefore, int levelAfter,
                         String titleAfter) {
    }
}
