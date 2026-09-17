package com.mulmeong.domain.magazine.repository;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import com.mulmeong.domain.magazine.entity.MagazineLike;

public interface MagazineLikeRepository extends JpaRepository<MagazineLike, Long> {
    boolean existsByMagazineIdAndUserId(Long magazineId, Long userId);
    Optional<MagazineLike> findByMagazineIdAndUserId(Long magazineId, Long userId);
    @Query("select l.magazineId from MagazineLike l where l.userId = :userId and l.magazineId in :magazineIds")
    Set<Long> findLikedMagazineIds(@Param("userId") Long userId, @Param("magazineIds") Collection<Long> magazineIds);
}
