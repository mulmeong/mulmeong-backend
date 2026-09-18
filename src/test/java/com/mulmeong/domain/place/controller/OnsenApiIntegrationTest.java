package com.mulmeong.domain.place.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

/** PAM-01~06(201~206) 명세의 HTTP 계약을 PostgreSQL과 함께 검증한다. */
@SpringBootTest
@AutoConfigureMockMvc
@Testcontainers
class OnsenApiIntegrationTest {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine")
            .withDatabaseName("mulmeong").withUsername("mulmeong").withPassword("mulmeong");

    @DynamicPropertySource
    static void registerProps(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
        registry.add("spring.docker.compose.enabled", () -> "false");
        registry.add("jwt.secret", () -> "onsen-test-secret-0123456789abcdef0123456789");
        registry.add("app.cors.allowed-origins", () -> "http://localhost:5173");
        // 계약 테스트는 외부 API 결과가 섞이지 않도록 DB fixture만 검증한다.
        registry.add("external.kakao.rest-api-key", () -> "");
        registry.add("external.tour-api.service-key", () -> "");
    }

    @Autowired MockMvc mockMvc;
    @Autowired JdbcTemplate jdbcTemplate;

    private long onsenId;

    @BeforeEach
    void seedFixture() {
        jdbcTemplate.update("DELETE FROM place_images WHERE place_id IN (SELECT id FROM places WHERE external_id LIKE 'test-onsen-%')");
        jdbcTemplate.update("DELETE FROM places WHERE external_id LIKE 'test-onsen-%' OR external_id LIKE 'test-poi-%'");
        jdbcTemplate.update("DELETE FROM stations WHERE station_code = 'test-station'");
        long stationId = jdbcTemplate.queryForObject(
                "INSERT INTO stations (station_code,name,station_type,lat,lng) VALUES ('test-station','테스트역','TRAIN',36.0,127.0) RETURNING id",
                Long.class);
        onsenId = jdbcTemplate.queryForObject("""
                INSERT INTO places (place_type,is_registered_onsen,source,external_id,name,sido,sigungu,address,lat,lng,
                    water_temp,water_type,water_benefit,access_level,station_id,station_to_place_desc)
                VALUES ('ONSEN',true,'MANUAL','test-onsen-main','테스트온천','충청북도','충주시','테스트 주소',36.01,127.01,
                    42.5,'중탄산천','피로 회복','WALKABLE',?, '버스 10분') RETURNING id
                """, Long.class, stationId);
        jdbcTemplate.update("INSERT INTO place_images (place_id,image_url,sort_order) VALUES (?, ?, 0)",
                onsenId, "https://cdn.test/onsen.jpg");
        long poiId = jdbcTemplate.queryForObject("""
                INSERT INTO places (place_type,is_registered_onsen,source,external_id,name,address,lat,lng,phone,homepage_url)
                VALUES ('CAFE',false,'KAKAO','test-poi-cafe','테스트카페','테스트 카페 주소',36.011,127.011,'010-0000-0000','https://place.test') RETURNING id
                """, Long.class);
        jdbcTemplate.update("INSERT INTO place_images (place_id,image_url,sort_order) VALUES (?, ?, 0)",
                poiId, "https://cdn.test/cafe.jpg");
    }

    @Test
    void api201_card_matchesContract() throws Exception {
        mockMvc.perform(get("/api/v1/onsens/{id}/card", onsenId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.onsenId").value(onsenId))
                .andExpect(jsonPath("$.name").value("테스트온천"))
                .andExpect(jsonPath("$.specBadges.waterTemp").value(42.5))
                .andExpect(jsonPath("$.specBadges.waterType").value("중탄산천"))
                .andExpect(jsonPath("$.benefitOneLine").value("피로 회복"));
    }

    @Test
    void api202_directions_matchesContract() throws Exception {
        // 테스트 환경엔 카카오 키가 없어 출발지→거점역 leg는 실패로 생략되고, 거점역→온천 leg만 내려온다.
        mockMvc.perform(get("/api/v1/onsens/{id}/directions", onsenId)
                        .param("originLat", "37.5").param("originLng", "127.0"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.nearestStation.name").value("테스트역"))
                .andExpect(jsonPath("$.legs[0].type").value("STATION_TO_ONSEN"))
                .andExpect(jsonPath("$.legs[0].summary").value("버스 10분"));
    }

    @Test
    void api203_detail_matchesContract() throws Exception {
        mockMvc.perform(get("/api/v1/onsens/{id}", onsenId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.onsenId").value(onsenId))
                .andExpect(jsonPath("$.isRegistered").value(true))
                .andExpect(jsonPath("$.lat").value(36.01))
                .andExpect(jsonPath("$.water.temp").value(42.5))
                .andExpect(jsonPath("$.access.accessLevel").value("WALKABLE"))
                .andExpect(jsonPath("$.access.nearestStation.name").value("테스트역"))
                .andExpect(jsonPath("$.isFavorite").value(false))
                .andExpect(jsonPath("$.reviewSummary.count").value(0))
                .andExpect(jsonPath("$.thumbnail").value("https://cdn.test/onsen.jpg"))
                .andExpect(jsonPath("$.images[0]").value("https://cdn.test/onsen.jpg"));
    }

    @Test
    void api204_nearby_returnsVisiblePlaces() throws Exception {
        mockMvc.perform(get("/api/v1/onsens/{id}/nearby", onsenId)
                        .param("category", "cafe"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content[0].source").value("KAKAO"))
                .andExpect(jsonPath("$.content[0].type").value("카페"))
                .andExpect(jsonPath("$.content[0].name").value("테스트카페"));
    }

    @Test
    void api205_reroll_excludesRequestedPlace() throws Exception {
        mockMvc.perform(post("/api/v1/onsens/{id}/nearby/reroll", onsenId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"category\":\"cafe\",\"excludeIds\":[\"test-poi-cafe\"]}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content").isEmpty());
    }

    @Test
    void api206_fullNearby_supportsPagination() throws Exception {
        mockMvc.perform(get("/api/v1/onsens/{id}/nearby", onsenId)
                        .param("full", "true").param("page", "0").param("size", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content.length()").value(1));
    }

    @Test
    void api201_listSupportsRegionKeywordImagesAndReviewSummary() throws Exception {
        mockMvc.perform(get("/api/v1/onsens")
                        .param("region", "충청북도")
                        .param("keyword", "테스트"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content[0].thumbnail").value("https://cdn.test/onsen.jpg"))
                .andExpect(jsonPath("$.content[0].reviewCount").value(0));
    }
}
