package com.mulmeong.domain.place.dto.request;

/**
 * MAP-04 카테고리 POI 토글. TourAPI 콘텐츠 타입을 기준으로 한다.
 */
public enum PoiCategory {
    CAFE(39, "카페"),
    RESTAURANT(39, null),
    PARK(12, "공원"),
    ACCOMMODATION(32, null),
    CULTURE(14, null),
    LEISURE(28, null),
    SHOPPING(38, null),
    FESTIVAL(15, null);

    private final Integer tourContentTypeId;
    private final String titleKeyword;

    PoiCategory(Integer tourContentTypeId, String titleKeyword) {
        this.tourContentTypeId = tourContentTypeId;
        this.titleKeyword = titleKeyword;
    }

    public Integer getTourContentTypeId() {
        return tourContentTypeId;
    }

    public boolean matchesTitle(String title) {
        return titleKeyword == null || (title != null && title.contains(titleKeyword));
    }
}
