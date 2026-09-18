# 물멍 프로젝트 메모

이 문서는 API 작업을 시작할 때 먼저 확인하는 프로젝트 운영 메모다.

## 저장소·이미지 인프라

- 대상: 매거진 사진과 리뷰 사진
- S3 버킷: `mulmeong-uploads` (서울, `ap-northeast-2`)
- CloudFront 배포: `mulmeong-cdn`
- CDN base URL: `https://dljh8zx4kwdv3.cloudfront.net`
- S3 퍼블릭 접근: 차단 유지. S3 URL 직접 읽기는 403이어야 한다.
- 읽기 권한: CloudFront OAC만 허용
- 쓰기 권한: 로그인 사용자를 위해 발급한 presigned PUT URL만 허용
- WAF: 없음 (읽기 전용 CDN)

### 키 구조

```text
mulmeong-uploads/
├─ magazines/   # 001.jpg ~ 243.jpg
└─ reviews/     # 리뷰 업로드
```

DB의 매거진 `hero_image_url` / `thumbnail_url`에는 CloudFront URL을 저장한다.

예시:

```text
https://dljh8zx4kwdv3.cloudfront.net/magazines/001.jpg
```

매거진 이미지 화면에는 공공누리 출처 표기인 `ⓒ 한국관광공사`를 표시해야 한다.

## 리뷰 이미지 업로드 계약

`POST /api/v1/uploads/presign` (로그인 필요)

요청:

```json
{
  "domain": "REVIEW",
  "files": [
    { "contentType": "image/jpeg", "size": 2148000 }
  ]
}
```

응답에는 `key`, 5분짜리 `uploadUrl`, 영구 저장할 `fileUrl`, `contentType`이 들어간다.

제약:

- 허용 형식: `image/jpeg`, `image/png`, `image/webp`
- 파일당 최대 10MB
- 최대 5장
- `expiresInSeconds`: 300
- `uploadUrl`은 DB에 저장하지 않는다. 리뷰 저장 시 `fileUrl`만 `review_images.image_url`에 저장한다.

프론트 업로드 시 S3 PUT 헤더는 `Content-Type`만 보낸다. 공통 Authorization 인터셉터가 presigned URL 요청에 붙지 않도록 주의한다.

에러 계약:

| code | status | 의미 |
| --- | --- | --- |
| `UNAUTHORIZED` | 401 | 토큰 없음/만료 |
| `UNSUPPORTED_IMAGE_TYPE` | 400 | jpeg/png/webp 외 형식 |
| `IMAGE_TOO_LARGE` | 400 | 10MB 초과 |
| `VALIDATION_FAILED` | 400 | 6장 이상 또는 입력 오류 |

## 운영 환경 설정

EC2 `~/app/.env`에는 다음 리소스 설정을 주입한다.

```bash
S3_BUCKET=mulmeong-uploads
S3_PUBLIC_BASE_URL=https://dljh8zx4kwdv3.cloudfront.net
```

끝에 `/`를 붙이지 않는다. AWS 액세스 키는 넣지 않으며 EC2 IAM 역할 `mulmeong-ec2-role`을 사용한다.
현재 저장소의 Spring 설정도 위 두 환경변수(`S3_BUCKET`, `S3_PUBLIC_BASE_URL`)를 `app.s3.*`로 매핑한다.

확인:

1. S3 `magazines/001.jpg` 직접 접근은 403
2. CloudFront `magazines/001.jpg` 접근은 200/이미지
3. 토큰 없이 presign 호출은 401

## 배포 메모

- 현재 배포 파이프라인은 메인 브랜치에 머지되면 자동으로 최신 커밋을 배포한다.
- 따라서 기능 구현 후 메인 머지 시 운영 배포가 갱신된다.
- 리뷰 이미지 업로드는 인프라만 구축되어 있고, 리뷰 저장 API와 프론트 연결까지 완료되어야 실제 동작한다.
- 운영 후 정리: 로컬 개발용 IAM 사용자 삭제, S3 CORS AllowedOrigins를 실제 도메인으로 제한.

## 미확인 작업

- EC2 IAM 역할의 `s3:PutObject` 권한 확인 필요
- Notion 원문에서 501~507 API 명세를 확인해야 구현 가능

## API 501~507 구현 메모

Notion 명세를 읽기 전용으로 확인했다. 원문은 `물멍 API 명세서`의 찜·팜플렛 영역이다.

| No. | Method | Path | 인증 | 성공 |
| --- | --- | --- | --- | --- |
| 501 | POST | `/api/v1/favorites` | 필수 | 201 (중복은 200) |
| 502 | GET | `/api/v1/favorites` | 필수 | 200 |
| 503 | DELETE | `/api/v1/favorites/{placeId}` | 필수 | 204 |
| 504 | POST | `/api/v1/pamphlets` | 필수 | 201 |
| 505 | GET | `/api/v1/pamphlets/share/{shareToken}` | 없음 | 200 |
| 506 | GET | `/api/v1/pamphlets` | 필수 | 200 |
| 507 | DELETE | `/api/v1/pamphlets/{pamphletId}` | 소유자 | 204 |

501은 내부 장소면 `placeId`만 받고, 외부 장소면 `source`, `externalId`, `name`, `lat`, `lng`, `category`를 받아 `(source, externalId)` upsert한다. 찜 최대 300개, 해제는 토글이 아닌 별도 DELETE다.

504는 title 1~50자, placeIds 1~20개(중복 금지), partySize 1~20을 검증하고 `pamphlets`와 `pamphlet_places`를 한 트랜잭션으로 저장한다. shareToken은 base62 8자다.

505는 비로그인 공개 조회이며 삭제된 팜플렛은 404다. 본인에게만 `pamphletId`와 `isMine`을 노출한다. 506은 createdAt 내림차순, 기본 12건/최대 50건이다. 507은 소유자만 삭제하며 `pamphlet_places`만 CASCADE되고 장소·찜은 유지한다.
