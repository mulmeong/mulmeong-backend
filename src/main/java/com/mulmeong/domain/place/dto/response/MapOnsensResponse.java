package com.mulmeong.domain.place.dto.response;

import java.util.List;

/** API-301 응답. clustered=true면 markers는 비고 clusters만 채워진다 (그 반대도 마찬가지). */
public record MapOnsensResponse(
        Bbox bbox,
        boolean clustered,
        List<Marker> markers,
        List<Cluster> clusters,
        String centerSidoCode,
        long totalCount
) {

    public record Bbox(double swLat, double swLng, double neLat, double neLng) {
    }

    public record Marker(
            Long onsenId,
            String name,
            double lat,
            double lng,
            boolean isRegistered,
            String markerType,
            Double waterTemp,
            String waterType,
            Boolean hasOutdoor,
            String facilityType,
            Integer priceMin,
            String accessLevel,
            String accessLevelLabel,
            boolean isFavorite,
            String thumbnail
    ) {
    }

    public record Cluster(String sigunguCode, String name, double lat, double lng, long count) {
    }
}
