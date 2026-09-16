package com.mulmeong.domain.user.dto.response;

import com.mulmeong.domain.user.entity.User;

public record SignupResponse(Long userId, String email, String nickname) {

    public static SignupResponse from(User user) {
        return new SignupResponse(user.getId(), user.getEmail(), user.getNickname());
    }
}
