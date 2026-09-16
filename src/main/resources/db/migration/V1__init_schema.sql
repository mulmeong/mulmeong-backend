-- =====================================================================
-- 물멍 DB 스키마 (최종 · ① 범위)
-- PostgreSQL 16 / Spring Boot + JPA (ddl-auto=validate)
-- 컬럼명: 엔티티 camelCase 필드 → DB snake_case (Hibernate 기본 전략)
-- 시간: 전부 TIMESTAMPTZ (JPA: OffsetDateTime 또는 Instant)
-- =====================================================================

-- 1. users -------------------------------------------------------------
CREATE TABLE users (
                       id                   BIGSERIAL    PRIMARY KEY,
                       name                 VARCHAR(50)  NOT NULL,
                       email                VARCHAR(100) NOT NULL UNIQUE,
                       password             VARCHAR(255) NOT NULL,
                       phone                VARCHAR(20)  NOT NULL,
                       birth_date           DATE         NOT NULL,
                       nickname             VARCHAR(30)  NOT NULL UNIQUE,
                       nickname_changed_at  TIMESTAMPTZ,
                       visit_count          INT          NOT NULL DEFAULT 0 CHECK (visit_count >= 0),
                       profile_share_token  VARCHAR(50)  UNIQUE,
                       created_at           TIMESTAMPTZ  NOT NULL DEFAULT now(),
                       updated_at           TIMESTAMPTZ  NOT NULL DEFAULT now(),
                       deleted_at           TIMESTAMPTZ
);

-- 2. password_reset_tokens --------------------------------------------
CREATE TABLE password_reset_tokens (
                                       id          BIGSERIAL    PRIMARY KEY,
                                       user_id     BIGINT       NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                                       token_hash  VARCHAR(100) NOT NULL UNIQUE,   -- 원본 토큰은 메일로만, DB엔 SHA-256 해시
                                       expires_at  TIMESTAMPTZ  NOT NULL,
                                       used_at     TIMESTAMPTZ,
                                       created_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);
CREATE INDEX idx_pwreset_user ON password_reset_tokens (user_id);

-- 2-1. stations (거점역 = 기차역) ------------------------------------
CREATE TABLE stations (
                          id            BIGSERIAL        PRIMARY KEY,
                          station_code  VARCHAR(20)      UNIQUE,          -- 원본 데이터의 역 코드 (시드 upsert 키)
                          name          VARCHAR(50)      NOT NULL,        -- 예: 충주역
                          station_type  VARCHAR(20)      NOT NULL DEFAULT 'TRAIN'
                              CHECK (station_type IN ('KTX','TRAIN')),
                          sido          VARCHAR(20),
                          sigungu       VARCHAR(30),
                          lat           DOUBLE PRECISION NOT NULL,
                          lng           DOUBLE PRECISION NOT NULL,
                          created_at    TIMESTAMPTZ      NOT NULL DEFAULT now()
);
CREATE INDEX idx_stations_latlng ON stations (lat, lng);

-- 3. places ------------------------------------------------------------
CREATE TABLE places (
                        id                     BIGSERIAL     PRIMARY KEY,
                        place_type             VARCHAR(20)   NOT NULL
                            CHECK (place_type IN ('ONSEN','RESTAURANT','CAFE','ATTRACTION','SPA','ETC')),
                        is_registered_onsen    BOOLEAN       NOT NULL DEFAULT false,
                        source                 VARCHAR(20)   NOT NULL
                            CHECK (source IN ('MOIS','MANUAL','KAKAO','TOUR_API')),
                        external_id            VARCHAR(100),
                        name                   VARCHAR(100)  NOT NULL,
                        sido                   VARCHAR(20),
                        sigungu                VARCHAR(30),
                        sido_code              VARCHAR(10),
                        sigungu_code           VARCHAR(10),
                        address                VARCHAR(255),
                        lat                    DOUBLE PRECISION,
                        lng                    DOUBLE PRECISION,
                        phone                  VARCHAR(30),
                        homepage_url           VARCHAR(500),
                        hours                  TEXT,
                        holiday                VARCHAR(255),
                        parking_info           VARCHAR(255),
                        price_min              INT           CHECK (price_min >= 0),
                        representative_menu    VARCHAR(100),
    -- 온천 전용 (place_type = 'ONSEN' 이 아니면 NULL)
                        water_temp             NUMERIC(4,1),
                        water_type             VARCHAR(30),
                        water_component        VARCHAR(30),
                        ph                     NUMERIC(3,1)  CHECK (ph BETWEEN 0 AND 14),
                        water_benefit          VARCHAR(255),
                        has_outdoor            BOOLEAN,
                        has_lodging            BOOLEAN,
                        facility_type          VARCHAR(50),
                        access_level           VARCHAR(20)
                            CHECK (access_level IN ('WALKABLE','CAR_RECOMMENDED','CAR_REQUIRED')),
                        station_id             BIGINT        REFERENCES stations(id) ON DELETE SET NULL,  -- 거점역
                        station_to_place_desc  VARCHAR(255),
                        region_comment         TEXT,
                        notes                  TEXT,
                        annual_visitors        INT           CHECK (annual_visitors >= 0),
                        created_at             TIMESTAMPTZ   NOT NULL DEFAULT now(),
                        updated_at             TIMESTAMPTZ   NOT NULL DEFAULT now(),
                        CONSTRAINT chk_places_registered_onsen
                            CHECK (is_registered_onsen = false OR place_type = 'ONSEN')
);
CREATE INDEX idx_places_type    ON places (place_type);
CREATE INDEX idx_places_latlng  ON places (lat, lng);
CREATE INDEX idx_places_name    ON places (name);
CREATE INDEX idx_places_sigungu ON places (sigungu_code);
CREATE INDEX idx_places_station ON places (station_id);
CREATE UNIQUE INDEX uq_places_external
    ON places (source, external_id) WHERE external_id IS NOT NULL;

