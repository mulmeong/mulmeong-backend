package com.mulmeong.global.util;

import java.security.SecureRandom;

/**
 * Base62 random tokens for share links (shareToken, profileShareToken, ...) — no PK exposed.
 */
public final class RandomTokenGenerator {

    private static final String ALPHABET = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    private static final SecureRandom RANDOM = new SecureRandom();

    private RandomTokenGenerator() {
    }

    public static String generate(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(ALPHABET.charAt(RANDOM.nextInt(ALPHABET.length())));
        }
        return sb.toString();
    }
}
