package com.mulmeong.domain.magazine.repository;

import com.mulmeong.domain.place.entity.Place;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MagazinePlaceRepository extends JpaRepository<com.mulmeong.domain.magazine.entity.MagazinePlace, Long> {
    @Query("select mp.place from MagazinePlace mp where mp.magazineId = :magazineId order by mp.sortOrder asc")
    List<Place> findPlaces(@Param("magazineId") Long magazineId);
}
