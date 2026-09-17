package com.mulmeong.domain.magazine.entity;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum MagazineCategory {
    VILLAGE_STORY("온천마을 이야기"), WALKING_GUIDE("뚜벅이 가이드"), SEASONAL("시즌 추천"),
    ONSEN_SCIENCE("온천 과학"), FOOD("먹거리");
    private final String label;
}
