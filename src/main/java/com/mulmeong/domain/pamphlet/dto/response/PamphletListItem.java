package com.mulmeong.domain.pamphlet.dto.response;

import java.time.LocalDate;
import java.time.OffsetDateTime;

public record PamphletListItem(Long pamphletId, String shareToken, String title, Integer partySize,
                               LocalDate travelDate, String coverImage, int placeCount, String regionName,
                               String shareUrl, OffsetDateTime createdAt) {
}
