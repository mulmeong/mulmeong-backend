-- 지도 bbox/클러스터 조회 전용 복합 인덱스
CREATE INDEX IF NOT EXISTS idx_places_onsen_map_bbox
    ON places (place_type, lat, lng)
    WHERE place_type = 'ONSEN' AND lat IS NOT NULL AND lng IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_places_onsen_cluster
    ON places (place_type, sigungu_code, lat, lng)
    WHERE place_type = 'ONSEN' AND lat IS NOT NULL AND lng IS NOT NULL;
