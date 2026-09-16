package com.mulmeong.domain.auth.service;

import com.mulmeong.domain.auth.dto.response.UserSummary;

public record LoginOutcome(TokenPair tokens, UserSummary user) {
}
