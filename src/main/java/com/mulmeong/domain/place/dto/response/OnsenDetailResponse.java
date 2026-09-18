package com.mulmeong.domain.place.dto.response;

import java.util.List;

/** 202 온천 정보 상세 응답. */
public record OnsenDetailResponse(
        Long onsenId,
        String name,
        boolean isRegistered,
        String sido,
        String sigungu,
        String address,
        Double lat,
        Double lng,
        String phone,
        String homepageUrl,
        String hours,
        String holiday,
        String parkingInfo,
        Integer priceMin,
        Water water,
        Facilities facilities,
        Access access,
        Integer annualVisitors,
        List<String> images,
        String regionComment,
        String notes,
        boolean isFavorite,
        ReviewSummary reviewSummary
) {

    public record Water(Double temp, String type, String component, Double ph, String benefit) {
    }

    public record Facilities(Boolean hasOutdoor, Boolean hasLodging, String facilityType) {
    }

    public record Access(String accessLevel, String accessLevelLabel, NearestStation nearestStation) {
    }

    public record NearestStation(String name, Double lat, Double lng, String stationToPlaceDesc) {
    }

    /** 리뷰 도메인이 아직 없어 항상 count=0, avgRating=null로 내려간다. */
    public record ReviewSummary(long count, Double avgRating) {
    }
}
