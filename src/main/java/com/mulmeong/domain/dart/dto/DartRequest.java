package com.mulmeong.domain.dart.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.List;

public record DartRequest(
        @Valid @NotNull Origin origin,
        @NotNull Transport transport,
        Integer maxMinutes,
        @NotNull StayType stayType,
        @Size(max = 100) List<Long> excludeIds) {
    public DartRequest {
        excludeIds = excludeIds == null ? List.of() : List.copyOf(excludeIds);
    }

    public record Origin(@NotNull Double lat, @NotNull Double lng, @NotBlank String label) {
    }

    public enum Transport {CAR, TRANSIT}

    public enum StayType {DAY, OVERNIGHT}
}
