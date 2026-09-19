package com.mulmeong.domain.place.dto.response;

public record TourPlaceDetailResponse(
        String externalId,
        String contentId,
        Integer contentTypeId,
        String name,
        String description,
        String imageUrl,
        String thumbnailUrl,
        String address,
        String phone,
        String homepageUrl,
        Double lat,
        Double lng
) {
}
