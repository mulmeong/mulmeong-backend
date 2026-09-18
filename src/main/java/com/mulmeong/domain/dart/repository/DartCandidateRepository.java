package com.mulmeong.domain.dart.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.mulmeong.domain.dart.entity.DartCandidate;

public interface DartCandidateRepository extends JpaRepository<DartCandidate, Long> {
    List<DartCandidate> findByActiveTrue();
}
