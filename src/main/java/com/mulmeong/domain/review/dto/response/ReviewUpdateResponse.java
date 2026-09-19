package com.mulmeong.domain.review.dto.response;

import java.time.OffsetDateTime;
import java.util.List;

public record ReviewUpdateResponse(Long reviewId, short rating, String body, List<String> images,
                                   OffsetDateTime updatedAt) {
}
