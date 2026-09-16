package com.mulmeong.domain.place.entity;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum AccessLevel {
    WALKABLE("뚜벅이 가능"),
    CAR_RECOMMENDED("자차 권장"),
    CAR_REQUIRED("자차 필수");

    private final String label;
}
