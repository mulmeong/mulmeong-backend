package com.mulmeong.domain.region.dto.response;

import java.util.List;

public record GrapeMapResponse(String level, long totalVisitedRegions, long totalRegions, int maxVisitCount,
        List<RegionItem> regions) {

    public record RegionItem(String regionCode, String name, int visitCount, double density, List<Long> onsenIds) {
    }
}
