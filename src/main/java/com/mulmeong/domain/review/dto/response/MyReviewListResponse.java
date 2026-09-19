package com.mulmeong.domain.review.dto.response;

import java.util.List;

public record MyReviewListResponse(List<MyReviewItem> content, int page, int size, long totalElements,
        int totalPages, boolean last, Filters filters) {

    public record Filters(List<MyReviewRegionFilter> regions) {
    }
}
