-- 카카오 로컬 API 응답은 영속 저장하지 않는 정책으로 전환한다.
-- 기존 KAKAO 장소와 그 장소를 참조하는 사용자 데이터를 함께 제거한다.

CREATE TEMP TABLE affected_kakao_review_users (
    user_id BIGINT PRIMARY KEY
) ON COMMIT DROP;

INSERT INTO affected_kakao_review_users (user_id)
SELECT DISTINCT review.user_id
FROM reviews review
JOIN places place ON place.id = review.place_id
WHERE place.source = 'KAKAO';

UPDATE dart_logs
SET candidate_id = NULL
WHERE candidate_id IN (
    SELECT candidate.id
    FROM dart_candidates candidate
    JOIN places place ON place.id = candidate.place_id
    WHERE place.source = 'KAKAO'
);

UPDATE dart_logs
SET result_place_id = NULL
WHERE result_place_id IN (
    SELECT id
    FROM places
    WHERE source = 'KAKAO'
);

DELETE FROM dart_candidates
WHERE place_id IN (
    SELECT id
    FROM places
    WHERE source = 'KAKAO'
);

DELETE FROM pamphlet_places
WHERE place_id IN (
    SELECT id
    FROM places
    WHERE source = 'KAKAO'
);

DELETE FROM favorites
WHERE place_id IN (
    SELECT id
    FROM places
    WHERE source = 'KAKAO'
);

DELETE FROM reviews
WHERE place_id IN (
    SELECT id
    FROM places
    WHERE source = 'KAKAO'
);

DELETE FROM region_stats
WHERE user_id IN (
    SELECT user_id
    FROM affected_kakao_review_users
);

INSERT INTO region_stats (user_id, sido_code, sigungu_code, visit_count)
SELECT review.user_id,
       place.sido_code,
       place.sigungu_code,
       COUNT(DISTINCT review.place_id)
FROM reviews review
JOIN places place ON place.id = review.place_id
JOIN affected_kakao_review_users affected ON affected.user_id = review.user_id
WHERE review.deleted_at IS NULL
  AND place.sido_code IS NOT NULL
  AND place.sigungu_code IS NOT NULL
GROUP BY review.user_id, place.sido_code, place.sigungu_code;

DELETE FROM places
WHERE source = 'KAKAO';
