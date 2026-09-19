package com.mulmeong.domain.place.dto.response;

import java.util.List;

/**
 * API-302 응답.
 */
public record OnsenSearchResponse(String keyword, List<Result> results) {

    public sealed interface Result permits OnsenResult, RegionResult {
    }

    public record OnsenResult(
            String type, Long onsenId, String name, String address, double lat, double lng, boolean isRegistered
    ) implements Result {

        public OnsenResult(Long onsenId, String name, String address, double lat, double lng, boolean isRegistered) {
            this("ONSEN", onsenId, name, address, lat, lng, isRegistered);
        }
    }

    public record RegionResult(
            String type, String regionCode, String name, double lat, double lng, long onsenCount
    ) implements Result {

        public RegionResult(String regionCode, String name, double lat, double lng, long onsenCount) {
            this("REGION", regionCode, name, lat, lng, onsenCount);
        }
    }
}
