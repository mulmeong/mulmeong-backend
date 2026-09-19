package com.mulmeong.domain.place.dto.response;

import java.util.List;

/**
 * PAM-04/06 주변 여행지 응답.
 */
public record NearbyPlaceResponse(List<Content> content) {
    public record Content(
            String source, String type, String contentId, String placeId, String name,
            String image, Double lat, Double lng, Integer distanceM, String description,
            String phone, String placeUrl, String categoryName) {
    }
}
