package com.mulmeong.domain.upload.service;

import java.time.Duration;
import java.time.ZonedDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.mulmeong.domain.upload.dto.request.PresignRequest;
import com.mulmeong.domain.upload.dto.response.PresignResponse;
import com.mulmeong.domain.upload.entity.UploadDomain;
import com.mulmeong.global.exception.*;
import lombok.RequiredArgsConstructor;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.PutObjectPresignRequest;

@Service @RequiredArgsConstructor
public class UploadService {
    private static final long MAX_SIZE = 10 * 1024 * 1024;
    private static final Set<String> IMAGE_TYPES = Set.of("image/jpeg", "image/png", "image/webp");
    private final S3Presigner presigner;
    @Value("${app.s3.bucket:}") private String bucket;
    @Value("${app.s3.cloudfront-base-url:}") private String cloudfrontBaseUrl;
    @Value("${app.s3.presign-expiry-seconds:300}") private int expirySeconds;

    public PresignResponse presign(PresignRequest request) {
        if (request.domain() != UploadDomain.REVIEW || request.files().size() > 5) {
            throw new BusinessException(ErrorCode.VALIDATION_FAILED);
        }
        if (bucket.isBlank() || cloudfrontBaseUrl.isBlank()) {
            throw new BusinessException(ErrorCode.INTERNAL_ERROR);
        }
        String prefix = "reviews/" + DateTimeFormatter.ofPattern("yyyy/MM/dd/HH")
                .format(ZonedDateTime.now(ZoneOffset.UTC)) + "/";
        List<PresignResponse.Item> items = request.files().stream().map(file -> createItem(prefix, file)).toList();
        return new PresignResponse(items, expirySeconds);
    }

    private PresignResponse.Item createItem(String prefix, PresignRequest.FileRequest file) {
        if (!IMAGE_TYPES.contains(file.contentType())) throw new BusinessException(ErrorCode.UNSUPPORTED_IMAGE_TYPE);
        if (file.size() == null || file.size() <= 0 || file.size() > MAX_SIZE) throw new BusinessException(ErrorCode.IMAGE_TOO_LARGE);
        String extension = file.contentType().substring(file.contentType().indexOf('/') + 1).replace("jpeg", "jpg");
        String key = prefix + UUID.randomUUID() + "." + extension;
        PutObjectRequest object = PutObjectRequest.builder().bucket(bucket).key(key).contentType(file.contentType()).contentLength(file.size()).build();
        String uploadUrl = presigner.presignPutObject(PutObjectPresignRequest.builder().signatureDuration(Duration.ofSeconds(expirySeconds)).putObjectRequest(object).build()).url().toString();
        return new PresignResponse.Item(key, uploadUrl, cloudfrontBaseUrl.replaceAll("/$", "") + "/" + key, file.contentType());
    }
}
