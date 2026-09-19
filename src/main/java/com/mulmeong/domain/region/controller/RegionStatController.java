package com.mulmeong.domain.region.controller;

import com.mulmeong.domain.region.dto.response.GrapeMapResponse;
import com.mulmeong.domain.region.service.RegionStatService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 702 포도알 지도.
 */
@RestController
@RequestMapping("/api/v1/users/me/grapes")
@RequiredArgsConstructor
public class RegionStatController {

    private final RegionStatService regionStatService;

    @GetMapping
    public GrapeMapResponse grapes(@AuthenticationPrincipal Long userId,
                                   @RequestParam(defaultValue = "SIDO") String level,
                                   @RequestParam(required = false) String parentRegionCode) {
        return regionStatService.grapeMap(userId, level, parentRegionCode);
    }
}
