package com.mulmeong.domain.user.dto.response;

import com.mulmeong.domain.user.entity.User;

/** 회원가입 결과. 비밀번호 등 민감 정보는 담지 않는다. */
public record SignupResponse(Long id, String email, String nickname) {

    public static SignupResponse from(User user) {
        return new SignupResponse(user.getId(), user.getEmail(), user.getNickname());
    }
}
