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

```
src/main/java/com/mulmeong/
├── config/       # 스프링 설정 (JPA 등)
├── common/       # 공통: BaseTimeEntity, ApiResponse, 예외 처리
├── controller/   # REST 컨트롤러
├── service/      # 비즈니스 로직
├── repository/   # 데이터 접근
├── dto/          # 요청/응답 DTO
├── entity/       # JPA 엔티티
└── external/     # 외부 API 클라이언트 (TourAPI, 카카오 등)

src/main/resources/
├── application.properties         # 공통 설정
├── application-local.properties   # 로컬 DB 접속 정보
└── db/migration/                  # Flyway 마이그레이션 (V1__init.sql)
```

## 참고

- 설정 파일 형식은 `.properties`.
- `spring.jpa.hibernate.ddl-auto=validate` — 스키마는 Flyway가 관리하고, 엔티티가 어긋나면 기동 시 에러.
- `V1__init.sql`은 기능명세 4-2의 범위 ① 테이블만 포함. 팜플렛 테이블은 명세에 정의가 없어 추후 추가.
