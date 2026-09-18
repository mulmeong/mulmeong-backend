package com.mulmeong.domain.place.dto.request;

/** MAP-04 카테고리 POI 토글. 카카오 로컬 그룹코드 매핑은 서버 내부에만 둔다. */
public enum PoiCategory {
    CAFE("CE7"),
    RESTAURANT("FD6"),
    PARK(null),
    CONVENIENCE("CS2"),
    PARKING("PK6"),
    ACCOMMODATION("AD5");

    private final String kakaoGroupCode;

    PoiCategory(String kakaoGroupCode) {
        this.kakaoGroupCode = kakaoGroupCode;
    }

    public String getKakaoGroupCode() {
        return kakaoGroupCode;
    }
}
