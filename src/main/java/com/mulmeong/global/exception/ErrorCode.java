package com.mulmeong.global.exception;

import org.springframework.http.HttpStatus;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {

    // Common
    INVALID_INPUT(HttpStatus.BAD_REQUEST, "C001", "invalid input"),
    RESOURCE_NOT_FOUND(HttpStatus.NOT_FOUND, "C002", "resource not found"),
    INTERNAL_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "C999", "internal server error"),

    // Auth
    UNAUTHORIZED(HttpStatus.UNAUTHORIZED, "A001", "authentication required"),
    FORBIDDEN(HttpStatus.FORBIDDEN, "A002", "access denied"),

    // User / Signup
    DUPLICATE_EMAIL(HttpStatus.CONFLICT, "U001", "이미 사용 중인 이메일입니다"),
    DUPLICATE_NICKNAME(HttpStatus.CONFLICT, "U002", "이미 사용 중인 닉네임입니다"),
    PASSWORD_MISMATCH(HttpStatus.BAD_REQUEST, "U003", "비밀번호가 일치하지 않습니다");

    private final HttpStatus status;
    private final String code;
    private final String message;
}
