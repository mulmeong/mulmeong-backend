package com.mulmeong.domain.user.dto.response;

import java.util.List;

/**
 * 703 GET /users/me/level.
 */
public record LevelResponse(int level, String title, int visitedOnsenCount, int currentLevelMin,
                            Integer nextLevelMin, int toNextLevel, double progress, boolean isMaxLevel,
                            List<LevelItem> levels) {

    public record LevelItem(int level, String title, int minVisits) {
    }
}
