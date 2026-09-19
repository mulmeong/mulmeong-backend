package com.mulmeong.domain.auth.service;

/**
 * accessToken은 응답 바디로, refreshToken은 항상 HttpOnly 쿠키로만 내려간다.
 */
public record TokenPair(String accessToken, String refreshToken, long expiresIn) {
}
