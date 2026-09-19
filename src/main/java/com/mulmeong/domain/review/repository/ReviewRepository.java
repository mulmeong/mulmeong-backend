package com.mulmeong.domain.review.repository;

import java.time.LocalDate;
import java.util.Optional;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import com.mulmeong.domain.review.entity.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    boolean existsByUserIdAndPlaceIdAndVisitedAtAndDeletedAtIsNull(Long userId, Long placeId, LocalDate visitedAt);
    boolean existsByUserIdAndPlaceIdAndDeletedAtIsNull(Long userId, Long placeId);
    Optional<Review> findByIdAndDeletedAtIsNull(Long id);

    @EntityGraph(attributePaths = { "user", "images" })
    Page<Review> findByPlaceIdAndDeletedAtIsNull(Long placeId, Pageable pageable);

    List<Review> findByPlaceIdAndDeletedAtIsNull(Long placeId);
}
