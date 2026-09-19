package com.mulmeong.domain.upload.controller;

import com.mulmeong.domain.upload.dto.request.PresignRequest;
import com.mulmeong.domain.upload.dto.response.PresignResponse;
import com.mulmeong.domain.upload.service.UploadService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/uploads")
@RequiredArgsConstructor
public class UploadController {
    private final UploadService service;

    @PostMapping("/presign")
    public PresignResponse presign(@Valid @RequestBody PresignRequest request) {
        return service.presign(request);
    }
}
