package com.mulmeong.global.config;

import com.mulmeong.domain.auth.jwt.JwtTokenProvider;
import com.mulmeong.global.security.JwtAuthenticationFilter;
import com.mulmeong.global.security.RestAccessDeniedHandler;
import com.mulmeong.global.security.RestAuthenticationEntryPoint;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

    private static final String API = "/api/v1";

    private final JwtTokenProvider jwtTokenProvider;
    private final RestAuthenticationEntryPoint restAuthenticationEntryPoint;
    private final RestAccessDeniedHandler restAccessDeniedHandler;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // CORS 활성화. 이 줄이 없으면 CorsConfig를 만들어도 시큐리티가 무시함
                .cors(Customizer.withDefaults())
                .csrf(AbstractHttpConfigurer::disable)
                .httpBasic(AbstractHttpConfigurer::disable)
                .formLogin(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .exceptionHandling(handling -> handling
                        .authenticationEntryPoint(restAuthenticationEntryPoint)
                        .accessDeniedHandler(restAccessDeniedHandler))
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(HttpMethod.POST,
                                API + "/auth/signup", API + "/auth/login", API + "/auth/reissue", API + "/auth/password/**")
                        .permitAll()
                        .requestMatchers(HttpMethod.GET, API + "/auth/email/check").permitAll()
                        .requestMatchers(HttpMethod.GET,
                                API + "/onsens/**", API + "/map/**", API + "/dart/**", API + "/darts/**", API + "/magazines/**",
                                API + "/pamphlets/share/**", API + "/profiles/**", API + "/external/**", API + "/regions/**")
                        .permitAll()
                        .requestMatchers(HttpMethod.POST,
                                API + "/dart/throw", API + "/dart/reroll",
                                API + "/darts", API + "/darts/*/rethrow", API + "/onsens/*/nearby/reroll")
                        .permitAll()
                        .requestMatchers("/api/health", "/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html").permitAll()
                        .anyRequest().authenticated())
                .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider), UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
