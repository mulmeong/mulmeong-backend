package com.mulmeong.domain.user.entity;

import java.time.Instant;
import java.time.LocalDate;

import com.mulmeong.global.entity.BaseTimeEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * 회원 (users 테이블, 스펙 4-2).
 * 생성은 {@link #createLocal} 팩터리로만 — 항상 유효한 상태로 만든다.
 */
@Getter
@Entity
@Table(name = "users")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    /** BCrypt 해시. 소셜 전용 계정(범위 ②)이면 null 가능. */
    @Column
    private String password;

    @Column(nullable = false, unique = true)
    private String nickname;

    @Column(name = "nickname_changed_at")
    private Instant nicknameChangedAt;

    /** AUTH-07 항목. 회원가입 화면엔 없어 현재는 선택(nullable). */
    @Column
    private String name;

    @Column(name = "birth_date")
    private LocalDate birthDate;

    @Column
    private String phone;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Provider provider;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    private User(String email, String password, String nickname) {
        this.email = email;
        this.password = password;
        this.nickname = nickname;
        this.provider = Provider.LOCAL;
        this.role = Role.USER;
    }

    /** 이메일/비밀번호 회원가입 (AUTH-07). password 는 반드시 인코딩된 값. */
    public static User createLocal(String email, String encodedPassword, String nickname) {
        return new User(email, encodedPassword, nickname);
    }
}
