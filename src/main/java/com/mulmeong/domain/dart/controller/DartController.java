package com.mulmeong.domain.dart.controller;

import java.util.List;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import jakarta.validation.Valid;
import com.mulmeong.domain.dart.dto.DartRequest;
import com.mulmeong.domain.dart.dto.DartResponse;
import com.mulmeong.domain.dart.dto.OriginResponse;
import com.mulmeong.domain.dart.service.DartService;
import lombok.RequiredArgsConstructor;

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
    public List<OriginResponse> origins() { return dartService.origins(); }
}
