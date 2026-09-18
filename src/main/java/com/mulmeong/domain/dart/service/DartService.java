package com.mulmeong.domain.dart.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Value;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mulmeong.domain.dart.dto.DartRequest;
import com.mulmeong.domain.dart.dto.DartResponse;
import com.mulmeong.domain.dart.dto.OriginResponse;
import com.mulmeong.domain.dart.entity.DartCandidate;
import com.mulmeong.domain.dart.repository.DartCandidateRepository;
import com.mulmeong.domain.place.entity.AccessLevel;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DartService {
    private static final int[] LIMIT_STEPS = {90, 120, 180, 240};
    @Value("${app.dart.road-factor:1.3}") private double roadFactor;
    @Value("${app.dart.car-kmh:70}") private double carKmh;
    @Value("${app.dart.transit-kmh:60}") private double transitKmh;
    @Value("${app.dart.transit-transfer-min:25}") private int transitTransferMin;
    @Value("${app.dart.min-pool:8}") private int minPool;
    @Value("${app.dart.weight-village:6}") private double villageWeight;
    @Value("${app.dart.weight-walkable:3}") private double walkableWeight;
    @Value("${app.dart.weight-lodging:2}") private double lodgingWeight;
    @Value("${app.dart.recent-penalty-divisor:4}") private double recentPenaltyDivisor;

    private final DartCandidateRepository candidateRepository;
    private final JdbcTemplate jdbcTemplate;
    private final ObjectMapper objectMapper = new ObjectMapper();

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
        Long dartId = saveLog(request, result, pool.size(), relaxSteps > 0, reroll, userId,
                relaxSteps == 0 ? null : request.maxMinutes());
        return new DartResponse(dartId, pool.size(), relaxSteps > 0, relaxedFrom, relaxMessage,
                toResult(request, result, minutes));
    }

    public List<OriginResponse> origins() {
        return List.of(new OriginResponse("서울역", 37.5563, 126.9723), new OriginResponse("수원역", 37.2659, 127.0001),
                new OriginResponse("대전역", 36.3323, 127.4345), new OriginResponse("대구역", 35.8760, 128.5960),
                new OriginResponse("부산역", 35.1151, 129.0414), new OriginResponse("광주송정역", 35.1370, 126.7910));
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
        if (r.stayType() == DartRequest.StayType.OVERNIGHT && Boolean.TRUE.equals(c.getHasLodging())) weight += lodgingWeight;
        if (recent.contains(c.getId())) weight /= recentPenaltyDivisor;
        return weight;
    }

    private int estimateMinutes(DartRequest.Origin origin, DartCandidate c, DartRequest.Transport transport) {
        double roadKm = haversine(origin.lat(), origin.lng(), c.getLat(), c.getLng()) * roadFactor;
        if (transport == DartRequest.Transport.CAR) return (int) (roadKm / carKmh * 60) + 10;
        int access = c.getTransitMinutes() != null ? c.getTransitMinutes() : switch (c.getAccessLevel()) {
            case "WALKABLE" -> 20; case "CAR_RECOMMENDED" -> 45; default -> 75;
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

    private Long saveLog(DartRequest request, DartCandidate result, int count, boolean relaxed, boolean reroll,
            Long userId, Integer relaxedFrom) {
        final String conditions;
        try {
            conditions = objectMapper.writeValueAsString(request);
        } catch (Exception e) {
            throw new IllegalStateException("다트 조건 직렬화에 실패했습니다", e);
        }
        return jdbcTemplate.queryForObject("""
                INSERT INTO dart_logs (user_id, conditions, candidate_id, candidate_count, relaxed, relaxed_from, is_reroll,
                    result_place_id, throw_count, start_location, start_lat, start_lng)
                VALUES (?, CAST(? AS jsonb), ?, ?, ?, ?, ?, ?, 1, ?, ?, ?) RETURNING id
                """, Long.class, userId, conditions, result.getId(), count, relaxed, relaxedFrom, reroll,
                result.getPlace() == null ? null : result.getPlace().getId(), request.origin().label(),
                request.origin().lat(), request.origin().lng());
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
    private int indexOfLimit(int value) { for (int i = 0; i < LIMIT_STEPS.length; i++) if (LIMIT_STEPS[i] == value) return i; return -1; }
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
