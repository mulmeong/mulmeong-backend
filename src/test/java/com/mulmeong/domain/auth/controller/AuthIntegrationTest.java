package com.mulmeong.domain.auth.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.Cookie;

/** API 101/102/104/105 통합 테스트. 실제 PostgreSQL·Redis를 Testcontainers로 띄워서 검증한다. */
@SpringBootTest
@AutoConfigureMockMvc
@Testcontainers
class AuthIntegrationTest {

    private static final String BASE = "/api/v1/auth";

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine")
            .withDatabaseName("mulmeong").withUsername("mulmeong").withPassword("mulmeong");

    @Container
    static GenericContainer<?> redis = new GenericContainer<>("redis:7-alpine").withExposedPorts(6379);

    @DynamicPropertySource
    static void registerProps(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
        registry.add("spring.data.redis.host", redis::getHost);
        registry.add("spring.data.redis.port", () -> redis.getMappedPort(6379));
        registry.add("jwt.secret", () -> "integration-test-secret-0123456789abcdef0123456789");
        registry.add("jwt.refresh-cookie-secure", () -> "false");
        registry.add("app.cors.allowed-origins", () -> "http://localhost:5173");
        registry.add("spring.docker.compose.enabled", () -> "false");
    }

    @Autowired
    private MockMvc mockMvc;

    // 이 프로젝트 클래스패스엔 스프링이 관리하는 ObjectMapper 빈이 없다 (MVC 컨버터가 내부적으로 자체 생성해서 씀) — 테스트에서만 직접 생성.
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private String uniqueEmail() {
        return "user" + System.nanoTime() + "@test.com";
    }

    private String uniqueNickname() {
        return "닉" + (System.nanoTime() % 1_000_000L);
    }

    private String signupJson(String email, String nickname) {
        return """
                {"email":"%s","password":"password1","passwordConfirm":"password1",
                 "name":"김온천","birthDate":"1995-05-05","phone":"010-1234-5678","nickname":"%s"}
                """.formatted(email, nickname);
    }

    private void signup(String email, String nickname) throws Exception {
        mockMvc.perform(post(BASE + "/signup").contentType(MediaType.APPLICATION_JSON).content(signupJson(email, nickname)))
                .andExpect(status().isCreated());
    }

    private MvcResult login(String email) throws Exception {
        String body = """
                {"email":"%s","password":"password1"}
                """.formatted(email);
        return mockMvc.perform(post(BASE + "/login").contentType(MediaType.APPLICATION_JSON).content(body))
                .andExpect(status().isOk())
                .andReturn();
    }

    @Test
    void signup_success() throws Exception {
        String email = uniqueEmail();
        String nickname = uniqueNickname();
        mockMvc.perform(post(BASE + "/signup").contentType(MediaType.APPLICATION_JSON).content(signupJson(email, nickname)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.email").value(email))
                .andExpect(jsonPath("$.nickname").value(nickname));
    }

    @Test
    void signup_duplicateEmail_returns409CommonErrorFormat() throws Exception {
        String email = uniqueEmail();
        signup(email, uniqueNickname());

        mockMvc.perform(post(BASE + "/signup").contentType(MediaType.APPLICATION_JSON).content(signupJson(email, uniqueNickname())))
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.code").value("DUPLICATE_EMAIL"))
                .andExpect(jsonPath("$.message").isNotEmpty());
    }

    @Test
    void signup_duplicateNickname_returns409CommonErrorFormat() throws Exception {
        String nickname = uniqueNickname();
        signup(uniqueEmail(), nickname);

        mockMvc.perform(post(BASE + "/signup").contentType(MediaType.APPLICATION_JSON).content(signupJson(uniqueEmail(), nickname)))
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.code").value("DUPLICATE_NICKNAME"));
    }

    @Test
    void signup_passwordMismatch_returns400() throws Exception {
        String body = """
                {"email":"%s","password":"password1","passwordConfirm":"different",
                 "name":"김","birthDate":"1995-05-05","phone":"010-1234-5678","nickname":"%s"}
                """.formatted(uniqueEmail(), uniqueNickname());

        mockMvc.perform(post(BASE + "/signup").contentType(MediaType.APPLICATION_JSON).content(body))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("PASSWORD_MISMATCH"));
    }

    @Test
    void login_success_thenWrongPassword_fails() throws Exception {
        String email = uniqueEmail();
        signup(email, uniqueNickname());

        login(email).getResponse();

        String wrongBody = """
                {"email":"%s","password":"wrongpass1"}
                """.formatted(email);
        mockMvc.perform(post(BASE + "/login").contentType(MediaType.APPLICATION_JSON).content(wrongBody))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.code").value("LOGIN_FAILED"));
    }

    @Test
    void login_withdrawnAccount_returns403() throws Exception {
        String email = uniqueEmail();
        signup(email, uniqueNickname());
        jdbcTemplate.update("UPDATE users SET deleted_at = now() WHERE email = ?", email);

        String body = """
                {"email":"%s","password":"password1"}
                """.formatted(email);
        mockMvc.perform(post(BASE + "/login").contentType(MediaType.APPLICATION_JSON).content(body))
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.code").value("ACCOUNT_WITHDRAWN"));
    }

    @Test
    void reissue_rotatesToken_andDetectsReuse_revokingWholeSession() throws Exception {
        String email = uniqueEmail();
        signup(email, uniqueNickname());
        MvcResult loginResult = login(email);
        Cookie rt1 = loginResult.getResponse().getCookie("refreshToken");
        assertThat(rt1).isNotNull();

        MvcResult reissueResult = mockMvc.perform(post(BASE + "/reissue").cookie(rt1))
                .andExpect(status().isOk())
                .andReturn();
        Cookie rt2 = reissueResult.getResponse().getCookie("refreshToken");
        assertThat(rt2).isNotNull();
        assertThat(rt2.getValue()).isNotEqualTo(rt1.getValue());

        // 옛(이미 회전된) 토큰 재사용 -> 무효
        mockMvc.perform(post(BASE + "/reissue").cookie(rt1))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.code").value("REFRESH_TOKEN_INVALID"));

        // 재사용 탐지로 세션 전체 폐기 -> 방금 회전된 rt2도 이제 무효
        mockMvc.perform(post(BASE + "/reissue").cookie(rt2))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.code").value("REFRESH_TOKEN_INVALID"));
    }

    @Test
    void reissue_withoutCookie_returns401() throws Exception {
        mockMvc.perform(post(BASE + "/reissue"))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.code").value("REFRESH_TOKEN_MISSING"));
    }

    @Test
    void logout_thenReissue_fails() throws Exception {
        String email = uniqueEmail();
        signup(email, uniqueNickname());
        MvcResult loginResult = login(email);
        Cookie rt = loginResult.getResponse().getCookie("refreshToken");
        JsonNode body = objectMapper.readTree(loginResult.getResponse().getContentAsString());
        String accessToken = body.get("accessToken").asText();

        mockMvc.perform(post(BASE + "/logout").cookie(rt).header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isNoContent());

        mockMvc.perform(post(BASE + "/reissue").cookie(rt))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.code").value("REFRESH_TOKEN_INVALID"));
    }

    @Test
    void logout_withoutToken_isIdempotent() throws Exception {
        mockMvc.perform(post(BASE + "/logout"))
                .andExpect(status().isUnauthorized()); // 로그아웃은 인증 필수
    }

    @Test
    void protectedEndpoint_withoutToken_returns401CommonFormat() throws Exception {
        mockMvc.perform(post("/api/v1/reviews"))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.code").value("UNAUTHORIZED"))
                .andExpect(jsonPath("$.message").isNotEmpty());
    }
}
