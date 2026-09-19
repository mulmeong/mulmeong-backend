package com.mulmeong.domain.auth.service;

import com.mulmeong.domain.auth.dto.request.LoginRequest;
import com.mulmeong.domain.auth.dto.response.UserSummary;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.domain.user.service.UserService;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

/**
 * 102 로그인, 104 재발급, 105 로그아웃. user 도메인 데이터는 UserRepository가 아니라 UserService를 통해서만 접근한다.
 */
@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final RefreshTokenService refreshTokenService;

    @Transactional(readOnly = true)
    public LoginOutcome login(LoginRequest request) {
        User user = userService.getByEmail(request.email().trim().toLowerCase())
                .orElseThrow(() -> new BusinessException(ErrorCode.LOGIN_FAILED));

        if (user.isWithdrawn()) {
            throw new BusinessException(ErrorCode.ACCOUNT_WITHDRAWN);
        }
        if (!passwordEncoder.matches(request.password(), user.getPassword())) {
            throw new BusinessException(ErrorCode.LOGIN_FAILED);
        }

        return new LoginOutcome(refreshTokenService.issue(user.getId()), UserSummary.from(user));
    }

    @Transactional(readOnly = true)
    public LoginOutcome reissue(String rawRefreshToken) {
        if (!StringUtils.hasText(rawRefreshToken)) {
            throw new BusinessException(ErrorCode.REFRESH_TOKEN_MISSING);
        }

        Long userId = refreshTokenService.rotate(rawRefreshToken);
        User user = userService.getById(userId)
                .orElseThrow(() -> new BusinessException(ErrorCode.REFRESH_TOKEN_INVALID));
        if (user.isWithdrawn()) {
            throw new BusinessException(ErrorCode.REFRESH_TOKEN_INVALID);
        }

        return new LoginOutcome(refreshTokenService.issue(user.getId()), UserSummary.from(user));
    }

    public void logout(String rawRefreshToken) {
        if (StringUtils.hasText(rawRefreshToken)) {
            refreshTokenService.revoke(rawRefreshToken);
        }
    }
}
