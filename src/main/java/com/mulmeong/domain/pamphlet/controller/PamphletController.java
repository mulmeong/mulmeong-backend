package com.mulmeong.domain.pamphlet.controller;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import com.mulmeong.domain.pamphlet.dto.request.PamphletCreateRequest;
import com.mulmeong.domain.pamphlet.dto.response.PamphletCreateResponse;
import com.mulmeong.domain.pamphlet.dto.response.PamphletDetail;
import com.mulmeong.domain.pamphlet.dto.response.PamphletListResponse;
import com.mulmeong.domain.pamphlet.service.PamphletService;
import lombok.RequiredArgsConstructor;

@RestController @RequestMapping("/api/v1/pamphlets") @RequiredArgsConstructor
public class PamphletController {
    private final PamphletService service;
    @PostMapping @ResponseStatus(HttpStatus.CREATED)
    public PamphletCreateResponse create(@AuthenticationPrincipal Long userId, @RequestBody PamphletCreateRequest request) { return service.create(userId, request); }
    @GetMapping public PamphletListResponse list(@AuthenticationPrincipal Long userId, @RequestParam(defaultValue="0") int page, @RequestParam(defaultValue="12") int size) { return service.list(userId, page, size); }
    @GetMapping("/share/{shareToken}") public PamphletDetail shared(@PathVariable String shareToken, @AuthenticationPrincipal Long userId) { return service.shared(shareToken, userId); }
    @DeleteMapping("/{pamphletId}") @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@AuthenticationPrincipal Long userId, @PathVariable Long pamphletId) { service.delete(userId, pamphletId); }
}
