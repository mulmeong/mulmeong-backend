package com.mulmeong.domain.place.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Table(name = "place_images")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PlaceImage {

    public PlaceImage(Long placeId, String imageUrl, short sortOrder) {
        this.placeId = placeId;
        this.imageUrl = imageUrl;
        this.sortOrder = sortOrder;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "place_id", nullable = false)
    private Long placeId;

    @Column(name = "image_url", nullable = false)
    private String imageUrl;

    @Column(name = "sort_order", nullable = false)
    private short sortOrder;
}
