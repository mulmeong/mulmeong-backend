package com.mulmeong.domain.auth.service;

import com.mulmeong.domain.auth.dto.request.PasswordResetConfirmRequest;
import com.mulmeong.domain.auth.dto.request.PasswordResetRequest;
import com.mulmeong.domain.user.entity.PasswordResetToken;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.domain.user.repository.PasswordResetTokenRepository;
import com.mulmeong.domain.user.service.UserService;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Duration;
import java.time.OffsetDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PasswordResetService {

    private static final Duration TOKEN_TTL = Duration.ofMinutes(30);
    private static final Duration REQUEST_COOLDOWN = Duration.ofSeconds(60);
    private static final String COOLDOWN_PREFIX = "pwreset-cooldown:";

    private final UserService userService;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final RefreshTokenService refreshTokenService;
    private final PasswordResetMailService passwordResetMailService;
    private final StringRedisTemplate redisTemplate;

    @Transactional
    public void requestReset(PasswordResetRequest request) {
        String email = request.email().trim().toLowerCase();
        User user = userService.getByEmail(email).filter(candidate -> !candidate.isWithdrawn()).orElse(null);
        if (user == null || isCooldownActive(email)) {
            return;
        }

        String rawToken = UUID.randomUUID().toString();
        passwordResetTokenRepository.deleteByUserId(user.getId());
        passwordResetTokenRepository.save(new PasswordResetToken(user.getId(), sha256(rawToken),
                OffsetDateTime.now().plus(TOKEN_TTL)));
        redisTemplate.opsForValue().set(cooldownKey(email), "1", REQUEST_COOLDOWN);
        passwordResetMailService.send(user.getEmail(), rawToken);
    }

    @Transactional
    public void resetPassword(PasswordResetConfirmRequest request) {
        if (!request.newPassword().equals(request.newPasswordConfirm())) {
            throw new BusinessException(ErrorCode.PASSWORD_MISMATCH);
        }

        PasswordResetToken resetToken = passwordResetTokenRepository.findByTokenHashForUpdate(sha256(request.token()))
                .orElseThrow(() -> new BusinessException(ErrorCode.RESET_TOKEN_INVALID));
        if (resetToken.isUsed()) {
            throw new BusinessException(ErrorCode.RESET_TOKEN_INVALID);
        }
        if (resetToken.isExpired(OffsetDateTime.now())) {
            throw new BusinessException(ErrorCode.RESET_TOKEN_EXPIRED);
        }

        userService.resetPassword(resetToken.getUserId(), request.newPassword());
        resetToken.markUsed(OffsetDateTime.now());
        refreshTokenService.revokeAllForUser(resetToken.getUserId());
    }

    private boolean isCooldownActive(String email) {
        return Boolean.TRUE.equals(redisTemplate.hasKey(cooldownKey(email)));
    }

    private String cooldownKey(String email) {
        return COOLDOWN_PREFIX + sha256(email);
    }

    private String sha256(String value) {
        try {
            byte[] hash = MessageDigest.getInstance("SHA-256").digest(value.getBytes(StandardCharsets.UTF_8));
            StringBuilder result = new StringBuilder(hash.length * 2);
            for (byte b : hash) {
                result.append(String.format("%02x", b));
            }
            return result.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 is not available", e);
        }
    }
}
