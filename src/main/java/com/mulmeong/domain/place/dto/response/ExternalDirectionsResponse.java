package com.mulmeong.domain.place.dto.response;

public record ExternalDirectionsResponse(String mode, Double distanceKm, Integer durationMin, String kakaoDeepLink) {}
