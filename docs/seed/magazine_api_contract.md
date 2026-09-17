# 준에게 — 시드 SQL 2개 + 매거진 API 계약

작성 2026-09-17 · 명진

---

## 🚨 먼저 — **시드는 이미 RDS에 들어가 있습니다**

오늘 오후에 제가 운영 RDS(`mulmeong`)에 직접 넣었습니다.

```
places           524건
magazines        243건
magazine_places  238건
hero_image_url   243건 (CloudFront 주소)
```

**그러니까 운영 DB에 다시 넣을 필요 없습니다.** 첨부한 SQL은 두 용도입니다.

1. **로컬 개발 DB에 넣을 때** — 이게 주 용도
2. 내용 확인 / 나중에 재적재

두 파일 다 `ON CONFLICT` 로 짜여 있어서 **다시 돌려도 중복이 안 생깁니다.** 실수로 운영에 한 번 더 돌려도 사고는 안 납니다.

### 적재 순서 (지켜야 함)

```bash
psql -v ON_ERROR_STOP=1 -f places_seed.sql      # 1) 온천 먼저
psql -v ON_ERROR_STOP=1 -f magazines_seed.sql   # 2) magazine_places가 places를 참조
```

로컬 PostgreSQL 16에 팀 DDL 그대로 적용해서 검증한 상태입니다. 두 번 돌려도 243편 그대로였습니다.

---

## stations V2 마이그레이션

직접 하신다니 SQL만 드립니다.

```sql
-- V2__add_terminal_station_type.sql
ALTER TABLE stations DROP CONSTRAINT stations_station_type_check;
ALTER TABLE stations ADD CONSTRAINT stations_station_type_check
    CHECK (station_type IN ('KTX', 'TRAIN', 'TERMINAL'));
```

> V1을 고치지 않고 V2로 가는 게 맞습니다. 9/16에 V1 수정했다가 체크섬 불일치로 배포 실패한 적 있어서요.

---

## 매거진 API — 프론트가 기대하는 계약

**프론트에 타입이 이미 다 정의돼 있습니다.** (`src/types/magazine.ts`) 제가 지어낸 게 아니라 거기서 그대로 옮긴 겁니다. 이대로 맞추면 연결할 때 한 번에 붙습니다.

### 엔드포인트 3개

| 메서드 | 경로 | 인증 |
|---|---|---|
| GET | `/api/v1/magazines` | 불필요 (토큰 있으면 `isLiked` 채움) |
| GET | `/api/v1/magazines/{id}` | 동일 |
| POST / DELETE | `/api/v1/magazines/{id}/like` | 필요 |

> ⚠️ 프론트는 지금 `/magazines` 로 부릅니다. `/api/v1` 접두사는 프론트가 `VITE_API_BASE_URL` 로 붙이기로 정리했습니다. **백엔드는 `/api/v1/magazines` 로 만들면 됩니다.**

### 목록 — 요청 파라미터

```
category   VILLAGE_STORY | WALKING_GUIDE | SEASONAL | ONSEN_SCIENCE | FOOD | ALL
sidoCode   문자열, 선택
sort       LATEST | POPULAR | READ_TIME     (기본 LATEST)
featured   boolean                           (기본 false)
page       number                            (기본 0)
size       number                            (기본 12, featured면 5, 최대 30)
```

### 목록 — 응답

```json
{
  "content": [ /* Magazine */ ],
  "page": 0,
  "size": 12,
  "totalElements": 243,
  "totalPages": 21,
  "last": false,
  "categories": [{ "code": "FOOD", "label": "먹거리", "count": 60 }],
  "regions": [{ "sidoCode": "47", "name": "경북", "count": 64 }]
}
```

`categories` / `regions` 는 **null 허용**입니다. 필터 칩에 개수를 띄우는 용도라 1차에선 null로 보내도 화면은 돕니다.

### Magazine 객체

```ts
{
  magazineId: number        // ⚠️ id 아니고 magazineId
  category: string          // VILLAGE_STORY 등
  categoryLabel: string     // "온천마을 이야기"
  title: string
  subtitle: string | null
  thumbnailUrl: string | null
  heroImageUrl: string | null
  sidoCode: string | null
  regionName: string        // "충북" — null 아님
  readMinutes: number
  likeCount: number
  isLiked: boolean
  publishedAt: string
}
```

### 상세 — 위에 더해서

```ts
{
  author: string            // ⚠️ null 아님
  photographer: string | null
  body: string
  bodyFormat: "MULMUNG_TEXT"
  relatedPlaces: MagazinePlace[]
  next: { magazineId, title, categoryLabel, readMinutes } | null
  shareUrl: string
}

MagazinePlace = {
  placeId: number
  name: string
  thumbnail: string | null
  sido: string
  sigungu: string
  lat: number
  lng: number
  subText: string | null
  accessSummary: string | null
}
```

---

## ⚠️ DB에 없어서 백엔드가 만들어줘야 하는 것

시드가 채운 컬럼은 이것뿐입니다:

```
category, title, subtitle, thumbnail_url, hero_image_url,
body, sido_code, read_minutes, published_at
```

