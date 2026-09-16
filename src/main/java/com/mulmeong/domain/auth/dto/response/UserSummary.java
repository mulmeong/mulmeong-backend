package com.mulmeong.domain.auth.dto.response;

import com.mulmeong.domain.user.entity.User;
import com.mulmeong.global.common.Level;

public record UserSummary(Long userId, String nickname, int level, String title) {

    public static UserSummary from(User user) {
        Level level = user.level();
        return new UserSummary(user.getId(), user.getNickname(), level.number(), level.title());
    }
}
