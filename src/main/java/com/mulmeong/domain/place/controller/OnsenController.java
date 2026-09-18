package com.mulmeong.domain.place.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestBody;

import jakarta.validation.Valid;

import com.mulmeong.domain.place.dto.response.OnsenCardResponse;
import com.mulmeong.domain.place.dto.response.OnsenListResponse;
import com.mulmeong.domain.place.dto.response.OnsenDetailResponse;
import com.mulmeong.domain.place.dto.response.OnsenDirectionsResponse;
import com.mulmeong.domain.place.dto.response.NearbyPlaceResponse;
import com.mulmeong.domain.place.dto.request.NearbyRerollRequest;
import com.mulmeong.domain.place.service.PlaceService;

import lombok.RequiredArgsConstructor;

/** PAM-01~06 카드·온천 API. */
@RestController
@RequestMapping("/api/v1/onsens")
@RequiredArgsConstructor
public class OnsenController {

    private final PlaceService placeService;

    @GetMapping
    public OnsenListResponse getOnsens(
            @RequestParam(required = false) String region,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(required = false) String keyword) {
        return placeService.getOnsens(region, page, size, keyword);
    }

    @GetMapping("/{onsenId}/card")
    public OnsenCardResponse getCard(
            @PathVariable Long onsenId
    ) {
        return placeService.getOnsenCard(onsenId);
    }

    @GetMapping("/{onsenId}/directions")
    public OnsenDirectionsResponse getDirections(
            @PathVariable Long onsenId,
            @RequestParam(required = false) Double originLat,
            @RequestParam(required = false) Double originLng,
            @RequestParam(defaultValue = "TRANSIT") String mode) {
        return placeService.getOnsenDirections(onsenId, originLat, originLng, mode);
    }

    @GetMapping("/{onsenId}")
    public OnsenDetailResponse getDetail(
            @PathVariable Long onsenId
    ) {
        return placeService.getOnsenDetail(onsenId);
    }

    @GetMapping("/{onsenId}/nearby")
    public NearbyPlaceResponse getNearby(
            @PathVariable Long onsenId,
            @RequestParam(defaultValue = "5000") int radius,
            @RequestParam(defaultValue = "false") boolean full,
            @RequestParam(defaultValue = "all") String category,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        return placeService.getNearby(onsenId, radius, full, category, page, size);
    }

    @PostMapping("/{onsenId}/nearby/reroll")
    public NearbyPlaceResponse rerollNearby(
            @PathVariable Long onsenId,
            @Valid @RequestBody NearbyRerollRequest request) {
        return placeService.rerollNearby(onsenId, request);
    }
}
