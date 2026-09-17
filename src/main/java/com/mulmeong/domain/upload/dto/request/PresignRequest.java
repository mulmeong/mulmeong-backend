package com.mulmeong.domain.upload.dto.request;

import java.util.List;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import com.mulmeong.domain.upload.entity.UploadDomain;

public record PresignRequest(
        @NotNull UploadDomain domain,
        @NotEmpty @Size(max = 5) List<@Valid FileRequest> files) {
    public record FileRequest(@NotNull String contentType, @NotNull Long size) {}
}
