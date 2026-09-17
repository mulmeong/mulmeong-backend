package com.mulmeong.domain.magazine.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import com.mulmeong.domain.magazine.dto.*;
import com.mulmeong.domain.magazine.service.MagazineService;
import lombok.RequiredArgsConstructor;

@RestController @RequestMapping("/api/v1/magazines") @RequiredArgsConstructor
public class MagazineController {
    private final MagazineService service;
    @GetMapping public MagazineListResponse list(@RequestParam(required=false) String category, @RequestParam(required=false) String sidoCode, @RequestParam(defaultValue="LATEST") String sort, @RequestParam(defaultValue="false") boolean featured, @RequestParam(defaultValue="0") int page, @RequestParam(defaultValue="12") int size, @AuthenticationPrincipal Long userId) { return service.list(category, sidoCode, sort, featured, page, size, userId); }
    @GetMapping("/{id}") public MagazineResponse.Detail detail(@PathVariable Long id, @AuthenticationPrincipal Long userId) { return service.detail(id, userId); }
    @PostMapping("/{id}/like") @ResponseStatus(org.springframework.http.HttpStatus.NO_CONTENT) public void like(@PathVariable Long id, @AuthenticationPrincipal Long userId) { service.like(id, userId); }
    @DeleteMapping("/{id}/like") @ResponseStatus(org.springframework.http.HttpStatus.NO_CONTENT) public void unlike(@PathVariable Long id, @AuthenticationPrincipal Long userId) { service.unlike(id, userId); }
}
