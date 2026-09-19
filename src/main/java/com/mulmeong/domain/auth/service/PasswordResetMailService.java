package com.mulmeong.domain.auth.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class PasswordResetMailService {

    private final ObjectProvider<JavaMailSender> mailSenderProvider;

    @Value("${app.password-reset.frontend-url:http://localhost:5173}")
    private String frontendUrl;

    @Value("${spring.mail.username:}")
    private String from;

    @Async
    public void send(String email, String token) {
        JavaMailSender mailSender = mailSenderProvider.getIfAvailable();
        if (mailSender == null) {
            // 개발 환경에서 SMTP를 설정하지 않아도 인증 API 전체가 시작 가능해야 한다.
            log.error("Password reset mail was not sent because SMTP is not configured");
            return;
        }
        String resetUrl = frontendUrl.replaceAll("/+$", "") + "/reset-password?token=" + token;
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        if (!from.isBlank()) {
            message.setFrom(from);
        }
        message.setSubject("[물멍] 비밀번호 재설정 안내");
        message.setText("비밀번호를 재설정하려면 아래 링크를 열어주세요.\n\n"
                + resetUrl + "\n\n링크는 30분 동안 한 번만 사용할 수 있습니다.");
        try {
            mailSender.send(message);
        } catch (Exception e) {
            // 요청 응답은 계정 존재 여부와 메일 전송 성공 여부를 노출하지 않는다.
            log.error("Password reset mail delivery failed", e);
        }
    }
}
