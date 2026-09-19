package com.mulmeong.domain.region.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

/** region_stats 테이블. 회원별 시군구 단위 방문 횟수 (포도알 지도 702용). */
@Getter
@Entity
@Table(name = "region_stats")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class RegionStat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "sido_code", nullable = false)
    private String sidoCode;

    @Column(name = "sigungu_code", nullable = false)
    private String sigunguCode;

    @Column(name = "visit_count", nullable = false)
    private Integer visitCount;
}
