package com.mulmeong.domain.place.controller;

import com.mulmeong.domain.place.dto.request.NearbyRerollRequest;
import com.mulmeong.domain.place.dto.response.*;
import com.mulmeong.domain.place.service.PlaceService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

/**
 * PAM-01~06 카드·온천 API.
 */
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
            @RequestParam(defaultValue = "TRANSIT") String mode,
            @RequestParam(defaultValue = "true") boolean includePath) {
        return placeService.getOnsenDirections(onsenId, originLat, originLng, mode, includePath);
    }

    @GetMapping("/{onsenId}")
    public OnsenDetailResponse getDetail(
            @PathVariable Long onsenId,
            @AuthenticationPrincipal Long userId
    ) {
        return placeService.getOnsenDetail(onsenId, userId);
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
