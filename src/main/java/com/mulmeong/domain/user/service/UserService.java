package com.mulmeong.domain.user.service;

//import java.security.SecureRandom;

import com.mulmeong.domain.user.dto.request.SignupRequest;
import com.mulmeong.domain.user.dto.response.EmailCheckResponse;
import com.mulmeong.domain.user.dto.response.NicknameCheckResponse;
import com.mulmeong.domain.user.dto.response.SignupResponse;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.domain.user.repository.UserRepository;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import com.mulmeong.global.util.RandomTokenGenerator;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.OffsetDateTime;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    /**
     * MY-07: 닉네임은 마지막 변경 후 30일이 지나야 다시 바꿀 수 있다.
     */
    private static final Duration NICKNAME_CHANGE_COOLDOWN = Duration.ofDays(30);

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

    /**
     * 이메일 사용 가능 여부 (API 103). 중복이어도 409가 아니라 200 + available=false.
     */
    @Transactional(readOnly = true)
    public EmailCheckResponse checkEmail(String email) {
        String normalized = email.trim().toLowerCase();
        return new EmailCheckResponse(normalized, !userRepository.existsByEmail(normalized));
    }

    /**
     * 닉네임 사용 가능 여부.
     */
    @Transactional(readOnly = true)
    public NicknameCheckResponse checkNickname(Long userId, String nickname) {
        User user = requireActiveUser(userId);
        OffsetDateTime editableAt = nicknameEditableAt(user);
        boolean available = nickname.equals(user.getNickname()) || !userRepository.existsByNickname(nickname);
        return new NicknameCheckResponse(nickname, available, editableAt == null, editableAt);
    }

    /** 기존 단위 테스트와 가입 전 중복 확인 호환용. API 108은 사용자 정보를 포함하는 위 메서드를 사용한다. */
    @Transactional(readOnly = true)
    public NicknameCheckResponse checkNickname(String nickname) {
        return new NicknameCheckResponse(nickname, !userRepository.existsByNickname(nickname), true, null);
    }

    /**
     * domain.auth가 로그인/재발급에서 쓰는 조회. 다른 도메인은 UserRepository를 직접 주입하지 않고 이걸 통해 접근한다.
     */
    @Transactional(readOnly = true)
    public Optional<User> getByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Transactional(readOnly = true)
    public Optional<User> getById(Long id) {
        return userRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public Optional<User> getByProfileShareToken(String token) {
        return userRepository.findByProfileShareToken(token);
    }

    /**
     * 방문 인증 흐름 직렬화 및 레벨 전후 계산용. 카운트 변경은 아래 UPDATE 쿼리로만 한다.
     */
    @Transactional
    public User lockActiveUser(Long userId) {
        User user = userRepository.findByIdForUpdate(userId)
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));
        if (user.isWithdrawn()) throw new BusinessException(ErrorCode.USER_NOT_FOUND);
        return user;
    }

    @Transactional
    public void incrementVisitCount(Long userId) {
        userRepository.incrementVisitCount(userId);
    }

    @Transactional
    public void decrementVisitCount(Long userId) {
        userRepository.decrementVisitCount(userId);
    }

    /**
     * 30일 이내 변경했으면 다음 변경 가능 시각, 아니면 null (지금 바로 가능).
     */
    public OffsetDateTime nicknameEditableAt(User user) {
        if (user.getNicknameChangedAt() == null) return null;
        OffsetDateTime editableAt = user.getNicknameChangedAt().plus(NICKNAME_CHANGE_COOLDOWN);
        return editableAt.isAfter(OffsetDateTime.now()) ? editableAt : null;
    }

    /**
     * 706-①: 닉네임 변경.
     */
    @Transactional
    public User changeNickname(Long userId, String nickname) {
        User user = requireActiveUser(userId);
        OffsetDateTime editableAt = nicknameEditableAt(user);
        if (editableAt != null) {
            throw new BusinessException(ErrorCode.NICKNAME_CHANGE_TOO_SOON);
        }
        if (userRepository.existsByNickname(nickname)) {
            throw new BusinessException(ErrorCode.DUPLICATE_NICKNAME);
        }
        user.changeNickname(nickname, OffsetDateTime.now());
        return user;
    }

    /**
     * 706-②: 비밀번호 변경.
     */
    @Transactional
    public void changePassword(Long userId, String currentPassword, String newPassword, String newPasswordConfirm) {
        User user = requireActiveUser(userId);
        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            throw new BusinessException(ErrorCode.CURRENT_PASSWORD_MISMATCH);
        }
        if (!newPassword.equals(newPasswordConfirm)) {
            throw new BusinessException(ErrorCode.PASSWORD_MISMATCH);
        }
        user.changePassword(passwordEncoder.encode(newPassword));
    }

    /**
     * 709: 탈퇴. users 테이블 자체의 소프트 삭제만 담당 — 찜/팜플렛/포도알 등 다른 도메인 정리는 호출자(orchestrator)의 몫.
     */
    @Transactional
    public void withdraw(Long userId, String password) {
        User user = requireActiveUser(userId);
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new BusinessException(ErrorCode.CURRENT_PASSWORD_MISMATCH);
        }
        user.withdraw(OffsetDateTime.now());
    }

    private User requireActiveUser(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));
        if (user.isWithdrawn()) {
            throw new BusinessException(ErrorCode.USER_NOT_FOUND);
        }
        return user;
    }

//    private String generateNickname() {
//        String nickname;
//        do {
//            nickname = NICKNAME_PREFIX + String.format("%04d", RANDOM.nextInt(10_000));
//        } while (userRepository.existsByNickname(nickname));
//        return nickname;
//    }
}
