package com.mulmeong.domain.place.dto.response;

import java.util.List;

public record ExternalKeywordSearchResponse(List<Item> places) {
    public record Item(String externalId, String name, String category, String roadAddress,
                       Double lat, Double lng, Integer distanceM) {
    }
}
