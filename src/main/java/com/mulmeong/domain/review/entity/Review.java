package com.mulmeong.domain.review.entity;

import java.time.LocalDate;
import java.time.OffsetDateTime;

import com.mulmeong.global.common.BaseTimeEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

/** reviews 테이블. 작성·수정·삭제(601~606)는 이 범위 밖 — 701~709 마이페이지 조회 전용 읽기 매핑. */
@Getter
@Entity
@Table(name = "reviews")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Review extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "place_id", nullable = false)
    private Long placeId;

    @Column(nullable = false)
    private Short rating;

    private Short cleanliness;

    private Short crowdedness;

    @Column(name = "facility_score")
    private Short facilityScore;

    @Column(name = "visit_time_slot")
    private String visitTimeSlot;

    @Column(name = "visited_at", nullable = false)
    private LocalDate visitedAt;

    private String body;

    @Column(name = "deleted_at")
    private OffsetDateTime deletedAt;

    public boolean isDeleted() {
        return deletedAt != null;
    }
}
