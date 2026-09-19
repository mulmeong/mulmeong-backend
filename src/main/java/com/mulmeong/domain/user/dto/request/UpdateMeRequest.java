package com.mulmeong.domain.user.dto.request;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

/**
 * 706 PATCH /users/me. 닉네임 변경과 비밀번호 변경 중 하나만 채워서 보낸다 (동시 전송 금지).
 */
public record UpdateMeRequest(
        @Pattern(regexp = "^[가-힣a-zA-Z0-9]{2,12}$", message = "닉네임은 2~12자의 한글·영문·숫자만 가능합니다")
        String nickname,

        String currentPassword,

        @Size(min = 8, max = 64, message = "비밀번호는 8~64자여야 합니다")
        @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&*()_+\\-=.]*$",
                message = "비밀번호는 영문과 숫자를 포함해야 합니다")
        String newPassword,

        String newPasswordConfirm) {

    public boolean isNicknameChange() {
        return nickname != null && !nickname.isBlank();
    }

    public boolean isPasswordChange() {
        return currentPassword != null || newPassword != null || newPasswordConfirm != null;
    }
}
