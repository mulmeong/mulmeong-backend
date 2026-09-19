package com.mulmeong.domain.region.entity;

import java.util.Arrays;
import java.util.Optional;

/**
 * 행정표준코드 시·도 17개 고정 목록 (포도알 지도 702의 0방문 지역 채우기용).
 * region_stats에 없는 지역도 여기 기준으로 0건 항목을 만들어 내려준다.
 */
public enum Sido {
    SEOUL("11", "서울특별시"),
    BUSAN("26", "부산광역시"),
    DAEGU("27", "대구광역시"),
    INCHEON("28", "인천광역시"),
    GWANGJU("29", "광주광역시"),
    DAEJEON("30", "대전광역시"),
    ULSAN("31", "울산광역시"),
    SEJONG("36", "세종특별자치시"),
    GYEONGGI("41", "경기도"),
    GANGWON("51", "강원특별자치도"),
    CHUNGBUK("43", "충청북도"),
    CHUNGNAM("44", "충청남도"),
    JEONBUK("52", "전북특별자치도"),
    JEONNAM("46", "전라남도"),
    GYEONGBUK("47", "경상북도"),
    GYEONGNAM("48", "경상남도"),
    JEJU("50", "제주특별자치도");

    private final String code;
    private final String displayName;

    Sido(String code, String displayName) {
        this.code = code;
        this.displayName = displayName;
    }

    public String code() {
        return code;
    }

    public String displayName() {
        return displayName;
    }

    public static Optional<Sido> byCode(String code) {
        return Arrays.stream(values()).filter(s -> s.code.equals(code)).findFirst();
    }
}
