package com.mulmeong.global.security;

import com.mulmeong.global.exception.ErrorCode;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * 인증이 필요한 엔드포인트에 토큰 없이/무효 토큰으로 접근했을 때 401을 공통 에러 포맷으로 내려준다.
 * Spring Security 필터 체인 초반에 실행되는 컴포넌트라 MVC의 ObjectMapper 자동 구성 시점 문제를
 * 피하려고 JSON을 직접 만든다 (메시지는 ErrorCode의 고정 문자열이라 이스케이프가 필요 없다).
 */
@Component
public class RestAuthenticationEntryPoint implements AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException)
            throws IOException {
        response.setStatus(ErrorCode.UNAUTHORIZED.getStatus().value());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(
                "{\"code\":\"%s\",\"message\":\"%s\"}".formatted(ErrorCode.UNAUTHORIZED.name(), ErrorCode.UNAUTHORIZED.getMessage()));
    }
}
