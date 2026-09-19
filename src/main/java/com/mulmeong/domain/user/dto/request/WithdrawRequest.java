package com.mulmeong.domain.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** 709 DELETE /users/me. */
public record WithdrawRequest(
        @NotBlank(message = "비밀번호를 입력해주세요") String password,
        @Size(max = 200, message = "탈퇴 사유는 200자 이하여야 합니다") String reason) {
}
