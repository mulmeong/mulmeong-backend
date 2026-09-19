package com.mulmeong.domain.review.service;

/** 704 정렬 기준. code는 MyReviewRepository 네이티브 쿼리의 CASE 분기 값과 맞춘다. */
public enum ReviewSort {
    RECENT(0),
    OLDEST(1),
    RATING_DESC(2);

    private final int code;

    ReviewSort(int code) {
        this.code = code;
    }

    public int code() {
        return code;
    }
}
