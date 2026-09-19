package com.mulmeong.domain.review.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;

import java.time.LocalDate;
import java.util.List;

public record ReviewCreateRequest(
        @Min(1) @Max(5) Short rating,
        LocalDate visitedAt,
        @Valid ReviewSpecRequest spec,
        @Size(max = 1000) String body,
        List<String> imageUrls) {
}
