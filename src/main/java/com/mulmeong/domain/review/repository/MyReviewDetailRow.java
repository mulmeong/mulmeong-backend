package com.mulmeong.domain.review.repository;

import java.time.LocalDate;
import java.time.OffsetDateTime;

/** 705(내 리뷰 상세) 네이티브 쿼리 투영. */
public interface MyReviewDetailRow {
    Long getReviewId();
    Long getUserId();
    Long getOnsenId();
    String getName();
    String getAddress();
    Double getLat();
    Double getLng();
    String getThumbnail();
    Short getRating();
    LocalDate getVisitedAt();
    String getVisitTimeSlot();
    Short getCleanliness();
    Short getCrowdedness();
    Short getFacilityScore();
    String getBody();
    OffsetDateTime getCreatedAt();
    OffsetDateTime getUpdatedAt();
    Boolean getIsRevisit();
}
