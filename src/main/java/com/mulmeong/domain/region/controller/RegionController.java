package com.mulmeong.domain.region.controller;

import com.mulmeong.domain.region.service.SigunguRegionService;
import com.mulmeong.domain.region.service.SigunguRegionService.SigunguRegion;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

// 프론트 지도 도형에 행정표준코드를 연결할 때 사용하는 시군구 마스터 목록.
@RestController
@RequestMapping("/api/v1/regions")
@RequiredArgsConstructor
public class RegionController {

    private final SigunguRegionService sigunguRegionService;

    @GetMapping("/sigungus")
    public List<SigunguRegion> sigungus(@RequestParam(required = false) String sidoCode) {
        return sidoCode == null
                ? sigunguRegionService.findAll()
                : sigunguRegionService.findBySidoCode(sidoCode);
    }
}
