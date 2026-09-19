package com.mulmeong.domain.place.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.mulmeong.domain.place.entity.AccessLevel;
import com.mulmeong.domain.place.entity.Place;
import com.mulmeong.domain.place.entity.PlaceType;

public interface PlaceRepository extends JpaRepository<Place, Long> {

    Optional<Place> findBySourceAndExternalId(String source, String externalId);

    Optional<Place> findFirstByPlaceTypeAndNameAndAddress(PlaceType placeType, String name, String address);

    @Query("""
            SELECT p FROM Place p
            WHERE p.placeType = com.mulmeong.domain.place.entity.PlaceType.ONSEN
              AND (:accessLevel IS NULL OR p.accessLevel = :accessLevel)
              AND (:hasOutdoor IS NULL OR p.hasOutdoor = :hasOutdoor)
              AND (:registeredOnly = false OR p.registeredOnsen = true)
            ORDER BY p.name
            """)
    List<Place> findAllOnsensForMap(@Param("accessLevel") AccessLevel accessLevel,
            @Param("hasOutdoor") Boolean hasOutdoor, @Param("registeredOnly") boolean registeredOnly);

    @Query(value = """
            SELECT * FROM places p
            WHERE p.place_type = 'ONSEN'
              AND (:region = '' OR CASE COALESCE(p.sido, '')
                        WHEN '서울특별시' THEN '서울'
                        WHEN '경기도' THEN '경기'
                        WHEN '인천광역시' THEN '인천'
                        WHEN '강원특별자치도' THEN '강원'
                        WHEN '대전광역시' THEN '충청'
                        WHEN '세종특별자치시' THEN '충청'
                        WHEN '충청북도' THEN '충청'
                        WHEN '충청남도' THEN '충청'
                        WHEN '부산광역시' THEN '경상'
                        WHEN '대구광역시' THEN '경상'
                        WHEN '울산광역시' THEN '경상'
                        WHEN '경상북도' THEN '경상'
                        WHEN '경상남도' THEN '경상'
                        WHEN '광주광역시' THEN '전라'
                        WHEN '전라남도' THEN '전라'
                        WHEN '전북특별자치도' THEN '전라'
                        WHEN '제주특별자치도' THEN '제주'
                        ELSE COALESCE(p.sido, '') END = :region
                   OR LOWER(COALESCE(p.sido, '')) LIKE LOWER(CONCAT('%', :region, '%'))
                   OR LOWER(COALESCE(p.sigungu, '')) LIKE LOWER(CONCAT('%', :region, '%'))
                   OR LOWER(COALESCE(p.sido_code, '')) = LOWER(:region)
                   OR LOWER(COALESCE(p.sigungu_code, '')) = LOWER(:region))
              AND (:keyword = '' OR LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
                   OR LOWER(COALESCE(p.address, '')) LIKE LOWER(CONCAT('%', :keyword, '%')))
            ORDER BY p.is_registered_onsen DESC, p.name
            """, nativeQuery = true)
    List<Place> findOnsens(@Param("region") String region, @Param("keyword") String keyword, Pageable pageable);

    @Query(value = """
            SELECT COUNT(*) FROM places p
            WHERE p.place_type = 'ONSEN'
              AND (:region = '' OR CASE COALESCE(p.sido, '')
                        WHEN '서울특별시' THEN '서울'
                        WHEN '경기도' THEN '경기'
                        WHEN '인천광역시' THEN '인천'
                        WHEN '강원특별자치도' THEN '강원'
                        WHEN '대전광역시' THEN '충청'
                        WHEN '세종특별자치시' THEN '충청'
                        WHEN '충청북도' THEN '충청'
                        WHEN '충청남도' THEN '충청'
                        WHEN '부산광역시' THEN '경상'
                        WHEN '대구광역시' THEN '경상'
                        WHEN '울산광역시' THEN '경상'
                        WHEN '경상북도' THEN '경상'
                        WHEN '경상남도' THEN '경상'
                        WHEN '광주광역시' THEN '전라'
                        WHEN '전라남도' THEN '전라'
                        WHEN '전북특별자치도' THEN '전라'
                        WHEN '제주특별자치도' THEN '제주'
                        ELSE COALESCE(p.sido, '') END = :region
                   OR LOWER(COALESCE(p.sido, '')) LIKE LOWER(CONCAT('%', :region, '%'))
                   OR LOWER(COALESCE(p.sigungu, '')) LIKE LOWER(CONCAT('%', :region, '%'))
                   OR LOWER(COALESCE(p.sido_code, '')) = LOWER(:region)
                   OR LOWER(COALESCE(p.sigungu_code, '')) = LOWER(:region))
              AND (:keyword = '' OR LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
                   OR LOWER(COALESCE(p.address, '')) LIKE LOWER(CONCAT('%', :keyword, '%')))
            """, nativeQuery = true)
    long countOnsens(@Param("region") String region, @Param("keyword") String keyword);

