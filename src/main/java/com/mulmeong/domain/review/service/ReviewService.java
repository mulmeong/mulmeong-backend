package com.mulmeong.domain.review.service;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mulmeong.domain.place.service.PlaceService;
import com.mulmeong.domain.region.service.RegionStatService;
import com.mulmeong.domain.review.dto.request.ReviewCreateRequest;
import com.mulmeong.domain.review.dto.request.ReviewSpecRequest;
import com.mulmeong.domain.review.dto.request.ReviewUpdateRequest;
import com.mulmeong.domain.review.dto.response.OnsenReviewListResponse;
import com.mulmeong.domain.review.dto.response.OnsenReviewStatsResponse;
import com.mulmeong.domain.review.dto.response.ReviewCreateResponse;
import com.mulmeong.domain.review.dto.response.ReviewUpdateResponse;
import com.mulmeong.domain.review.entity.Review;
import com.mulmeong.domain.review.entity.ReviewImage;
import com.mulmeong.domain.review.repository.ReviewImageRepository;
import com.mulmeong.domain.review.repository.ReviewRepository;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.domain.user.service.UserService;
import com.mulmeong.global.common.Level;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService {
    private static final ZoneId KST = ZoneId.of("Asia/Seoul");
    private static final int MAX_PAGE_SIZE = 30;
    private static final List<String> VISIT_TIMES = List.of("MORNING", "AFTERNOON", "EVENING", "NIGHT");

    private final ReviewRepository reviewRepository;
    private final ReviewImageRepository reviewImageRepository;
    private final PlaceService placeService;
    private final UserService userService;
    private final RegionStatService regionStatService;
    @Value("${app.s3.cloudfront-base-url:}")
    private String storageBaseUrl;

    @Transactional
    public ReviewCreateResponse create(Long userId, Long onsenId, ReviewCreateRequest request) {
        validateCreate(request);
        User user = userService.lockActiveUser(userId);
        PlaceService.OnsenVisitInfo onsen = placeService.getOnsenVisitInfo(onsenId);
        LocalDate visitedAt = request.visitedAt() == null ? LocalDate.now(KST) : request.visitedAt();
        if (visitedAt.isAfter(LocalDate.now(KST))) throw new BusinessException(ErrorCode.VALIDATION_FAILED);
        if (reviewRepository.existsByUserIdAndPlaceIdAndVisitedAtAndDeletedAtIsNull(userId, onsenId, visitedAt)) {
            throw new BusinessException(ErrorCode.DAILY_REVIEW_LIMIT);
        }
        boolean firstVisit = !reviewRepository.existsByUserIdAndPlaceIdAndDeletedAtIsNull(userId, onsenId);
        Level before = user.level();
        Review review = Review.create(
                userId,
                onsenId,
                request.rating(),
                request.spec().clean(),
                request.spec().crowd(),
                request.spec().facility(),
                request.spec().visitTime(),
                visitedAt,
                request.body() == null ? "" : request.body());
        try {
            reviewRepository.saveAndFlush(review);
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException(ErrorCode.DAILY_REVIEW_LIMIT);
        }
        replaceImages(review.getId(), request.imageUrls());
        int visitCountAfter = user.getVisitCount();
        if (firstVisit) {
            userService.incrementVisitCount(userId);
            visitCountAfter++;
        }
        regionStatService.incrementVisitCount(userId, onsen.sidoCode(), onsen.sigunguCode());
        Level after = Level.from(visitCountAfter);
        return new ReviewCreateResponse(review.getId(), onsenId, visitedAt, review.getCreatedAt(),
                new ReviewCreateResponse.Reward(firstVisit, onsen.sidoCode(), onsen.sigunguCode(), regionName(onsen),
                        regionStatService.visitCount(userId, onsen.sigunguCode()), visitCountAfter,
                        after.number() > before.number(), before.number(), after.number(), after.title()));
    }

    @Transactional
    public ReviewUpdateResponse update(Long userId, Long reviewId, ReviewUpdateRequest request) {
        validateUpdate(request);
        Review review = ownedReview(userId, reviewId);
        ReviewSpecRequest spec = request.spec();
        if (spec != null && spec.visitTime() != null) {
            validateVisitTime(spec.visitTime());
        }
        review.update(
                request.rating(),
                spec == null ? null : spec.clean(),
                spec == null ? null : spec.crowd(),
                spec == null ? null : spec.facility(),
                spec == null ? null : spec.visitTime(),
                request.body());
        if (request.imageUrls() != null) {
            replaceImages(reviewId, request.imageUrls());
        }
        reviewRepository.flush();
        List<String> images = request.imageUrls() != null ? request.imageUrls() : imageUrls(review);
        return new ReviewUpdateResponse(
                reviewId,
                review.getRating(),
                review.getBody() == null ? "" : review.getBody(),
                images,
                review.getUpdatedAt());
    }

    @Transactional
    public void delete(Long userId, Long reviewId) {
        userService.lockActiveUser(userId);
        Review review = ownedReview(userId, reviewId);
        PlaceService.OnsenVisitInfo onsen = placeService.getOnsenVisitInfo(review.getPlaceId());
        review.delete(OffsetDateTime.now());
        reviewRepository.flush();
        if (!reviewRepository.existsByUserIdAndPlaceIdAndDeletedAtIsNull(userId, review.getPlaceId())) {
            userService.decrementVisitCount(userId);
        }
        regionStatService.decrementVisitCount(userId, onsen.sigunguCode());
    }

    @Transactional(readOnly = true)
    public OnsenReviewListResponse list(Long onsenId, Long viewerId, String sort, int page, int size) {
        placeService.getOnsenVisitInfo(onsenId);
        if (!List.of("RECENT", "RATING_DESC", "PHOTO_FIRST").contains(sort)) {
            throw new BusinessException(ErrorCode.VALIDATION_FAILED);
        }
        int safePage = Math.max(0, page);
        int safeSize = Math.max(1, Math.min(size, MAX_PAGE_SIZE));
        Sort ordering = "RATING_DESC".equals(sort)
                ? Sort.by(Sort.Direction.DESC, "rating").and(Sort.by(Sort.Direction.DESC, "createdAt"))
                : Sort.by(Sort.Direction.DESC, "createdAt");
        Page<Review> result = reviewRepository.findByPlaceIdAndDeletedAtIsNull(
                onsenId, PageRequest.of(safePage, safeSize, ordering));
        List<Review> reviews = result.getContent();
        if ("PHOTO_FIRST".equals(sort)) {
            reviews = reviews.stream()
                    .sorted(Comparator.comparing(review -> review.getImages().isEmpty()))
                    .toList();
        }
        return new OnsenReviewListResponse(
                reviews.stream().map(review -> toItem(review, viewerId)).toList(),
                safePage,
                safeSize,
                result.getTotalElements(),
                result.getTotalPages(),
                result.isLast());
    }

    @Transactional(readOnly = true)
    public OnsenReviewStatsResponse stats(Long onsenId) {
        placeService.getOnsenVisitInfo(onsenId);
        List<Review> reviews = reviewRepository.findByPlaceIdAndDeletedAtIsNull(onsenId);
        Map<String, Long> ratings = new LinkedHashMap<>();
        for (int i = 5; i >= 1; i--) {
            ratings.put(String.valueOf(i), 0L);
        }
        reviews.forEach(r -> ratings.compute(String.valueOf(r.getRating()), (k, v) -> v + 1));
        if (reviews.size() < 3) {
            return new OnsenReviewStatsResponse(
                    onsenId,
                    reviews.size(),
                    null,
                    ratings,
                    null,
                    new OnsenReviewStatsResponse.VisitTime(timeCounts(reviews), null),
                    List.of());
        }
        double rating = average(reviews.stream().map(Review::getRating).toList());
        double clean = average(reviews.stream().map(Review::getCleanliness).toList());
        double crowd = average(reviews.stream().map(Review::getCrowdedness).toList());
        double facility = average(reviews.stream().map(Review::getFacilityScore).toList());
        Map<String, Long> times = timeCounts(reviews);
        String top = times.entrySet().stream()
                .max(Map.Entry.comparingByValue())
                .map(entry -> timeLabel(entry.getKey()))
                .orElse(null);
        var specs = new OnsenReviewStatsResponse.Specs(
                new OnsenReviewStatsResponse.Metric(round(clean), cleanLabel(clean)),
                new OnsenReviewStatsResponse.Metric(round(crowd), crowdLabel(crowd)),
                new OnsenReviewStatsResponse.Metric(round(facility), facilityLabel(facility)));
        return new OnsenReviewStatsResponse(onsenId, reviews.size(), round(rating), ratings, specs,
                new OnsenReviewStatsResponse.VisitTime(times, top), List.of(cleanLabel(clean), top, crowdLabel(crowd)));
    }

    private Review ownedReview(Long userId, Long reviewId) {
        Review review = reviewRepository.findByIdAndDeletedAtIsNull(reviewId)
                .orElseThrow(() -> new BusinessException(ErrorCode.REVIEW_NOT_FOUND));
        if (!review.getUserId().equals(userId)) {
            throw new BusinessException(ErrorCode.FORBIDDEN);
        }
        return review;
    }

    private void validateCreate(ReviewCreateRequest request) {
        ReviewSpecRequest spec = request.spec();
        if (spec == null || request.rating() == null || spec.clean() == null || spec.crowd() == null
                || spec.facility() == null || spec.visitTime() == null) {
            throw new BusinessException(ErrorCode.VALIDATION_FAILED);
        }
        validateVisitTime(spec.visitTime());
        validateUrls(request.imageUrls());
    }

    private void validateUpdate(ReviewUpdateRequest request) {
        ReviewSpecRequest spec = request.spec();
        if (spec != null && spec.clean() == null && spec.crowd() == null && spec.facility() == null
                && spec.visitTime() == null) {
            throw new BusinessException(ErrorCode.VALIDATION_FAILED);
        }
        validateUrls(request.imageUrls());
    }

    private void validateVisitTime(String value) {
        if (!VISIT_TIMES.contains(value)) {
            throw new BusinessException(ErrorCode.VALIDATION_FAILED);
        }
    }

    private void validateUrls(List<String> urls) {
        if (urls == null) return;
        if (urls.size() > 5) {
            throw new BusinessException(ErrorCode.TOO_MANY_IMAGES);
        }
        if (storageBaseUrl.isBlank() || urls.stream().anyMatch(url -> url == null || !url.startsWith(storageBaseUrl))) {
            throw new BusinessException(ErrorCode.VALIDATION_FAILED);
        }
    }

    private void replaceImages(Long reviewId, List<String> urls) {
        if (urls == null) return;
        reviewImageRepository.deleteByReviewId(reviewId);
        for (short index = 0; index < urls.size(); index++) {
            reviewImageRepository.save(ReviewImage.create(reviewId, urls.get(index), index));
        }
    }

    private List<String> imageUrls(Review review) {
        return review.getImages().stream().map(ReviewImage::getImageUrl).toList();
    }

    private OnsenReviewListResponse.Item toItem(Review review, Long viewerId) {
        User author = review.getUser();
        boolean withdrawn = author == null || author.isWithdrawn();
        OnsenReviewListResponse.Author responseAuthor = new OnsenReviewListResponse.Author(
                withdrawn ? "탈퇴한 사용자" : author.getNickname(),
                withdrawn ? null : author.level().number(),
                withdrawn ? null : author.level().title(),
                withdrawn ? null : author.getProfileShareToken());
        OnsenReviewListResponse.Spec spec = new OnsenReviewListResponse.Spec(
                review.getVisitTimeSlot(), review.getCleanliness(), review.getCrowdedness(), review.getFacilityScore());
        return new OnsenReviewListResponse.Item(
                review.getId(), responseAuthor, review.getRating(), review.getVisitedAt(), review.isRevisit(), spec,
                review.getBody() == null ? "" : review.getBody(), imageUrls(review), review.getUserId().equals(viewerId),
                !review.getUpdatedAt().equals(review.getCreatedAt()), review.getCreatedAt());
    }

    private String regionName(PlaceService.OnsenVisitInfo onsen) {
        String sido = onsen.sido();
        String sigungu = onsen.sigungu();
        if (sido == null || sido.isBlank()) return sigungu;
        if (sigungu == null || sigungu.isBlank()) return sido;
        return sido + " " + sigungu;
    }

    private Map<String, Long> timeCounts(List<Review> reviews) {
        Map<String, Long> counts = new LinkedHashMap<>();
        VISIT_TIMES.forEach(time -> counts.put(time, 0L));
        reviews.forEach(review -> counts.compute(review.getVisitTimeSlot(), (key, count) -> count + 1));
        return counts;
    }

    private double average(List<Short> values) {
        return values.stream().mapToInt(Short::intValue).average().orElse(0);
    }

    private Double round(double value) {
        return Math.round(value * 10) / 10.0;
    }

    private String cleanLabel(double value) {
        return value >= 3.5 ? "깨끗해요" : value >= 2.0 ? "보통이에요" : "아쉬워요";
    }

    private String crowdLabel(double value) {
        return value <= 2.0 ? "한산해요" : value <= 3.5 ? "보통이에요" : "붐벼요";
    }

    private String facilityLabel(double value) {
        return value >= 3.5 ? "시설이 좋아요" : value >= 2.0 ? "보통이에요" : "아쉬워요";
    }

    private String timeLabel(String value) {
        return Map.of(
                "MORNING", "아침에 많이 가요",
                "AFTERNOON", "오후에 많이 가요",
                "EVENING", "저녁에 많이 가요",
                "NIGHT", "밤에 많이 가요").get(value);
    }
}