-- 4. place_images ------------------------------------------------------
CREATE TABLE place_images (
                              id          BIGSERIAL    PRIMARY KEY,
                              place_id    BIGINT       NOT NULL REFERENCES places(id) ON DELETE CASCADE,
                              image_url   VARCHAR(500) NOT NULL,
                              sort_order  SMALLINT     NOT NULL DEFAULT 0
);
CREATE INDEX idx_place_images_place ON place_images (place_id, sort_order);

-- 5. reviews -----------------------------------------------------------
CREATE TABLE reviews (
                         id               BIGSERIAL    PRIMARY KEY,
                         user_id          BIGINT       NOT NULL REFERENCES users(id),
                         place_id         BIGINT       NOT NULL REFERENCES places(id),
                         rating           SMALLINT     NOT NULL CHECK (rating BETWEEN 1 AND 5),
                         cleanliness      SMALLINT     CHECK (cleanliness BETWEEN 1 AND 5),
                         crowdedness      SMALLINT     CHECK (crowdedness BETWEEN 1 AND 5),
                         facility_score   SMALLINT     CHECK (facility_score BETWEEN 1 AND 5),
                         visit_time_slot  VARCHAR(20),
                         visited_at       DATE         NOT NULL,
                         body             TEXT,
                         created_at       TIMESTAMPTZ  NOT NULL DEFAULT now(),
                         updated_at       TIMESTAMPTZ  NOT NULL DEFAULT now(),
                         deleted_at       TIMESTAMPTZ
);
CREATE INDEX idx_reviews_place ON reviews (place_id) WHERE deleted_at IS NULL;
CREATE INDEX idx_reviews_user  ON reviews (user_id)  WHERE deleted_at IS NULL;
-- 일 1회 제한 (REV-06): 같은 회원 + 같은 장소 + 같은 방문일은 1건
CREATE UNIQUE INDEX uq_reviews_daily
    ON reviews (user_id, place_id, visited_at) WHERE deleted_at IS NULL;

-- 6. review_images -----------------------------------------------------
CREATE TABLE review_images (
                               id          BIGSERIAL    PRIMARY KEY,
                               review_id   BIGINT       NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
                               image_url   VARCHAR(500) NOT NULL,
                               sort_order  SMALLINT     NOT NULL DEFAULT 0
);
CREATE INDEX idx_review_images_review ON review_images (review_id, sort_order);

-- 7. favorites ---------------------------------------------------------
CREATE TABLE favorites (
                           id          BIGSERIAL   PRIMARY KEY,
                           user_id     BIGINT      NOT NULL REFERENCES users(id),
                           place_id    BIGINT      NOT NULL REFERENCES places(id),
                           created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
                           CONSTRAINT uq_favorites UNIQUE (user_id, place_id)
);
CREATE INDEX idx_favorites_user ON favorites (user_id, created_at DESC);

-- 8. pamphlets ---------------------------------------------------------
CREATE TABLE pamphlets (
                           id               BIGSERIAL    PRIMARY KEY,
                           user_id          BIGINT       NOT NULL REFERENCES users(id),
                           title            VARCHAR(100) NOT NULL,
                           party_size       SMALLINT     CHECK (party_size > 0),
                           travel_date      DATE,
                           cover_image_url  VARCHAR(500),
                           share_token      VARCHAR(50)  UNIQUE,
                           created_at       TIMESTAMPTZ  NOT NULL DEFAULT now(),
                           updated_at       TIMESTAMPTZ  NOT NULL DEFAULT now()
);
CREATE INDEX idx_pamphlets_user ON pamphlets (user_id);

