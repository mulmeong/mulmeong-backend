package com.mulmeong.domain.pamphlet.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter @Entity @Table(name = "pamphlet_places") @NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PamphletPlace {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(name = "pamphlet_id", nullable = false) private Long pamphletId;
    @Column(name = "place_id", nullable = false) private Long placeId;
    @Column(name = "sort_order", nullable = false) private short sortOrder;
    public PamphletPlace(Long pamphletId, Long placeId, short sortOrder) { this.pamphletId = pamphletId; this.placeId = placeId; this.sortOrder = sortOrder; }
}
