package com.mulmeong.domain.place.dto.response;

import java.util.List;

/**
 * 904 카테고리 POI 토글 응답.
 */
public record ExternalCategoryPlaceResponse(
        String category,
        List<Item> places
) {

    public record Item(
            String externalId,
            Integer contentTypeId,
            String name,
            String categoryName,
            String imageUrl,
            String roadAddress,
            String phone,
            Double lat,
            Double lng,
            Integer distanceM,
            String description,
            String homepageUrl
    ) {
    }
}
