package com.mulmeong.domain.auth.jwt;

import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.UUID;

import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

/**
 * Access/Refresh 토큰 둘 다 JWT다. {@code type} 클레임으로 access와 refresh를 구분해서
 * 서로 바꿔 쓸 수 없게 한다 (재발급 로직이 서명을 검증해 userId를 뽑아내야 하기 때문).
 */
@Component
public class JwtTokenProvider {

    public static final String TYPE_ACCESS = "access";
    public static final String TYPE_REFRESH = "refresh";

    private final SecretKey key;
    private final long accessTokenExpireSeconds;
    private final long refreshTokenExpireSeconds;

    public JwtTokenProvider(
            @Value("${jwt.secret}") String secret,
            @Value("${jwt.access-token-expire-seconds}") long accessTokenExpireSeconds,
            @Value("${jwt.refresh-token-expire-seconds}") long refreshTokenExpireSeconds) {
        this.key = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
        this.accessTokenExpireSeconds = accessTokenExpireSeconds;
        this.refreshTokenExpireSeconds = refreshTokenExpireSeconds;
    }

    public long accessTokenExpireSeconds() {
        return accessTokenExpireSeconds;
    }

    public long refreshTokenExpireSeconds() {
        return refreshTokenExpireSeconds;
    }

    public String createAccessToken(Long userId) {
        return createToken(userId, TYPE_ACCESS, accessTokenExpireSeconds);
    }

    public String createRefreshToken(Long userId) {
        return createToken(userId, TYPE_REFRESH, refreshTokenExpireSeconds);
    }

    private String createToken(Long userId, String type, long expireSeconds) {
        Date now = new Date();
        Date expiry = new Date(now.getTime() + expireSeconds * 1000);
        return Jwts.builder()
                .subject(userId.toString())
                .id(UUID.randomUUID().toString())
                .claim("type", type)
                .issuedAt(now)
                .expiration(expiry)
                .signWith(key)
                .compact();
    }

    /** 서명·만료 검증. 유효하지 않으면 {@link io.jsonwebtoken.JwtException} (하위 타입 포함)을 던진다. */
    public Claims parse(String token) {
        return Jwts.parser().verifyWith(key).build().parseSignedClaims(token).getPayload();
    }

    public Long getUserId(Claims claims) {
        return Long.valueOf(claims.getSubject());
    }

    public boolean isType(Claims claims, String expectedType) {
        return expectedType.equals(claims.get("type", String.class));
    }
}
