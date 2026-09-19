package com.mulmeong.domain.review.entity;

import java.time.LocalDate;
import java.time.OffsetDateTime;

import com.mulmeong.global.common.BaseTimeEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.FetchType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OrderBy;
import java.util.ArrayList;
import java.util.List;
import com.mulmeong.domain.user.entity.User;
import org.hibernate.annotations.Formula;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Table(name = "reviews")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Review extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "place_id", nullable = false)
    private Long placeId;

    @Column(nullable = false)
    private Short rating;

    private Short cleanliness;

    private Short crowdedness;

    @Column(name = "facility_score")
    private Short facilityScore;

    @Column(name = "visit_time_slot")
    private String visitTimeSlot;

    @Column(name = "visited_at", nullable = false)
    private LocalDate visitedAt;

    private String body;

    @Column(name = "deleted_at")
    private OffsetDateTime deletedAt;

    @Formula("""
            exists (
                select 1 from reviews prev
                where prev.user_id = user_id
                  and prev.place_id = place_id
                  and prev.deleted_at is null
                  and prev.visited_at < visited_at
            )
            """)
    private boolean revisit;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    private User user;

    @OneToMany(mappedBy = "review", fetch = FetchType.LAZY)
    @OrderBy("sortOrder asc")
    private List<ReviewImage> images = new ArrayList<>();

    public static Review create(Long userId, Long placeId, short rating, short cleanliness, short crowdedness,
            short facilityScore, String visitTimeSlot, LocalDate visitedAt, String body) {
        Review review = new Review();
        review.userId = userId;
        review.placeId = placeId;
        review.rating = rating;
        review.cleanliness = cleanliness;
        review.crowdedness = crowdedness;
        review.facilityScore = facilityScore;
        review.visitTimeSlot = visitTimeSlot;
        review.visitedAt = visitedAt;
        review.body = body;
        return review;
    }

    public void update(Short rating, Short cleanliness, Short crowdedness, Short facilityScore, String visitTimeSlot,
            String body) {
        if (rating != null) this.rating = rating;
        if (cleanliness != null) this.cleanliness = cleanliness;
        if (crowdedness != null) this.crowdedness = crowdedness;
        if (facilityScore != null) this.facilityScore = facilityScore;
        if (visitTimeSlot != null) this.visitTimeSlot = visitTimeSlot;
        if (body != null) this.body = body;
    }

    public void delete(OffsetDateTime deletedAt) { this.deletedAt = deletedAt; }

    public boolean isDeleted() {
        return deletedAt != null;
    }
}
