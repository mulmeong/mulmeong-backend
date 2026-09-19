package com.mulmeong.domain.favorite.controller;

import com.mulmeong.domain.favorite.dto.request.FavoriteCreateRequest;
import com.mulmeong.domain.favorite.dto.response.FavoriteCreateResponse;
import com.mulmeong.domain.favorite.dto.response.FavoriteListResponse;
import com.mulmeong.domain.favorite.service.FavoriteService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/favorites")
@RequiredArgsConstructor
public class FavoriteController {
    private final FavoriteService service;

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<FavoriteCreateResponse> create(@AuthenticationPrincipal Long userId, @RequestBody FavoriteCreateRequest request) {
        var result = service.create(userId, request);
        return ResponseEntity.status(result.existing() ? HttpStatus.OK : HttpStatus.CREATED).body(result.response());
    }

    @GetMapping
    public FavoriteListResponse list(@AuthenticationPrincipal Long userId,
                                     @RequestParam(defaultValue = "ALL") String category, @RequestParam(defaultValue = "RECENT") String sort,
                                     @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "20") int size) {
        return service.list(userId, category, sort, page, size);
    }

    @DeleteMapping("/{placeId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@AuthenticationPrincipal Long userId, @PathVariable Long placeId) {
        service.delete(userId, placeId);
    }
}
