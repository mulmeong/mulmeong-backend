package com.mulmeong.domain.region.service;

import com.mulmeong.domain.region.dto.response.GrapeMapResponse;
import com.mulmeong.domain.region.entity.RegionStat;
import com.mulmeong.domain.region.entity.Sido;
import com.mulmeong.domain.region.repository.RegionStatRepository;
import com.mulmeong.domain.review.service.MyReviewService;
import com.mulmeong.global.exception.BusinessException;
import com.mulmeong.global.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// 702(포도알 지도), 708 공개 프로필의 지역 요약, 701/708의 grapeRegionCount.
@Service
@RequiredArgsConstructor
public class RegionStatService {

    private final RegionStatRepository regionStatRepository;
    private final MyReviewService myReviewService;
    private final SigunguRegionService sigunguRegionService;

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

    /**
     * 708 공개 프로필용. 방문한 시·도만, onsenIds 없이 별도 요약으로 내려준다.
     */
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
        Map<String, RegionStat> statsBySigunguCode = rows.stream()
                .collect(java.util.stream.Collectors.toMap(RegionStat::getSigunguCode, stat -> stat));
        List<SigunguRegionService.SigunguRegion> sigungus = parentRegionCode != null
                ? sigunguRegionService.findBySidoCode(parentRegionCode)
                : sigunguRegionService.findAll();

        int max = rows.stream().mapToInt(RegionStat::getVisitCount).max().orElse(0);
        List<GrapeMapResponse.RegionItem> regions = new ArrayList<>();
        long visited = 0;
        for (SigunguRegionService.SigunguRegion sigungu : sigungus) {
            RegionStat stat = statsBySigunguCode.get(sigungu.code());
            int count = stat == null ? 0 : stat.getVisitCount();
            if (count > 0) visited++;
            double density = max == 0 ? 0.0 : (double) count / max;
            List<Long> onsenIds = count == 0
                    ? List.of()
                    : myReviewService.distinctOnsenIdsByUserAndSigungu(userId, sigungu.code());
            regions.add(new GrapeMapResponse.RegionItem(sigungu.code(), sigungu.name(), count, density,
                    onsenIds));
        }
        return new GrapeMapResponse("SIGUNGU", visited, sigungus.size(), max, regions);
    }

    private Map<String, Integer> sumBySido(Long userId) {
        Map<String, Integer> sums = new HashMap<>();
        for (RegionStat stat : regionStatRepository.findByUserId(userId)) {
            sums.merge(stat.getSidoCode(), stat.getVisitCount(), Integer::sum);
        }
        return sums;
    }

    /**
     * 709 탈퇴.
     */
    @Transactional
    public void deleteAllByUserId(Long userId) {
        regionStatRepository.deleteByUserId(userId);
    }

    @Transactional
    public void incrementVisitCount(Long userId, String sidoCode, String sigunguCode) {
        if (hasRegionCodes(sidoCode, sigunguCode))
            regionStatRepository.incrementVisitCount(userId, sidoCode, sigunguCode);
    }

    @Transactional
    public void decrementVisitCount(Long userId, String sigunguCode) {
        if (sigunguCode != null && !sigunguCode.isBlank())
            regionStatRepository.decrementVisitCount(userId, sigunguCode);
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
