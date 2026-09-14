package com.mulmeong.domain.user.entity;

/** users.provider — 가입 경로. 지금은 LOCAL만, 소셜 로그인은 범위 ② (AUTH-04). */
public enum Provider {
    LOCAL,
    GOOGLE,
    NAVER,
    KAKAO
}
