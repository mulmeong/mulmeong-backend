package com.mulmeong.domain.review.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mulmeong.domain.review.dto.response.MyReviewDetailResponse;
import com.mulmeong.domain.review.dto.response.MyReviewListResponse;
import com.mulmeong.domain.review.service.MyReviewService;
import com.mulmeong.domain.review.service.ReviewSort;

import lombok.RequiredArgsConstructor;

/** 704 내 리뷰 목록, 705 내 리뷰 상세. */
@RestController
@RequestMapping("/api/v1/users/me/reviews")
@RequiredArgsConstructor
public class MyReviewController {

    private final MyReviewService myReviewService;

    @GetMapping
    public MyReviewListResponse myReviews(
            @AuthenticationPrincipal Long userId,
            @RequestParam(required = false) String regionCode,
            @RequestParam(defaultValue = "RECENT") ReviewSort sort,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        return myReviewService.myReviews(userId, regionCode, sort, page, size);
    }

    @GetMapping("/{reviewId}")
    public MyReviewDetailResponse myReviewDetail(@AuthenticationPrincipal Long userId,
            @PathVariable Long reviewId) {
        return myReviewService.myReviewDetail(userId, reviewId);
    }
}
