package com.mulmeong.domain.place.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mulmeong.domain.favorite.service.FavoriteService;
import com.mulmeong.domain.place.dto.response.MapOnsensResponse;
import com.mulmeong.domain.place.dto.response.OnsenSearchResponse;
import com.mulmeong.domain.place.entity.AccessLevel;
import com.mulmeong.domain.place.entity.Place;
import com.mulmeong.domain.place.entity.PlaceImage;
import com.mulmeong.domain.place.repository.PlaceImageRepository;
import com.mulmeong.domain.place.repository.PlaceRepository;
import com.mulmeong.domain.place.repository.RegionAggregate;
import com.mulmeong.domain.place.repository.SigunguAggregate;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
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
    private final FavoriteService favoriteService;

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

        Map<Long, String> thumbnails = placeImageRepository
                .findByPlaceIdInAndSortOrder(placeIds, THUMBNAIL_SORT_ORDER).stream()
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
}
