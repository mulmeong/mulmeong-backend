package com.mulmeong.domain.magazine.service;

import java.util.*;
import java.util.stream.Collectors;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.mulmeong.domain.magazine.dto.*;
import com.mulmeong.domain.magazine.entity.*;
import com.mulmeong.domain.magazine.repository.*;
import com.mulmeong.domain.place.entity.Place;
import com.mulmeong.domain.place.repository.PlaceImageRepository;
import com.mulmeong.global.exception.*;
import lombok.RequiredArgsConstructor;

@Service @RequiredArgsConstructor
public class MagazineService {
    private final MagazineRepository magazineRepository;
    private final MagazineLikeRepository likeRepository;
    private final MagazinePlaceRepository placeRepository;
    private final PlaceImageRepository imageRepository;

    @Transactional(readOnly = true)
    public MagazineListResponse list(String category, String sidoCode, String sort, boolean featured, int page, int size, Long userId) {
        MagazineCategory c = parseCategory(category);
        int actualSize = featured ? 5 : Math.min(Math.max(size, 1), 30);
        Sort.Direction direction = "READ_TIME".equals(sort) || "POPULAR".equals(sort) ? Sort.Direction.DESC : Sort.Direction.DESC;
        String property = "POPULAR".equals(sort) ? "likeCount" : "LATEST".equals(sort) ? "publishedAt" : "readMinutes";
        Pageable pageable = PageRequest.of(Math.max(page, 0), actualSize, Sort.by(direction, property));
        Page<Magazine> result = magazineRepository.search(c, blankToNull(sidoCode), pageable);
        List<Long> magazineIds = result.getContent().stream().map(Magazine::getId).toList();
        Set<Long> liked = userId == null || magazineIds.isEmpty() ? Set.of() : likeRepository.findLikedMagazineIds(userId, magazineIds);
        List<MagazineResponse> content = result.getContent().stream().map(m -> toSummary(m, liked.contains(m.getId()))).toList();
        return new MagazineListResponse(content, result.getNumber(), result.getSize(), result.getTotalElements(), result.getTotalPages(), result.isLast(), null, null);
    }

    @Transactional(readOnly = true)
    public MagazineResponse.Detail detail(Long id, Long userId) {
        Magazine m = magazineRepository.findById(id).orElseThrow(() -> new BusinessException(ErrorCode.MAGAZINE_NOT_FOUND));
        boolean liked = userId != null && likeRepository.existsByMagazineIdAndUserId(id, userId);
        List<MagazineResponse.Place> places = placeRepository.findPlaces(id).stream().filter(p -> p.getLat() != null && p.getLng() != null).map(this::toPlace).toList();
        Magazine next = magazineRepository.findNext(m.getCategory(), id, PageRequest.of(0, 1)).stream().findFirst().orElse(null);
        return new MagazineResponse.Detail(m.getId(), m.getCategory().name(), m.getCategory().getLabel(), m.getTitle(), m.getSubtitle(), m.getThumbnailUrl(), m.getHeroImageUrl(), m.getSidoCode(), regionName(m.getSidoCode()), m.getReadMinutes(), m.getLikeCount(), liked, m.getPublishedAt(), m.getAuthor() == null ? "물멍 에디터" : m.getAuthor(), m.getPhotographer(), m.getBody(), "MULMUNG_TEXT", places, next == null ? null : new MagazineResponse.Next(next.getId(), next.getTitle(), next.getCategory().getLabel(), next.getReadMinutes()), "https://mulmung.space/magazine/" + m.getId());
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
    private void requireMagazine(Long id) { if (!magazineRepository.existsById(id)) throw new BusinessException(ErrorCode.MAGAZINE_NOT_FOUND); }
    private MagazineResponse toSummary(Magazine m, boolean liked) { return new MagazineResponse(m.getId(), m.getCategory().name(), m.getCategory().getLabel(), m.getTitle(), m.getSubtitle(), m.getThumbnailUrl(), m.getHeroImageUrl(), m.getSidoCode(), regionName(m.getSidoCode()), m.getReadMinutes(), m.getLikeCount(), liked, m.getPublishedAt()); }
    private MagazineResponse.Place toPlace(Place p) { String image = imageRepository.findByPlaceIdOrderBySortOrder(p.getId()).stream().findFirst().map(i -> i.getImageUrl()).orElse(null); return new MagazineResponse.Place(p.getId(), p.getName(), image, p.getSido(), p.getSigungu(), p.getLat(), p.getLng(), p.getRegionComment(), p.getAccessLevel() == null ? null : p.getAccessLevel().getLabel()); }
    private MagazineCategory parseCategory(String value) { if (value == null || value.isBlank() || "ALL".equals(value)) return null; try { return MagazineCategory.valueOf(value); } catch (IllegalArgumentException e) { throw new BusinessException(ErrorCode.INVALID_MAGAZINE_FILTER); } }
    private String blankToNull(String value) { return value == null || value.isBlank() ? null : value; }
    private String regionName(String code) {
        if (code == null) return "전국";
        return Map.ofEntries(
                Map.entry("11", "서울"), Map.entry("26", "부산"), Map.entry("27", "대구"),
                Map.entry("28", "인천"), Map.entry("29", "광주"), Map.entry("30", "대전"),
                Map.entry("31", "울산"), Map.entry("43", "충북"), Map.entry("44", "충남"),
                Map.entry("46", "전남"), Map.entry("47", "경북"), Map.entry("48", "경남"),
                Map.entry("51", "강원"), Map.entry("52", "전북"), Map.entry("41", "경기"))
                .getOrDefault(code, code);
    }
}
