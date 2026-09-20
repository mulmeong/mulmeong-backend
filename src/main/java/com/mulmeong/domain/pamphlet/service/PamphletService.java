package com.mulmeong.domain.pamphlet.service;

import com.mulmeong.domain.dart.repository.DartCandidateRepository;
import com.mulmeong.domain.pamphlet.dto.request.PamphletCreateRequest;
import com.mulmeong.domain.pamphlet.dto.response.*;
import com.mulmeong.domain.pamphlet.entity.Pamphlet;
import com.mulmeong.domain.pamphlet.entity.PamphletPlace;
import com.mulmeong.domain.pamphlet.repository.PamphletPlaceRepository;
import com.mulmeong.domain.pamphlet.repository.PamphletRepository;
import com.mulmeong.domain.place.entity.Place;
import com.mulmeong.domain.place.entity.PlaceType;
import com.mulmeong.domain.place.repository.PlaceImageRepository;
import com.mulmeong.domain.place.repository.PlaceRepository;
import com.mulmeong.domain.place.repository.ReviewAggregate;
import com.mulmeong.domain.place.repository.ReviewAggregateRepository;
import com.mulmeong.domain.user.entity.User;
import com.mulmeong.domain.user.service.UserService;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import com.mulmeong.global.util.RandomTokenGenerator;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PamphletService {
    private static final String SHARE_BASE = "https://mulmeong.space/pamphlet/";
    private final PamphletRepository pamphlets;
    private final PamphletPlaceRepository pamphletPlaces;
    private final PlaceRepository places;
    private final PlaceImageRepository images;
    private final DartCandidateRepository dartCandidates;
    private final ReviewAggregateRepository reviewAggregates;
    private final UserService users;

    @Transactional
    public PamphletCreateResponse create(Long userId, PamphletCreateRequest request) {
        if (request == null || request.title() == null || request.title().isBlank() || request.title().length() > 50
                || request.placeIds() == null || request.placeIds().isEmpty() || request.placeIds().size() > 20
                || new HashSet<>(request.placeIds()).size() != request.placeIds().size()
                || (request.partySize() != null && (request.partySize() < 1 || request.partySize() > 20)))
            throw new BusinessException(ErrorCode.VALIDATION_FAILED);
        List<Place> selected = request.placeIds().stream().map(id -> places.findById(id).orElseThrow(() -> new BusinessException(ErrorCode.PLACE_NOT_FOUND))).toList();
        String cover = request.coverImageUrl();
        if (cover == null || cover.isBlank()) {
            Place coverPlace = selected.stream().filter(p -> p.getPlaceType() == PlaceType.ONSEN).findFirst().orElse(selected.get(0));
            cover = image(coverPlace.getId());
        }
        String token;
        do {
            token = RandomTokenGenerator.generate(8);
        } while (pamphlets.existsByShareToken(token));
        Short partySize = request.partySize() == null ? null : request.partySize().shortValue();
        Pamphlet pamphlet = pamphlets.save(new Pamphlet(userId, request.title().trim(), partySize, request.travelDate(), cover, token));
        for (int i = 0; i < selected.size(); i++)
            pamphletPlaces.save(new PamphletPlace(pamphlet.getId(), selected.get(i).getId(), (short) i));
        return new PamphletCreateResponse(pamphlet.getId(), token, SHARE_BASE + token, pamphlet.getTitle(), toInteger(pamphlet.getPartySize()), pamphlet.getTravelDate(), selected.size(), cover, pamphlet.getCreatedAt());
    }

    @Transactional(readOnly = true)
    public PamphletListResponse list(Long userId, int page, int size) {
        int safePage = Math.max(page, 0), actualSize = Math.min(Math.max(size, 1), 50);
        List<Pamphlet> all = pamphlets.findByUserIdOrderByCreatedAtDesc(userId);
        int from = Math.min(safePage * actualSize, all.size()), to = Math.min(from + actualSize, all.size());
        List<PamphletListItem> content = all.subList(from, to).stream().map(this::listItem).toList();
        return new PamphletListResponse(content, safePage, actualSize, all.size(), (all.size() + actualSize - 1) / actualSize, to == all.size());
    }

    @Transactional(readOnly = true)
    public PamphletDetail detail(Long userId, Long pamphletId) {
        Pamphlet pamphlet = pamphlets.findById(pamphletId)
                .orElseThrow(() -> new BusinessException(ErrorCode.PAMPHLET_NOT_FOUND));
        if (!pamphlet.getUserId().equals(userId)) {
            throw new BusinessException(ErrorCode.FORBIDDEN);
        }

        List<Place> selected = orderedPlaces(pamphlet.getId());
        User author = users.getById(userId)
                .orElseThrow(() -> new BusinessException(ErrorCode.PAMPHLET_NOT_FOUND));
        return detail(pamphlet, selected, author, true);
    }

    @Transactional(readOnly = true)
    public PamphletDetail shared(String token, Long viewerId) {
        Pamphlet p = pamphlets.findByShareToken(token).orElseThrow(() -> new BusinessException(ErrorCode.PAMPHLET_NOT_FOUND));
        List<Place> selected = orderedPlaces(p.getId());
        User author = users.getById(p.getUserId()).orElseThrow(() -> new BusinessException(ErrorCode.PAMPHLET_NOT_FOUND));
        boolean mine = viewerId != null && viewerId.equals(p.getUserId());
        return detail(p, selected, author, mine);
    }

    @Transactional
    public void delete(Long userId, Long id) {
        Pamphlet p = pamphlets.findById(id).orElseThrow(() -> new BusinessException(ErrorCode.PAMPHLET_NOT_FOUND));
        if (!p.getUserId().equals(userId)) throw new BusinessException(ErrorCode.FORBIDDEN);
        pamphlets.delete(p);
    }

    @Transactional(readOnly = true)
    public long countByUserId(Long userId) {
        return pamphlets.findByUserIdOrderByCreatedAtDesc(userId).size();
    }

    /**
     * 709 탈퇴. pamphlet_places는 DB의 ON DELETE CASCADE로 함께 삭제된다.
     */
    @Transactional
    public void deleteAllByUserId(Long userId) {
        pamphlets.deleteByUserId(userId);
    }

    private PamphletListItem listItem(Pamphlet p) {
        List<Place> selected = orderedPlaces(p.getId());
        String region = regionName(selected);
        return new PamphletListItem(p.getId(), p.getShareToken(), p.getTitle(), toInteger(p.getPartySize()), p.getTravelDate(), p.getCoverImageUrl(), selected.size(), region, SHARE_BASE + p.getShareToken(), p.getCreatedAt());
    }

    private PamphletDetail detail(Pamphlet p, List<Place> selected, User author, boolean mine) {
        int onsens = (int) selected.stream().filter(x -> x.getPlaceType() == PlaceType.ONSEN).count();
        Map<Long, ReviewAggregate> reviewsByPlaceId = selected.isEmpty()
                ? Map.of()
                : reviewAggregates.findByPlaceIds(selected.stream().map(Place::getId).toList())
                        .stream()
                        .collect(Collectors.toMap(ReviewAggregate::getPlaceId, review -> review));
        return new PamphletDetail(mine ? p.getId() : null, p.getShareToken(), p.getTitle(), toInteger(p.getPartySize()), p.getTravelDate(),
                new PamphletAuthor(author.getNickname(), author.level().number(), author.level().title()), mine, p.getCoverImageUrl(),
                java.util.stream.IntStream.range(0, selected.size())
                        .mapToObj(i -> placeItem(selected.get(i), i + 1, reviewsByPlaceId.get(selected.get(i).getId())))
                        .toList(),
                new PamphletSummary(onsens, selected.size(), regionName(selected)), p.getCreatedAt());
    }

    private static Integer toInteger(Short value) {
        return value == null ? null : value.intValue();
    }

    private List<Place> orderedPlaces(Long id) {
        return pamphletPlaces.findByPamphletIdOrderBySortOrder(id).stream().map(x -> places.findById(x.getPlaceId()).orElse(null)).filter(Objects::nonNull).toList();
    }

    private PamphletPlaceItem placeItem(Place p, int seq, ReviewAggregate review) {
        String type = p.getPlaceType().name();
        String sub = p.getPlaceType() == PlaceType.ONSEN ? (p.getWaterTemp() == null ? "" : p.getWaterTemp() + "℃") + (p.getWaterType() == null ? "" : " · " + p.getWaterType()) + (Boolean.TRUE.equals(p.getHasOutdoor()) ? " · 노천 있음" : "") : typeLabel(p.getPlaceType());
        String kakao = "KAKAO".equals(p.getSource()) && p.getExternalId() != null ? "http://place.map.kakao.com/" + p.getExternalId().replaceFirst("^KAKAO_", "") : null;
        List<String> placeImages = images.findByPlaceIdOrderBySortOrder(p.getId()).stream()
                .map(image -> image.getImageUrl())
                .toList();
        String thumbnail = placeImages.stream().findFirst().orElse(null);
        PamphletPlaceItem.NearestStation nearestStation = dartCandidates.findFirstByPlace_IdOrderById(p.getId())
                .filter(candidate -> candidate.getStationName() != null && !candidate.getStationName().isBlank())
                .map(candidate -> new PamphletPlaceItem.NearestStation(
                        candidate.getStationName(), candidate.getStationToPlace()))
                .orElse(null);
        PamphletPlaceItem.Access access = new PamphletPlaceItem.Access(
                p.getAccessLevel() == null ? null : p.getAccessLevel().name(),
                p.getAccessLevel() == null ? null : p.getAccessLevel().getLabel(), nearestStation);
        PamphletPlaceItem.ReviewSummary reviewSummary = review == null
                ? new PamphletPlaceItem.ReviewSummary(0, null)
                : new PamphletPlaceItem.ReviewSummary(review.getReviewCount(), review.getRating());
        return new PamphletPlaceItem(seq, p.getId(), p.getExternalId(), p.getContentTypeId(), type,
                typeLabel(p.getPlaceType()), p.getName(), sub, p.getAddress(), thumbnail, p.getLat(), p.getLng(), kakao,
                p.getPriceMin(), new PamphletPlaceItem.Water(
                        p.getWaterTemp() == null ? null : p.getWaterTemp().doubleValue(),
                        p.getWaterType(), p.getWaterComponent(),
                        p.getPh() == null ? null : p.getPh().doubleValue(), p.getWaterBenefit()),
                new PamphletPlaceItem.Facilities(p.getHasOutdoor(), p.getHasLodging(), p.getFacilityType()),
                access, placeImages, thumbnail, p.getRegionComment(), p.getNotes(), reviewSummary);
    }

    private String image(Long id) {
        return images.findByPlaceIdOrderBySortOrder(id).stream().findFirst().map(x -> x.getImageUrl()).orElse(null);
    }

    private String typeLabel(PlaceType t) {
        return switch (t) {
            case ONSEN -> "온천";
            case SPA -> "스파";
            case RESTAURANT -> "식당";
            case CAFE -> "카페";
            case ATTRACTION -> "관광지";
            default -> "기타";
        };
    }

    private String regionName(List<Place> ps) {
        return ps.stream().map(Place::getSido).filter(Objects::nonNull).collect(Collectors.groupingBy(x -> x, Collectors.counting())).entrySet().stream().max(Map.Entry.comparingByValue()).map(Map.Entry::getKey).orElse(null);
    }
}
