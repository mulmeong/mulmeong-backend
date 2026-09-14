# mulmeong-backend

물멍 — 온천·사우나 웰니스 여행 플랫폼 백엔드 (범위 ①).

## 스택

- Java 21, Spring Boot 4.1.1
- Gradle (Kotlin DSL), Gradle Wrapper 9.7.1
- PostgreSQL 16
- Flyway (스키마 마이그레이션)

## 로컬 실행

```bash
# 1. DB 기동
docker compose up -d

# 2. 앱 실행 (기본 프로파일: local)
./gradlew bootRun

# 3. 확인
curl http://localhost:8080/api/health
```

- 앱: http://localhost:8080
- Swagger UI: http://localhost:8080/swagger-ui.html
- DB: `localhost:5432` / db=`mulmeong` user=`mulmeong` pw=`mulmeong`

## 빌드 / 테스트

```bash
./gradlew build     # 컴파일 + 테스트 (DB 컨테이너가 떠 있어야 함)
```

## 구조

패키지는 기능(도메인)별로 나눕니다. 공통/설정 코드는 `global`, 외부 API 연동은 `external`, 실제 비즈니스 기능은 `domain/<기능명>` 아래에 둡니다.

```
src/main/java/com/mulmeong/
├── global/                # 앱 전역 공통 (특정 기능에 속하지 않음)
│   ├── config/             # JpaConfig, OpenApiConfig ...
│   ├── entity/              # BaseTimeEntity
│   ├── response/            # ApiResponse
│   ├── exception/           # BusinessException, ErrorCode, GlobalExceptionHandler
│   └── controller/           # 헬스체크 등 시스템성 엔드포인트
├── external/               # 외부 API 클라이언트 (TourAPI, 카카오 등) — 기능에 속하지 않음
└── domain/                 # 기능별 패키지. 기능 하나 추가할 때 이 구조를 따름:
    └── <feature>/
        ├── controller/
        ├── dto/
        │   ├── request/     # 요청 DTO (ex. OnsenCreateRequest)
        │   └── response/    # 응답 DTO (ex. OnsenResponse)
        ├── entity/
        ├── repository/
        └── service/

src/main/resources/
├── application.properties         # 공통 설정
├── application-local.properties   # 로컬 DB 접속 정보
└── db/migration/                  # Flyway 마이그레이션 (V1__init.sql)
```

## API

| 메서드 | 경로 | 설명 |
| --- | --- | --- |
| GET | `/api/health` | 헬스체크 |
| POST | `/api/auth/signup` | 회원가입 (AUTH-07, 이메일 인증 없음) |
| GET | `/api/auth/check-email?email=` | 이메일 중복 확인 |
| GET | `/api/auth/check-nickname?nickname=` | 닉네임 중복 확인 |

회원가입 요청 예시:

```json
POST /api/auth/signup
{
  "email": "you@example.com",
  "password": "password1",
  "passwordConfirm": "password1",
  "nickname": "온탕러버"
}
```

## 참고

- 설정 파일 형식은 `.properties`.
- `spring.jpa.hibernate.ddl-auto=validate` — 스키마는 Flyway가 관리하고, 엔티티가 어긋나면 기동 시 에러.
- `V1__init.sql`은 기능명세 4-2의 범위 ① 테이블만 포함. 팜플렛 테이블은 명세에 정의가 없어 추후 추가.
