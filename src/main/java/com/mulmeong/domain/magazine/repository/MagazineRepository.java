package com.mulmeong.domain.magazine.repository;

import com.mulmeong.domain.magazine.entity.Magazine;
import com.mulmeong.domain.magazine.entity.MagazineCategory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

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
            "and (:category is null or m.category = :category) and m.sidoCode in :sidoCodes")
    Page<Magazine> searchBySidoCodes(@Param("category") MagazineCategory category,
                                     @Param("sidoCodes") java.util.List<String> sidoCodes, Pageable pageable);

    @Query("select m.sidoCode as sidoCode, count(m) as count from Magazine m " +
            "where m.publishedAt is not null and m.publishedAt <= CURRENT_TIMESTAMP " +
            "and m.sidoCode is not null and (:category is null or m.category = :category) " +
            "group by m.sidoCode order by count(m) desc, m.sidoCode asc")
    java.util.List<RegionCount> countBySidoCode(@Param("category") MagazineCategory category);

    @Query("select m from Magazine m where m.publishedAt is not null and m.publishedAt <= CURRENT_TIMESTAMP " +
            "and m.category = :category and m.id > :id order by m.id asc")
    java.util.List<Magazine> findNext(@Param("category") MagazineCategory category, @Param("id") Long id, Pageable pageable);

    interface RegionCount {
        String getSidoCode();

        long getCount();
    }
}
