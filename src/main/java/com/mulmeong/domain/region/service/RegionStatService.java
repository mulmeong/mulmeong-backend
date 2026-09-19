package com.mulmeong.domain.region.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mulmeong.domain.region.dto.response.GrapeMapResponse;
import com.mulmeong.domain.region.entity.RegionStat;
import com.mulmeong.domain.region.entity.Sido;
import com.mulmeong.domain.region.repository.RegionStatRepository;
import com.mulmeong.domain.review.service.MyReviewService;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;

import lombok.RequiredArgsConstructor;

/**
 * 702(포도알 지도), 708 공개 프로필의 지역 요약, 701/708의 grapeRegionCount.
 * 시·도(SIDO) 레벨은 17개 고정 목록으로 0방문 지역까지 채운다. 시군구(SIGUNGU) 레벨은
 * 프론트 GeoJSON과 코드가 맞아야 하는 전국 시군구 마스터가 아직 없어, region_stats에
 * 실제로 있는 행만 내려준다 — 0방문 시군구 채우기는 그 마스터 데이터가 준비되면 추가한다.
 */
@Service
@RequiredArgsConstructor
public class RegionStatService {

    private final RegionStatRepository regionStatRepository;
    private final MyReviewService myReviewService;

    @Transactional(readOnly = true)
    public long grapeRegionCount(Long userId) {
        return regionStatRepository.countVisitedSido(userId);
    }

    @Transactional(readOnly = true)
    public GrapeMapResponse grapeMap(Long userId, String level, String parentRegionCode) {
        return "SIGUNGU".equalsIgnoreCase(level)
                ? sigunguMap(userId, parentRegionCode)
                : sidoMap(userId);
    }

    /** 708 공개 프로필용. 방문한 시·도만, onsenIds 없이 별도 요약으로 내려준다. */
    @Transactional(readOnly = true)
    public List<VisitedRegionSummary> visitedSidoSummaries(Long userId) {
        Map<String, Integer> visitCounts = sumBySido(userId);
        int max = visitCounts.values().stream().mapToInt(Integer::intValue).max().orElse(0);
        List<VisitedRegionSummary> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : visitCounts.entrySet()) {
            if (entry.getValue() <= 0) continue;
            Sido sido = Sido.byCode(entry.getKey()).orElse(null);
            String name = sido != null ? sido.displayName() : entry.getKey();
            double density = max == 0 ? 0.0 : (double) entry.getValue() / max;
            result.add(new VisitedRegionSummary(entry.getKey(), name, entry.getValue(), density));
        }
        return result;
    }

    private GrapeMapResponse sidoMap(Long userId) {
        Map<String, Integer> visitCounts = sumBySido(userId);
        int max = visitCounts.values().stream().mapToInt(Integer::intValue).max().orElse(0);

        List<GrapeMapResponse.RegionItem> regions = new ArrayList<>();
        long visited = 0;
        for (Sido sido : Sido.values()) {
            int count = visitCounts.getOrDefault(sido.code(), 0);
            if (count > 0) visited++;
            double density = max == 0 ? 0.0 : (double) count / max;
            List<Long> onsenIds = count == 0
                    ? List.of()
                    : myReviewService.distinctOnsenIdsByUserAndSido(userId, sido.code());
            regions.add(new GrapeMapResponse.RegionItem(sido.code(), sido.displayName(), count, density, onsenIds));
        }
        return new GrapeMapResponse("SIDO", visited, Sido.values().length, max, regions);
    }

    private GrapeMapResponse sigunguMap(Long userId, String parentRegionCode) {
        if (parentRegionCode != null && Sido.byCode(parentRegionCode).isEmpty()) {
            throw new BusinessException(ErrorCode.INVALID_REGION_CODE);
        }

        List<RegionStat> rows = parentRegionCode != null
                ? regionStatRepository.findByUserIdAndSidoCode(userId, parentRegionCode)
                : regionStatRepository.findByUserId(userId);

        int max = rows.stream().mapToInt(RegionStat::getVisitCount).max().orElse(0);
        List<GrapeMapResponse.RegionItem> regions = new ArrayList<>();
        long visited = 0;
        for (RegionStat row : rows) {
            int count = row.getVisitCount();
            if (count > 0) visited++;
            double density = max == 0 ? 0.0 : (double) count / max;
            List<Long> onsenIds = count == 0
                    ? List.of()
                    : myReviewService.distinctOnsenIdsByUserAndSigungu(userId, row.getSigunguCode());
            regions.add(new GrapeMapResponse.RegionItem(row.getSigunguCode(), row.getSigunguCode(), count, density,
                    onsenIds));
        }
        return new GrapeMapResponse("SIGUNGU", visited, regions.size(), max, regions);
    }

    private Map<String, Integer> sumBySido(Long userId) {
        Map<String, Integer> sums = new HashMap<>();
        for (RegionStat stat : regionStatRepository.findByUserId(userId)) {
            sums.merge(stat.getSidoCode(), stat.getVisitCount(), Integer::sum);
        }
        return sums;
    }

    /** 709 탈퇴. */
    @Transactional
    public void deleteAllByUserId(Long userId) {
        regionStatRepository.deleteByUserId(userId);
    }

    @Transactional
    public void incrementVisitCount(Long userId, String sidoCode, String sigunguCode) {
        if (hasRegionCodes(sidoCode, sigunguCode)) regionStatRepository.incrementVisitCount(userId, sidoCode, sigunguCode);
    }

    @Transactional
    public void decrementVisitCount(Long userId, String sigunguCode) {
        if (sigunguCode != null && !sigunguCode.isBlank()) regionStatRepository.decrementVisitCount(userId, sigunguCode);
    }

    @Transactional(readOnly = true)
    public int visitCount(Long userId, String sigunguCode) {
        if (sigunguCode == null || sigunguCode.isBlank()) return 0;
        return regionStatRepository.findByUserIdAndSigunguCode(userId, sigunguCode)
                .map(RegionStat::getVisitCount).orElse(0);
    }

    private boolean hasRegionCodes(String sidoCode, String sigunguCode) {
        return sidoCode != null && !sidoCode.isBlank() && sigunguCode != null && !sigunguCode.isBlank();
    }

    public record VisitedRegionSummary(String regionCode, String name, int visitCount, double density) {
    }
}
