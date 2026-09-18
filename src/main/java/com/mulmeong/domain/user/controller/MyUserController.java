package com.mulmeong.domain.user.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mulmeong.domain.auth.dto.response.UserSummary;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.domain.user.service.UserService;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;

import lombok.RequiredArgsConstructor;

/** 로그인한 사용자의 내 정보 API. */
@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
public class MyUserController {

    private final UserService userService;

    @GetMapping("/me")
    public UserSummary getMe(@AuthenticationPrincipal Long userId) {
        User user = userService.getById(userId)
                .filter(found -> !found.isWithdrawn())
                .orElseThrow(() -> new BusinessException(ErrorCode.RESOURCE_NOT_FOUND));
        return UserSummary.from(user);
    }
}