    @Query("""
            SELECT p FROM Place p
            WHERE p.placeType = com.mulmeong.domain.place.entity.PlaceType.ONSEN
              AND p.lat IS NOT NULL
              AND p.lng IS NOT NULL
              AND p.lat BETWEEN :swLat AND :neLat
              AND p.lng BETWEEN :swLng AND :neLng
              AND (:accessLevel IS NULL OR p.accessLevel = :accessLevel)
              AND (:hasOutdoor IS NULL OR p.hasOutdoor = :hasOutdoor)
              AND (:registeredOnly = false OR p.registeredOnsen = true)
            """)
    List<Place> findOnsensInBbox(
            @Param("swLat") double swLat, @Param("neLat") double neLat,
            @Param("swLng") double swLng, @Param("neLng") double neLng,
            @Param("accessLevel") AccessLevel accessLevel, @Param("hasOutdoor") Boolean hasOutdoor,
            @Param("registeredOnly") boolean registeredOnly);

    @Query("""
            SELECT new com.mulmeong.domain.place.repository.SigunguAggregate(
                p.sigunguCode, p.sigungu, AVG(p.lat), AVG(p.lng), COUNT(p))
            FROM Place p
            WHERE p.placeType = com.mulmeong.domain.place.entity.PlaceType.ONSEN
              AND p.lat IS NOT NULL
              AND p.lng IS NOT NULL
              AND p.lat BETWEEN :swLat AND :neLat
              AND p.lng BETWEEN :swLng AND :neLng
              AND (:accessLevel IS NULL OR p.accessLevel = :accessLevel)
              AND (:hasOutdoor IS NULL OR p.hasOutdoor = :hasOutdoor)
              AND (:registeredOnly = false OR p.registeredOnsen = true)
              AND p.sigunguCode IS NOT NULL
            GROUP BY p.sigunguCode, p.sigungu
            """)
    List<SigunguAggregate> clusterOnsensInBbox(
            @Param("swLat") double swLat, @Param("neLat") double neLat,
            @Param("swLng") double swLng, @Param("neLng") double neLng,
            @Param("accessLevel") AccessLevel accessLevel, @Param("hasOutdoor") Boolean hasOutdoor,
            @Param("registeredOnly") boolean registeredOnly);

    @Query("""
            SELECT p FROM Place p
            WHERE p.placeType = com.mulmeong.domain.place.entity.PlaceType.ONSEN
              AND p.lat IS NOT NULL
              AND p.lng IS NOT NULL
              AND LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
            ORDER BY CASE WHEN LOWER(p.name) LIKE LOWER(CONCAT(:keyword, '%')) THEN 0 ELSE 1 END, p.name
            """)
    List<Place> searchOnsensByName(@Param("keyword") String keyword, Pageable pageable);

    @Query("""
            SELECT p FROM Place p
            WHERE p.placeType <> com.mulmeong.domain.place.entity.PlaceType.ONSEN
              AND p.lat IS NOT NULL AND p.lng IS NOT NULL
              AND p.lat BETWEEN :minLat AND :maxLat
              AND p.lng BETWEEN :minLng AND :maxLng
            """)
    List<Place> findNearbyPlaces(@Param("minLat") double minLat, @Param("maxLat") double maxLat,
            @Param("minLng") double minLng, @Param("maxLng") double maxLng);

    @Query("""
            SELECT new com.mulmeong.domain.place.repository.RegionAggregate(
                p.sigunguCode, p.sido, p.sigungu, AVG(p.lat), AVG(p.lng), COUNT(p))
            FROM Place p
            WHERE p.placeType = com.mulmeong.domain.place.entity.PlaceType.ONSEN
              AND p.sigunguCode IS NOT NULL
              AND p.lat IS NOT NULL
              AND p.lng IS NOT NULL
              AND (LOWER(p.sido) LIKE LOWER(CONCAT('%', :keyword, '%'))
                   OR LOWER(p.sigungu) LIKE LOWER(CONCAT('%', :keyword, '%')))
            GROUP BY p.sigunguCode, p.sido, p.sigungu
            """)
    List<RegionAggregate> searchRegionsByName(@Param("keyword") String keyword, Pageable pageable);

    /** 화면 중심 좌표에서 가장 가까운 온천의 sido_code (centerSidoCode 응답용, MVP: 역지오코딩 대신 최근접 온천 기준). */
    @Query(value = """
            SELECT p.sido_code FROM places p
            WHERE p.place_type = 'ONSEN' AND p.sido_code IS NOT NULL
              AND p.lat IS NOT NULL AND p.lng IS NOT NULL
            ORDER BY (ABS(p.lat - :lat) + ABS(p.lng - :lng)) ASC
            LIMIT 1
            """, nativeQuery = true)
    Optional<String> findNearestSidoCode(@Param("lat") double lat, @Param("lng") double lng);
}
