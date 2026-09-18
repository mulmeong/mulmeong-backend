package com.mulmeong.domain.pamphlet.entity;

import java.time.LocalDate;
import com.mulmeong.global.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

@Getter @Entity @Table(name = "pamphlets") @NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Pamphlet extends BaseTimeEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(name = "user_id", nullable = false) private Long userId;
    @Column(nullable = false) private String title;
    @Column(name = "party_size") private Short partySize;
    @Column(name = "travel_date") private LocalDate travelDate;
    @Column(name = "cover_image_url") private String coverImageUrl;
    @Column(name = "share_token", unique = true) private String shareToken;
    public Pamphlet(Long userId, String title, Short partySize, LocalDate travelDate, String coverImageUrl, String shareToken) {
        this.userId = userId; this.title = title; this.partySize = partySize; this.travelDate = travelDate;
        this.coverImageUrl = coverImageUrl; this.shareToken = shareToken;
    }
}
