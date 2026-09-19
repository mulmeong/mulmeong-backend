package com.mulmeong.domain.pamphlet.repository;

import com.mulmeong.domain.pamphlet.entity.PamphletPlace;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PamphletPlaceRepository extends JpaRepository<PamphletPlace, Long> {
    List<PamphletPlace> findByPamphletIdOrderBySortOrder(Long pamphletId);

    void deleteByPamphletId(Long pamphletId);
}
