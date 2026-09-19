package com.mulmeong.domain.region.service;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.util.Comparator;
import java.util.List;

// 행정표준 시군구 코드 마스터. 포도알 지도와 places.sigungu_code가 동일한 코드를 사용한다.
@Service
public class SigunguRegionService {

    private final List<SigunguRegion> regions;

    public SigunguRegionService(ObjectMapper objectMapper) {
        this.regions = loadRegions(objectMapper);
    }

    public List<SigunguRegion> findAll() {
        return regions;
    }

    public List<SigunguRegion> findBySidoCode(String sidoCode) {
        return regions.stream()
                .filter(region -> region.sidoCode().equals(sidoCode))
                .toList();
    }

    private List<SigunguRegion> loadRegions(ObjectMapper objectMapper) {
        ClassPathResource resource = new ClassPathResource("regions/sigungu-regions.json");

        try (InputStream inputStream = resource.getInputStream()) {
            return objectMapper.readValue(inputStream, new TypeReference<List<SigunguRegion>>() {
            }).stream()
                    .sorted(Comparator.comparing(SigunguRegion::code))
                    .toList();
        } catch (IOException exception) {
            throw new IllegalStateException("시군구 코드 마스터를 읽을 수 없습니다.", exception);
        }
    }

    public record SigunguRegion(String code, @JsonProperty("sido") String sidoCode, String name) {
    }
}
