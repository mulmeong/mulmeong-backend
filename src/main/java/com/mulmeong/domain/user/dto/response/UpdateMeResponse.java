package com.mulmeong.domain.user.dto.response;

import java.time.OffsetDateTime;

/** 706 응답. */
public record UpdateMeResponse(Long userId, String nickname, OffsetDateTime nicknameChangedAt,
        OffsetDateTime nicknameEditableAt, boolean passwordChanged) {
}
