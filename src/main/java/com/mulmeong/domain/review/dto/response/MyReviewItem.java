package com.mulmeong.domain.review.dto.response;

import java.time.LocalDate;
import java.time.OffsetDateTime;

public record MyReviewItem(Long reviewId, MyReviewOnsenSummary onsen, int rating, String bodyPreview,
        long imageCount, String firstImage, LocalDate visitedAt, boolean isRevisit, OffsetDateTime createdAt) {
}
