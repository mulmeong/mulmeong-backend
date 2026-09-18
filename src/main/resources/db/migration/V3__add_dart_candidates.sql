-- 다트 후보 정본과 추첨 로그 확장
CREATE TABLE dart_candidates (
    id BIGSERIAL PRIMARY KEY,
    place_id BIGINT REFERENCES places(id),
    place_external_id VARCHAR(50),
    place_name VARCHAR(200),
    name VARCHAR(100) NOT NULL UNIQUE,
    grade VARCHAR(10) NOT NULL CHECK (grade IN ('VILLAGE', 'SOLO')),
    sido VARCHAR(20),
    sigungu VARCHAR(20),
    lat DOUBLE PRECISION NOT NULL,
    lng DOUBLE PRECISION NOT NULL,
    access_level VARCHAR(20) NOT NULL CHECK (access_level IN ('WALKABLE', 'CAR_RECOMMENDED', 'CAR_REQUIRED')),
    station_name VARCHAR(60),
    station_type VARCHAR(10),
    transit_mode VARCHAR(10),
    transit_minutes INT,
    station_to_place TEXT,
    has_lodging BOOLEAN,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE INDEX idx_dart_active ON dart_candidates(is_active);

ALTER TABLE dart_logs ADD COLUMN candidate_id BIGINT REFERENCES dart_candidates(id);
ALTER TABLE dart_logs ADD COLUMN candidate_count INT;
ALTER TABLE dart_logs ADD COLUMN relaxed_from INT;
ALTER TABLE dart_logs ADD COLUMN is_reroll BOOLEAN NOT NULL DEFAULT FALSE;
