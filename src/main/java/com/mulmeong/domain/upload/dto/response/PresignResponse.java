package com.mulmeong.domain.upload.dto.response;

import java.util.List;

public record PresignResponse(List<Item> items, int expiresInSeconds) {
    public record Item(String key, String uploadUrl, String fileUrl, String contentType) {
    }
}
