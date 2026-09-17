package com.mulmeong.domain.place.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mulmeong.domain.place.entity.PlaceImage;

public interface PlaceImageRepository extends JpaRepository<PlaceImage, Long> {

    List<PlaceImage> findByPlaceIdInAndSortOrder(List<Long> placeIds, short sortOrder);

    List<PlaceImage> findByPlaceIdOrderBySortOrder(Long placeId);
}
