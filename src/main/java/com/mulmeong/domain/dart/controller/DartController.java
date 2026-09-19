package com.mulmeong.domain.dart.controller;

import com.mulmeong.domain.dart.dto.DartRequest;
import com.mulmeong.domain.dart.dto.DartResponse;
import com.mulmeong.domain.dart.dto.OriginResponse;
import com.mulmeong.domain.dart.service.DartService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/dart")
@RequiredArgsConstructor
public class DartController {
    private final DartService dartService;

    @PostMapping("/throw")
    public DartResponse throwDart(@Valid @RequestBody DartRequest request, @AuthenticationPrincipal Long userId) {
        return dartService.throwDart(request, userId, false);
    }

    @PostMapping("/reroll")
    public DartResponse reroll(@Valid @RequestBody DartRequest request, @AuthenticationPrincipal Long userId) {
        return dartService.throwDart(request, userId, true);
    }

    @GetMapping("/origins")
    public List<OriginResponse> origins() {
        return dartService.origins();
    }
}
