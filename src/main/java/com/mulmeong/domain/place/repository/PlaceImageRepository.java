package com.mulmeong.domain.place.repository;

import com.mulmeong.domain.place.entity.PlaceImage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PlaceImageRepository extends JpaRepository<PlaceImage, Long> {

    List<PlaceImage> findByPlaceIdInAndSortOrder(List<Long> placeIds, short sortOrder);

    List<PlaceImage> findByPlaceIdInOrderBySortOrder(List<Long> placeIds);

    List<PlaceImage> findByPlaceIdOrderBySortOrder(Long placeId);
}
