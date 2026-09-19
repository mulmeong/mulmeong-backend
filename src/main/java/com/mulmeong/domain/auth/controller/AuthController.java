package com.mulmeong.domain.auth.controller;

import com.mulmeong.domain.auth.dto.request.LoginRequest;
import com.mulmeong.domain.auth.dto.request.PasswordResetConfirmRequest;
import com.mulmeong.domain.auth.dto.request.PasswordResetRequest;
import com.mulmeong.domain.auth.dto.response.LoginResponse;
import com.mulmeong.domain.auth.dto.response.MessageResponse;
import com.mulmeong.domain.auth.jwt.JwtTokenProvider;
import com.mulmeong.domain.auth.service.AuthService;
import com.mulmeong.domain.auth.service.LoginOutcome;
import com.mulmeong.domain.auth.service.PasswordResetService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * 102 로그인, 104 재발급, 105 로그아웃, 106~107 비밀번호 재설정.
 */
@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private static final String REFRESH_COOKIE_NAME = "refreshToken";
    private static final String REFRESH_COOKIE_PATH = "/api/v1/auth";

    private final AuthService authService;
    private final PasswordResetService passwordResetService;
    private final JwtTokenProvider jwtTokenProvider;

    @Value("${jwt.refresh-cookie-secure}")
    private boolean refreshCookieSecure;

    /**
     * 102 로그인.
     */
    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@Valid @RequestBody LoginRequest request) {
        return respondWithTokens(authService.login(request));
    }

    /**
     * 104 토큰 재발급 (Refresh Token Rotation).
     */
    @PostMapping("/reissue")
    public ResponseEntity<LoginResponse> reissue(
            @CookieValue(value = REFRESH_COOKIE_NAME, required = false) String refreshToken) {
        return respondWithTokens(authService.reissue(refreshToken));
    }

    /**
     * 105 로그아웃. 이미 로그아웃 상태여도 204(멱등).
     */
    @PostMapping("/logout")
    public ResponseEntity<Void> logout(
            @CookieValue(value = REFRESH_COOKIE_NAME, required = false) String refreshToken) {
        authService.logout(refreshToken);
        return ResponseEntity.noContent()
                .header(HttpHeaders.SET_COOKIE, expireRefreshCookie().toString())
                .build();
    }

    @PostMapping("/password/reset-request")
    public MessageResponse requestPasswordReset(@Valid @RequestBody PasswordResetRequest request) {
        passwordResetService.requestReset(request);
        return new MessageResponse("입력하신 이메일로 재설정 링크를 보냈습니다.");
    }

    @PostMapping("/password/reset")
    public MessageResponse resetPassword(@Valid @RequestBody PasswordResetConfirmRequest request) {
        passwordResetService.resetPassword(request);
        return new MessageResponse("비밀번호가 변경되었습니다. 다시 로그인해 주세요.");
    }

    private ResponseEntity<LoginResponse> respondWithTokens(LoginOutcome outcome) {
        LoginResponse body = new LoginResponse(
                outcome.tokens().accessToken(), outcome.tokens().expiresIn(), outcome.user());
        return ResponseEntity.ok()
                .header(HttpHeaders.SET_COOKIE, refreshCookie(outcome.tokens().refreshToken()).toString())
                .body(body);
    }

    private ResponseCookie refreshCookie(String refreshToken) {
        return ResponseCookie.from(REFRESH_COOKIE_NAME, refreshToken)
                .httpOnly(true)
                .secure(refreshCookieSecure)
                .sameSite("Lax")
                .path(REFRESH_COOKIE_PATH)
                .maxAge(jwtTokenProvider.refreshTokenExpireSeconds())
                .build();
    }

    private ResponseCookie expireRefreshCookie() {
        return ResponseCookie.from(REFRESH_COOKIE_NAME, "")
                .httpOnly(true)
                .secure(refreshCookieSecure)
                .sameSite("Lax")
                .path(REFRESH_COOKIE_PATH)
                .maxAge(0)
                .build();
    }
}
