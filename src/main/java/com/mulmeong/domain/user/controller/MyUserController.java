package com.mulmeong.domain.user.controller;

import com.mulmeong.domain.user.dto.request.UpdateMeRequest;
import com.mulmeong.domain.user.dto.request.WithdrawRequest;
import com.mulmeong.domain.user.dto.response.LevelResponse;
import com.mulmeong.domain.user.dto.response.MyProfileResponse;
import com.mulmeong.domain.user.dto.response.UpdateMeResponse;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.domain.user.service.MyProfileService;
import com.mulmeong.domain.user.service.UserService;
import com.mulmeong.global.common.Level;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 701 내 프로필 헤더, 703 레벨 시스템, 706 내 정보 수정, 709 계정 탈퇴.
 */
@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
public class MyUserController {

    private final UserService userService;
    private final MyProfileService myProfileService;

    @GetMapping("/me")
    public MyProfileResponse getMe(@AuthenticationPrincipal Long userId) {
        return myProfileService.myProfile(userId);
    }

    @GetMapping("/me/level")
    public LevelResponse getMyLevel(@AuthenticationPrincipal Long userId) {
        User user = userService.getById(userId)
                .filter(found -> !found.isWithdrawn())
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));
        Level level = user.level();
        Integer nextMin = level.nextLevelMin();
        int toNext = nextMin == null ? 0 : Math.max(nextMin - user.getVisitCount(), 0);
        double progress = level.isMaxLevel()
                ? 1.0
                : (user.getVisitCount() - level.minVisits()) / (double) (nextMin - level.minVisits());

        List<LevelResponse.LevelItem> levels = Arrays.stream(Level.values())
                .map(l -> new LevelResponse.LevelItem(l.number(), l.title(), l.minVisits()))
                .toList();

        return new LevelResponse(level.number(), level.title(), user.getVisitCount(), level.minVisits(), nextMin,
                toNext, progress, level.isMaxLevel(), levels);
    }

    @PatchMapping("/me")
    public UpdateMeResponse updateMe(@AuthenticationPrincipal Long userId, @Valid @RequestBody UpdateMeRequest request) {
        return myProfileService.updateMe(userId, request);
    }

    @DeleteMapping("/me")
    public ResponseEntity<Void> withdraw(@AuthenticationPrincipal Long userId,
                                         @Valid @RequestBody WithdrawRequest request) {
        myProfileService.withdraw(userId, request.password());
        ResponseCookie expiredRefreshToken = ResponseCookie.from("refreshToken", "")
                .httpOnly(true)
                .path("/api/v1/auth")
                .maxAge(0)
                .build();
        return ResponseEntity.noContent()
                .header(HttpHeaders.SET_COOKIE, expiredRefreshToken.toString())
                .build();
    }
}
