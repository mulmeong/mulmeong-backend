package com.mulmeong.domain.user.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mulmeong.domain.user.dto.request.SignupRequest;
import com.mulmeong.domain.user.dto.response.SignupResponse;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.domain.user.repository.UserRepository;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    /** 회원가입 (AUTH-07). 이메일 인증 없음. */
    @Transactional
    public SignupResponse signup(SignupRequest request) {
        if (!request.password().equals(request.passwordConfirm())) {
            throw new BusinessException(ErrorCode.PASSWORD_MISMATCH);
        }
        if (userRepository.existsByEmail(request.email())) {
            throw new BusinessException(ErrorCode.DUPLICATE_EMAIL);
        }
        if (userRepository.existsByNickname(request.nickname())) {
            throw new BusinessException(ErrorCode.DUPLICATE_NICKNAME);
        }

        User user = User.createLocal(
                request.email(),
                passwordEncoder.encode(request.password()),
                request.nickname());

        return SignupResponse.from(userRepository.save(user));
    }

    /** 이메일 사용 가능 여부 (회원가입 화면 중복 확인). */
    @Transactional(readOnly = true)
    public boolean isEmailAvailable(String email) {
        return !userRepository.existsByEmail(email);
    }

    /** 닉네임 사용 가능 여부 (회원가입 화면 중복 확인). */
    @Transactional(readOnly = true)
    public boolean isNicknameAvailable(String nickname) {
        return !userRepository.existsByNickname(nickname);
    }
}
