package com.mulmeong.domain.review.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.mulmeong.domain.user.entity.User;

/**
 * reviews는 아직 JPA 엔티티로 모델링되지 않았다(601~606 리뷰 작성/수정/삭제 API 미구현, {@link
 * com.mulmeong.domain.place.repository.ReviewAggregateRepository}와 같은 이유). 마이페이지
 * 701~705·709 조회 전용 네이티브 쿼리만 여기 둔다.
 */
public interface MyReviewRepository extends JpaRepository<User, Long> {

    @Query(value = """
            SELECT
              r.id AS reviewId, r.place_id AS onsenId, p.name AS name,
              p.sido AS sido, p.sigungu AS sigungu,
              (SELECT ri.image_url FROM review_images ri WHERE ri.review_id = r.id ORDER BY ri.sort_order LIMIT 1) AS thumbnail,
              r.rating AS rating, r.body AS body,
              (SELECT COUNT(*) FROM review_images ri WHERE ri.review_id = r.id) AS imageCount,
              (SELECT ri.image_url FROM review_images ri WHERE ri.review_id = r.id ORDER BY ri.sort_order LIMIT 1) AS firstImage,
              r.visited_at AS visitedAt,
              EXISTS (SELECT 1 FROM reviews prev WHERE prev.user_id = r.user_id AND prev.place_id = r.place_id
                      AND prev.deleted_at IS NULL AND prev.visited_at < r.visited_at) AS isRevisit,
              r.created_at AS createdAt
            FROM reviews r JOIN places p ON p.id = r.place_id
            WHERE r.user_id = :userId AND r.deleted_at IS NULL
              AND (:regionCode IS NULL OR p.sido_code = :regionCode OR p.sigungu_code = :regionCode)
            ORDER BY
              CASE WHEN :sortCode = 1 THEN r.visited_at END ASC,
              CASE WHEN :sortCode = 2 THEN r.rating END DESC,
              CASE WHEN :sortCode = 0 THEN r.visited_at END DESC,
              r.created_at DESC
            """,
            countQuery = """
            SELECT COUNT(*) FROM reviews r JOIN places p ON p.id = r.place_id
            WHERE r.user_id = :userId AND r.deleted_at IS NULL
              AND (:regionCode IS NULL OR p.sido_code = :regionCode OR p.sigungu_code = :regionCode)
            """,
            nativeQuery = true)
    Page<MyReviewRow> findMyReviews(@Param("userId") Long userId, @Param("regionCode") String regionCode,
            @Param("sortCode") int sortCode, Pageable pageable);

    @Query(value = """
            SELECT p.sido_code AS regionCode, p.sido AS name, COUNT(*) AS count
            FROM reviews r JOIN places p ON p.id = r.place_id
            WHERE r.user_id = :userId AND r.deleted_at IS NULL AND p.sido_code IS NOT NULL
            GROUP BY p.sido_code, p.sido
            ORDER BY p.sido_code
            """, nativeQuery = true)
    List<MyReviewRegionCount> findMyReviewRegions(@Param("userId") Long userId);

    @Query(value = """
            SELECT
              r.id AS reviewId, r.user_id AS userId, r.place_id AS onsenId, p.name AS name,
              p.address AS address, p.lat AS lat, p.lng AS lng,
              (SELECT ri.image_url FROM review_images ri WHERE ri.review_id = r.id ORDER BY ri.sort_order LIMIT 1) AS thumbnail,
              r.rating AS rating, r.visited_at AS visitedAt, r.visit_time_slot AS visitTimeSlot,
              r.cleanliness AS cleanliness, r.crowdedness AS crowdedness, r.facility_score AS facilityScore,
              r.body AS body, r.created_at AS createdAt, r.updated_at AS updatedAt,
              EXISTS (SELECT 1 FROM reviews prev WHERE prev.user_id = r.user_id AND prev.place_id = r.place_id
                      AND prev.deleted_at IS NULL AND prev.visited_at < r.visited_at) AS isRevisit
            FROM reviews r JOIN places p ON p.id = r.place_id
            WHERE r.id = :reviewId AND r.deleted_at IS NULL
            """, nativeQuery = true)
    Optional<MyReviewDetailRow> findMyReviewDetail(@Param("reviewId") Long reviewId);

    @Query(value = "SELECT image_url FROM review_images WHERE review_id = :reviewId ORDER BY sort_order",
            nativeQuery = true)
    List<String> findReviewImageUrls(@Param("reviewId") Long reviewId);

    @Query(value = "SELECT COUNT(*) FROM reviews WHERE user_id = :userId AND deleted_at IS NULL", nativeQuery = true)
    long countByUserId(@Param("userId") Long userId);

    @Query(value = """
            SELECT DISTINCT r.place_id FROM reviews r JOIN places p ON p.id = r.place_id
            WHERE r.user_id = :userId AND r.deleted_at IS NULL AND p.sido_code = :sidoCode
            """, nativeQuery = true)
    List<Long> findDistinctPlaceIdsByUserAndSido(@Param("userId") Long userId, @Param("sidoCode") String sidoCode);

    @Query(value = """
            SELECT DISTINCT r.place_id FROM reviews r JOIN places p ON p.id = r.place_id
            WHERE r.user_id = :userId AND r.deleted_at IS NULL AND p.sigungu_code = :sigunguCode
            """, nativeQuery = true)
    List<Long> findDistinctPlaceIdsByUserAndSigungu(@Param("userId") Long userId,
            @Param("sigunguCode") String sigunguCode);

    /** 708 recentOnsens: visited_at 최근순 3곳, 같은 온천 중복 제외. */
    @Query(value = """
            SELECT DISTINCT ON (r.place_id) r.place_id AS onsenId, p.name AS name,
              (SELECT ri.image_url FROM review_images ri WHERE ri.review_id = r.id ORDER BY ri.sort_order LIMIT 1) AS thumbnail,
              r.visited_at AS visitedAt
            FROM reviews r JOIN places p ON p.id = r.place_id
            WHERE r.user_id = :userId AND r.deleted_at IS NULL
            ORDER BY r.place_id, r.visited_at DESC
            """, nativeQuery = true)
    List<RecentOnsenRow> findRecentOnsenCandidates(@Param("userId") Long userId);
}
