package com.mulmeong.domain.dart.entity;

import com.mulmeong.domain.place.entity.Place;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Table(name = "dart_candidates")
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
public class DartCandidate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "place_id")
    private Place place;

    @Column(name = "name", nullable = false, unique = true)
    private String name;
    @Column(nullable = false)
    private String grade;
    private String sido;
    private String sigungu;
    @Column(nullable = false)
    private double lat;
    @Column(nullable = false)
    private double lng;
    @Column(name = "access_level", nullable = false)
    private String accessLevel;
    @Column(name = "station_name")
    private String stationName;
    @Column(name = "transit_minutes")
    private Integer transitMinutes;
    @Column(name = "station_to_place")
    private String stationToPlace;
    @Column(name = "has_lodging")
    private Boolean hasLodging;
    @Column(name = "is_active", nullable = false)
    private boolean active;
}
