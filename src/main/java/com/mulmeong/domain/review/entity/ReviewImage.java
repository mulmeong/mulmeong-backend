package com.mulmeong.domain.review.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

/** review_images 테이블. */
@Getter
@Entity
@Table(name = "review_images")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ReviewImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "review_id", nullable = false)
    private Long reviewId;

    @Column(name = "image_url", nullable = false)
    private String imageUrl;

    @Column(name = "sort_order", nullable = false)
    private Short sortOrder;
}
