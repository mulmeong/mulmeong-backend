package com.mulmeong.domain.place.dto.request;

import java.util.List;

import jakarta.validation.constraints.NotBlank;

public record NearbyRerollRequest(@NotBlank String category, List<String> excludeIds) {
    public NearbyRerollRequest {
        excludeIds = excludeIds == null ? List.of() : List.copyOf(excludeIds);
    }
}
