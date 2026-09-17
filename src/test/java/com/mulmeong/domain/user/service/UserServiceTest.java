package com.mulmeong.domain.user.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;

import java.time.LocalDate;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.mulmeong.domain.user.dto.request.SignupRequest;
import com.mulmeong.domain.user.dto.response.EmailCheckResponse;
import com.mulmeong.domain.user.dto.response.NicknameCheckResponse;
import com.mulmeong.domain.user.dto.response.SignupResponse;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.domain.user.repository.UserRepository;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private UserService userService;

    private SignupRequest request(String email, String password, String confirm, String nickname) {
        return new SignupRequest(email, password, confirm, "김온천", LocalDate.of(1995, 1, 1), "010-1234-5678", nickname);
    }

    @Test
    @DisplayName("회원가입 성공: 이메일은 소문자로 정규화되고 입력한 닉네임이 그대로 저장된다")
    void signup_success() {
        SignupRequest req = request("Test@Example.COM", "password1", "password1", "온탕러버");
        given(userRepository.existsByEmail("test@example.com")).willReturn(false);
        given(userRepository.existsByNickname("온탕러버")).willReturn(false);
        given(passwordEncoder.encode("password1")).willReturn("ENCODED");
        given(userRepository.save(any(User.class))).willAnswer(inv -> inv.getArgument(0));

        SignupResponse res = userService.signup(req);

        assertThat(res.email()).isEqualTo("test@example.com");
        assertThat(res.nickname()).isEqualTo("온탕러버");
        verify(passwordEncoder).encode("password1");
    }

    @Test
    @DisplayName("비밀번호와 확인이 다르면 PASSWORD_MISMATCH, 저장하지 않는다")
    void signup_passwordMismatch() {
        SignupRequest req = request("test@example.com", "password1", "password2", "온탕러버");

        assertThatThrownBy(() -> userService.signup(req))
                .isInstanceOf(BusinessException.class)
                .extracting("errorCode").isEqualTo(ErrorCode.PASSWORD_MISMATCH);
        verify(userRepository, never()).save(any());
    }

    @Test
    @DisplayName("이메일이 중복이면 DUPLICATE_EMAIL")
    void signup_duplicateEmail() {
        SignupRequest req = request("test@example.com", "password1", "password1", "온탕러버");
        given(userRepository.existsByEmail("test@example.com")).willReturn(true);

        assertThatThrownBy(() -> userService.signup(req))
                .isInstanceOf(BusinessException.class)
                .extracting("errorCode").isEqualTo(ErrorCode.DUPLICATE_EMAIL);
        verify(userRepository, never()).save(any());
    }

    @Test
    @DisplayName("닉네임이 중복이면 DUPLICATE_NICKNAME")
    void signup_duplicateNickname() {
        SignupRequest req = request("test@example.com", "password1", "password1", "온탕러버");
        given(userRepository.existsByEmail("test@example.com")).willReturn(false);
        given(userRepository.existsByNickname("온탕러버")).willReturn(true);

        assertThatThrownBy(() -> userService.signup(req))
                .isInstanceOf(BusinessException.class)
                .extracting("errorCode").isEqualTo(ErrorCode.DUPLICATE_NICKNAME);
        verify(userRepository, never()).save(any());
    }

    @Test
    @DisplayName("이메일 중복 확인: 사용 가능하면 소문자로 정규화하고 available=true")
    void checkEmail_available() {
        given(userRepository.existsByEmail("test@example.com")).willReturn(false);

        EmailCheckResponse res = userService.checkEmail(" Test@Example.COM ");

        assertThat(res.email()).isEqualTo("test@example.com");
        assertThat(res.available()).isTrue();
    }

    @Test
    @DisplayName("이메일 중복 확인: 중복이면 available=false")
    void checkEmail_duplicate() {
        given(userRepository.existsByEmail("test@example.com")).willReturn(true);

        EmailCheckResponse res = userService.checkEmail("test@example.com");

        assertThat(res.available()).isFalse();
    }

    @Test
    @DisplayName("닉네임 중복 확인: 사용 가능하면 available=true")
    void checkNickname_available() {
        given(userRepository.existsByNickname("온탕러버")).willReturn(false);

        NicknameCheckResponse res = userService.checkNickname("온탕러버");

        assertThat(res.nickname()).isEqualTo("온탕러버");
        assertThat(res.available()).isTrue();
    }

    @Test
    @DisplayName("닉네임 중복 확인: 중복이면 available=false")
    void checkNickname_duplicate() {
        given(userRepository.existsByNickname("온탕러버")).willReturn(true);

        NicknameCheckResponse res = userService.checkNickname("온탕러버");

        assertThat(res.available()).isFalse();
    }
}
