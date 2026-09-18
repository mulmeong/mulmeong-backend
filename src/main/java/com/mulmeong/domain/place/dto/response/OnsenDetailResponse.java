package com.mulmeong.domain.place.dto.response;

/** PAM-03 온천 정보 상세 응답. 명세에 맞춰 평탄한 구조를 사용한다. */
public record OnsenDetailResponse(
        Long onsenId,
        String name,
        String grade,
        boolean isRegistered,
        String sido,
        String sigungu,
        String address,
        Double lat,
        Double lng,
        Double waterTemp,
        String waterType,
        String waterBenefit,
        Boolean hasOutdoor,
        Boolean hasLodging,
        String facilityType,
        Integer priceMin,
        String phone,
        String hours,
        String accessLevel,
        java.util.List<String> images,
        String regionComment,
        String waterComponent,
        Double ph,
        String holiday,
        String parkingInfo,
        String homepageUrl,
        String representativeMenu,
        Integer annualVisitors,
        String nearestStation,
        String stationToPlaceDescription
) {
}
