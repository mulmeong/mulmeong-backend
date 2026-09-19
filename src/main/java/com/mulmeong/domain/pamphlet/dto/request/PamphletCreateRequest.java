package com.mulmeong.domain.pamphlet.dto.request;

import java.time.LocalDate;
import java.util.List;

public record PamphletCreateRequest(String title, Integer partySize, LocalDate travelDate,
                                    List<Long> placeIds, String coverImageUrl) {
}
