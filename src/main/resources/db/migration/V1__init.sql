-- Mulmeong initial schema (scope ①).
-- Mirrors the tables listed in the feature spec section 4-2 that are in scope ①.
-- Tables for scope ②/③ (diaries, reports, biz_claims) are intentionally omitted.
-- NOTE: the spec's 4-2 has no pamphlet table even though PAM-08 / MY-12 are scope ① —
--       that gap is tracked separately and not guessed at here.

-- ---------------------------------------------------------------------------
-- users  (AUTH-01/03/06/07)
-- ---------------------------------------------------------------------------
CREATE TABLE users (
    id                  BIGSERIAL PRIMARY KEY,
    email               VARCHAR(255) NOT NULL UNIQUE,
    password            VARCHAR(255),                              -- null for social-only accounts (AUTH-04, scope ②)
    nickname            VARCHAR(50)  NOT NULL UNIQUE,
    nickname_changed_at TIMESTAMPTZ,
    name                VARCHAR(50),                               -- AUTH-07
    birth_date          DATE,                                      -- AUTH-07
    phone               VARCHAR(20),                               -- AUTH-07
    provider            VARCHAR(20)  NOT NULL DEFAULT 'local',     -- local / google / naver / kakao
    role                VARCHAR(20)  NOT NULL DEFAULT 'user',      -- user / biz / admin
    created_at          TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- ---------------------------------------------------------------------------
-- onsen  (MAP-*, PAM-*, DART-*)
-- ---------------------------------------------------------------------------
CREATE TABLE onsen (
    id                BIGSERIAL PRIMARY KEY,
    name              VARCHAR(255) NOT NULL,
    grade             VARCHAR(20),                                 -- 온천 등급
    is_registered     BOOLEAN      NOT NULL DEFAULT TRUE,          -- 온천 신고/등록 여부
    sido              VARCHAR(50),
    sigungu           VARCHAR(50),
    address           VARCHAR(500),
    lat               DOUBLE PRECISION,
    lng               DOUBLE PRECISION,
    water_temp        NUMERIC(4, 1),
    water_type        VARCHAR(100),
    water_benefit     TEXT,
    annual_visitors   INTEGER,
    has_outdoor       BOOLEAN      NOT NULL DEFAULT FALSE,         -- 노천 여부
    has_lodging       BOOLEAN      NOT NULL DEFAULT FALSE,         -- 숙박 가능 여부
    facility_type     VARCHAR(50),
    price_min         INTEGER,
    phone             VARCHAR(30),
    hours             VARCHAR(255),
    images            TEXT[]       NOT NULL DEFAULT '{}',
    access_level      VARCHAR(20),                                 -- 뚜벅이 / 자차 (PAM-03)
    nearest_station   VARCHAR(255),                                -- 거점역 (PAM-02, 수기)
    station_to_onsen  TEXT,                                        -- 거점역 -> 온천 이동 안내 (수기)
    region_comment    TEXT,                                        -- 온천마을 코멘트 (팀 수기)
    created_at        TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at        TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE INDEX idx_onsen_sido_sigungu ON onsen (sido, sigungu);
CREATE INDEX idx_onsen_lat_lng ON onsen (lat, lng);

-- ---------------------------------------------------------------------------
-- reviews  (REV-*)  — a review is the visit-verification record
-- ---------------------------------------------------------------------------
CREATE TABLE reviews (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT   NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    onsen_id        BIGINT   NOT NULL REFERENCES onsen (id) ON DELETE CASCADE,
    rating          SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),   -- 전체 만족도
    spec_temp       SMALLINT CHECK (spec_temp    BETWEEN 1 AND 5),
    spec_cold       SMALLINT CHECK (spec_cold    BETWEEN 1 AND 5),
    spec_outdoor    SMALLINT CHECK (spec_outdoor BETWEEN 1 AND 5),
    spec_clean      SMALLINT CHECK (spec_clean   BETWEEN 1 AND 5),      -- 청결도
    spec_crowd      SMALLINT CHECK (spec_crowd   BETWEEN 1 AND 5),      -- 혼잡도
    spec_visit_time VARCHAR(20),                                        -- 방문 시간대
    body            TEXT,                                               -- REV-02: 글은 선택
    images          TEXT[]   NOT NULL DEFAULT '{}',                     -- REV-04: 최대 5장 (앱에서 검증)
    is_public       BOOLEAN  NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_reviews_user  ON reviews (user_id);
CREATE INDEX idx_reviews_onsen ON reviews (onsen_id);
-- REV-06 (같은 온천 재리뷰 일 1회 제한) is enforced in the service layer.

-- ---------------------------------------------------------------------------
-- favorites  (PAM-07, MAP-02, MY-06)
-- ---------------------------------------------------------------------------
CREATE TABLE favorites (
    id         BIGSERIAL PRIMARY KEY,
    user_id    BIGINT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    onsen_id   BIGINT NOT NULL REFERENCES onsen (id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (user_id, onsen_id)
);

-- ---------------------------------------------------------------------------
-- dart_logs  (DART-03/04, ADM-05)
-- ---------------------------------------------------------------------------
CREATE TABLE dart_logs (
    id         BIGSERIAL PRIMARY KEY,
    user_id    BIGINT REFERENCES users (id) ON DELETE SET NULL,     -- nullable: 비로그인 다트 허용 (AUTH-02)
    conditions JSONB  NOT NULL DEFAULT '{}',                        -- 출발지 / 이동수단 / 소요시간 등
    onsen_id   BIGINT REFERENCES onsen (id) ON DELETE SET NULL,     -- 추첨 결과
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ---------------------------------------------------------------------------
-- badges  (REV-03 성장 요소, MY-14 도감의 데이터 소스)
-- ---------------------------------------------------------------------------
CREATE TABLE badges (
    id        BIGSERIAL PRIMARY KEY,
    user_id   BIGINT      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    type      VARCHAR(50) NOT NULL,
    meta      JSONB       NOT NULL DEFAULT '{}',
    earned_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (user_id, type)
);

-- ---------------------------------------------------------------------------
-- region_stats  (MY-02 포도알 지도, MY-09 시군구 확대)
-- ---------------------------------------------------------------------------
CREATE TABLE region_stats (
    user_id     BIGINT      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    region_code VARCHAR(10) NOT NULL,                              -- 시도 -> 시군구 확장
    visit_count INTEGER     NOT NULL DEFAULT 0,
    PRIMARY KEY (user_id, region_code)
);

-- ---------------------------------------------------------------------------
-- magazines  (MAG-*)
-- ---------------------------------------------------------------------------
CREATE TABLE magazines (
    id            BIGSERIAL PRIMARY KEY,
    category      VARCHAR(50)  NOT NULL,                           -- 온천마을 이야기 / 뚜벅이 가이드 / 시즌 추천 / 온천 과학 / 먹거리
    title         VARCHAR(255) NOT NULL,
    thumbnail     VARCHAR(500),
    body          TEXT         NOT NULL,
    region_code   VARCHAR(10),
    related_onsen BIGINT[]     NOT NULL DEFAULT '{}',              -- 관련 온천 카드 연결 (MAG-03)
    status        VARCHAR(20)  NOT NULL DEFAULT 'draft',           -- draft / published
    like_count    INTEGER      NOT NULL DEFAULT 0,                 -- MAG-04 (denormalised counter)
    published_at  TIMESTAMPTZ,
    created_at    TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE INDEX idx_magazines_status_published ON magazines (status, published_at DESC);

-- magazine_likes  (MAG-04: 좋아요 토글 + 인기 피드 선별)
CREATE TABLE magazine_likes (
    magazine_id BIGINT NOT NULL REFERENCES magazines (id) ON DELETE CASCADE,
    user_id     BIGINT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (magazine_id, user_id)
);
