package com.mulmeong.domain.user.dto.request;

import jakarta.validation.constraints.*;

import java.time.LocalDate;

/**
 * 회원가입 요청 (AUTH-07 / API 101 POST /api/v1/auth/signup). 이메일 인증 없음.
 */
public record SignupRequest(

        @NotBlank(message = "이메일을 입력해주세요")
        @Email(message = "이메일 형식이 올바르지 않습니다")
        @Size(max = 100, message = "이메일은 100자 이하여야 합니다")
        String email,

        @NotBlank(message = "비밀번호를 입력해주세요")
        @Size(min = 8, max = 64, message = "비밀번호는 8~64자여야 합니다")
        @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&*()_+\\-=.]*$",
                message = "비밀번호는 영문과 숫자를 포함해야 합니다")
        String password,

        @NotBlank(message = "비밀번호 확인을 입력해주세요")
        String passwordConfirm,

        @NotBlank(message = "이름을 입력해주세요")
        @Size(min = 1, max = 20, message = "이름은 1~20자여야 합니다")
        String name,

        @NotNull(message = "생년월일을 입력해주세요")
        @Past(message = "생년월일이 올바르지 않습니다")
        LocalDate birthDate,

        @NotBlank(message = "전화번호를 입력해주세요")
        @Pattern(regexp = "^01[016789]-\\d{3,4}-\\d{4}$", message = "전화번호는 010-0000-0000 형식이어야 합니다")
        String phone,

        @NotBlank(message = "닉네임을 입력해주세요")
        @Size(min = 2, max = 10, message = "닉네임은 2~10자로 입력해주세요")
        String nickname

) {
}
