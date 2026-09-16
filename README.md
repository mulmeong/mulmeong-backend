# mulmeong-backend

물멍 — 온천·사우나 웰니스 여행 플랫폼 백엔드 (범위 ①).

## 스택

- Java 21, Spring Boot 4.1.1
- Gradle (Kotlin DSL), Gradle Wrapper 9.7.1
- PostgreSQL 16, Redis 7
- Flyway (스키마 마이그레이션)
- Spring Security + JWT (access/refresh 회전)

## 로컬 실행

```bash
# 1. DB + Redis 기동 (bootRun 시 spring-boot-docker-compose가 자동으로 띄워주기도 함)
docker compose up -d

# 2. 앱 실행 (기본 프로파일: local)
./gradlew bootRun

# 3. 확인
curl http://localhost:8080/api/health
```

- 앱: http://localhost:8080
- Swagger UI: http://localhost:8080/swagger-ui.html
- Postgres: `localhost:5432` / db=`mulmeong` user=`mulmeong` pw=`mulmeong`
- Redis: `localhost:6379`

로컬 Postgres 포트는 **5432 고정**입니다. 다른 로컬 Postgres(예: Postgres.app)가 이미 5432를 쓰고 있으면 그쪽을 내리고 사용하세요 — 포트를 바꿔서 우회하지 않습니다.

## 빌드 / 테스트

```bash
./gradlew build          # 컴파일 + 유닛 테스트
./gradlew test           # 유닛 + 통합 테스트 (Testcontainers가 Postgres/Redis를 자동으로 띄움 — Docker 필요)
```

## 프로필

| 프로필 | 용도 | DB/Redis | 쿠키 Secure |
| --- | --- | --- | --- |
| `local` (기본) | 로컬 개발 | compose.yaml (localhost 고정값) | false |
| `prod` | 배포 | 환경변수(`DB_URL`/`DB_USERNAME`/`DB_PASSWORD`/`REDIS_HOST`/`REDIS_PORT`) | true |

`prod`는 `JWT_SECRET`, `CORS_ALLOWED_ORIGINS`도 환경변수로 받습니다. 파일에 실제 값을 적지 않습니다.

## 구조

패키지는 기능(도메인)별로 나눕니다. 공통 코드는 `global`, 외부 API 연동은 `external`, 실제 비즈니스 기능은 `domain/<도메인>` 아래에 둡니다. **다른 도메인의 Repository를 직접 주입하지 않고, 그 도메인의 Service를 통해서만 접근합니다.**

```
src/main/java/com/mulmeong/
├── global/
│   ├── config/          # SecurityConfig, JpaConfig, OpenApiConfig ...
│   ├── exception/        # ErrorCode, BusinessException, ErrorResponse, GlobalExceptionHandler
│   ├── security/          # JwtAuthenticationFilter, RestAuthenticationEntryPoint, RestAccessDeniedHandler
│   ├── common/             # BaseTimeEntity, Level enum
│   ├── util/                # RandomTokenGenerator (base62)
│   └── controller/            # 헬스체크 등 시스템성 엔드포인트
├── external/               # 외부 API 클라이언트: kakao/, tourapi/
└── domain/
    ├── auth/               # 로그인 · 재발급 · 로그아웃 · JWT 발급
    │   ├── controller/ service/ dto/{request,response}/ jwt/
    ├── user/               # 회원가입 · 회원 정보
    │   ├── controller/ service/ repository/ entity/ dto/{request,response}/
    └── (place, review, favorite, pamphlet, dart, region, magazine)  # 앞으로 추가될 도메인

src/main/resources/
├── application.properties        # 공통 설정
├── application-local.properties  # 로컬 프로필
├── application-prod.properties   # 배포 프로필 (전부 환경변수)
└── db/migration/                 # Flyway 마이그레이션 (docs/mulmung_schema_final.sql 그대로)
```

## API (범위 ① 회원가입/인증)

| 메서드 | 경로 | 인증 | 설명 |
| --- | --- | --- | --- |
| POST | `/api/v1/auth/signup` | 없음 | 회원가입. 닉네임은 서버가 자동 생성(`물멍러####`) |
| GET | `/api/v1/auth/email/check?email=` | 없음 | 이메일 중복 확인 (중복이어도 200 + `available:false`) |
| POST | `/api/v1/auth/login` | 없음 | 로그인. accessToken은 응답 바디, refreshToken은 HttpOnly 쿠키 |
| POST | `/api/v1/auth/reissue` | 쿠키 | 토큰 재발급 (Rotation). 이미 쓴 토큰 재사용 시 해당 유저의 모든 세션 폐기 |
| POST | `/api/v1/auth/logout` | 필수(Bearer) | 로그아웃. 이미 로그아웃 상태여도 204 |
| GET | `/api/health` | 없음 | 헬스체크 |

회원가입 요청 예시:

```json
POST /api/v1/auth/signup
{
  "email": "you@example.com",
  "password": "password1",
  "passwordConfirm": "password1",
  "name": "김온천",
  "birthDate": "1995-05-05",
  "phone": "010-1234-5678"
}
```

에러 응답은 항상 `{ "code": "DUPLICATE_EMAIL", "message": "...", "fieldErrors": [...] }` 형식입니다.

## 참고

- 설정 파일 형식은 `.properties`.
- `spring.jpa.hibernate.ddl-auto=validate` — 스키마는 Flyway가 관리하고, 엔티티가 어긋나면 기동 시 에러.
- `db/migration/V1__init_schema.sql`은 `docs/mulmung_schema_final.sql`을 그대로 옮긴 파일(15개 테이블, 범위 ①). 이 파일은 임의로 수정하지 않고, 변경이 필요하면 `V2__설명.sql`을 새로 추가.
- Refresh Token은 JWT면서 원문의 SHA-256 해시를 Redis에 저장(`rt:{hash}` → userId, `rt-user:{userId}` → 해시 Set)해 유효성을 관리. 재사용 탐지 시 해당 유저의 모든 세션을 폐기.
- 106/107(비밀번호 재설정)은 이번 범위 밖 — `password_reset_tokens` 엔티티만 미리 만들어 둠.
