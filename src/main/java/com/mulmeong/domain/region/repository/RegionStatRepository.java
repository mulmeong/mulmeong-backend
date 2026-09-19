package com.mulmeong.domain.region.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Modifying;

import com.mulmeong.domain.region.entity.RegionStat;

public interface RegionStatRepository extends JpaRepository<RegionStat, Long> {

    List<RegionStat> findByUserId(Long userId);

    List<RegionStat> findByUserIdAndSidoCode(Long userId, String sidoCode);

    Optional<RegionStat> findByUserIdAndSigunguCode(Long userId, String sigunguCode);

    void deleteByUserId(Long userId);

    @Query("select count(distinct r.sidoCode) from RegionStat r where r.userId = :userId and r.visitCount > 0")
    long countVisitedSido(@Param("userId") Long userId);

    @Modifying
    @Query(value = """
            insert into region_stats (user_id, sido_code, sigungu_code, visit_count)
            values (:userId, :sidoCode, :sigunguCode, 1)
            on conflict (user_id, sigungu_code)
            do update set visit_count = region_stats.visit_count + 1
            """, nativeQuery = true)
    void incrementVisitCount(@Param("userId") Long userId, @Param("sidoCode") String sidoCode,
            @Param("sigunguCode") String sigunguCode);

    @Modifying
    @Query(value = """
            update region_stats
            set visit_count = case when visit_count > 0 then visit_count - 1 else 0 end
            where user_id = :userId and sigungu_code = :sigunguCode
            """, nativeQuery = true)
    void decrementVisitCount(@Param("userId") Long userId, @Param("sigunguCode") String sigunguCode);
}
