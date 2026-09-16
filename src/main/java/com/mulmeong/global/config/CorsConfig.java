package com.mulmeong.global.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

/**
 * CORS 설정.
 * 브라우저는 "화면을 받은 주소"와 "API를 부르는 주소"가 다르면 요청을 막는다.
 * 프론트(Vercel)와 백엔드(ALB)는 주소가 다르므로, 여기서 허용 목록을 지정한다.
 */
@Configuration
public class CorsConfig {

    // 허용할 프론트 주소 목록. application.properties의 app.cors.allowed-origins 값을 주입받음
    @Value("${app.cors.allowed-origins}")
    private List<String> allowedOrigins;

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();

        // 허용할 출처. *.vercel.app 같은 와일드카드를 쓰려면 setAllowedOrigins가 아니라 이 메서드를 써야 함
        config.setAllowedOriginPatterns(allowedOrigins);

        // 허용할 HTTP 메서드. OPTIONS는 브라우저가 본 요청 전에 보내는 사전 확인용이라 반드시 포함
        config.setAllowedMethods(List.of("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));

        // 허용할 요청 헤더 (Authorization, Content-Type 등 전부 허용)
        config.setAllowedHeaders(List.of("*"));

        // 쿠키·인증 정보를 함께 주고받도록 허용
        config.setAllowCredentials(true);

        // 브라우저가 사전 확인 결과를 1시간 동안 기억 → 불필요한 요청이 줄어듦
        config.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);   // 모든 경로에 위 설정 적용
        return source;
    }
}
