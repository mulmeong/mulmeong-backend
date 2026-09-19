package com.mulmeong.domain.review.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;

import java.util.List;

public record ReviewUpdateRequest(
        @Min(1) @Max(5) Short rating,
        @Valid ReviewSpecRequest spec,
        @Size(max = 1000) String body,
        List<String> imageUrls) {
}
