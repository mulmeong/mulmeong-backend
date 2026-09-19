package com.mulmeong.domain.dart.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mulmeong.domain.dart.dto.DartRequest;
import com.mulmeong.domain.dart.dto.DartResponse;
import com.mulmeong.domain.dart.dto.OriginResponse;
import com.mulmeong.domain.dart.dto.DartSharedResponse;
import com.mulmeong.domain.dart.entity.DartCandidate;
import com.mulmeong.domain.dart.repository.DartCandidateRepository;
import com.mulmeong.domain.place.entity.AccessLevel;
import com.mulmeong.domain.place.service.PlaceService;
import com.mulmeong.domain.user.service.UserService;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import com.mulmeong.global.util.RandomTokenGenerator;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;
import java.time.OffsetDateTime;

@Service
@RequiredArgsConstructor
public class DartService {
    private static final int[] LIMIT_STEPS = {90, 120, 180, 240};
    private static final String SHARE_BASE = "https://mulmeong.app/dart/";
    private static final int SHARE_TOKEN_LENGTH = 8;
    private static final int SHARE_EXPIRY_DAYS = 30;
    private static final String ANONYMOUS_THROWER = "익명의 물멍러";
    @Value("${app.dart.road-factor:1.3}")
    private double roadFactor;
    @Value("${app.dart.car-kmh:70}")
    private double carKmh;
    @Value("${app.dart.transit-kmh:60}")
    private double transitKmh;
    @Value("${app.dart.transit-transfer-min:25}")
    private int transitTransferMin;
    @Value("${app.dart.min-pool:8}")
    private int minPool;
    @Value("${app.dart.weight-village:6}")
    private double villageWeight;
    @Value("${app.dart.weight-walkable:3}")
    private double walkableWeight;
    @Value("${app.dart.weight-lodging:2}")
    private double lodgingWeight;
    @Value("${app.dart.recent-penalty-divisor:4}")
    private double recentPenaltyDivisor;

    private final DartCandidateRepository candidateRepository;
    private final JdbcTemplate jdbcTemplate;
    private final ObjectMapper objectMapper;
    private final UserService userService;
    private final PlaceService placeService;

    @Transactional
    public DartResponse throwDart(DartRequest request, Long userId, boolean reroll) {
        validateOrigin(request.origin());
        validateMinutes(request.maxMinutes());
        List<DartCandidate> active = candidateRepository.findByActiveTrue();
        Set<Long> excluded = Set.copyOf(request.excludeIds());
        List<DartCandidate> pool = new ArrayList<>(active);
        pool.removeIf(c -> excluded.contains(c.getId()));
        pool.removeIf(c -> request.transport() == DartRequest.Transport.TRANSIT
                && "CAR_REQUIRED".equals(c.getAccessLevel()));

        int usedLimit = request.maxMinutes() == null ? Integer.MAX_VALUE : request.maxMinutes();
        int initialCount = request.maxMinutes() == null
                ? pool.size() : within(pool, request, request.maxMinutes()).size();
        int relaxSteps = 0;
        if (request.maxMinutes() != null) {
            int index = indexOfLimit(request.maxMinutes());
            while (true) {
                int limit = index < LIMIT_STEPS.length ? LIMIT_STEPS[index] : Integer.MAX_VALUE;
                List<DartCandidate> filtered = within(pool, request, limit);
                if (filtered.size() >= minPool || index >= LIMIT_STEPS.length) {
                    pool = filtered;
                    usedLimit = limit;
                    break;
                }
                index++;
                relaxSteps++;
            }
        } else {
            pool = within(pool, request, Integer.MAX_VALUE);
        }
        // Excluding every candidate must not produce an empty result screen.
        if (pool.isEmpty()) {
            pool = active.stream()
                    .filter(c -> request.transport() != DartRequest.Transport.TRANSIT
                            || !"CAR_REQUIRED".equals(c.getAccessLevel()))
                    .toList();
            usedLimit = Integer.MAX_VALUE;
            relaxSteps++;
        }
        if (pool.isEmpty()) throw new BusinessException(ErrorCode.DART_CANDIDATE_UNAVAILABLE);

        List<Long> recent = userId == null ? List.of() : recentCandidates(userId);
        DartCandidate result = weightedPick(pool, request, recent);
        int minutes = estimateMinutes(request.origin(), result, request.transport());
        Integer relaxedFrom = relaxSteps == 0 ? null : request.maxMinutes();
        String relaxMessage = relaxSteps == 0 ? null
                : relaxMessage(request.maxMinutes(), initialCount, usedLimit);
        // 공유 링크에 PK를 노출하지 않으려고 dartId 자체를 base62 토큰으로 내려준다 (401·403).
        String dartId = saveLog(request, result, pool.size(), relaxSteps > 0, reroll, userId,
                relaxSteps == 0 ? null : request.maxMinutes());
        return new DartResponse(dartId, SHARE_BASE + dartId, pool.size(), relaxSteps > 0, relaxedFrom, relaxMessage,
                toResult(request, result, minutes));
    }

