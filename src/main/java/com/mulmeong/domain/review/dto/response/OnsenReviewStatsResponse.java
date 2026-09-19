package com.mulmeong.domain.review.dto.response;

import java.util.List;
import java.util.Map;

public record OnsenReviewStatsResponse(Long onsenId, long reviewCount, Double avgRating,
                                       Map<String, Long> ratingDistribution, Specs specs, VisitTime visitTime,
                                       List<String> highlights) {
    public record Specs(Metric clean, Metric crowd, Metric facility) {
    }

    public record Metric(Double avg, String label) {
    }

    public record VisitTime(Map<String, Long> counts, String topLabel) {
    }
}
