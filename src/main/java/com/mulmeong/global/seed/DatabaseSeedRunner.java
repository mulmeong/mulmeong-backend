package com.mulmeong.global.seed;

import javax.sql.DataSource;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.stereotype.Component;

/**
 * seed 프로필이 켜졌을 때만 동작. 스크립트는 전부 (source, external_id) / name 기준
 * ON CONFLICT upsert라 재실행해도 안전 — 배포마다 자동으로 최신 시드가 반영된다.
 * places -> magazines -> dart_candidates 순서(외래키/매칭 의존성)를 지켜야 한다.
 */
@Component
@Profile("seed")
public class DatabaseSeedRunner implements ApplicationRunner {

    private static final String[] SEED_SCRIPTS = {
            "db/seed/places_seed.sql",
            "db/seed/magazines_seed.sql",
            "db/seed/dart_candidates_seed.sql"
    };

    private final DataSource dataSource;

    public DatabaseSeedRunner(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public void run(ApplicationArguments args) {
        ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
        populator.setContinueOnError(false);
        populator.setSqlScriptEncoding("UTF-8");
        for (String script : SEED_SCRIPTS) {
            populator.addScript(new ClassPathResource(script));
        }
        populator.execute(dataSource);
    }
}