    /**
     * 709 탈퇴: 다트 기록은 남기되 회원 연결만 끊는다.
     */
    @Transactional
    public void anonymizeUserId(Long userId) {
        jdbcTemplate.update("UPDATE dart_logs SET user_id = NULL WHERE user_id = ?", userId);
    }

    public List<OriginResponse> origins() {
        return List.of(new OriginResponse("서울역", 37.5563, 126.9723), new OriginResponse("수원역", 37.2659, 127.0001),
                new OriginResponse("대전역", 36.3323, 127.4345), new OriginResponse("대구역", 35.8760, 128.5960),
                new OriginResponse("부산역", 35.1151, 129.0414), new OriginResponse("광주송정역", 35.1370, 126.7910));
    }

    @Transactional(readOnly = true)
    public DartSharedResponse shared(String shareToken, Long viewerId) {
        DartSharedRow row = jdbcTemplate.query("""
                        SELECT d.user_id, d.conditions::text AS conditions, d.is_relaxed, d.throw_count, d.created_at,
                               d.start_location, d.start_lat, d.start_lng,
                               c.name, c.sido, c.lat, c.lng, c.place_id, c.access_level, c.transit_minutes
                        FROM dart_logs d
                        JOIN dart_candidates c ON c.id = d.candidate_id
                        WHERE d.share_token = ?
                        """, rs -> rs.next() ? new DartSharedRow(rs.getObject("user_id", Long.class),
                rs.getString("conditions"), rs.getBoolean("is_relaxed"), rs.getInt("throw_count"),
                rs.getObject("created_at", OffsetDateTime.class), rs.getString("start_location"),
                rs.getDouble("start_lat"), rs.getDouble("start_lng"),
                rs.getString("name"), rs.getString("sido"), rs.getDouble("lat"), rs.getDouble("lng"),
                rs.getObject("place_id", Long.class), rs.getString("access_level"),
                rs.getObject("transit_minutes", Integer.class)) : null, shareToken);
        if (row == null) {
            throw new BusinessException(ErrorCode.DART_NOT_FOUND);
        }
        OffsetDateTime expiresAt = row.createdAt().plusDays(SHARE_EXPIRY_DAYS);
        if (expiresAt.isBefore(OffsetDateTime.now())) {
            throw new BusinessException(ErrorCode.DART_EXPIRED);
        }

        DartRequest request = readConditions(row.conditions());
        DartSharedResponse.Conditions conditions = new DartSharedResponse.Conditions(row.originLabel(),
                request.transport(), request.maxMinutes(), request.stayType());
        int minutes = estimateMinutes(row.startLat(), row.startLng(), row.lat(), row.lng(),
                row.transitMinutes(), row.accessLevel(), request.transport());
        DartSharedResponse.Result result = new DartSharedResponse.Result(row.placeId(), row.name(), row.sido(),
                row.lat(), row.lng(), placeService.thumbnailOf(row.placeId()), minutes);
        String thrownBy = userService.nicknameOf(row.userId()).orElse(ANONYMOUS_THROWER);
        boolean isMine = row.userId() != null && row.userId().equals(viewerId);
        return new DartSharedResponse(shareToken, conditions, result, row.relaxed(), row.throwCount(),
                thrownBy, isMine, row.createdAt(), expiresAt);
    }

    private DartRequest readConditions(String conditions) {
        try {
            return objectMapper.readValue(conditions, DartRequest.class);
        } catch (Exception e) {
            // 저장된 조건이 깨진 것은 서버 데이터 문제다 — 404로 숨기지 않는다.
            throw new IllegalStateException("다트 조건 역직렬화에 실패했습니다", e);
        }
    }

    private List<DartCandidate> within(List<DartCandidate> candidates, DartRequest r, int limit) {
        return candidates.stream().filter(c -> estimateMinutes(r.origin(), c, r.transport()) <= limit).toList();
    }

    private DartCandidate weightedPick(List<DartCandidate> pool, DartRequest r, List<Long> recent) {
        double total = pool.stream().mapToDouble(c -> weight(c, r, recent)).sum();
        double random = ThreadLocalRandom.current().nextDouble(total);
        for (DartCandidate candidate : pool) {
            random -= weight(candidate, r, recent);
            if (random <= 0) return candidate;
        }
        return pool.get(pool.size() - 1);
    }

    private double weight(DartCandidate c, DartRequest r, List<Long> recent) {
        double weight = 1;
        if ("VILLAGE".equals(c.getGrade())) weight += villageWeight;
        if (r.transport() == DartRequest.Transport.TRANSIT) {
            if ("WALKABLE".equals(c.getAccessLevel())) weight += walkableWeight;
            if ("CAR_RECOMMENDED".equals(c.getAccessLevel())) weight += 1;
        }
        if (r.stayType() == DartRequest.StayType.OVERNIGHT && Boolean.TRUE.equals(c.getHasLodging()))
            weight += lodgingWeight;
        if (recent.contains(c.getId())) weight /= recentPenaltyDivisor;
        return weight;
    }

