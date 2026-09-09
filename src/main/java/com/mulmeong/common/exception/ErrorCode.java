package com.mulmeong.common.exception;

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
    FORBIDDEN(HttpStatus.FORBIDDEN, "A002", "access denied");

    private final HttpStatus status;
    private final String code;
    private final String message;
}
