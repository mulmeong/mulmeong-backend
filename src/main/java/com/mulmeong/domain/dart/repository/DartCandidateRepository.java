package com.mulmeong.domain.dart.repository;

import com.mulmeong.domain.dart.entity.DartCandidate;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface DartCandidateRepository extends JpaRepository<DartCandidate, Long> {
    List<DartCandidate> findByActiveTrue();

    Optional<DartCandidate> findFirstByPlace_IdOrderById(Long placeId);
}
