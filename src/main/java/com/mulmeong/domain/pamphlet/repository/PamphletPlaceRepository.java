package com.mulmeong.domain.pamphlet.repository;

import java.util.*;
import org.springframework.data.jpa.repository.JpaRepository;
import com.mulmeong.domain.pamphlet.entity.PamphletPlace;

public interface PamphletPlaceRepository extends JpaRepository<PamphletPlace, Long> {
    List<PamphletPlace> findByPamphletIdOrderBySortOrder(Long pamphletId);
    void deleteByPamphletId(Long pamphletId);
}
