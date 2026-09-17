package com.mulmeong.domain.magazine.entity;

import java.time.OffsetDateTime;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter @Entity @Table(name = "magazines") @NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
public class Magazine {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Enumerated(EnumType.STRING) @Column(nullable = false) private MagazineCategory category;
    @Column(nullable = false) private String title;
    private String subtitle;
    @Column(name = "thumbnail_url") private String thumbnailUrl;
    @Column(name = "hero_image_url") private String heroImageUrl;
    @Column(columnDefinition = "text") private String body;
    @Column(name = "sido_code") private String sidoCode;
    private String author;
    private String photographer;
    @Column(name = "read_minutes") private Short readMinutes;
    @Column(name = "like_count", nullable = false) private Integer likeCount;
    @Column(name = "published_at") private OffsetDateTime publishedAt;
}
