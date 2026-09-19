package com.mulmeong.domain.auth.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record PasswordResetConfirmRequest(
        @NotBlank(message = "재설정 토큰이 필요합니다")
        String token,

        @NotBlank(message = "비밀번호를 입력해주세요")
        @Size(min = 8, max = 64, message = "비밀번호는 8~64자여야 합니다")
        @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&*()_+\\-=.]*$",
                message = "비밀번호는 영문과 숫자를 포함해야 합니다")
        String newPassword,

        @NotBlank(message = "비밀번호 확인을 입력해주세요")
        String newPasswordConfirm) {
}
