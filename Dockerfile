# ===== 1단계: 빌드 =====
# Java 21 JDK 이미지에서 시작 (빌드용 주방)
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

# Gradle Wrapper 먼저 복사 (프로젝트에 있는 9.7.1을 그대로 사용)
COPY gradlew .
COPY gradle gradle

# 빌드 설정 파일 복사 (소스보다 먼저 복사해야 의존성 캐시가 유지됨)
COPY build.gradle.kts settings.gradle.kts ./

# gradlew 실행 권한 부여 (윈도우에서 커밋되면 권한이 빠지는 경우 대비)
RUN chmod +x gradlew

# 의존성만 미리 내려받음 — 소스만 바뀐 다음 빌드가 빨라짐
RUN ./gradlew dependencies --no-daemon || true

# 소스 복사
COPY src src

# 실행 가능한 jar 굽기
# -x test: 테스트 스킵 (테스트는 DB 컨테이너가 필요해서 빌드 단계에선 못 돌림)
RUN ./gradlew bootJar --no-daemon -x test


# ===== 2단계: 실행 =====
# 실행기(JRE)만 있는 가벼운 이미지 (배달용 도시락)
FROM eclipse-temurin:21-jre

WORKDIR /app

# 1단계에서 구운 jar만 가져옴 (-plain.jar는 실행 불가라 제외되도록 패턴 지정)
COPY --from=builder /app/build/libs/*-SNAPSHOT.jar app.jar

# Spring Boot 포트 (문서용 표시)
EXPOSE 8080

# 타임존을 한국으로 (로그 시간이 UTC로 찍히는 것 방지)
ENV TZ=Asia/Seoul

# 컨테이너 시작 시 실행
# -Xmx512m: 자바 최대 메모리 512MB 제한 (EC2 메모리 보호)
ENTRYPOINT ["java", "-Xmx512m", "-jar", "app.jar"]
