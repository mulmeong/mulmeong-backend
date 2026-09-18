package com.mulmeong.domain.pamphlet.dto.response;

import java.time.*;
import java.util.List;

public record PamphletDetail(Long pamphletId, String shareToken, String title, Integer partySize,
        LocalDate travelDate, PamphletAuthor author, boolean isMine, String coverImage,
        List<PamphletPlaceItem> places, PamphletSummary summary, OffsetDateTime createdAt) {}
