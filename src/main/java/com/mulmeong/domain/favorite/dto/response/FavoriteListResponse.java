package com.mulmeong.domain.favorite.dto.response;

import java.util.List;

public record FavoriteListResponse(List<FavoriteItem> content, int page, int size, long totalElements,
        int totalPages, boolean last, FavoriteCounts counts) {}
