package com.mulmeong.domain.favorite.service;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mulmeong.domain.favorite.entity.Favorite;
import com.mulmeong.domain.favorite.repository.FavoriteRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FavoriteService {

    private final FavoriteRepository favoriteRepository;

    /** 비로그인(userId=null)이면 항상 빈 Set — 마커/카드의 isFavorite는 전부 false 처리된다. */
    @Transactional(readOnly = true)
    public Set<Long> getFavoritePlaceIds(Long userId, List<Long> placeIds) {
        if (userId == null || placeIds.isEmpty()) {
            return Set.of();
        }
        return favoriteRepository.findByUserIdAndPlaceIdIn(userId, placeIds).stream()
                .map(Favorite::getPlaceId)
                .collect(Collectors.toSet());
    }
}
