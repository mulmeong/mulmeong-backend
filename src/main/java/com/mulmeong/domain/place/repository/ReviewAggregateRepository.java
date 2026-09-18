package com.mulmeong.domain.place.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.mulmeong.domain.user.entity.User;

/** Reviews are not modelled as a JPA aggregate yet; keep list/detail statistics as a read projection. */
public interface ReviewAggregateRepository extends JpaRepository<User, Long> {

    @Query(value = """
            SELECT r.place_id AS placeId, COUNT(*) AS reviewCount, AVG(r.rating)::float8 AS rating
            FROM reviews r
            WHERE r.deleted_at IS NULL AND r.place_id IN (:placeIds)
            GROUP BY r.place_id
            """, nativeQuery = true)
    List<ReviewAggregate> findByPlaceIds(@Param("placeIds") List<Long> placeIds);
}
