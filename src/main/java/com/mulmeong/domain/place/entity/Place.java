package com.mulmeong.domain.place.entity;

import java.math.BigDecimal;

import com.mulmeong.global.common.BaseTimeEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

/** places 테이블. 지도(301/302)에서 쓰는 컬럼만 매핑 — 카드/상세(201~206) 구현 때 확장한다. */
@Getter
@Entity
@Table(name = "places")
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
public class Place extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "place_type", nullable = false)
    private PlaceType placeType;

    @Column(name = "is_registered_onsen", nullable = false)
    private boolean registeredOnsen;

    @Column(nullable = false)
    private String name;

    private String sido;

    private String sigungu;

    @Column(name = "sido_code")
    private String sidoCode;

    @Column(name = "sigungu_code")
    private String sigunguCode;

    private String address;

    // 스키마상 nullable. 지도 API에서는 좌표가 있는 온천만 조회한다.
    private Double lat;

    private Double lng;

    @Column(name = "water_temp")
    private BigDecimal waterTemp;

    @Column(name = "water_type")
    private String waterType;

    @Column(name = "has_outdoor")
    private Boolean hasOutdoor;

    @Column(name = "facility_type")
    private String facilityType;

    @Column(name = "price_min")
    private Integer priceMin;

    @Enumerated(EnumType.STRING)
    @Column(name = "access_level")
    private AccessLevel accessLevel;
}
