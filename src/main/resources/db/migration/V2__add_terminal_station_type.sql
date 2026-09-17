-- V2: stations.station_type 에 TERMINAL 추가
--
-- V1에 만든 CHECK 제약이 ('KTX','TRAIN') 두 개만 허용해서
-- 시외버스터미널 데이터를 넣을 수 없었다.
--
-- ⚠️ V1 파일을 고치지 않고 V2로 만드는 이유:
--    Flyway는 이미 적용된 마이그레이션 파일의 체크섬을 DB에 기록한다.
--    파일을 수정하면 체크섬이 달라져 "과거가 조작됐다"고 판단하고 앱이 아예 안 뜬다.
--    (9/16 배포 실패가 정확히 이 케이스였다)

ALTER TABLE stations DROP CONSTRAINT stations_station_type_check;

ALTER TABLE stations ADD CONSTRAINT stations_station_type_check
    CHECK (station_type IN ('KTX', 'TRAIN', 'TERMINAL'));
