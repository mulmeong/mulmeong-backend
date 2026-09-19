package com.mulmeong.domain.user.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Lock;
import jakarta.persistence.LockModeType;
import org.springframework.data.repository.query.Param;

import com.mulmeong.domain.user.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {

    boolean existsByEmail(String email);

    boolean existsByNickname(String nickname);

    Optional<User> findByEmail(String email);

    Optional<User> findByProfileShareToken(String profileShareToken);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("select u from User u where u.id = :userId")
    Optional<User> findByIdForUpdate(@Param("userId") Long userId);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.visitCount = u.visitCount + 1 where u.id = :userId")
    int incrementVisitCount(@Param("userId") Long userId);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.visitCount = case when u.visitCount > 0 then u.visitCount - 1 else 0 end where u.id = :userId")
    int decrementVisitCount(@Param("userId") Long userId);
}
