package com.mulmeong.domain.place.repository;

/**
 * 시군구 단위 클러스터 집계 (좌표는 해당 시군구 온천들의 평균).
 */
public record SigunguAggregate(String sigunguCode, String sigunguName, double avgLat, double avgLng, long count) {
}
