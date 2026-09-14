package com.mulmeong.global.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI mulmeongOpenApi() {
        return new OpenAPI().info(new Info()
                .title("물멍 API")
                .description("온천·사우나 웰니스 여행 플랫폼 백엔드 API")
                .version("v0"));
    }
}
