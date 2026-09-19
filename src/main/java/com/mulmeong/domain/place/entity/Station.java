package com.mulmeong.domain.place.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * stations 테이블 (거점역 = 기차역/터미널).
 */
@Getter
@Entity
@Table(name = "stations")
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
public class Station {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "station_code")
    private String stationCode;

    @Column(nullable = false)
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(name = "station_type", nullable = false)
    private StationType stationType;

    private String sido;

    private String sigungu;

    @Column(nullable = false)
    private Double lat;

    @Column(nullable = false)
    private Double lng;
}
