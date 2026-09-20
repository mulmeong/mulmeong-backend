package com.mulmeong.domain.place.service;

import com.mulmeong.domain.place.entity.Place;
import com.mulmeong.domain.place.entity.PlaceType;
import com.mulmeong.domain.place.repository.PlaceRepository;
import com.mulmeong.global.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 지도 요청과 분리해 TourAPI 온천 후보를 주기적으로 DB에 반영한다.
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class TourApiSyncService {
    private final ExternalPlaceClient externalPlaceClient;
    private final PlaceRepository placeRepository;

    @Value("${external.tour-api.sync-enabled:false}")
    private boolean syncEnabled;

    @Scheduled(cron = "${external.tour-api.sync-cron:0 30 3 * * *}")
    @Transactional
    public void syncOnsens() {
        if (!syncEnabled) return;
        List<ExternalPlaceClient.TourOnsenData> data = externalPlaceClient.findOnsensForSync(10, 100);
        int updated = 0;
        for (ExternalPlaceClient.TourOnsenData item : data) {
            Place place = placeRepository.findBySourceAndExternalId("TOUR_API", item.externalId())
                    .or(() -> placeRepository.findFirstByPlaceTypeAndNameAndAddress(
                            PlaceType.ONSEN, item.name(), item.address()))
                    .orElseGet(() -> Place.createTourOnsen(item.externalId(), item.name(), item.address(),
                            item.lat(), item.lng(), item.phone(), item.homepageUrl()));
            place.updateTourData(item.name(), item.address(), item.lat(), item.lng(), item.phone(), item.homepageUrl());
            placeRepository.save(place);
            updated++;
        }
        log.info("TourAPI onsen sync completed: {} records", updated);
    }
}
