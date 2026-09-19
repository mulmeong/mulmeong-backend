package com.mulmeong.domain.magazine.repository;

import com.mulmeong.domain.magazine.entity.MagazineLike;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.Set;

public interface MagazineLikeRepository extends JpaRepository<MagazineLike, Long> {
    boolean existsByMagazineIdAndUserId(Long magazineId, Long userId);

    Optional<MagazineLike> findByMagazineIdAndUserId(Long magazineId, Long userId);

    List<MagazineLike> findByUserId(Long userId);

    @Query("select l.magazineId from MagazineLike l where l.userId = :userId and l.magazineId in :magazineIds")
    Set<Long> findLikedMagazineIds(@Param("userId") Long userId, @Param("magazineIds") Collection<Long> magazineIds);
}
