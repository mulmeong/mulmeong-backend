package com.mulmeong.domain.review.controller;

import com.mulmeong.domain.review.dto.request.ReviewCreateRequest;
import com.mulmeong.domain.review.dto.request.ReviewUpdateRequest;
import com.mulmeong.domain.review.dto.response.OnsenReviewListResponse;
import com.mulmeong.domain.review.dto.response.OnsenReviewStatsResponse;
import com.mulmeong.domain.review.dto.response.ReviewCreateResponse;
import com.mulmeong.domain.review.dto.response.ReviewUpdateResponse;
import com.mulmeong.domain.review.service.ReviewService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class ReviewController {
    private final ReviewService reviewService;

    @PostMapping("/api/v1/onsens/{onsenId}/reviews")
    @ResponseStatus(HttpStatus.CREATED)
    public ReviewCreateResponse create(@AuthenticationPrincipal Long userId, @PathVariable Long onsenId,
                                       @Valid @RequestBody ReviewCreateRequest request) {
        return reviewService.create(userId, onsenId, request);
    }

    @GetMapping("/api/v1/onsens/{onsenId}/reviews")
    public OnsenReviewListResponse list(@PathVariable Long onsenId, @AuthenticationPrincipal Long userId,
                                        @RequestParam(defaultValue = "RECENT") String sort, @RequestParam(defaultValue = "0") int page,
                                        @RequestParam(defaultValue = "10") int size) {
        return reviewService.list(onsenId, userId, sort, page, size);
    }

    @GetMapping("/api/v1/onsens/{onsenId}/reviews/stats")
    public OnsenReviewStatsResponse stats(@PathVariable Long onsenId) {
        return reviewService.stats(onsenId);
    }

    @PatchMapping("/api/v1/reviews/{reviewId}")
    public ReviewUpdateResponse update(@AuthenticationPrincipal Long userId, @PathVariable Long reviewId,
                                       @Valid @RequestBody ReviewUpdateRequest request) {
        return reviewService.update(userId, reviewId, request);
    }

    @DeleteMapping("/api/v1/reviews/{reviewId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@AuthenticationPrincipal Long userId, @PathVariable Long reviewId) {
        reviewService.delete(userId, reviewId);
    }
}
