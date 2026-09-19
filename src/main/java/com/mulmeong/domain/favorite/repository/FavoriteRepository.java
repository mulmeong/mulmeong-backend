package com.mulmeong.domain.favorite.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

import com.mulmeong.domain.favorite.entity.Favorite;

public interface FavoriteRepository extends JpaRepository<Favorite, Long> {

    List<Favorite> findByUserIdAndPlaceIdIn(Long userId, List<Long> placeIds);
    Optional<Favorite> findByUserIdAndPlaceId(Long userId, Long placeId);
    long countByUserId(Long userId);
    void deleteByUserIdAndPlaceId(Long userId, Long placeId);
    List<Favorite> findByUserId(Long userId);
    void deleteByUserId(Long userId);
}
