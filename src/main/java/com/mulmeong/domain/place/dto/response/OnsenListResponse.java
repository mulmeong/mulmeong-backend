package com.mulmeong.domain.place.dto.response;

import java.util.List;

public record OnsenListResponse(List<Item> content, int page, int size, long totalElements, int totalPages) {
    public record Item(Long onsenId, String name, String sido, String sigungu, String address,
            Double lat, Double lng, boolean isRegistered, Double waterTemp, String waterType,
            String accessLevel, String accessLevelLabel, String thumbnail,
            long reviewCount, Double rating) {}
}
