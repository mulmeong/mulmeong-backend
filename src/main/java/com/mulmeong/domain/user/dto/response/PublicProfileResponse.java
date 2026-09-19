package com.mulmeong.domain.user.dto.response;

import java.time.LocalDate;
import java.util.List;

/**
 * 708 GET /profiles/{profileShareToken}. 개인정보(이메일·이름·생년월일·전화번호) 절대 포함 금지 — 701과 응답을 공유하지 않는다.
 */
public record PublicProfileResponse(
        String profileShareToken,
        String nickname,
        int level,
        String title,
        boolean isMine,
        int visitedOnsenCount,
        long grapeRegionCount,
        long totalRegions,
        List<Region> regions,
        List<RecentOnsen> recentOnsens,
        String shareUrl,
        LocalDate joinedAt) {

    public record Region(String regionCode, String name, int visitCount, double density) {
    }

    public record RecentOnsen(Long onsenId, String name, String thumbnail) {
    }
}
