package com.mulmeong.domain.user.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * 회원가입 요청 (AUTH-07 / 회원가입 화면).
 * 이메일 인증은 범위에서 제외. 이름·생년월일·전화번호는 화면에 없어 현재 미수집.
 */
public record SignupRequest(

        @NotBlank(message = "이메일을 입력해주세요")
        @Email(message = "이메일 형식이 올바르지 않습니다")
        @Size(max = 255)
        String email,

        @NotBlank(message = "비밀번호를 입력해주세요")
        @Size(min = 8, max = 64, message = "비밀번호는 8자 이상이어야 합니다")
        String password,

        @NotBlank(message = "비밀번호 확인을 입력해주세요")
        String passwordConfirm,

        @NotBlank(message = "닉네임을 입력해주세요")
        @Size(min = 2, max = 50, message = "닉네임은 2~50자여야 합니다")
        String nickname
) {
}
