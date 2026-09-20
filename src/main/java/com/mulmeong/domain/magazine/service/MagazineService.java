package com.mulmeong.domain.magazine.service;

import com.mulmeong.domain.magazine.dto.MagazineListResponse;
import com.mulmeong.domain.magazine.dto.MagazineResponse;
import com.mulmeong.domain.magazine.entity.Magazine;
import com.mulmeong.domain.magazine.entity.MagazineCategory;
import com.mulmeong.domain.magazine.entity.MagazineLike;
import com.mulmeong.domain.magazine.repository.MagazineLikeRepository;
import com.mulmeong.domain.magazine.repository.MagazinePlaceRepository;
import com.mulmeong.domain.magazine.repository.MagazineRepository;
import com.mulmeong.domain.place.entity.Place;
import com.mulmeong.domain.place.repository.PlaceImageRepository;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class MagazineService {
    private static final Map<String, List<String>> REGION_CODES = Map.ofEntries(
            Map.entry("수도권", List.of("11", "28", "41")),
            Map.entry("충청", List.of("30", "36", "43", "44")),
            Map.entry("전라", List.of("29", "46", "52")),
            Map.entry("경상", List.of("26", "27", "31", "47", "48")),
            Map.entry("강원", List.of("51")),
            Map.entry("제주", List.of("50")),
            Map.entry("서울", List.of("11")), Map.entry("부산", List.of("26")),
            Map.entry("대구", List.of("27")), Map.entry("인천", List.of("28")),
            Map.entry("광주", List.of("29")), Map.entry("대전", List.of("30")),
            Map.entry("울산", List.of("31")), Map.entry("세종", List.of("36")),
            Map.entry("경기", List.of("41")), Map.entry("충북", List.of("43")),
            Map.entry("충남", List.of("44")), Map.entry("전남", List.of("46")),
            Map.entry("경북", List.of("47")), Map.entry("경남", List.of("48")),
            Map.entry("전북", List.of("52"))
    );

    private final MagazineRepository magazineRepository;
    private final MagazineLikeRepository likeRepository;
    private final MagazinePlaceRepository placeRepository;
    private final PlaceImageRepository imageRepository;

    @Transactional(readOnly = true)
    public MagazineListResponse list(String category, String sidoCode, String region, String sort, boolean featured,
                                     int page, int size,
                                     Long userId) {
        MagazineCategory c = parseCategory(category);
        String normalizedSidoCode = blankToNull(sidoCode);
        List<String> regionCodes = regionCodes(region);
        if (normalizedSidoCode != null && regionCodes != null) {
            throw new BusinessException(ErrorCode.INVALID_MAGAZINE_FILTER);
        }
        int actualSize = featured ? 5 : Math.min(Math.max(size, 1), 100);
        String property = "POPULAR".equals(sort) ? "likeCount"
                : "LATEST".equals(sort) ? "publishedAt" : "readMinutes";
        Pageable pageable = PageRequest.of(Math.max(page, 0), actualSize, Sort.by(Sort.Direction.DESC, property));
        Page<Magazine> result = regionCodes == null
                ? magazineRepository.search(c, normalizedSidoCode, pageable)
                : magazineRepository.searchBySidoCodes(c, regionCodes, pageable);
        List<Long> magazineIds = result.getContent().stream().map(Magazine::getId).toList();
        Set<Long> liked = userId == null || magazineIds.isEmpty()
                ? Set.of()
                : likeRepository.findLikedMagazineIds(userId, magazineIds);
        List<MagazineResponse> content = result.getContent().stream()
                .map(magazine -> toSummary(magazine, liked.contains(magazine.getId())))
                .toList();
        List<MagazineListResponse.RegionCount> regions = page == 0
                ? magazineRepository.countBySidoCode(c).stream()
                .map(count -> new MagazineListResponse.RegionCount(
                        count.getSidoCode(), regionName(count.getSidoCode()), count.getCount()))
                .toList()
                : null;
        return new MagazineListResponse(
                content, result.getNumber(), result.getSize(), result.getTotalElements(), result.getTotalPages(),
                result.isLast(), null, regions);
    }

    @Transactional(readOnly = true)
    public MagazineResponse.Detail detail(Long id, Long userId) {
        Magazine m = magazineRepository.findById(id)
                .orElseThrow(() -> new BusinessException(ErrorCode.MAGAZINE_NOT_FOUND));
        boolean liked = userId != null && likeRepository.existsByMagazineIdAndUserId(id, userId);
        List<MagazineResponse.Place> places = placeRepository.findPlaces(id).stream()
                .filter(place -> place.getLat() != null && place.getLng() != null)
                .map(this::toPlace)
                .toList();
        Magazine next = magazineRepository.findNext(m.getCategory(), id, PageRequest.of(0, 1)).stream()
                .findFirst().orElse(null);
        return new MagazineResponse.Detail(
                m.getId(), m.getCategory().name(), m.getCategory().getLabel(), m.getTitle(), m.getSubtitle(),
                m.getThumbnailUrl(), m.getHeroImageUrl(), m.getSidoCode(), regionName(m.getSidoCode()),
                m.getReadMinutes(), m.getLikeCount(), liked, m.getPublishedAt(),
                m.getAuthor() == null ? "물멍 에디터" : m.getAuthor(), m.getPhotographer(), m.getBody(),
                "MULMEONG_TEXT", places,
                next == null ? null : new MagazineResponse.Next(
                        next.getId(), next.getTitle(), next.getCategory().getLabel(), next.getReadMinutes()),
                "https://mulmeong.space/magazine/" + m.getId());
    }

    @Transactional
    public void like(Long id, Long userId) {
        requireMagazine(id);
        if (!likeRepository.existsByMagazineIdAndUserId(id, userId)) {
            likeRepository.save(new MagazineLike(id, userId));
            magazineRepository.incrementLikeCount(id);
        }
    }

    @Transactional
    public void unlike(Long id, Long userId) {
        requireMagazine(id);
        likeRepository.findByMagazineIdAndUserId(id, userId).ifPresent(like -> {
            likeRepository.delete(like);
            magazineRepository.decrementLikeCount(id);
        });
    }

    /**
     * 709 탈퇴 시 내 좋아요를 전부 취소한다(like_count 감소 포함).
     */
    @Transactional
    public void unlikeAllByUser(Long userId) {
        likeRepository.findByUserId(userId).forEach(like -> unlike(like.getMagazineId(), userId));
    }

    private void requireMagazine(Long id) {
        if (!magazineRepository.existsById(id)) {
            throw new BusinessException(ErrorCode.MAGAZINE_NOT_FOUND);
        }
    }

    private MagazineResponse toSummary(Magazine magazine, boolean liked) {
        return new MagazineResponse(
                magazine.getId(), magazine.getCategory().name(), magazine.getCategory().getLabel(),
                magazine.getTitle(), magazine.getSubtitle(), magazine.getThumbnailUrl(), magazine.getHeroImageUrl(),
                magazine.getSidoCode(), regionName(magazine.getSidoCode()), magazine.getReadMinutes(),
                magazine.getLikeCount(), liked, magazine.getPublishedAt());
    }

    private MagazineResponse.Place toPlace(Place place) {
        String image = imageRepository.findByPlaceIdOrderBySortOrder(place.getId()).stream()
                .findFirst().map(item -> item.getImageUrl()).orElse(null);
        return new MagazineResponse.Place(
                place.getId(), place.getName(), image, place.getSido(), place.getSigungu(), place.getLat(),
                place.getLng(), place.getRegionComment(),
                place.getAccessLevel() == null ? null : place.getAccessLevel().getLabel(),
                place.getWaterTemp(), place.getWaterType(), place.getHasOutdoor());
    }

    private MagazineCategory parseCategory(String value) {
        if (value == null || value.isBlank() || "ALL".equals(value)) {
            return null;
        }
        try {
            return MagazineCategory.valueOf(value);
        } catch (IllegalArgumentException e) {
            throw new BusinessException(ErrorCode.INVALID_MAGAZINE_FILTER);
        }
    }

    private String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value;
    }

    private List<String> regionCodes(String region) {
        String normalized = blankToNull(region);
        if (normalized == null) {
            return null;
        }
        List<String> codes = REGION_CODES.get(normalized);
        if (codes == null) {
            throw new BusinessException(ErrorCode.INVALID_MAGAZINE_FILTER);
        }
        return codes;
    }

    private String regionName(String code) {
        if (code == null) {
            return "전국";
        }
        return Map.ofEntries(
                        Map.entry("11", "서울"), Map.entry("26", "부산"), Map.entry("27", "대구"),
                        Map.entry("28", "인천"), Map.entry("29", "광주"), Map.entry("30", "대전"),
                        Map.entry("31", "울산"), Map.entry("43", "충북"), Map.entry("44", "충남"),
                        Map.entry("46", "전남"), Map.entry("47", "경북"), Map.entry("48", "경남"),
                        Map.entry("50", "제주"), Map.entry("51", "강원"), Map.entry("52", "전북"), Map.entry("36", "세종"),
                        Map.entry("41", "경기"))
                .getOrDefault(code, code);
    }
}
