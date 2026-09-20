package com.mulmeong.domain.favorite.dto.request;

import com.mulmeong.domain.place.entity.PlaceType;

public record FavoriteCreateRequest(Long placeId, String source, String externalId, String name,
                                    Double lat, Double lng, PlaceType category, String address, String phone,
                                    String imageUrl, Integer contentTypeId) {
}
