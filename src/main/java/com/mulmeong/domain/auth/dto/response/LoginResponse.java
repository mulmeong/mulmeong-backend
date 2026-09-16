package com.mulmeong.domain.auth.dto.response;

/** 102 로그인 / 104 재발급 공통 응답. Refresh Token은 여기 담지 않고 HttpOnly 쿠키로만 내려간다. */
public record LoginResponse(String accessToken, long expiresIn, UserSummary user) {
}
