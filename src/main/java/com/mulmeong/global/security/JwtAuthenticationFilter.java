package com.mulmeong.global.security;

import com.mulmeong.domain.auth.jwt.JwtTokenProvider;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;

/**
 * "선택 인증": Authorization 헤더가 없거나 토큰이 무효(만료·위조)여도 여기서 막지 않고
 * 그냥 비로그인으로 통과시킨다. 실제 401은 인증이 필요한 엔드포인트에서
 * {@code authorizeHttpRequests}가 판단하고 {@link RestAuthenticationEntryPoint}가 응답한다.
 * Refresh 토큰은 여기서 인증 주체로 인정하지 않는다 (type=access 만 허용).
 */
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private static final String BEARER_PREFIX = "Bearer ";

    private final JwtTokenProvider jwtTokenProvider;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        String header = request.getHeader("Authorization");
        if (header != null && header.startsWith(BEARER_PREFIX)) {
            String token = header.substring(BEARER_PREFIX.length());
            try {
                Claims claims = jwtTokenProvider.parse(token);
                if (jwtTokenProvider.isType(claims, JwtTokenProvider.TYPE_ACCESS)) {
                    Long userId = jwtTokenProvider.getUserId(claims);
                    var authentication = new UsernamePasswordAuthenticationToken(userId, null, List.of());
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }
            } catch (JwtException | IllegalArgumentException ignored) {
                // 선택 인증: 무효 토큰이면 그냥 비로그인으로 처리한다.
            }
        }
        filterChain.doFilter(request, response);
    }
}
