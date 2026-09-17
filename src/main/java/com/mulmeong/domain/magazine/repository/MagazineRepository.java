package com.mulmeong.domain.magazine.repository;

import java.util.Optional;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import com.mulmeong.domain.magazine.entity.*;

public interface MagazineRepository extends JpaRepository<Magazine, Long> {
    @Modifying
    @Query("update Magazine m set m.likeCount = m.likeCount + 1 where m.id = :id")
    int incrementLikeCount(@Param("id") Long id);

    @Modifying
    @Query("update Magazine m set m.likeCount = m.likeCount - 1 where m.id = :id and m.likeCount > 0")
    int decrementLikeCount(@Param("id") Long id);

    @Query("select m from Magazine m where m.publishedAt is not null and m.publishedAt <= CURRENT_TIMESTAMP " +
            "and (:category is null or m.category = :category) and (:sidoCode is null or m.sidoCode = :sidoCode)")
    Page<Magazine> search(@Param("category") MagazineCategory category, @Param("sidoCode") String sidoCode, Pageable pageable);

    @Query("select m from Magazine m where m.publishedAt is not null and m.publishedAt <= CURRENT_TIMESTAMP " +
            "and m.category = :category and m.id > :id order by m.id asc")
    java.util.List<Magazine> findNext(@Param("category") MagazineCategory category, @Param("id") Long id, Pageable pageable);
}
