package com.mulmeong.common.exception;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import com.mulmeong.common.response.ApiResponse;

import lombok.extern.slf4j.Slf4j;

/**
 * Turns every error into an {@link ApiResponse} envelope.
 * Extends {@link ResponseEntityExceptionHandler} so the framework's own MVC
 * exceptions keep their correct status (404, 405, 400, ...) instead of collapsing to 500.
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<ApiResponse<Void>> handleBusiness(BusinessException e) {
        ErrorCode code = e.getErrorCode();
        log.warn("BusinessException [{}] {}", code.getCode(), e.getMessage());
        return ResponseEntity.status(code.getStatus()).body(ApiResponse.fail(e.getMessage()));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiResponse<Void>> handleUnexpected(Exception e) {
        log.error("Unhandled exception", e);
        return ResponseEntity.status(ErrorCode.INTERNAL_ERROR.getStatus())
                .body(ApiResponse.fail(ErrorCode.INTERNAL_ERROR.getMessage()));
    }

    /** Wrap the built-in MVC error responses (404, 405, 415, malformed body, ...) in {@link ApiResponse}. */
    @Override
    protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body,
            HttpHeaders headers, HttpStatusCode statusCode, WebRequest request) {
        String message = (statusCode instanceof HttpStatus status) ? status.getReasonPhrase() : "request failed";
        if (ex instanceof MethodArgumentNotValidException validationError) {
            message = validationError.getBindingResult().getFieldErrors().stream()
                    .findFirst()
                    .map(fieldError -> fieldError.getField() + ": " + fieldError.getDefaultMessage())
                    .orElse(message);
        }
        return super.handleExceptionInternal(ex, ApiResponse.fail(message), headers, statusCode, request);
    }
}
