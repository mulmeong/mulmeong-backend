package com.mulmeong.domain.user.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.mulmeong.domain.user.dto.request.SignupRequest;
import com.mulmeong.domain.user.dto.response.AvailabilityResponse;
import com.mulmeong.domain.user.dto.response.SignupResponse;
import com.mulmeong.domain.user.service.UserService;
import com.mulmeong.global.response.ApiResponse;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;

    /** 회원가입 (AUTH-07). */
    @PostMapping("/signup")
    @ResponseStatus(HttpStatus.CREATED)
    public ApiResponse<SignupResponse> signup(@Valid @RequestBody SignupRequest request) {
        return ApiResponse.ok(userService.signup(request));
    }

    /** 이메일 중복 확인. */
    @GetMapping("/check-email")
    public ApiResponse<AvailabilityResponse> checkEmail(@RequestParam String email) {
        return ApiResponse.ok(new AvailabilityResponse(userService.isEmailAvailable(email)));
    }

    /** 닉네임 중복 확인. */
    @GetMapping("/check-nickname")
    public ApiResponse<AvailabilityResponse> checkNickname(@RequestParam String nickname) {
        return ApiResponse.ok(new AvailabilityResponse(userService.isNicknameAvailable(nickname)));
    }
}
