package com.mulmeong.domain.pamphlet.dto.response;

import java.time.*;

public record PamphletCreateResponse(Long pamphletId, String shareToken, String shareUrl, String title,
        Integer partySize, LocalDate travelDate, int placeCount, String coverImage, OffsetDateTime createdAt) {}
