package com.mulmeong.global.security;

import java.io.IOException;

import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import com.mulmeong.global.exception.ErrorCode;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/** 403 응답도 {@link RestAuthenticationEntryPoint}와 같은 이유로 JSON을 직접 만든다. */
@Component
public class RestAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException)
            throws IOException {
        response.setStatus(ErrorCode.FORBIDDEN.getStatus().value());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(
                "{\"code\":\"%s\",\"message\":\"%s\"}".formatted(ErrorCode.FORBIDDEN.name(), ErrorCode.FORBIDDEN.getMessage()));
    }
}
