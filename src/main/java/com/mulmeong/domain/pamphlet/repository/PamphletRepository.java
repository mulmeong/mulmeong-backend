package com.mulmeong.domain.pamphlet.repository;

import java.util.*;
import org.springframework.data.jpa.repository.JpaRepository;
import com.mulmeong.domain.pamphlet.entity.Pamphlet;

public interface PamphletRepository extends JpaRepository<Pamphlet, Long> {
    List<Pamphlet> findByUserIdOrderByCreatedAtDesc(Long userId);
    Optional<Pamphlet> findByShareToken(String shareToken);
    boolean existsByShareToken(String shareToken);
    void deleteByUserId(Long userId);
}
