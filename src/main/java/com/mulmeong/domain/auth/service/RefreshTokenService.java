package com.mulmeong.domain.auth.service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Duration;
import java.util.Set;

import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import com.mulmeong.domain.auth.jwt.JwtTokenProvider;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import lombok.RequiredArgsConstructor;

/**
 * Refresh Token은 JWT(서명으로 만료·위조 검증 + userId 추출)면서, 원문의 SHA-256 해시를
 * Redis에 저장해 "이 토큰이 아직 살아있는가"를 별도로 관리한다 (rt:{hash} -> userId, TTL 14일).
 * {@code rt-user:{userId}}는 그 유저가 현재 들고 있는 해시 목록 — 재사용 공격 탐지 시 한 번에 폐기하는 용도.
 */
@Service
@RequiredArgsConstructor
public class RefreshTokenService {

    private static final String TOKEN_KEY_PREFIX = "rt:";
    private static final String USER_KEY_PREFIX = "rt-user:";

    private final StringRedisTemplate redisTemplate;
    private final JwtTokenProvider jwtTokenProvider;

    public TokenPair issue(Long userId) {
        String accessToken = jwtTokenProvider.createAccessToken(userId);
        String refreshToken = jwtTokenProvider.createRefreshToken(userId);
        store(userId, refreshToken);
        return new TokenPair(accessToken, refreshToken, jwtTokenProvider.accessTokenExpireSeconds());
    }

    /** 검증 + 회전. 재사용(이미 폐기된 토큰) 시 해당 유저의 모든 Refresh Token을 폐기하고 예외를 던진다. */
    public Long rotate(String rawRefreshToken) {
        Claims claims;
        try {
            claims = jwtTokenProvider.parse(rawRefreshToken);
        } catch (JwtException | IllegalArgumentException e) {
            throw new BusinessException(ErrorCode.REFRESH_TOKEN_INVALID);
        }
        if (!jwtTokenProvider.isType(claims, JwtTokenProvider.TYPE_REFRESH)) {
            throw new BusinessException(ErrorCode.REFRESH_TOKEN_INVALID);
        }

        Long userId = jwtTokenProvider.getUserId(claims);
        String hash = sha256(rawRefreshToken);
        String stored = redisTemplate.opsForValue().get(TOKEN_KEY_PREFIX + hash);

        if (stored == null) {
            // 서명은 유효한데 Redis에 없다 = 이미 사용(회전)된 토큰의 재사용 시도.
            revokeAll(userId);
            throw new BusinessException(ErrorCode.REFRESH_TOKEN_INVALID);
        }

        redisTemplate.delete(TOKEN_KEY_PREFIX + hash);
        redisTemplate.opsForSet().remove(USER_KEY_PREFIX + userId, hash);
        return userId;
    }

    /** 로그아웃. 토큰이 이미 없거나 무효해도 조용히 무시한다(멱등). */
    public void revoke(String rawRefreshToken) {
        String hash = sha256(rawRefreshToken);
        String userId = redisTemplate.opsForValue().get(TOKEN_KEY_PREFIX + hash);
        if (userId == null) {
            return;
        }
        redisTemplate.delete(TOKEN_KEY_PREFIX + hash);
        redisTemplate.opsForSet().remove(USER_KEY_PREFIX + userId, hash);
    }

    private void revokeAll(Long userId) {
        String userKey = USER_KEY_PREFIX + userId;
        Set<String> hashes = redisTemplate.opsForSet().members(userKey);
        if (hashes != null) {
            hashes.forEach(hash -> redisTemplate.delete(TOKEN_KEY_PREFIX + hash));
        }
        redisTemplate.delete(userKey);
    }

    private void store(Long userId, String refreshToken) {
        String hash = sha256(refreshToken);
        Duration ttl = Duration.ofSeconds(jwtTokenProvider.refreshTokenExpireSeconds());
        redisTemplate.opsForValue().set(TOKEN_KEY_PREFIX + hash, userId.toString(), ttl);
        redisTemplate.opsForSet().add(USER_KEY_PREFIX + userId, hash);
    }

    private String sha256(String value) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(value.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(hash.length * 2);
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 not available", e);
        }
    }
}
