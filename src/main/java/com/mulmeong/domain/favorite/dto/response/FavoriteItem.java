package com.mulmeong.domain.favorite.dto.response;

import java.time.OffsetDateTime;

public record FavoriteItem(Long favoriteId, Long placeId, String placeType, String placeTypeLabel,
                           String name, String sido, String sigungu, String address, Double lat, Double lng,
                           String thumbnail, String subText, boolean isRegistered, String source,
                           String kakaoPlaceUrl, OffsetDateTime createdAt) {
}
