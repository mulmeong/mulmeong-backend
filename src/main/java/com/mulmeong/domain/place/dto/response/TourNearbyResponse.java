package com.mulmeong.domain.place.dto.response;

import java.util.List;

public record TourNearbyResponse(List<Item> items, int totalCount) {
    public record Item(String externalId, String contentId, Integer contentTypeId, String name,
                       String description, String imageUrl, String thumbnailUrl, String address,
                       Double lat, Double lng, Integer distanceM) {
    }
}
