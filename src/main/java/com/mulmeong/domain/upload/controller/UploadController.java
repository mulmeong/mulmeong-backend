package com.mulmeong.domain.upload.controller;

import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import com.mulmeong.domain.upload.dto.request.PresignRequest;
import com.mulmeong.domain.upload.dto.response.PresignResponse;
import com.mulmeong.domain.upload.service.UploadService;
import lombok.RequiredArgsConstructor;

@RestController @RequestMapping("/api/v1/uploads") @RequiredArgsConstructor
public class UploadController {
    private final UploadService service;
    @PostMapping("/presign")
    public PresignResponse presign(@Valid @RequestBody PresignRequest request) { return service.presign(request); }
}
