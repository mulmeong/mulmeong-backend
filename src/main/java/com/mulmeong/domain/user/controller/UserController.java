package com.mulmeong.domain.user.controller;

import com.mulmeong.domain.user.dto.request.SignupRequest;
import com.mulmeong.domain.user.dto.response.EmailCheckResponse;
import com.mulmeong.domain.user.dto.response.NicknameCheckResponse;
import com.mulmeong.domain.user.dto.response.SignupResponse;
import com.mulmeong.domain.user.service.UserService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 101 회원가입, 닉네임 중복확인. 로그인/재발급/로그아웃은 domain.auth의 AuthController.
 */
@Validated
@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    /**
     * 101 회원가입.
     */
    @PostMapping("/signup")
    @ResponseStatus(HttpStatus.CREATED)
    public SignupResponse signup(@Valid @RequestBody SignupRequest request) {
        return userService.signup(request);
    }

    /**
     * 103 이메일 중복 확인.
     */
    @GetMapping("/email/check")
    public EmailCheckResponse checkEmail(@RequestParam @Email String email) {
        return userService.checkEmail(email);
    }

    /**
     * 닉네임 중복 확인.
     */
    @GetMapping("/nickname/check")
    public NicknameCheckResponse checkNickname(
            @RequestParam
            @Size(min = 2, max = 10, message = "닉네임은 2~10자로 입력해주세요")
            String nickname
    ) {
        return userService.checkNickname(nickname);
    }
}
