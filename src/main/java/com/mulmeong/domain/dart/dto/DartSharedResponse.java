package com.mulmeong.domain.dart.dto;

import java.time.OffsetDateTime;

public record DartSharedResponse(String dartId, Conditions conditions, Result result, boolean relaxed,
                                 int throwCount, String thrownBy, boolean isMine, OffsetDateTime createdAt,
                                 OffsetDateTime expiresAt) {
    public record Conditions(String originLabel, DartRequest.Transport transport, Integer maxDurationMin,
                             DartRequest.StayType tripType) {
    }

    public record Result(Long onsenId, String name, String sido, Double lat, Double lng,
                         String thumbnail, Integer estimatedMinutes) {
    }
}
