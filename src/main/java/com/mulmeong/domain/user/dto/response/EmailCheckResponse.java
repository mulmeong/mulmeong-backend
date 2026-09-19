package com.mulmeong.domain.user.dto.response;

/**
 * GET /api/v1/auth/email/check 응답. 중복이어도 409가 아니라 200 + available=false.
 */
public record EmailCheckResponse(String email, boolean available) {
}
