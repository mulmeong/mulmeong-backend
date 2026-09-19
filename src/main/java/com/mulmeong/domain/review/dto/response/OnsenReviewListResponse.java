package com.mulmeong.domain.review.dto.response;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;

public record OnsenReviewListResponse(List<Item> content, int page, int size, long totalElements, int totalPages, boolean last) {
    public record Item(Long reviewId, Author author, short rating, LocalDate visitedAt, boolean isRevisit,
            Spec spec, String body, List<String> images, boolean isMine, boolean isEdited, OffsetDateTime createdAt) {}
    public record Author(String nickname, Integer level, String title, String profileShareToken) {}
    public record Spec(String visitTime, short clean, short crowd, short facility) {}
}
