package com.mulmeong.domain.review.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mulmeong.domain.review.entity.ReviewImage;

public interface ReviewImageRepository extends JpaRepository<ReviewImage, Long> {
    void deleteByReviewId(Long reviewId);
}
