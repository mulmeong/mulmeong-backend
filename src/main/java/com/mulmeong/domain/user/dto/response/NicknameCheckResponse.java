package com.mulmeong.domain.user.dto.response;

public record NicknameCheckResponse(
        String nickname,
        boolean available
) {
}