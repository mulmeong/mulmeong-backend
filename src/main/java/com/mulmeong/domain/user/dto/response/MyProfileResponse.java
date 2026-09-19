package com.mulmeong.domain.user.dto.response;

import java.time.OffsetDateTime;

/** 701 GET /users/me. 이 API만 예외적으로 email을 내려준다. */
public record MyProfileResponse(
        Long userId,
        String email,
        String nickname,
        int level,
        String title,
        int visitedOnsenCount,
        long reviewCount,
        long grapeRegionCount,
        OffsetDateTime nicknameChangedAt,
        boolean nicknameEditable,
        OffsetDateTime nicknameEditableAt,
        String profileShareToken,
        String profileShareUrl,
        long favoriteCount,
        long pamphletCount,
        OffsetDateTime createdAt) {
}
