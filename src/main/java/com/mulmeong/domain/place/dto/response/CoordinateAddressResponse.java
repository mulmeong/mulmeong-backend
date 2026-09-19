package com.mulmeong.domain.place.dto.response;

public record CoordinateAddressResponse(Double lat, Double lng, String roadAddress, String jibunAddress,
                                        String sido, String sigungu, String regionCode, String label) {
}
