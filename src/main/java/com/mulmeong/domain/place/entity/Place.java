package com.mulmeong.domain.place.entity;

import java.math.BigDecimal;

import com.mulmeong.global.common.BaseTimeEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

/** places 테이블. 카드/상세(201~206)용 컬럼까지 매핑 완료. */
@Getter
@Entity
@Table(name = "places")
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
public class Place extends BaseTimeEntity {

    public void updateCoordinates(double lat, double lng) {
        this.lat = lat;
        this.lng = lng;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "place_type", nullable = false)
    private PlaceType placeType;

    @Column(name = "is_registered_onsen", nullable = false)
    private boolean registeredOnsen;

    @Column(nullable = false)
    private String source;

    @Column(name = "external_id")
    private String externalId;

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

    @Column(name = "water_component")
    private String waterComponent;

    private BigDecimal ph;

    @Column(name = "water_benefit")
    private String waterBenefit;

    @Column(name = "has_outdoor")
    private Boolean hasOutdoor;

    @Column(name = "has_lodging")
    private Boolean hasLodging;

    @Column(name = "facility_type")
    private String facilityType;

    @Column(name = "price_min")
    private Integer priceMin;

    private String phone;

    @Column(name = "homepage_url")
    private String homepageUrl;

    private String hours;

    private String holiday;

    @Column(name = "parking_info")
    private String parkingInfo;

    @Column(name = "representative_menu")
    private String representativeMenu;

    @Enumerated(EnumType.STRING)
    @Column(name = "access_level")
    private AccessLevel accessLevel;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "station_id")
    private Station station;

    @Column(name = "station_to_place_desc")
    private String stationToPlaceDesc;

    @Column(name = "region_comment")
    private String regionComment;

    private String notes;

    @Column(name = "annual_visitors")
    private Integer annualVisitors;
}
