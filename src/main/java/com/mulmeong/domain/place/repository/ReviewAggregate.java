package com.mulmeong.domain.place.repository;

public interface ReviewAggregate {
    Long getPlaceId();
    long getReviewCount();
    Double getRating();
}
