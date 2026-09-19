package com.mulmeong.domain.review.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mulmeong.domain.review.dto.response.MyReviewDetailResponse;
import com.mulmeong.domain.review.dto.response.MyReviewItem;
import com.mulmeong.domain.review.dto.response.MyReviewListResponse;
import com.mulmeong.domain.review.dto.response.MyReviewOnsenSummary;
import com.mulmeong.domain.review.dto.response.MyReviewRegionFilter;
import com.mulmeong.domain.review.dto.response.RecentOnsenSummary;
import com.mulmeong.domain.review.repository.MyReviewDetailRow;
import com.mulmeong.domain.review.repository.MyReviewRepository;
import com.mulmeong.domain.review.repository.MyReviewRow;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;

import lombok.RequiredArgsConstructor;

/** 701(리뷰 수), 704(내 리뷰 목록), 705(내 리뷰 상세). 601~606 리뷰 작성/수정/삭제는 범위 밖. */
@Service
@RequiredArgsConstructor
public class MyReviewService {

    private static final int MAX_PAGE_SIZE = 30;
    private static final int BODY_PREVIEW_LENGTH = 60;

    private final MyReviewRepository myReviewRepository;

    @Transactional(readOnly = true)
    public long countByUserId(Long userId) {
        return myReviewRepository.countByUserId(userId);
    }

    @Transactional(readOnly = true)
    public List<Long> distinctOnsenIdsByUserAndSido(Long userId, String sidoCode) {
        return myReviewRepository.findDistinctPlaceIdsByUserAndSido(userId, sidoCode);
    }

    @Transactional(readOnly = true)
    public List<Long> distinctOnsenIdsByUserAndSigungu(Long userId, String sigunguCode) {
        return myReviewRepository.findDistinctPlaceIdsByUserAndSigungu(userId, sigunguCode);
    }

    /** 708 recentOnsens: visited_at 최근순 최대 3곳(같은 온천 중복 제외). */
    @Transactional(readOnly = true)
    public List<RecentOnsenSummary> recentOnsens(Long userId, int limit) {
        return myReviewRepository.findRecentOnsenCandidates(userId).stream()
                .sorted((a, b) -> b.getVisitedAt().compareTo(a.getVisitedAt()))
                .limit(limit)
                .map(row -> new RecentOnsenSummary(row.getOnsenId(), row.getName(), row.getThumbnail()))
                .toList();
    }

    @Transactional(readOnly = true)
    public MyReviewListResponse myReviews(Long userId, String regionCode, ReviewSort sort, int page, int size) {
        int pageSize = Math.min(Math.max(size, 1), MAX_PAGE_SIZE);
        Page<MyReviewRow> result = myReviewRepository.findMyReviews(
                userId, regionCode, sort.code(), PageRequest.of(Math.max(page, 0), pageSize));

        List<MyReviewItem> content = result.getContent().stream().map(this::toItem).toList();
        List<MyReviewRegionFilter> regions = myReviewRepository.findMyReviewRegions(userId).stream()
                .map(r -> new MyReviewRegionFilter(r.getRegionCode(), r.getName(), r.getCount()))
                .toList();

        return new MyReviewListResponse(content, result.getNumber(), result.getSize(), result.getTotalElements(),
                result.getTotalPages(), result.isLast(), new MyReviewListResponse.Filters(regions));
    }

    @Transactional(readOnly = true)
    public MyReviewDetailResponse myReviewDetail(Long userId, Long reviewId) {
        MyReviewDetailRow row = myReviewRepository.findMyReviewDetail(reviewId)
                .orElseThrow(() -> new BusinessException(ErrorCode.REVIEW_NOT_FOUND));
        if (!row.getUserId().equals(userId)) {
            throw new BusinessException(ErrorCode.FORBIDDEN);
        }

        List<MyReviewDetailResponse.Image> images = myReviewRepository.findReviewImageUrls(reviewId).stream()
                .map(url -> new MyReviewDetailResponse.Image(url, url))
                .toList();

        return new MyReviewDetailResponse(
                row.getReviewId(),
                new MyReviewDetailResponse.Onsen(row.getOnsenId(), row.getName(), row.getAddress(), row.getLat(),
                        row.getLng(), row.getThumbnail()),
                row.getRating(),
                row.getVisitedAt(),
                new MyReviewDetailResponse.Spec(row.getVisitTimeSlot(), row.getCleanliness(), row.getCrowdedness(),
                        row.getFacilityScore()),
                row.getBody() == null ? "" : row.getBody(),
                images,
                row.getCreatedAt(),
                row.getUpdatedAt(),
                Boolean.TRUE.equals(row.getIsRevisit()));
    }

    private MyReviewItem toItem(MyReviewRow row) {
        String body = row.getBody() == null ? "" : row.getBody();
        String preview = body.length() > BODY_PREVIEW_LENGTH ? body.substring(0, BODY_PREVIEW_LENGTH) : body;
        return new MyReviewItem(
                row.getReviewId(),
                new MyReviewOnsenSummary(row.getOnsenId(), row.getName(), row.getSido(), row.getSigungu(),
                        row.getThumbnail()),
                row.getRating(),
                preview,
                row.getImageCount(),
                row.getFirstImage(),
                row.getVisitedAt(),
                Boolean.TRUE.equals(row.getIsRevisit()),
                row.getCreatedAt());
    }
}
