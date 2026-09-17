package com.mulmeong.domain.magazine.entity;

import jakarta.persistence.*;
import lombok.*;
import com.mulmeong.domain.place.entity.Place;

@Getter @Entity @Table(name = "magazine_places") @NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MagazinePlace {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(name = "magazine_id", nullable = false) private Long magazineId;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "place_id", nullable = false) private Place place;
    @Column(name = "sort_order", nullable = false) private Short sortOrder;
}
