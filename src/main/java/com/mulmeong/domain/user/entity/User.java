package com.mulmeong.domain.user.entity;

import java.time.LocalDate;
import java.time.OffsetDateTime;

import com.mulmeong.global.common.BaseTimeEntity;
import com.mulmeong.global.common.Level;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * 회원 (users 테이블).
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

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, unique = true)
    private String email;

    /** BCrypt 해시. */
    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String phone;

    @Column(name = "birth_date", nullable = false)
    private LocalDate birthDate;

    @Column(nullable = false, unique = true)
    private String nickname;

    @Column(name = "nickname_changed_at")
    private OffsetDateTime nicknameChangedAt;

    /** 고유 방문 온천 수. 레벨 계산 기준 (같은 곳 재리뷰는 미반영, REV-06). */
    @Column(name = "visit_count", nullable = false)
    private Integer visitCount;

    /** 프로필 공개 URL 토큰 (MY-08). PK를 노출하지 않기 위한 base62 랜덤 값. */
    @Column(name = "profile_share_token", unique = true)
    private String profileShareToken;

    /** soft delete (MY-10). */
    @Column(name = "deleted_at")
    private OffsetDateTime deletedAt;

    private User(String name, String email, String encodedPassword, String phone, LocalDate birthDate,
            String nickname, String profileShareToken) {
        this.name = name;
        this.email = email;
        this.password = encodedPassword;
        this.phone = phone;
        this.birthDate = birthDate;
        this.nickname = nickname;
        this.profileShareToken = profileShareToken;
        this.visitCount = 0;
    }

    /** 이메일/비밀번호 회원가입 (AUTH-07). password는 반드시 인코딩된 값, nickname/profileShareToken은 서버가 생성한 값. */
    public static User createLocal(String name, String email, String encodedPassword, String phone,
            LocalDate birthDate, String nickname, String profileShareToken) {
        return new User(name, email, encodedPassword, phone, birthDate, nickname, profileShareToken);
    }

    public boolean isWithdrawn() {
        return deletedAt != null;
    }

    public Level level() {
        return Level.from(visitCount);
    }

    /** MY-07 닉네임 변경. 30일 제한은 서비스 레이어에서 nicknameChangedAt으로 판단한다. */
    public void changeNickname(String nickname, OffsetDateTime changedAt) {
        this.nickname = nickname;
        this.nicknameChangedAt = changedAt;
    }

    public void changePassword(String encodedPassword) {
        this.password = encodedPassword;
    }

    /** MY-10 탈퇴 (소프트 삭제). 이메일·닉네임은 UNIQUE라 재가입 가능하도록 충돌 회피 값으로 바꾼다. */
    public void withdraw(OffsetDateTime withdrawnAt) {
        this.email = "deleted_" + id + "@mulmeong.invalid";
        this.name = "탈퇴한 사용자";
        this.phone = "000-0000-0000";
        this.nickname = "deleted_" + id;
        this.profileShareToken = null;
        this.deletedAt = withdrawnAt;
    }
}
