package com.mulmeong.domain.magazine.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Table(name = "magazine_likes")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MagazineLike {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "magazine_id", nullable = false)
    private Long magazineId;
    @Column(name = "user_id", nullable = false)
    private Long userId;

    public MagazineLike(Long magazineId, Long userId) {
        this.magazineId = magazineId;
        this.userId = userId;
    }
}
