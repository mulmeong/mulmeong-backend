package com.mulmeong.domain.place.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mulmeong.domain.place.dto.response.ExternalDirectionsResponse;
import com.mulmeong.domain.place.dto.response.NearbyPlaceResponse;
import com.mulmeong.domain.place.dto.response.OnsenDirectionsResponse;
import com.mulmeong.domain.place.service.ExternalDirectionsClient;
import com.mulmeong.domain.place.service.ExternalPlaceClient;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/v1/external")
@RequiredArgsConstructor
public class ExternalPlaceController {
    private final ExternalPlaceClient placeClient;
    private final ExternalDirectionsClient directionsClient;

    @GetMapping("/places/category")
    public NearbyPlaceResponse placesByCategory(@RequestParam double lat, @RequestParam double lng,
            @RequestParam(defaultValue = "5000") int radius,
            @RequestParam(defaultValue = "all") String category) {
        return new NearbyPlaceResponse(placeClient.findNearby(lat, lng, radius, category));
    }

    @GetMapping("/directions")
    public ExternalDirectionsResponse directions(@RequestParam double originLat, @RequestParam double originLng,
            @RequestParam double destinationLat, @RequestParam double destinationLng,
            @RequestParam(defaultValue = "TRANSIT") String mode) {
        OnsenDirectionsResponse.OriginToStation route = directionsClient.route(mode, originLat, originLng,
                destinationLat, destinationLng);
        return route == null ? new ExternalDirectionsResponse(mode.toUpperCase(), null, null, null)
                : new ExternalDirectionsResponse(route.transport(), route.distanceKm(), route.durationMin(), route.kakaoDeepLink());
    }
}
