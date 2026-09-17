package com.mulmeong.domain.magazine.dto;

import java.util.List;

public record MagazineListResponse(List<MagazineResponse> content, int page, int size, long totalElements,
        int totalPages, boolean last, List<CategoryCount> categories, List<RegionCount> regions) {
    public record CategoryCount(String code, String label, long count) {}
    public record RegionCount(String sidoCode, String name, long count) {}
}
