package com.mulmeong.domain.dart.controller;

import com.mulmeong.domain.dart.dto.DartSharedResponse;
import com.mulmeong.domain.dart.service.DartService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/darts")
@RequiredArgsConstructor
public class DartShareController {

    private final DartService dartService;

    @GetMapping("/{dartId}")
    public DartSharedResponse shared(@PathVariable String dartId, @AuthenticationPrincipal Long userId) {
        return dartService.shared(dartId, userId);
    }
}
