package com.mulmeong.domain.review.repository;

import java.time.LocalDate;

public interface RecentOnsenRow {
    Long getOnsenId();

    String getName();

    String getThumbnail();

    LocalDate getVisitedAt();
}
