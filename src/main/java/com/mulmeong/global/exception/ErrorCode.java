package com.mulmeong.global.exception;

import org.springframework.http.HttpStatus;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * {@code name()} is the wire "code" sent to clients — keep names stable, they're part of the API contract.
 */
@Getter
@RequiredArgsConstructor
public enum ErrorCode {

    // Common
    VALIDATION_FAILED(HttpStatus.BAD_REQUEST, "입력값을 확인해주세요"),
    RESOURCE_NOT_FOUND(HttpStatus.NOT_FOUND, "요청한 리소스를 찾을 수 없습니다"),
    METHOD_NOT_ALLOWED(HttpStatus.METHOD_NOT_ALLOWED, "허용되지 않은 요청 방식입니다"),
    INTERNAL_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "일시적인 오류가 발생했습니다"),

    // Auth
    UNAUTHORIZED(HttpStatus.UNAUTHORIZED, "로그인이 필요합니다"),
    FORBIDDEN(HttpStatus.FORBIDDEN, "접근 권한이 없습니다"),
    LOGIN_FAILED(HttpStatus.UNAUTHORIZED, "이메일 또는 비밀번호가 올바르지 않습니다"),
    ACCOUNT_WITHDRAWN(HttpStatus.FORBIDDEN, "탈퇴한 계정입니다"),
    REFRESH_TOKEN_MISSING(HttpStatus.UNAUTHORIZED, "로그인이 필요합니다"),
    REFRESH_TOKEN_INVALID(HttpStatus.UNAUTHORIZED, "다시 로그인해주세요"),

    // User / Signup
    DUPLICATE_EMAIL(HttpStatus.CONFLICT, "이미 사용 중인 이메일입니다"),
    PASSWORD_MISMATCH(HttpStatus.BAD_REQUEST, "비밀번호가 일치하지 않습니다"),
    DUPLICATE_NICKNAME(HttpStatus.CONFLICT, "이미 사용 중인 닉네임입니다"),

    // Map / Place
    INVALID_BBOX(HttpStatus.BAD_REQUEST, "지도 영역이 올바르지 않습니다"),
    BBOX_TOO_LARGE(HttpStatus.BAD_REQUEST, "지도 영역이 너무 넓습니다. 지도를 확대해주세요"),
    KEYWORD_TOO_SHORT(HttpStatus.BAD_REQUEST, "검색어는 2자 이상 입력해주세요"),
    INVALID_NEARBY_REQUEST(HttpStatus.BAD_REQUEST, "주변 여행지 요청값이 올바르지 않습니다"),
    MAGAZINE_NOT_FOUND(HttpStatus.NOT_FOUND, "존재하지 않는 매거진입니다"),
    INVALID_MAGAZINE_FILTER(HttpStatus.BAD_REQUEST, "매거진 필터값이 올바르지 않습니다"),
    UNSUPPORTED_IMAGE_TYPE(HttpStatus.BAD_REQUEST, "지원하지 않는 이미지 형식입니다"),
    IMAGE_TOO_LARGE(HttpStatus.BAD_REQUEST, "이미지 용량은 10MB 이하여야 합니다"),
    ONSEN_NOT_FOUND(HttpStatus.NOT_FOUND, "존재하지 않는 온천입니다"),

    // External proxy
    INVALID_CATEGORY(HttpStatus.BAD_REQUEST, "정의되지 않은 카테고리입니다"),
    RADIUS_TOO_LARGE(HttpStatus.BAD_REQUEST, "반경은 20km를 넘을 수 없습니다"),
    INVALID_MODE(HttpStatus.BAD_REQUEST, "정의되지 않은 길찾기 수단입니다"),
    ORIGIN_REQUIRED(HttpStatus.BAD_REQUEST, "자차 길찾기는 출발지 좌표가 필요합니다"),
    ROUTE_NOT_FOUND(HttpStatus.NOT_FOUND, "경로를 찾을 수 없습니다"),
    EXTERNAL_API_FAILED(HttpStatus.BAD_GATEWAY, "외부 서비스 호출에 실패했습니다"),
    EXTERNAL_QUOTA_EXCEEDED(HttpStatus.TOO_MANY_REQUESTS, "외부 서비스 호출 한도를 초과했습니다");

    private final HttpStatus status;
    private final String message;
}
