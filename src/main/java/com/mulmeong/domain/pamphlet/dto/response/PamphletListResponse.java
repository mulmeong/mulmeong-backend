package com.mulmeong.domain.pamphlet.dto.response;

import java.util.List;

public record PamphletListResponse(List<PamphletListItem> content, int page, int size,
        long totalElements, int totalPages, boolean last) {}
