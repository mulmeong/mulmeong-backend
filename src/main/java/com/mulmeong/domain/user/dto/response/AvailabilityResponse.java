package com.mulmeong.domain.user.dto.response;

/** 이메일/닉네임 중복 확인 결과. */
public record AvailabilityResponse(boolean available) {
}
