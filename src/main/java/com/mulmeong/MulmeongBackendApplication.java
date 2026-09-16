package com.mulmeong;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.security.autoconfigure.UserDetailsServiceAutoConfiguration;

/** JWT로 직접 인증을 처리하므로 Spring Security의 기본 in-memory UserDetailsService는 끈다. */
@SpringBootApplication(exclude = UserDetailsServiceAutoConfiguration.class)
public class MulmeongBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(MulmeongBackendApplication.class, args);
	}

}
