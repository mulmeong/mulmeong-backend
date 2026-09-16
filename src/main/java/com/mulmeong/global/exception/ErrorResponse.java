package com.mulmeong.global.exception;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;

/** Common error body: {@code { "code": "...", "message": "...", "fieldErrors": [...] } }. */
@JsonInclude(JsonInclude.Include.NON_NULL)
public record ErrorResponse(String code, String message, List<FieldErrorDetail> fieldErrors) {

    public record FieldErrorDetail(String field, String reason) {
    }

    public static ErrorResponse of(ErrorCode errorCode) {
        return new ErrorResponse(errorCode.name(), errorCode.getMessage(), null);
    }

    public static ErrorResponse of(ErrorCode errorCode, String message) {
        return new ErrorResponse(errorCode.name(), message, null);
    }

    public static ErrorResponse of(ErrorCode errorCode, List<FieldErrorDetail> fieldErrors) {
        return new ErrorResponse(errorCode.name(), errorCode.getMessage(), fieldErrors);
    }
}
