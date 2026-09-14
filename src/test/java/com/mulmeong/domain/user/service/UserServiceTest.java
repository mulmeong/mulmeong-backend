package com.mulmeong.domain.user.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.mulmeong.domain.user.dto.request.SignupRequest;
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
        return new SignupRequest(email, password, confirm, nickname);
    }

    @Test
    @DisplayName("회원가입 성공: 비밀번호는 인코딩되어 저장되고 응답에 민감정보가 없다")
    void signup_success() {
        SignupRequest req = request("a@b.com", "password1", "password1", "온탕러버");
        given(userRepository.existsByEmail("a@b.com")).willReturn(false);
        given(userRepository.existsByNickname("온탕러버")).willReturn(false);
        given(passwordEncoder.encode("password1")).willReturn("ENCODED");
        given(userRepository.save(any(User.class))).willAnswer(inv -> inv.getArgument(0));

        SignupResponse res = userService.signup(req);

        assertThat(res.email()).isEqualTo("a@b.com");
        assertThat(res.nickname()).isEqualTo("온탕러버");
        verify(passwordEncoder).encode("password1");
    }

    @Test
    @DisplayName("비밀번호와 확인이 다르면 PASSWORD_MISMATCH, 저장하지 않는다")
    void signup_passwordMismatch() {
        SignupRequest req = request("a@b.com", "password1", "password2", "온탕러버");

        assertThatThrownBy(() -> userService.signup(req))
                .isInstanceOf(BusinessException.class)
                .extracting("errorCode").isEqualTo(ErrorCode.PASSWORD_MISMATCH);
        verify(userRepository, never()).save(any());
    }

    @Test
    @DisplayName("이메일이 중복이면 DUPLICATE_EMAIL")
    void signup_duplicateEmail() {
        SignupRequest req = request("a@b.com", "password1", "password1", "온탕러버");
        given(userRepository.existsByEmail("a@b.com")).willReturn(true);

        assertThatThrownBy(() -> userService.signup(req))
                .isInstanceOf(BusinessException.class)
                .extracting("errorCode").isEqualTo(ErrorCode.DUPLICATE_EMAIL);
        verify(userRepository, never()).save(any());
    }

    @Test
    @DisplayName("닉네임이 중복이면 DUPLICATE_NICKNAME")
    void signup_duplicateNickname() {
        SignupRequest req = request("a@b.com", "password1", "password1", "온탕러버");
        given(userRepository.existsByEmail("a@b.com")).willReturn(false);
        given(userRepository.existsByNickname("온탕러버")).willReturn(true);

        assertThatThrownBy(() -> userService.signup(req))
                .isInstanceOf(BusinessException.class)
                .extracting("errorCode").isEqualTo(ErrorCode.DUPLICATE_NICKNAME);
        verify(userRepository, never()).save(any());
    }
}
