package com.mulmeong.domain.pamphlet.dto.response;

import java.util.List;

public record PamphletPlaceItem(int seq, Long placeId, String externalId, Integer contentTypeId,
                                String placeType, String placeTypeLabel,
                                String name, String subText, String address, String imageUrl, Double lat, Double lng,
                                String kakaoPlaceUrl, Integer priceMin, Water water, Facilities facilities,
                                Access access, List<String> images, String thumbnail, String regionComment,
                                String notes, ReviewSummary reviewSummary) {

    public record Water(Double temp, String type, String component, Double ph, String benefit) {
    }

    public record Facilities(Boolean hasOutdoor, Boolean hasLodging, String facilityType) {
    }

    public record Access(String accessLevel, String accessLevelLabel, NearestStation nearestStation) {
    }

    public record NearestStation(String name, String stationToPlaceDesc) {
    }

    public record ReviewSummary(long count, Double avgRating) {
    }
}
