package com.mulmeong.domain.favorite.dto.response;

import java.time.OffsetDateTime;

public record FavoriteCreateResponse(Long favoriteId, Long placeId, boolean isFavorite, OffsetDateTime createdAt) {}
