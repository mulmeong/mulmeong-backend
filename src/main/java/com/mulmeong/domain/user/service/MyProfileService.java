package com.mulmeong.domain.user.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mulmeong.domain.auth.service.RefreshTokenService;
import com.mulmeong.domain.dart.service.DartService;
import com.mulmeong.domain.favorite.service.FavoriteService;
import com.mulmeong.domain.magazine.service.MagazineService;
import com.mulmeong.domain.pamphlet.service.PamphletService;
import com.mulmeong.domain.region.service.RegionStatService;
import com.mulmeong.domain.review.dto.response.RecentOnsenSummary;
import com.mulmeong.domain.review.service.MyReviewService;
import com.mulmeong.domain.user.dto.request.UpdateMeRequest;
import com.mulmeong.domain.user.dto.response.MyProfileResponse;
import com.mulmeong.domain.user.dto.response.PublicProfileResponse;
import com.mulmeong.domain.user.dto.response.UpdateMeResponse;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;

import lombok.RequiredArgsConstructor;

/**
 * 701(내 프로필)·706(내 정보 수정)·708(공개 프로필)·709(탈퇴)처럼 user 도메인 하나로 끝나지 않는
 * 마이페이지 API를 조합한다. UserService/FavoriteService/PamphletService/MyReviewService/
 * RegionStatService/MagazineService는 전부 Service 계층을 통해서만 접근한다(Repository 직접 주입 금지 규칙).
 */
@Service
@RequiredArgsConstructor
public class MyProfileService {

    private static final String PROFILE_SHARE_BASE = "https://mulmeong.app/u/";
    private static final int RECENT_ONSEN_LIMIT = 3;

    private final UserService userService;
    private final FavoriteService favoriteService;
    private final PamphletService pamphletService;
    private final MyReviewService myReviewService;
    private final RegionStatService regionStatService;
    private final MagazineService magazineService;
    private final DartService dartService;
    private final RefreshTokenService refreshTokenService;

    @Transactional(readOnly = true)
    public MyProfileResponse myProfile(Long userId) {
        User user = requireUser(userId);
        var editableAt = userService.nicknameEditableAt(user);

        return new MyProfileResponse(
                user.getId(),
                user.getEmail(),
                user.getNickname(),
                user.level().number(),
                user.level().title(),
                user.getVisitCount(),
                myReviewService.countByUserId(userId),
                regionStatService.grapeRegionCount(userId),
                user.getNicknameChangedAt(),
                editableAt == null,
                editableAt,
                user.getProfileShareToken(),
                user.getProfileShareToken() == null ? null : PROFILE_SHARE_BASE + user.getProfileShareToken(),
                favoriteService.countByUserId(userId),
                pamphletService.countByUserId(userId),
                user.getCreatedAt());
    }

    @Transactional
    public UpdateMeResponse updateMe(Long userId, UpdateMeRequest request) {
        boolean nicknameChange = request.isNicknameChange();
        boolean passwordChange = request.isPasswordChange();
        if (nicknameChange == passwordChange) {
            // 둘 다 비어있거나 둘 다 채워진 경우 모두 잘못된 요청.
            throw new BusinessException(nicknameChange ? ErrorCode.MIXED_UPDATE_NOT_ALLOWED : ErrorCode.VALIDATION_FAILED);
        }

        if (nicknameChange) {
            User user = userService.changeNickname(userId, request.nickname());
            return new UpdateMeResponse(user.getId(), user.getNickname(), user.getNicknameChangedAt(),
                    userService.nicknameEditableAt(user), false);
        }

        userService.changePassword(userId, request.currentPassword(), request.newPassword(),
                request.newPasswordConfirm());
        refreshTokenService.revokeAllForUser(userId);
        return new UpdateMeResponse(userId, null, null, null, true);
    }

    @Transactional(readOnly = true)
    public PublicProfileResponse publicProfile(String profileShareToken, Long viewerId) {
        User user = userService.getByProfileShareToken(profileShareToken)
                .filter(found -> !found.isWithdrawn())
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));

        List<RegionStatService.VisitedRegionSummary> visited = regionStatService.visitedSidoSummaries(user.getId());
        List<PublicProfileResponse.Region> regions = visited.stream()
                .map(r -> new PublicProfileResponse.Region(r.regionCode(), r.name(), r.visitCount(), r.density()))
                .toList();
        List<RecentOnsenSummary> recent = myReviewService.recentOnsens(user.getId(), RECENT_ONSEN_LIMIT);
        List<PublicProfileResponse.RecentOnsen> recentOnsens = recent.stream()
                .map(r -> new PublicProfileResponse.RecentOnsen(r.onsenId(), r.name(), r.thumbnail()))
                .toList();

        return new PublicProfileResponse(
                user.getProfileShareToken(),
                user.getNickname(),
                user.level().number(),
                user.level().title(),
                viewerId != null && viewerId.equals(user.getId()),
                user.getVisitCount(),
                regionStatService.grapeRegionCount(user.getId()),
                regions.size(),
                regions,
                recentOnsens,
                PROFILE_SHARE_BASE + user.getProfileShareToken(),
                user.getCreatedAt().toLocalDate());
    }

    /** 709. 남긴 리뷰·다트 기록은 유지하되 회원 연결만 끊는다 — 찜·팜플렛·매거진 좋아요·포도알은 삭제. */
    @Transactional
    public void withdraw(Long userId, String password) {
        userService.withdraw(userId, password);
        favoriteService.deleteAllByUserId(userId);
        pamphletService.deleteAllByUserId(userId);
        regionStatService.deleteAllByUserId(userId);
        magazineService.unlikeAllByUser(userId);
        dartService.anonymizeUserId(userId);
        refreshTokenService.revokeAllForUser(userId);
    }

    private User requireUser(Long userId) {
        return userService.getById(userId)
                .filter(found -> !found.isWithdrawn())
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));
    }
}
