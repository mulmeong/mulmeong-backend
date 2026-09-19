package com.mulmeong.domain.place.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mulmeong.domain.place.dto.request.PoiCategory;
import com.mulmeong.domain.place.dto.response.CoordinateAddressResponse;
import com.mulmeong.domain.place.dto.response.ExternalCategoryPlaceResponse;
import com.mulmeong.domain.place.dto.response.ExternalDirectionsResponse;
import com.mulmeong.domain.place.dto.response.ExternalKeywordSearchResponse;
import com.mulmeong.domain.place.dto.response.TourNearbyResponse;
import com.mulmeong.domain.place.service.ExternalDirectionsClient;
import com.mulmeong.domain.place.service.ExternalPlaceClient;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Duration;
import java.util.Locale;
import java.util.function.Supplier;

@RestController
@RequestMapping("/api/v1/external")
@RequiredArgsConstructor
public class ExternalPlaceController {

    private static final int MAX_CATEGORY_RADIUS = 20_000;
    private static final int MAX_CATEGORY_SIZE = 15;
    private static final int MIN_KEYWORD_LENGTH = 2;
    private static final int MAX_SEARCH_SIZE = 15;
    private static final int MAX_TOUR_SIZE = 100;
    private static final Duration CATEGORY_CACHE_TTL = Duration.ofMinutes(30);
    private static final Duration DIRECTIONS_CACHE_TTL = Duration.ofHours(1);
    private static final Duration SEARCH_CACHE_TTL = Duration.ofMinutes(10);
    private static final Duration COORD2ADDRESS_CACHE_TTL = Duration.ofHours(1);
    private static final Duration TOUR_CACHE_TTL = Duration.ofHours(24);

    private final ExternalPlaceClient placeClient;
    private final ExternalDirectionsClient directionsClient;
    private final StringRedisTemplate redisTemplate;
    private final ObjectMapper objectMapper;

    @GetMapping("/places/search")
    public ExternalKeywordSearchResponse search(@RequestParam String keyword,
                                                @RequestParam(required = false) Double lat,
                                                @RequestParam(required = false) Double lng,
                                                @RequestParam(defaultValue = "10") int size) {
        String trimmed = keyword.trim();
        if (trimmed.length() < MIN_KEYWORD_LENGTH) {
            throw new BusinessException(ErrorCode.KEYWORD_TOO_SHORT);
        }
        int safeSize = clamp(size, MAX_SEARCH_SIZE);
        String cacheKey = String.format(Locale.ROOT, "places-search:%s:%s:%s:%d", trimmed, lat, lng, safeSize);
        return cached(cacheKey, SEARCH_CACHE_TTL, ExternalKeywordSearchResponse.class,
                () -> placeClient.searchKeyword(trimmed, lat, lng, safeSize));
    }

    @GetMapping("/places/coord2address")
    public CoordinateAddressResponse coord2address(@RequestParam double lat, @RequestParam double lng) {
        // 같은 위치 반복 호출을 막으려고 좌표를 소수점 4자리로 반올림한 키를 쓴다.
        String cacheKey = String.format(Locale.ROOT, "coord2address:%.4f:%.4f", lat, lng);
        return cached(cacheKey, COORD2ADDRESS_CACHE_TTL, CoordinateAddressResponse.class,
                () -> placeClient.coord2address(lat, lng));
    }

    @GetMapping("/tour/nearby")
    public TourNearbyResponse tourNearby(@RequestParam double lat, @RequestParam double lng,
                                         @RequestParam(defaultValue = "5000") int radius,
                                         @RequestParam(required = false) Integer contentTypeId,
                                         @RequestParam(defaultValue = "true") boolean withImageOnly,
                                         @RequestParam(defaultValue = "20") int size) {
        if (radius < 1 || radius > MAX_CATEGORY_RADIUS) {
            throw new BusinessException(ErrorCode.RADIUS_TOO_LARGE);
        }
        int safeSize = clamp(size, MAX_TOUR_SIZE);
        String cacheKey = String.format(Locale.ROOT, "tour-nearby:%.4f:%.4f:%d:%s:%b:%d",
                lat, lng, radius, contentTypeId, withImageOnly, safeSize);
        return cached(cacheKey, TOUR_CACHE_TTL, TourNearbyResponse.class,
                () -> placeClient.findTourNearby(lat, lng, radius, contentTypeId, withImageOnly, safeSize));
    }

    @GetMapping("/places/category")
    public ExternalCategoryPlaceResponse placesByCategory(
            @RequestParam double lat, @RequestParam double lng,
            @RequestParam(defaultValue = "2000") int radius,
            @RequestParam(defaultValue = "15") int size,
            @RequestParam String category) {
        if (radius > MAX_CATEGORY_RADIUS) {
            throw new BusinessException(ErrorCode.RADIUS_TOO_LARGE);
        }
        PoiCategory poiCategory;
        try {
            poiCategory = PoiCategory.valueOf(category.trim().toUpperCase(Locale.ROOT));
        } catch (IllegalArgumentException e) {
            throw new BusinessException(ErrorCode.INVALID_CATEGORY);
        }
        int safeSize = Math.min(size, MAX_CATEGORY_SIZE);

        String cacheKey = String.format(Locale.ROOT, "places-category:%.3f:%.3f:%s", lat, lng, poiCategory.name());
        return cached(cacheKey, CATEGORY_CACHE_TTL, ExternalCategoryPlaceResponse.class,
                () -> placeClient.findByCategory(lat, lng, radius, poiCategory, safeSize));
    }

    @GetMapping("/directions")
    public ExternalDirectionsResponse directions(
            @RequestParam double originLat, @RequestParam double originLng,
            @RequestParam double destLat, @RequestParam double destLng,
            @RequestParam String mode,
            @RequestParam(defaultValue = "true") boolean includePath) {
        String cacheKey = String.format(Locale.ROOT, "directions:%.3f,%.3f:%.3f,%.3f:%s",
                originLat, originLng, destLat, destLng, mode.toUpperCase(Locale.ROOT));
        return cached(cacheKey, DIRECTIONS_CACHE_TTL, ExternalDirectionsResponse.class,
                () -> directionsClient.route(mode, originLat, originLng, destLat, destLng, includePath));
    }

    private static int clamp(int size, int max) {
        return Math.min(Math.max(size, 1), max);
    }

    private <T> T cached(String key, Duration ttl, Class<T> type, Supplier<T> loader) {
        T hit = readCache(key, type);
        if (hit != null) {
            return hit;
        }
        T value = loader.get();
        writeCache(key, ttl, value);
        return value;
    }

    private <T> T readCache(String key, Class<T> type) {
        String cached;
        try {
            cached = redisTemplate.opsForValue().get(key);
        } catch (Exception e) {
            // Redis는 최적화 수단일 뿐이다 — 캐시 장애가 외부 호출을 5xx로 바꾸면 안 된다.
            return null;
        }
        if (cached == null) {
            return null;
        }
        try {
            return objectMapper.readValue(cached, type);
        } catch (Exception e) {
            return null;
        }
    }

    private void writeCache(String key, Duration ttl, Object value) {
        try {
            redisTemplate.opsForValue().set(key, objectMapper.writeValueAsString(value), ttl);
        } catch (Exception ignored) {
            // 캐시 쓰기 실패는 정상 응답에 영향을 주지 않는다.
        }
    }
}
