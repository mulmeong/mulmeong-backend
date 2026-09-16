package com.mulmeong.domain.place.repository;

/** 검색(302) 지역 결과용 시군구 집계. */
public record RegionAggregate(String sigunguCode, String sido, String sigungu, double avgLat, double avgLng, long count) {
}
