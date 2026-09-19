package com.mulmeong.domain.user.dto.response;

import java.time.OffsetDateTime;

public record NicknameCheckResponse(
        String nickname,
        boolean available,
        boolean editable,
        OffsetDateTime editableAt
) {
}