**나머지는 비어 있습니다.** 프론트 타입과 대조하면 이렇습니다.

| 프론트가 기대 | DB 상태 | 어떻게 채울지 |
|---|---|---|
| `magazineId` | 컬럼명은 `id` | 응답에서 이름만 바꿔주면 됨 |
| `categoryLabel` | 없음 | enum → 한글 라벨 매핑 (아래 표) |
| `regionName` | `sido_code` 만 있음 | 코드 → 이름 매핑 (아래 표) |
| `likeCount` | `like_count` = **전부 0** | 그대로 0 나감. 정상 |
| `isLiked` | `magazine_likes` 조인 | 비로그인이면 false |
| **`author`** | **전건 NULL** | 🔴 타입이 non-null인데 DB가 null. **아래 참고** |
| `photographer` | 전건 NULL | null 허용이라 괜찮음 |
| `shareUrl` | 없음 | 서버에서 조합 (`https://mulmeong.space/magazine/{id}`) |
| `next` | 없음 | 같은 카테고리 다음 글 or id+1 |
| `relatedPlaces` | `magazine_places` 조인 | 아래 참고 |

### 🔴 `author` 처리 — 결정 필요

프론트 타입은 `author: string` (**null 불가**)인데 DB는 전건 null입니다. 그대로 내보내면 프론트에서 터질 수 있습니다.

선택지:
- **(a) 백엔드에서 기본값** — `author ?? "물멍 에디터"` ← 제일 빠름, 추천
- (b) DB에 UPDATE로 일괄 채움 — 말씀하시면 SQL 드립니다
- (c) 프론트 타입을 nullable로 — 소희랑 협의 필요

### `relatedPlaces` 주의

`magazine_places` 로 조인하면 됩니다(238건 연결돼 있음). 다만:

- **`thumbnail` 은 항상 null 입니다** — `place_images` 테이블이 비어 있습니다
- **`lat`/`lng` 가 없는 온천이 많습니다** — 524건 중 좌표 있는 건 92건뿐. 타입은 non-null이라 **좌표 없는 온천은 `relatedPlaces` 에서 빼는 편**이 안전합니다
- `subText` / `accessSummary` 는 `region_comment`, `access_level` 로 만들면 됩니다

---

## 매핑표 2개

### 카테고리

| enum | 라벨 | 건수 |
|---|---|---|
| `VILLAGE_STORY` | 온천마을 이야기 | 60 |
| `WALKING_GUIDE` | 뚜벅이 가이드 | 60 |
| `FOOD` | 먹거리 | 60 |
| `SEASONAL` | 시즌 추천 | 40 |
| `ONSEN_SCIENCE` | 온천 과학 | 23 |

### sido_code (행정표준코드 2자리)

| 코드 | 지역 | 건수 |
|---|---|---|
| 47 | 경북 | 64 |
| 48 | 경남 | 36 |
| 51 | 강원 | 24 |
| 26 | 부산 | 21 |
| 44 | 충남 | 18 |
| 41 | 경기 | 18 |
| 46 | 전남 | 15 |
| 43 | 충북 | 9 |
| 30 | 대전 | 8 |
| 31 | 울산 | 6 |
| 27 | 대구 | 6 |
| 29 | 광주 | 2 |
| 52 | 전북 | 1 |
| 11 | 서울 | 1 |
| (null) | 전국 기사 | 14 |

> `sido_code` 는 **행정표준코드**로 넣었습니다. `places.sido_code` 도 같은 체계입니다.
> `sigungu_code` 는 아직 전건 null입니다 — 통계청/법정동 중 뭘 쓸지 정해지면 채우겠습니다.

---

## body 형식 — `MULMUNG_TEXT`

본문이 그냥 텍스트가 아니라 마커가 섞여 있습니다. **문단은 `\n\n` 로 구분**되고, 문단 맨 앞에 마커가 올 수 있습니다.

```
[IMG]수안보 물탕공원 족욕탕에서 김이 오르는 이른 아침. ⓒ 물멍
[QUOTE]땅을 파서 만든 온천이 아니라 스스로 솟은 물이다.
[TIP]족욕탕은 무료, 수건은 없으니 챙겨갈 것
```

**백엔드는 파싱하지 말고 원문 그대로 내려주세요.** 렌더링은 프론트가 합니다 (`bodyFormat: "MULMUNG_TEXT"` 로 알려주는 이유). 소희한테 이 규약 전달돼야 합니다.

> `[IMG]` 자리에 넣을 사진은 없습니다. 기사당 히어로 이미지 1장뿐이라, 캡션만 쓰거나 해당 문단을 건너뛰는 쪽으로 프론트에서 처리하면 됩니다.

---

## 마지막 — 사진 출처 표기

매거진 사진은 **한국관광공사 TourAPI**에서 가져왔습니다. 공공누리 조건상 **화면에 `ⓒ 한국관광공사` 표기가 필수**입니다. 공모전 심사에서 걸릴 수 있는 부분이라 프론트에 꼭 전달돼야 합니다.
