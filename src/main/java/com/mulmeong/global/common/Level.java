package com.mulmeong.global.common;

/**
 * users.visit_count 기준 레벨/칭호. DB에 저장하지 않고 항상 여기서 계산한다.
 */
public enum Level {

    LV1(0, 2, "첫 탕"),
    LV2(3, 5, "물 좀 아는"),
    LV3(6, 10, "탕 순례자"),
    LV4(11, 20, "온천 애호가"),
    LV5(21, Integer.MAX_VALUE, "물멍 마스터");

    private final int min;
    private final int max;
    private final String title;

    Level(int min, int max, String title) {
        this.min = min;
        this.max = max;
        this.title = title;
    }

    public static Level from(int visitCount) {
        for (Level level : values()) {
            if (visitCount >= level.min && visitCount <= level.max) {
                return level;
            }
        }
        return LV5;
    }

    public int number() {
        return ordinal() + 1;
    }

    public String title() {
        return title;
    }

    public int minVisits() {
        return min;
    }

    /**
     * 다음 레벨의 최소 방문 수. 최고 레벨이면 null.
     */
    public Integer nextLevelMin() {
        Level[] values = values();
        int next = ordinal() + 1;
        return next < values.length ? values[next].min : null;
    }

    public boolean isMaxLevel() {
        return this == LV5;
    }
}
