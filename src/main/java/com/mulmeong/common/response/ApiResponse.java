package com.mulmeong.common.response;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * Standard envelope for every REST response.
 *
 * <pre>
 * { "success": true,  "data": { ... }, "message": null }
 * { "success": false, "data": null,    "message": "error description" }
 * </pre>
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public record ApiResponse<T>(boolean success, T data, String message) {

    public static <T> ApiResponse<T> ok(T data) {
        return new ApiResponse<>(true, data, null);
    }

    public static ApiResponse<Void> ok() {
        return new ApiResponse<>(true, null, null);
    }

    public static ApiResponse<Void> fail(String message) {
        return new ApiResponse<>(false, null, message);
    }
}
