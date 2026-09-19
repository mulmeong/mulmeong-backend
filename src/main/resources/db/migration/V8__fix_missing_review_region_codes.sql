-- V6 실행 뒤 시드된 두 온천의 시군구 코드를 보정하고, 리뷰 기반 지역 집계를 재생성한다.
UPDATE places
SET sigungu_code = CASE external_id
    WHEN '207' THEN '47850'
    WHEN '325' THEN '26530'
END
WHERE source = 'MOIS'
  AND external_id IN ('207', '325');

DELETE FROM region_stats;

INSERT INTO region_stats (user_id, sido_code, sigungu_code, visit_count)
SELECT review.user_id,
       place.sido_code,
       place.sigungu_code,
       COUNT(DISTINCT review.place_id)
FROM reviews AS review
JOIN places AS place ON place.id = review.place_id
WHERE review.deleted_at IS NULL
  AND place.sido_code IS NOT NULL
  AND place.sigungu_code IS NOT NULL
GROUP BY review.user_id, place.sido_code, place.sigungu_code;
