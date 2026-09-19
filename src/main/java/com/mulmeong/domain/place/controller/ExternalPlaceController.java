package com.mulmeong.domain.place.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mulmeong.domain.place.dto.request.PoiCategory;
import com.mulmeong.domain.place.dto.response.ExternalCategoryPlaceResponse;
import com.mulmeong.domain.place.dto.response.ExternalDirectionsResponse;
import com.mulmeong.domain.place.service.ExternalDirectionsClient;
import com.mulmeong.domain.place.service.ExternalPlaceClient;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Duration;
import java.util.Locale;

@RestController
@RequestMapping("/api/v1/external")
@RequiredArgsConstructor
public class ExternalPlaceController {

    private static final int MAX_CATEGORY_RADIUS = 20_000;
    private static final int MAX_CATEGORY_SIZE = 15;
    private static final Duration CATEGORY_CACHE_TTL = Duration.ofMinutes(30);
    private static final Duration DIRECTIONS_CACHE_TTL = Duration.ofHours(1);

    private final ExternalPlaceClient placeClient;
    private final ExternalDirectionsClient directionsClient;
    private final StringRedisTemplate redisTemplate;
    private final ObjectMapper objectMapper = new ObjectMapper();

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
        ExternalCategoryPlaceResponse cached = readCategoryCache(cacheKey);
        if (cached != null) return cached;

        ExternalCategoryPlaceResponse response = placeClient.findByCategory(lat, lng, radius, poiCategory, safeSize);
        writeCategoryCache(cacheKey, response);
        return response;
    }

    private ExternalCategoryPlaceResponse readCategoryCache(String key) {
        String cached;
        try {
            cached = redisTemplate.opsForValue().get(key);
        } catch (Exception e) {
            // Redis is only an optimization; an unavailable cache must not turn a Kakao request into a 5xx.
            return null;
        }
        if (cached == null) return null;
        try {
            return objectMapper.readValue(cached, ExternalCategoryPlaceResponse.class);
        } catch (Exception e) {
            return null;
        }
    }

    @SneakyThrows
    private void writeCategoryCache(String key, ExternalCategoryPlaceResponse response) {
        try {
            redisTemplate.opsForValue().set(key, objectMapper.writeValueAsString(response), CATEGORY_CACHE_TTL);
        } catch (Exception ignored) {
            // Cache failure does not affect the successful external response.
        }
    }

    @GetMapping("/directions")
    public ExternalDirectionsResponse directions(
            @RequestParam double originLat, @RequestParam double originLng,
            @RequestParam double destLat, @RequestParam double destLng,
            @RequestParam String mode,
            @RequestParam(defaultValue = "true") boolean includePath) {
        String cacheKey = String.format(Locale.ROOT, "directions:%.3f,%.3f:%.3f,%.3f:%s",
                originLat, originLng, destLat, destLng, mode.toUpperCase(Locale.ROOT));
        ExternalDirectionsResponse cached = readDirectionsCache(cacheKey);
        if (cached != null) return cached;

        ExternalDirectionsResponse response = directionsClient.route(mode, originLat, originLng, destLat, destLng, includePath);
        writeDirectionsCache(cacheKey, response);
        return response;
    }

    private ExternalDirectionsResponse readDirectionsCache(String key) {
        String cached;
        try {
            cached = redisTemplate.opsForValue().get(key);
        } catch (Exception e) {
            return null;
        }
        if (cached == null) return null;
        try {
            return objectMapper.readValue(cached, ExternalDirectionsResponse.class);
        } catch (Exception e) {
            return null;
        }
    }

    @SneakyThrows
    private void writeDirectionsCache(String key, ExternalDirectionsResponse response) {
        try {
            redisTemplate.opsForValue().set(key, objectMapper.writeValueAsString(response), DIRECTIONS_CACHE_TTL);
        } catch (Exception ignored) {
            // Cache failure does not affect the successful external response.
        }
    }
}
