package com.mulmeong.domain.user.service;

//import java.security.SecureRandom;
import java.util.Optional;

import com.mulmeong.domain.user.dto.response.NicknameCheckResponse;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mulmeong.domain.user.dto.request.SignupRequest;
//import com.mulmeong.domain.user.dto.response.EmailCheckResponse;
import com.mulmeong.domain.user.dto.response.SignupResponse;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.domain.user.repository.UserRepository;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import com.mulmeong.global.util.RandomTokenGenerator;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

//    private static final String NICKNAME_PREFIX = "물멍러";
//    private static final SecureRandom RANDOM = new SecureRandom();

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    // 회원가입 (AUTH-07 / API 101). 닉네임은 사용자 입력, 이메일 인증 없음.
    @Transactional
    public SignupResponse signup(SignupRequest request) {
        if (!request.password().equals(request.passwordConfirm())) {
            throw new BusinessException(ErrorCode.PASSWORD_MISMATCH);
        }

        String email = request.email().trim().toLowerCase();

        // 가입할 때 중복 이메일 가입 방지
        if (userRepository.existsByEmail(email)) {
            throw new BusinessException(ErrorCode.DUPLICATE_EMAIL);
        }

        if (userRepository.existsByNickname(request.nickname())) {
            throw new BusinessException(ErrorCode.DUPLICATE_NICKNAME);
        }

        User user = User.createLocal(
                request.name(),
                email,
                passwordEncoder.encode(request.password()),
                request.phone(),
                request.birthDate(),
                request.nickname(),
                RandomTokenGenerator.generate(8)
        );

        try {
            return SignupResponse.from(userRepository.save(user));
        } catch (DataIntegrityViolationException e) {
            // email UNIQUE 위반이 동시 요청으로 여기까지 온 경우.
            throw new BusinessException(ErrorCode.DUPLICATE_EMAIL);
        }
    }

//    /** 이메일 사용 가능 여부 (API 103). 중복이어도 409가 아니라 200 + available=false. */
//    @Transactional(readOnly = true)
//    public EmailCheckResponse checkEmail(String email) {
//        String normalized = email.trim().toLowerCase();
//        return new EmailCheckResponse(normalized, !userRepository.existsByEmail(normalized));
//    }

    /** 닉네임 사용 가능 여부. */
    @Transactional(readOnly = true)
    public NicknameCheckResponse checkNickname(String nickname) {
        return new NicknameCheckResponse(
                nickname,
                !userRepository.existsByNickname(nickname)
        );
    }

    /** domain.auth가 로그인/재발급에서 쓰는 조회. 다른 도메인은 UserRepository를 직접 주입하지 않고 이걸 통해 접근한다. */
    @Transactional(readOnly = true)
    public Optional<User> getByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Transactional(readOnly = true)
    public Optional<User> getById(Long id) {
        return userRepository.findById(id);
    }

//    private String generateNickname() {
//        String nickname;
//        do {
//            nickname = NICKNAME_PREFIX + String.format("%04d", RANDOM.nextInt(10_000));
//        } while (userRepository.existsByNickname(nickname));
//        return nickname;
//    }
}
