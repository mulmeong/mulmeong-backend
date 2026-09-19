package com.mulmeong.domain.magazine.dto;

import java.time.OffsetDateTime;
import java.util.List;

public record MagazineResponse(Long magazineId, String category, String categoryLabel, String title,
                               String subtitle, String thumbnailUrl, String heroImageUrl, String sidoCode,
                               String regionName,
                               short readMinutes, int likeCount, boolean isLiked, OffsetDateTime publishedAt) {
    public record Detail(Long magazineId, String category, String categoryLabel, String title, String subtitle,
                         String thumbnailUrl, String heroImageUrl, String sidoCode, String regionName,
                         short readMinutes,
                         int likeCount, boolean isLiked, OffsetDateTime publishedAt, String author, String photographer,
                         String body, String bodyFormat, List<Place> relatedPlaces, Next next, String shareUrl) {
    }

    public record Place(Long placeId, String name, String thumbnail, String sido, String sigungu,
                        Double lat, Double lng, String subText, String accessSummary) {
    }

    public record Next(Long magazineId, String title, String categoryLabel, short readMinutes) {
    }
}
