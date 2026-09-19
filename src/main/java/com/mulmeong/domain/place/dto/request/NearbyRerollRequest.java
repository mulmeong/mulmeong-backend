package com.mulmeong.domain.place.dto.request;

import jakarta.validation.constraints.NotBlank;

import java.util.List;

public record NearbyRerollRequest(@NotBlank String category, List<String> excludeIds) {
    public NearbyRerollRequest {
        excludeIds = excludeIds == null ? List.of() : List.copyOf(excludeIds);
    }
}
