package com.mulmeong.domain.place.entity;

import com.mulmeong.global.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * places 테이블. 카드/상세(201~206)용 컬럼까지 매핑 완료.
 */
@Getter
@Entity
@Table(name = "places")
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
public class Place extends BaseTimeEntity {

    public static Place createExternal(String source, String externalId, String name,
                                       Double lat, Double lng, PlaceType placeType, String address, String phone) {
        Place place = new Place();
        place.source = source;
        place.externalId = externalId;
        place.name = name;
        place.lat = lat;
        place.lng = lng;
        place.placeType = placeType;
        place.address = address;
        place.phone = phone;
        place.registeredOnsen = false;
        return place;
    }

    public void updateExternal(String name, Double lat, Double lng, PlaceType placeType,
                               String address, String phone) {
        this.name = name;
        this.lat = lat;
        this.lng = lng;
        this.placeType = placeType;
        this.address = address;
        this.phone = phone;
    }

    public static Place createTourOnsen(String externalId, String name, String address,
                                        Double lat, Double lng, String phone, String homepageUrl) {
        Place place = new Place();
        place.placeType = PlaceType.ONSEN;
        place.registeredOnsen = false;
        place.source = "TOUR_API";
        place.externalId = externalId;
        place.name = name;
        place.address = address;
        place.lat = lat;
        place.lng = lng;
        place.phone = phone;
        place.homepageUrl = homepageUrl;
        return place;
    }

    public void updateTourData(String name, String address, Double lat, Double lng,
                               String phone, String homepageUrl) {
        this.name = name;
        this.address = address;
        this.lat = lat;
        this.lng = lng;
        this.phone = phone;
        this.homepageUrl = homepageUrl;
    }

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