-- 9. pamphlet_places ---------------------------------------------------
CREATE TABLE pamphlet_places (
                                 id           BIGSERIAL PRIMARY KEY,
                                 pamphlet_id  BIGINT    NOT NULL REFERENCES pamphlets(id) ON DELETE CASCADE,
                                 place_id     BIGINT    NOT NULL REFERENCES places(id),
                                 sort_order   SMALLINT  NOT NULL DEFAULT 0,
                                 CONSTRAINT uq_pamphlet_places UNIQUE (pamphlet_id, place_id)
);

-- 10. dart_logs --------------------------------------------------------
CREATE TABLE dart_logs (
                           id               BIGSERIAL    PRIMARY KEY,
                           user_id          BIGINT       REFERENCES users(id),
                           share_token      VARCHAR(50)  UNIQUE,
                           start_location   VARCHAR(255),
                           start_lat        DOUBLE PRECISION,
                           start_lng        DOUBLE PRECISION,
                           conditions       JSONB,
                           is_relaxed       BOOLEAN      NOT NULL DEFAULT false,
                           result_place_id  BIGINT       REFERENCES places(id),
                           throw_count      SMALLINT     NOT NULL DEFAULT 1 CHECK (throw_count >= 1),
                           created_at       TIMESTAMPTZ  NOT NULL DEFAULT now(),
                           updated_at       TIMESTAMPTZ  NOT NULL DEFAULT now()
);
CREATE INDEX idx_dart_logs_user ON dart_logs (user_id, created_at DESC);

-- 11. region_stats -----------------------------------------------------
CREATE TABLE region_stats (
                              id            BIGSERIAL   PRIMARY KEY,
                              user_id       BIGINT      NOT NULL REFERENCES users(id),
                              sido_code     VARCHAR(10) NOT NULL,
                              sigungu_code  VARCHAR(10) NOT NULL,
                              visit_count   INT         NOT NULL DEFAULT 0 CHECK (visit_count >= 0),
                              CONSTRAINT uq_region_stats UNIQUE (user_id, sigungu_code)
);
CREATE INDEX idx_region_stats_sido ON region_stats (user_id, sido_code);

-- 12. magazines --------------------------------------------------------
CREATE TABLE magazines (
                           id                BIGSERIAL    PRIMARY KEY,
                           category          VARCHAR(30)  NOT NULL
                               CHECK (category IN ('VILLAGE_STORY','WALKING_GUIDE','SEASONAL','ONSEN_SCIENCE','FOOD')),
                           title             VARCHAR(100) NOT NULL,
                           subtitle          VARCHAR(255),
                           thumbnail_url     VARCHAR(500),
                           hero_image_url    VARCHAR(500),
                           body              TEXT,
                           sido_code         VARCHAR(10),
                           author            VARCHAR(50),
                           photographer      VARCHAR(50),
                           read_minutes      SMALLINT     CHECK (read_minutes > 0),
                           like_count        INT          NOT NULL DEFAULT 0 CHECK (like_count >= 0),
                           published_at      TIMESTAMPTZ,
                           created_at        TIMESTAMPTZ  NOT NULL DEFAULT now(),
                           updated_at        TIMESTAMPTZ  NOT NULL DEFAULT now()
);
CREATE INDEX idx_magazines_published ON magazines (published_at DESC);
CREATE INDEX idx_magazines_popular   ON magazines (like_count DESC);

-- 13. magazine_likes ---------------------------------------------------
CREATE TABLE magazine_likes (
                                id           BIGSERIAL   PRIMARY KEY,
                                magazine_id  BIGINT      NOT NULL REFERENCES magazines(id) ON DELETE CASCADE,
                                user_id      BIGINT      NOT NULL REFERENCES users(id),
                                created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
                                CONSTRAINT uq_magazine_likes UNIQUE (magazine_id, user_id)
);
CREATE INDEX idx_magazine_likes_user ON magazine_likes (user_id);

-- 14. magazine_places --------------------------------------------------
-- 매거진 ↔ 관련 온천 (N:M). sort_order 0 = 대표 온천
CREATE TABLE magazine_places (
                                 id           BIGSERIAL PRIMARY KEY,
                                 magazine_id  BIGINT    NOT NULL REFERENCES magazines(id) ON DELETE CASCADE,
                                 place_id     BIGINT    NOT NULL REFERENCES places(id)    ON DELETE CASCADE,
                                 sort_order   SMALLINT  NOT NULL DEFAULT 0,
                                 CONSTRAINT uq_magazine_places UNIQUE (magazine_id, place_id)
);
CREATE INDEX idx_magazine_places_place ON magazine_places (place_id);