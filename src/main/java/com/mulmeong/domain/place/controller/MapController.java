package com.mulmeong.domain.place.controller;

import com.mulmeong.domain.place.dto.response.MapOnsensResponse;
import com.mulmeong.domain.place.dto.response.OnsenSearchResponse;
import com.mulmeong.domain.place.entity.AccessLevel;
import com.mulmeong.domain.place.service.PlaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 301 지도 영역 온천 조회, 302 온천 검색(자동완성).
 */
@RestController
@RequestMapping("/api/v1/map/onsens")
@RequiredArgsConstructor
public class MapController {

    private final PlaceService placeService;

    @GetMapping
    public MapOnsensResponse getMapOnsens(
            @RequestParam double swLat, @RequestParam double swLng,
            @RequestParam double neLat, @RequestParam double neLng,
            @RequestParam int zoom,
            @RequestParam(required = false) AccessLevel accessLevel,
            @RequestParam(required = false) Boolean hasOutdoor,
            @RequestParam(defaultValue = "false") boolean registeredOnly,
            @AuthenticationPrincipal Long userId
    ) {
        return placeService.getMapOnsens(swLat, swLng, neLat, neLng, zoom, accessLevel, hasOutdoor, registeredOnly, userId);
    }

    @GetMapping("/search")
    public OnsenSearchResponse search(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "10") int limit
    ) {
        return placeService.searchOnsens(keyword, limit);
    }
}
