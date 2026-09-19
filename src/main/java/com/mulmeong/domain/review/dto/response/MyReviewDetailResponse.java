package com.mulmeong.domain.review.dto.response;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;

public record MyReviewDetailResponse(Long reviewId, Onsen onsen, int rating, LocalDate visitedAt, Spec spec,
        String body, List<Image> images, OffsetDateTime createdAt, OffsetDateTime updatedAt, boolean isRevisit) {

    public record Onsen(Long onsenId, String name, String address, Double lat, Double lng, String thumbnail) {
    }

    public record Spec(String visitTime, Short clean, Short crowd, Short facility) {
    }

    public record Image(String url, String thumbnailUrl) {
    }
}
