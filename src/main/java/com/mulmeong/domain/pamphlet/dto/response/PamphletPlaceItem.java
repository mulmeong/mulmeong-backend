package com.mulmeong.domain.pamphlet.dto.response;

public record PamphletPlaceItem(int seq, Long placeId, String placeType, String placeTypeLabel,
        String name, String subText, String address, String imageUrl, Double lat, Double lng,
        String kakaoPlaceUrl) {}
