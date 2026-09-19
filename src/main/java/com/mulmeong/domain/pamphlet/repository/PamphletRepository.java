package com.mulmeong.domain.pamphlet.repository;

import com.mulmeong.domain.pamphlet.entity.Pamphlet;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PamphletRepository extends JpaRepository<Pamphlet, Long> {
    List<Pamphlet> findByUserIdOrderByCreatedAtDesc(Long userId);

    Optional<Pamphlet> findByShareToken(String shareToken);

    boolean existsByShareToken(String shareToken);

    void deleteByUserId(Long userId);
}
