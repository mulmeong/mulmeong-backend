package com.mulmeong.domain.place.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;
import java.util.stream.Collectors;

import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mulmeong.domain.favorite.service.FavoriteService;
import com.mulmeong.domain.place.dto.request.NearbyRerollRequest;
import com.mulmeong.domain.place.dto.response.ExternalDirectionsResponse;
import com.mulmeong.domain.place.dto.response.MapOnsensResponse;
import com.mulmeong.domain.place.dto.response.OnsenCardResponse;
import com.mulmeong.domain.place.dto.response.OnsenDetailResponse;
import com.mulmeong.domain.place.dto.response.OnsenDirectionsResponse;
import com.mulmeong.domain.place.dto.response.NearbyPlaceResponse;
import com.mulmeong.domain.place.dto.response.OnsenSearchResponse;
import com.mulmeong.domain.place.dto.response.OnsenListResponse;
import com.mulmeong.domain.place.entity.AccessLevel;
import com.mulmeong.domain.place.entity.Place;
import com.mulmeong.domain.place.entity.PlaceImage;
import com.mulmeong.domain.place.entity.PlaceType;
import com.mulmeong.domain.place.repository.PlaceImageRepository;
import com.mulmeong.domain.place.repository.PlaceRepository;
import com.mulmeong.domain.place.repository.RegionAggregate;
import com.mulmeong.domain.place.repository.SigunguAggregate;
import com.mulmeong.domain.place.repository.ReviewAggregate;
import com.mulmeong.domain.place.repository.ReviewAggregateRepository;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PlaceService {

    // 대한민국 대략 범위 밖이거나 이보다 넓은 bbox는 전국을 넘어서는 요청으로 간주한다.
    private static final double KOREA_MIN_LAT = 33.0;
    private static final double KOREA_MAX_LAT = 39.0;
    private static final double KOREA_MIN_LNG = 124.0;
    private static final double KOREA_MAX_LNG = 132.0;
    private static final double MAX_BBOX_LAT_SPAN = 6.0;
    private static final double MAX_BBOX_LNG_SPAN = 9.0;

    // 카카오맵 레벨 기준: 이 이상으로 축소되면 마커 대신 시군구 클러스터로 응답한다.
    private static final int CLUSTER_ZOOM_LEVEL = 8;

    private static final int MAX_SEARCH_LIMIT = 20;
    private static final int MAX_REGION_RESULTS = 3;
    private static final short THUMBNAIL_SORT_ORDER = 0;

    private final PlaceRepository placeRepository;
    private final PlaceImageRepository placeImageRepository;
    private final ReviewAggregateRepository reviewAggregateRepository;
    private final FavoriteService favoriteService;
    private final ExternalPlaceClient externalPlaceClient;
    private final ExternalDirectionsClient externalDirectionsClient;

    @Transactional
    public OnsenListResponse getOnsens(String region, int page, int size, String keyword) {
        if (page < 0 || size < 1 || size > 100) throw new BusinessException(ErrorCode.VALIDATION_FAILED);
        int safeSize = Math.min(size, 100);
        List<Place> all = placeRepository.findOnsens(region == null ? "" : region.trim(),
                keyword == null ? "" : keyword.trim(), PageRequest.of(page, safeSize));
        // Seeded MOIS rows may not have coordinates yet. Geocode only the requested page,
        // persist successful results, and return the coordinates in this response immediately.
        all.stream().filter(p -> p.getLat() == null || p.getLng() == null).forEach(externalPlaceClient::geocode);
        long total = placeRepository.countOnsens(region == null ? "" : region.trim(),
                keyword == null ? "" : keyword.trim());
        List<Long> ids = all.stream().map(Place::getId).toList();
        Map<Long, String> images = ids.isEmpty() ? Map.of() : placeImageRepository.findByPlaceIdInOrderBySortOrder(ids).stream()
                .collect(Collectors.toMap(PlaceImage::getPlaceId, PlaceImage::getImageUrl, (a, b) -> a));
        Map<Long, ReviewAggregate> reviews = ids.isEmpty() ? Map.of() : reviewAggregateRepository.findByPlaceIds(ids).stream()
                .collect(Collectors.toMap(ReviewAggregate::getPlaceId, r -> r));
        List<OnsenListResponse.Item> items = all.stream().map(p -> new OnsenListResponse.Item(p.getId(), p.getName(),
                p.getSido(), p.getSigungu(), p.getAddress(), p.getLat(), p.getLng(), p.isRegisteredOnsen(),
                p.getWaterTemp() == null ? null : p.getWaterTemp().doubleValue(), p.getWaterType(),
                p.getAccessLevel() == null ? null : p.getAccessLevel().name(),
                p.getAccessLevel() == null ? null : p.getAccessLevel().getLabel(), images.get(p.getId()),
                reviews.containsKey(p.getId()) ? reviews.get(p.getId()).getReviewCount() : 0,
                reviews.containsKey(p.getId()) ? reviews.get(p.getId()).getRating() : null)).toList();
        return new OnsenListResponse(items, page, safeSize, total, (int) Math.ceil((double) total / safeSize));
    }

    @Transactional(readOnly = true)
    public MapOnsensResponse getMapOnsens(double swLat, double swLng, double neLat, double neLng, int zoom,
            AccessLevel accessLevel, Boolean hasOutdoor, boolean registeredOnly, Long userId) {
        validateBbox(swLat, swLng, neLat, neLng);

        MapOnsensResponse.Bbox bbox = new MapOnsensResponse.Bbox(swLat, swLng, neLat, neLng);
        String centerSidoCode = placeRepository
                .findNearestSidoCode((swLat + neLat) / 2, (swLng + neLng) / 2)
                .orElse(null);

        if (zoom >= CLUSTER_ZOOM_LEVEL) {
            List<SigunguAggregate> aggregates = placeRepository.clusterOnsensInBbox(
                    swLat, neLat, swLng, neLng, accessLevel, hasOutdoor, registeredOnly);
            List<MapOnsensResponse.Cluster> clusters = aggregates.stream()
                    .map(a -> new MapOnsensResponse.Cluster(a.sigunguCode(), a.sigunguName(), a.avgLat(), a.avgLng(), a.count()))
                    .toList();
            long totalCount = aggregates.stream().mapToLong(SigunguAggregate::count).sum();
            return new MapOnsensResponse(bbox, true, List.of(), clusters, centerSidoCode, totalCount);
        }

        List<Place> places = placeRepository.findOnsensInBbox(
                swLat, neLat, swLng, neLng, accessLevel, hasOutdoor, registeredOnly);
        List<Long> placeIds = places.stream().map(Place::getId).toList();

        Map<Long, String> thumbnails = placeIds.isEmpty() ? Map.of() : placeImageRepository
                .findByPlaceIdInOrderBySortOrder(placeIds).stream()
                .collect(Collectors.toMap(PlaceImage::getPlaceId, PlaceImage::getImageUrl, (first, ignored) -> first));
        Set<Long> favoritePlaceIds = favoriteService.getFavoritePlaceIds(userId, placeIds);

        double centerLat = (swLat + neLat) / 2;
        double centerLng = (swLng + neLng) / 2;
        List<MapOnsensResponse.Marker> markers = places.stream()
                .sorted(Comparator
                        .comparing((Place p) -> !p.isRegisteredOnsen())
                        .thenComparing(p -> Math.hypot(p.getLat() - centerLat, p.getLng() - centerLng)))
                .map(p -> toMarker(p, thumbnails.get(p.getId()), favoritePlaceIds.contains(p.getId())))
                .toList();

        return new MapOnsensResponse(bbox, false, markers, List.of(), centerSidoCode, markers.size());
    }

    @Transactional(readOnly = true)
    public OnsenSearchResponse searchOnsens(String keyword, int limit) {
        String trimmed = keyword == null ? "" : keyword.trim();
        if (trimmed.length() < 2) {
            throw new BusinessException(ErrorCode.KEYWORD_TOO_SHORT);
        }
        int onsenLimit = Math.max(1, Math.min(limit, MAX_SEARCH_LIMIT));

        List<Place> onsens = placeRepository.searchOnsensByName(trimmed, PageRequest.of(0, onsenLimit));
        List<OnsenSearchResponse.Result> results = new ArrayList<>(onsens.stream()
                .map(p -> (OnsenSearchResponse.Result) new OnsenSearchResponse.OnsenResult(
                        p.getId(), p.getName(), p.getAddress(), p.getLat(), p.getLng(), p.isRegisteredOnsen()))
                .toList());

        int regionSlots = Math.min(MAX_REGION_RESULTS, Math.max(0, onsenLimit - results.size()));
        if (regionSlots > 0) {
            List<RegionAggregate> regions = placeRepository.searchRegionsByName(trimmed, PageRequest.of(0, regionSlots));
            regions.forEach(r -> results.add(new OnsenSearchResponse.RegionResult(
                    r.sigunguCode(), r.sido() + " " + r.sigungu(), r.avgLat(), r.avgLng(), r.count())));
        }

        return new OnsenSearchResponse(trimmed, results);
    }

    @Transactional(readOnly = true)
    public OnsenCardResponse getOnsenCard(Long onsenId) {
        Place place = findOnsenOrThrow(onsenId);
        AccessLevel accessLevel = place.getAccessLevel();
        String stationName = place.getStation() == null ? null : place.getStation().getName();
        String stationDescription = place.getStationToPlaceDesc();
        String courseSummary = stationName == null ? stationDescription
                : stationDescription == null ? stationName : stationName + " → " + stationDescription;
        return new OnsenCardResponse(
                place.getId(), place.getName(), new OnsenCardResponse.SpecBadges(
                place.getWaterTemp() != null ? place.getWaterTemp().doubleValue() : null,
                place.getWaterType(),
                accessLevel != null ? accessLevel.name() : null, null),
                place.getWaterBenefit(), courseSummary, stationDescription);
    }

    @Transactional(readOnly = true)
    public OnsenDetailResponse getOnsenDetail(Long onsenId, Long userId) {
        Place place = findOnsenOrThrow(onsenId);
        List<String> images = placeImageRepository.findByPlaceIdOrderBySortOrder(onsenId).stream()
                .map(PlaceImage::getImageUrl)
                .toList();
        AccessLevel accessLevel = place.getAccessLevel();
        OnsenDetailResponse.NearestStation nearestStation = place.getStation() == null ? null
                : new OnsenDetailResponse.NearestStation(place.getStation().getName(), place.getStation().getLat(),
                        place.getStation().getLng(), place.getStationToPlaceDesc());
        boolean isFavorite = favoriteService.getFavoritePlaceIds(userId, List.of(onsenId)).contains(onsenId);
        return new OnsenDetailResponse(
                place.getId(), place.getName(), place.isRegisteredOnsen(),
                place.getSido(), place.getSigungu(), place.getAddress(), place.getLat(), place.getLng(),
                place.getPhone(), place.getHomepageUrl(), place.getHours(), place.getHoliday(), place.getParkingInfo(),
                place.getPriceMin(),
                new OnsenDetailResponse.Water(
                        place.getWaterTemp() == null ? null : place.getWaterTemp().doubleValue(),
                        place.getWaterType(), place.getWaterComponent(),
                        place.getPh() == null ? null : place.getPh().doubleValue(), place.getWaterBenefit()),
                new OnsenDetailResponse.Facilities(place.getHasOutdoor(), place.getHasLodging(), place.getFacilityType()),
                new OnsenDetailResponse.Access(
                        accessLevel == null ? null : accessLevel.name(),
                        accessLevel == null ? null : accessLevel.getLabel(),
                        nearestStation),
                place.getAnnualVisitors(), images, images.stream().findFirst().orElse(null),
                place.getRegionComment(), place.getNotes(),
                isFavorite, reviewSummary(onsenId));
    }

    @Transactional(readOnly = true)
    public OnsenDirectionsResponse getOnsenDirections(Long onsenId, Double originLat, Double originLng, String mode,
            boolean includePath) {
        Place place = findOnsenOrThrow(onsenId);
        String normalizedMode = mode == null ? "TRANSIT" : mode.toUpperCase(Locale.ROOT);
        if ("CAR".equals(normalizedMode) && (originLat == null || originLng == null)) {
            throw new BusinessException(ErrorCode.ORIGIN_REQUIRED);
        }

        OnsenDirectionsResponse.NearestStation nearestStation = place.getStation() == null ? null
                : new OnsenDirectionsResponse.NearestStation(
                        place.getStation().getName(), place.getStation().getLat(), place.getStation().getLng());

        List<OnsenDirectionsResponse.Leg> legs = new ArrayList<>();
        Integer originLegDuration = null;
        if (place.getStation() != null && originLat != null && originLng != null) {
            try {
                ExternalDirectionsResponse route = externalDirectionsClient.route(normalizedMode, originLat, originLng,
                        place.getStation().getLat(), place.getStation().getLng(), includePath);
                legs.add(new OnsenDirectionsResponse.Leg(legs.size() + 1, "ORIGIN_TO_STATION", "KAKAO",
                        normalizedMode, route.distanceM(), route.totalDurationMin(), route.summary(), route.path()));
                originLegDuration = route.totalDurationMin();
            } catch (BusinessException e) {
                // 카카오 장애 시 부분 성공(200)으로 처리 — 거점역 구간만 응답한다.
                log.warn("Origin-to-station route failed for onsen {}: {}", onsenId, e.getMessage());
            }
        }
        if (place.getStation() != null) {
            legs.add(new OnsenDirectionsResponse.Leg(legs.size() + 1, "STATION_TO_ONSEN", "MANUAL", "BUS",
                    null, null, place.getStationToPlaceDesc(), null));
        }

        String kakaoDeepLink = place.getLat() == null || place.getLng() == null ? null
                : String.format(Locale.ROOT, "https://map.kakao.com/link/to/%s,%f,%f",
                        place.getName(), place.getLat(), place.getLng());
        return new OnsenDirectionsResponse(place.getId(), nearestStation, legs, originLegDuration, kakaoDeepLink);
    }

    @Transactional(readOnly = true)
    public NearbyPlaceResponse getNearby(Long onsenId, int radius, boolean full, String category, int page, int size) {
        Place onsen = findOnsenOrThrow(onsenId);
        validateNearbyRequest(radius, category, page, size);
        List<NearbyPlaceResponse.Content> content = findExternalNearby(onsen, radius, category);
        if (content.isEmpty()) content = findLocalNearby(onsen, radius, category);
        if (!full) {
            content = content.stream().limit(6).toList();
        } else {
            int from = Math.min(page * size, content.size());
            content = content.subList(from, Math.min(from + size, content.size()));
        }
        return new NearbyPlaceResponse(content);
    }

    @Transactional(readOnly = true)
    public NearbyPlaceResponse rerollNearby(Long onsenId, NearbyRerollRequest request) {
        Place onsen = findOnsenOrThrow(onsenId);
        validateNearbyCategory(request.category());
        Set<String> excluded = new HashSet<>(request.excludeIds());
        List<NearbyPlaceResponse.Content> content = findExternalNearby(onsen, 5000, request.category());
        if (content.isEmpty()) content = findLocalNearby(onsen, 5000, request.category());
        content = content.stream()
                .filter(item -> !excluded.contains(item.contentId()) && !excluded.contains(item.placeId()))
                .limit(6)
                .toList();
        return new NearbyPlaceResponse(content);
    }

    private List<NearbyPlaceResponse.Content> findExternalNearby(Place onsen, int radius, String category) {
        if (onsen.getLat() == null || onsen.getLng() == null) return List.of();
        return externalPlaceClient.findNearby(onsen.getLat(), onsen.getLng(), radius, category).stream()
                .filter(item -> item.lat() != null && item.lng() != null)
                .filter(item -> distanceKm(onsen.getLat(), onsen.getLng(), item.lat(), item.lng()) * 1000 > 20)
                .collect(Collectors.collectingAndThen(Collectors.toMap(
                        item -> item.contentId() != null ? "tour:" + item.contentId() : "kakao:" + item.placeId(),
                        item -> item, (first, ignored) -> first), map -> new ArrayList<>(map.values())));
    }

    private List<NearbyPlaceResponse.Content> findLocalNearby(Place onsen, int radius, String category) {
        if (onsen.getLat() == null || onsen.getLng() == null) return List.of();
        double latDelta = radius / 111_000.0;
        double lngDelta = radius / (111_000.0 * Math.max(0.1, Math.cos(Math.toRadians(onsen.getLat()))));
        return placeRepository.findNearbyPlaces(onsen.getLat() - latDelta, onsen.getLat() + latDelta,
                        onsen.getLng() - lngDelta, onsen.getLng() + lngDelta).stream()
                .filter(place -> matchesNearbyCategory(place, category))
                .map(place -> new NearbyPlaceResponse.Content(
                        nearbySource(place), nearbyType(place), nearbyContentId(place), nearbyPlaceId(place), place.getName(),
                        placeImageRepository.findByPlaceIdOrderBySortOrder(place.getId()).stream()
                                .findFirst().map(PlaceImage::getImageUrl).orElse(null),
                        place.getLat(), place.getLng(),
                        (int) Math.round(distanceKm(onsen.getLat(), onsen.getLng(), place.getLat(), place.getLng()) * 1000),
                        null, place.getPhone(), place.getHomepageUrl(), null))
                .filter(item -> item.image() != null)
                .toList();
    }

    private boolean matchesNearbyCategory(Place place, String category) {
        return "all".equals(category)
                || ("food".equals(category) && place.getPlaceType() == PlaceType.RESTAURANT)
                || ("cafe".equals(category) && place.getPlaceType() == PlaceType.CAFE)
                || ("tour".equals(category) && place.getPlaceType() == PlaceType.ATTRACTION);
    }

    private String nearbyType(Place place) {
        return switch (place.getPlaceType()) {
            case RESTAURANT -> "맛집";
            case CAFE -> "카페";
            default -> "관광지";
        };
    }

    private String nearbySource(Place place) {
        return "TOUR_API".equals(place.getSource()) ? "TOUR" : "KAKAO";
    }

    private String nearbyContentId(Place place) {
        return "TOUR_API".equals(place.getSource()) ? place.getExternalId() : null;
    }

    private String nearbyPlaceId(Place place) {
        return "TOUR_API".equals(place.getSource()) ? null : place.getExternalId();
    }

    private double distanceKm(double lat1, double lng1, double lat2, double lng2) {
        double dLat = Math.toRadians(lat2 - lat1);
        double dLng = Math.toRadians(lng2 - lng1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLng / 2) * Math.sin(dLng / 2);
        return 6371 * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    }

    private void validateNearbyRequest(int radius, String category, int page, int size) {
        if (radius <= 0 || radius > 20_000 || page < 0 || size < 1 || size > 100) {
            throw new BusinessException(ErrorCode.INVALID_NEARBY_REQUEST);
        }
        validateNearbyCategory(category);
    }

    private void validateNearbyCategory(String category) {
        if (!Set.of("all", "tour", "food", "cafe").contains(category)) {
            throw new BusinessException(ErrorCode.INVALID_NEARBY_REQUEST);
        }
    }

    private Place findOnsenOrThrow(Long onsenId) {
        Place place = placeRepository.findById(onsenId)
                .orElseThrow(() -> new BusinessException(ErrorCode.ONSEN_NOT_FOUND));
        if (place.getPlaceType() != PlaceType.ONSEN) {
            throw new BusinessException(ErrorCode.ONSEN_NOT_FOUND);
        }
        return place;
    }

    private void validateBbox(double swLat, double swLng, double neLat, double neLng) {
        if (!Double.isFinite(swLat) || !Double.isFinite(swLng)
                || !Double.isFinite(neLat) || !Double.isFinite(neLng)
                || swLat >= neLat || swLng >= neLng) {
            throw new BusinessException(ErrorCode.INVALID_BBOX);
        }
        if (swLat < KOREA_MIN_LAT || neLat > KOREA_MAX_LAT || swLng < KOREA_MIN_LNG || neLng > KOREA_MAX_LNG) {
            throw new BusinessException(ErrorCode.INVALID_BBOX);
        }
        if (neLat - swLat > MAX_BBOX_LAT_SPAN || neLng - swLng > MAX_BBOX_LNG_SPAN) {
            throw new BusinessException(ErrorCode.BBOX_TOO_LARGE);
        }
    }

    private MapOnsensResponse.Marker toMarker(Place p, String thumbnail, boolean isFavorite) {
        AccessLevel accessLevel = p.getAccessLevel();
        return new MapOnsensResponse.Marker(
                p.getId(),
                p.getName(),
                p.getLat(),
                p.getLng(),
                p.isRegisteredOnsen(),
                p.isRegisteredOnsen() ? "REGISTERED" : "LISTED",
                p.getWaterTemp() != null ? p.getWaterTemp().doubleValue() : null,
                p.getWaterType(),
                p.getHasOutdoor(),
                p.getFacilityType(),
                p.getPriceMin(),
                accessLevel != null ? accessLevel.name() : null,
                accessLevel != null ? accessLevel.getLabel() : null,
                isFavorite,
                thumbnail
        );
    }

    private OnsenDetailResponse.ReviewSummary reviewSummary(Long placeId) {
        List<ReviewAggregate> summaries = reviewAggregateRepository.findByPlaceIds(List.of(placeId));
        if (summaries.isEmpty()) return new OnsenDetailResponse.ReviewSummary(0, null);
        ReviewAggregate summary = summaries.get(0);
        return new OnsenDetailResponse.ReviewSummary(summary.getReviewCount(), summary.getRating());
    }
}
