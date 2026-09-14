package com.mulmeong.global.exception;

import lombok.Getter;

/**
 * Throw this for any expected, domain-level failure. {@link GlobalExceptionHandler}
 * turns it into the matching HTTP status and {@link com.mulmeong.global.response.ApiResponse}.
 */
@Getter
public class BusinessException extends RuntimeException {

    private final ErrorCode errorCode;

    public BusinessException(ErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
    }

    public BusinessException(ErrorCode errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }
}
