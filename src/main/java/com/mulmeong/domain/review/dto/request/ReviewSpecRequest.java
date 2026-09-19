package com.mulmeong.domain.review.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

public record ReviewSpecRequest(
        String visitTime,
        @Min(1) @Max(5) Short clean,
        @Min(1) @Max(5) Short crowd,
        @Min(1) @Max(5) Short facility) {
}
