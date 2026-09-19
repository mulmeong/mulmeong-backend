package com.mulmeong.domain.favorite.service;

import com.mulmeong.domain.favorite.dto.request.FavoriteCreateRequest;
import com.mulmeong.domain.favorite.dto.response.FavoriteCounts;
import com.mulmeong.domain.favorite.dto.response.FavoriteCreateResponse;
import com.mulmeong.domain.favorite.dto.response.FavoriteItem;
import com.mulmeong.domain.favorite.dto.response.FavoriteListResponse;
import com.mulmeong.domain.favorite.entity.Favorite;
import com.mulmeong.domain.favorite.repository.FavoriteRepository;
import com.mulmeong.domain.place.entity.Place;
import com.mulmeong.domain.place.entity.PlaceImage;
import com.mulmeong.domain.place.entity.PlaceType;
import com.mulmeong.domain.place.repository.PlaceImageRepository;
import com.mulmeong.domain.place.repository.PlaceRepository;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class FavoriteService {
    private final FavoriteRepository favorites;
    private final PlaceRepository places;
    private final PlaceImageRepository images;

    /**
     * 지도/온천 응답에서 사용하는 기존 조회 계약을 유지한다.
     */
    @Transactional(readOnly = true)
    public Set<Long> getFavoritePlaceIds(Long userId, List<Long> placeIds) {
        if (userId == null || placeIds.isEmpty()) return Set.of();
        return favorites.findByUserIdAndPlaceIdIn(userId, placeIds).stream()
                .map(Favorite::getPlaceId).collect(Collectors.toSet());
    }

    @Transactional
    public CreateOutcome create(Long userId, FavoriteCreateRequest request) {
        Place place;
        if (request.placeId() != null) {
            place = places.findById(request.placeId()).orElseThrow(() -> new BusinessException(ErrorCode.PLACE_NOT_FOUND));
        } else {
            if (request.source() == null || request.externalId() == null || request.name() == null
                    || request.lat() == null || request.lng() == null || request.category() == null)
                throw new BusinessException(ErrorCode.VALIDATION_FAILED);
            place = places.findBySourceAndExternalId(request.source(), request.externalId()).orElseGet(() ->
                    places.save(Place.createExternal(request.source(), request.externalId(), request.name(),
                            request.lat(), request.lng(), request.category(), request.address(), request.phone())));
            place.updateExternal(request.name(), request.lat(), request.lng(), request.category(), request.address(), request.phone());
            if (request.imageUrl() != null && !request.imageUrl().isBlank()
                    && images.findByPlaceIdOrderBySortOrder(place.getId()).stream().noneMatch(i -> request.imageUrl().equals(i.getImageUrl())))
                images.save(new PlaceImage(place.getId(), request.imageUrl(), (short) 0));
        }
        Optional<Favorite> existing = favorites.findByUserIdAndPlaceId(userId, place.getId());
        if (existing.isPresent()) return new CreateOutcome(response(existing.get()), true);
        if (favorites.countByUserId(userId) >= 300) throw new BusinessException(ErrorCode.FAVORITE_LIMIT_EXCEEDED);
        return new CreateOutcome(response(favorites.save(new Favorite(userId, place.getId()))), false);
    }

    @Transactional(readOnly = true)
    public FavoriteListResponse list(Long userId, String category, String sort, int page, int size) {
        if (!Set.of("ALL", "ONSEN", "RESTAURANT", "CAFE", "ATTRACTION").contains(category))
            throw new BusinessException(ErrorCode.INVALID_FAVORITE_CATEGORY);
        if (!Set.of("RECENT", "NAME").contains(sort)) throw new BusinessException(ErrorCode.VALIDATION_FAILED);
        int actualSize = Math.min(Math.max(size, 1), 100);
        List<PlaceType> types = switch (category) {
            case "ONSEN" -> List.of(PlaceType.ONSEN, PlaceType.SPA);
            case "RESTAURANT" -> List.of(PlaceType.RESTAURANT);
            case "CAFE" -> List.of(PlaceType.CAFE);
            case "ATTRACTION" -> List.of(PlaceType.ATTRACTION);
            default -> Arrays.asList(PlaceType.values());
        };
        List<Favorite> all = favorites.findByUserId(userId);
        List<Favorite> filtered = all.stream().filter(f -> types.contains(findPlace(f.getPlaceId()).getPlaceType())).toList();
        Comparator<Favorite> comparator = "NAME".equals(sort)
                ? Comparator.comparing(f -> findPlace(f.getPlaceId()).getName(), String.CASE_INSENSITIVE_ORDER)
                : Comparator.comparing(Favorite::getCreatedAt, Comparator.nullsLast(Comparator.reverseOrder()));
        filtered = filtered.stream().sorted(comparator).toList();
        int safePage = Math.max(page, 0), from = Math.min(safePage * actualSize, filtered.size()), to = Math.min(from + actualSize, filtered.size());
        List<FavoriteItem> content = filtered.subList(from, to).stream().map(this::item).toList();
        FavoriteCounts counts = safePage == 0 ? counts(all) : null;
        return new FavoriteListResponse(content, safePage, actualSize, filtered.size(), (filtered.size() + actualSize - 1) / actualSize, to == filtered.size(), counts);
    }

    @Transactional
    public void delete(Long userId, Long placeId) {
        favorites.deleteByUserIdAndPlaceId(userId, placeId);
    }

    @Transactional(readOnly = true)
    public long countByUserId(Long userId) {
        return favorites.countByUserId(userId);
    }

    @Transactional
    public void deleteAllByUserId(Long userId) {
        favorites.deleteByUserId(userId);
    }

    private Place findPlace(Long id) {
        return places.findById(id).orElseThrow(() -> new BusinessException(ErrorCode.PLACE_NOT_FOUND));
    }

    private FavoriteCreateResponse response(Favorite f) {
        return new FavoriteCreateResponse(f.getId(), f.getPlaceId(), true, f.getCreatedAt());
    }

    private FavoriteItem item(Favorite f) {
        Place p = findPlace(f.getPlaceId());
        String thumbnail = images.findByPlaceIdOrderBySortOrder(p.getId()).stream().findFirst().map(i -> i.getImageUrl()).orElse(null);
        String sub = p.getPlaceType() == PlaceType.ONSEN
                ? (p.getWaterTemp() == null ? "" : p.getWaterTemp() + "℃") + (p.getWaterType() == null ? "" : " · " + p.getWaterType())
                : switch (p.getPlaceType()) {
            case RESTAURANT -> "식당";
            case CAFE -> "카페";
            case ATTRACTION -> "관광지";
            case SPA -> "스파";
            default -> "기타";
        };
        String kakao = "KAKAO".equals(p.getSource()) && p.getExternalId() != null ? "http://place.map.kakao.com/" + p.getExternalId().replaceFirst("^KAKAO_", "") : null;
        return new FavoriteItem(f.getId(), p.getId(), p.getPlaceType().name(), typeLabel(p.getPlaceType()), p.getName(), p.getSido(), p.getSigungu(), p.getAddress(), p.getLat(), p.getLng(), thumbnail, sub, p.isRegisteredOnsen(), p.getSource(), kakao, f.getCreatedAt());
    }

    private String typeLabel(PlaceType type) {
        return switch (type) {
            case ONSEN -> "온천";
            case SPA -> "스파";
            case RESTAURANT -> "식당";
            case CAFE -> "카페";
            case ATTRACTION -> "관광지";
            default -> "기타";
        };
    }

    private FavoriteCounts counts(List<Favorite> all) {
        Map<PlaceType, Long> map = all.stream().map(f -> findPlace(f.getPlaceId()).getPlaceType()).collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
        return new FavoriteCounts(all.size(), map.getOrDefault(PlaceType.ONSEN, 0L) + map.getOrDefault(PlaceType.SPA, 0L), map.getOrDefault(PlaceType.RESTAURANT, 0L), map.getOrDefault(PlaceType.CAFE, 0L), map.getOrDefault(PlaceType.ATTRACTION, 0L));
    }

    public record CreateOutcome(FavoriteCreateResponse response, boolean existing) {
    }
}