    private int estimateMinutes(DartRequest.Origin origin, DartCandidate c, DartRequest.Transport transport) {
        return estimateMinutes(origin.lat(), origin.lng(), c.getLat(), c.getLng(),
                c.getTransitMinutes(), c.getAccessLevel(), transport);
    }

    private int estimateMinutes(double originLat, double originLng, double destLat, double destLng,
                                Integer transitMinutes, String accessLevel, DartRequest.Transport transport) {
        double roadKm = haversine(originLat, originLng, destLat, destLng) * roadFactor;
        if (transport == DartRequest.Transport.CAR) {
            return (int) (roadKm / carKmh * 60) + 10;
        }
        int access = transitMinutes != null ? transitMinutes : switch (accessLevel) {
            case "WALKABLE" -> 20;
            case "CAR_RECOMMENDED" -> 45;
            default -> 75;
        };
        return (int) (roadKm / transitKmh * 60) + transitTransferMin + access;
    }

    private DartResponse.Result toResult(DartRequest r, DartCandidate c, int minutes) {
        AccessLevel access = AccessLevel.valueOf(c.getAccessLevel());
        return new DartResponse.Result(c.getId(), c.getPlace() == null ? null : c.getPlace().getId(), c.getName(),
                c.getGrade(), c.getSido(), c.getSigungu(), c.getLat(), c.getLng(),
                Math.round(haversine(r.origin().lat(), r.origin().lng(), c.getLat(), c.getLng()) * 10) / 10.0,
                minutes, c.getAccessLevel(), access.getLabel(), c.getStationName(), c.getStationToPlace(), c.getHasLodging());
    }

    private String saveLog(DartRequest request, DartCandidate result, int count, boolean relaxed, boolean reroll,
                           Long userId, Integer relaxedFrom) {
        final String conditions;
        try {
            conditions = objectMapper.writeValueAsString(request);
        } catch (Exception e) {
            throw new IllegalStateException("다트 조건 직렬화에 실패했습니다", e);
        }
        String shareToken;
        do {
            shareToken = RandomTokenGenerator.generate(SHARE_TOKEN_LENGTH);
        } while (shareTokenExists(shareToken));
        return jdbcTemplate.queryForObject("""
                        INSERT INTO dart_logs (user_id, conditions, candidate_id, candidate_count, is_relaxed, relaxed_from, is_reroll,
                            result_place_id, throw_count, start_location, start_lat, start_lng, share_token)
                        VALUES (?, CAST(? AS jsonb), ?, ?, ?, ?, ?, ?, 1, ?, ?, ?, ?) RETURNING share_token
                        """, String.class, userId, conditions, result.getId(), count, relaxed, relaxedFrom, reroll,
                result.getPlace() == null ? null : result.getPlace().getId(), request.origin().label(),
                request.origin().lat(), request.origin().lng(), shareToken);
    }

    private boolean shareTokenExists(String shareToken) {
        return Boolean.TRUE.equals(jdbcTemplate.queryForObject(
                "SELECT EXISTS (SELECT 1 FROM dart_logs WHERE share_token = ?)", Boolean.class, shareToken));
    }

    private record DartSharedRow(Long userId, String conditions, boolean relaxed, int throwCount,
                                 OffsetDateTime createdAt, String originLabel, double startLat, double startLng,
                                 String name, String sido, double lat, double lng, Long placeId,
                                 String accessLevel, Integer transitMinutes) {
    }

    private List<Long> recentCandidates(Long userId) {
        return jdbcTemplate.query("SELECT candidate_id FROM dart_logs WHERE user_id = ? AND candidate_id IS NOT NULL ORDER BY created_at DESC LIMIT 3",
                (rs, row) -> rs.getLong(1), userId);
    }

    private void validateOrigin(DartRequest.Origin o) {
        if (!Double.isFinite(o.lat()) || !Double.isFinite(o.lng()) || o.lat() < 33 || o.lat() > 39 || o.lng() < 124 || o.lng() > 132)
            throw new BusinessException(ErrorCode.INVALID_ORIGIN);
    }

    private void validateMinutes(Integer minutes) {
        if (minutes != null && indexOfLimit(minutes) < 0) throw new BusinessException(ErrorCode.VALIDATION_FAILED);
    }

    private int indexOfLimit(int value) {
        for (int i = 0; i < LIMIT_STEPS.length; i++) if (LIMIT_STEPS[i] == value) return i;
        return -1;
    }

    private String relaxMessage(Integer requested, int initialCount, int used) {
        if (used == Integer.MAX_VALUE) return "조건에 맞는 곳이 적어서 전국에서 골랐어요";
        if (requested != null && used == 120) return "90분 안에는 후보가 적어서 2시간까지 넓혔어요";
        return requested + "분 안에는 " + initialCount + "곳뿐이라 " + (used / 60) + "시간까지 넓혔어요";
    }

    private static double haversine(double lat1, double lng1, double lat2, double lng2) {
        double dLat = Math.toRadians(lat2 - lat1), dLng = Math.toRadians(lng2 - lng1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) * Math.sin(dLng / 2) * Math.sin(dLng / 2);
        return 6371 * 2 * Math.asin(Math.sqrt(a));
    }
}
