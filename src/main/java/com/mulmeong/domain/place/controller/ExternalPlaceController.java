package com.mulmeong.domain.place.controller;

import com.mulmeong.domain.place.dto.request.PoiCategory;
import com.mulmeong.domain.place.dto.response.ExternalCategoryPlaceResponse;
import com.mulmeong.domain.place.dto.response.ExternalDirectionsResponse;
import com.mulmeong.domain.place.dto.response.ExternalKeywordSearchResponse;
import com.mulmeong.domain.place.dto.response.TourNearbyResponse;
import com.mulmeong.domain.place.dto.response.TourPlaceDetailResponse;
import com.mulmeong.domain.place.service.ExternalDirectionsClient;
import com.mulmeong.domain.place.service.ExternalPlaceClient;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Locale;

@RestController
@RequestMapping("/api/v1/external")
@RequiredArgsConstructor
public class ExternalPlaceController {

    private static final int MAX_CATEGORY_RADIUS = 20_000;
    private static final int MAX_CATEGORY_SIZE = 15;
    private static final int MIN_KEYWORD_LENGTH = 2;
    private static final int MAX_SEARCH_SIZE = 15;
    private static final int MAX_TOUR_SIZE = 100;
    private final ExternalPlaceClient placeClient;
    private final ExternalDirectionsClient directionsClient;

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
        return placeClient.searchKeyword(trimmed, lat, lng, safeSize);
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
        return placeClient.findTourNearby(lat, lng, radius, contentTypeId, withImageOnly, safeSize);
    }

    @GetMapping("/tour/{externalId}")
    public TourPlaceDetailResponse tourDetail(@PathVariable String externalId,
                                              @RequestParam(required = false) Integer contentTypeId) {
        return placeClient.findTourDetail(externalId, contentTypeId);
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

        return placeClient.findByCategory(lat, lng, radius, poiCategory, safeSize);
    }

    @GetMapping("/directions")
    public ExternalDirectionsResponse directions(
            @RequestParam double originLat, @RequestParam double originLng,
            @RequestParam double destLat, @RequestParam double destLng,
            @RequestParam String mode,
            @RequestParam(defaultValue = "true") boolean includePath) {
        return directionsClient.route(mode, originLat, originLng, destLat, destLng, includePath);
    }

    private static int clamp(int size, int max) {
        return Math.min(Math.max(size, 1), max);
    }

}
