package com.mulmeong.domain.dart.dto;

public record DartResponse(
        String dartId, String shareUrl, int candidateCount, boolean relaxed, Integer relaxedFrom,
        String relaxMessage, Result result) {
    public record Result(Long candidateId, Long placeId, String name, String grade,
                         String sido, String sigungu, double lat, double lng, double distanceKm,
                         int estimatedMinutes, String accessLevel, String accessLabel,
                         String stationName, String stationToPlace, Boolean hasLodging) {
    }
}
