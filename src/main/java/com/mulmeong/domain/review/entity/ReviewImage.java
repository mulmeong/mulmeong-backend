package com.mulmeong.domain.review.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * review_images 테이블.
 */
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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "review_id", insertable = false, updatable = false)
    private Review review;

    public static ReviewImage create(Long reviewId, String imageUrl, short sortOrder) {
        ReviewImage image = new ReviewImage();
        image.reviewId = reviewId;
        image.imageUrl = imageUrl;
        image.sortOrder = sortOrder;
        return image;
    }
}
