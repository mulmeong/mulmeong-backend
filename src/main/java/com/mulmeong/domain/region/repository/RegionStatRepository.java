package com.mulmeong.domain.region.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.mulmeong.domain.region.entity.RegionStat;

public interface RegionStatRepository extends JpaRepository<RegionStat, Long> {

    List<RegionStat> findByUserId(Long userId);

    List<RegionStat> findByUserIdAndSidoCode(Long userId, String sidoCode);

    void deleteByUserId(Long userId);

    @Query("select count(distinct r.sidoCode) from RegionStat r where r.userId = :userId and r.visitCount > 0")
    long countVisitedSido(@Param("userId") Long userId);
}
