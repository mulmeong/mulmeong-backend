package com.mulmeong.domain.review.repository;

import java.time.LocalDate;
import java.time.OffsetDateTime;

/** 704(내 리뷰 목록) 네이티브 쿼리 투영. */
public interface MyReviewRow {
    Long getReviewId();
    Long getOnsenId();
    String getName();
    String getSido();
    String getSigungu();
    String getThumbnail();
    Short getRating();
    String getBody();
    Long getImageCount();
    String getFirstImage();
    LocalDate getVisitedAt();
    Boolean getIsRevisit();
    OffsetDateTime getCreatedAt();
}
