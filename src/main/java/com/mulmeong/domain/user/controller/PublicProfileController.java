package com.mulmeong.domain.user.controller;

import com.mulmeong.domain.user.dto.response.PublicProfileResponse;
import com.mulmeong.domain.user.service.MyProfileService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 708 공개 프로필. 인증 없음 — 로그인했으면(선택 인증) isMine 계산에 쓴다.
 */
@RestController
@RequestMapping("/api/v1/profiles")
@RequiredArgsConstructor
public class PublicProfileController {

    private final MyProfileService myProfileService;

    @GetMapping("/{profileShareToken}")
    public PublicProfileResponse publicProfile(@PathVariable String profileShareToken,
                                               @AuthenticationPrincipal Long viewerId) {
        return myProfileService.publicProfile(profileShareToken, viewerId);
    }
}
