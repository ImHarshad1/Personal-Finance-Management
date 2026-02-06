package com.pfm.serviceimpl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.pfm.repo.UserRepo;
import com.pfm.service.EmailService;
import com.pfm.service.util.HtmlEmailUtil;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailServiceImpl implements EmailService {
	
	@Autowired
	private UserRepo userRepo;
	
	@Autowired
	private JavaMailSender javaMailSender;

	@Autowired
	private HtmlEmailUtil htmlEmailUtil;

	public void sendWelcomeMail(String toEmail, String subject, String username) throws MessagingException {

		String htmlContent = """
				<!DOCTYPE html>
				<html>
				<head>
				    <meta charset="UTF-8">
				    <style>
				        body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }
				        .container { background: white; padding: 20px; border-radius: 10px; }
				        h1 { color: #4CAF50; }
				        p { font-size: 16px; }
				        .footer { margin-top: 20px; font-size: 12px; color: gray; }
				    </style>
				</head>
				<body>
				    <div class="container">
				        <h1>Welcome, %s</h1>
				        <p>Thank you for registering in our Personal Finance Management System.</p>
				        <p>We are excited to have you on board.</p>
				        <div class="footer">
				            &copy; 2026 Personal Finance Management System
				        </div>
				    </div>
				</body>
				</html>
				""";

		htmlContent = String.format(htmlContent, username);

		MimeMessage message = javaMailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true);
		helper.setTo(toEmail);
		helper.setSubject(subject);
		helper.setText(htmlContent, true);//html code in body

		javaMailSender.send(message);
	}

	@Override
	public void sendOtpEmail(String toEmail, String otp) {
		try {
			String html = htmlEmailUtil.getHtmlContent("otp-email.html");
			
			String userName = userRepo.findByEmail(toEmail).get().getName();

			Map<String, String> values = new HashMap<>();
			values.put("otp", otp);
			values.put("name", userName);
			
			html = htmlEmailUtil.replacePlaceholders(html, values);

			MimeMessage message = javaMailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);

			helper.setTo(toEmail);
			helper.setSubject("Password Reset OTP");
			helper.setText(html, true);

			javaMailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void sendPasswordResetSuccessEmail(String toEmail, String name) {
		try {
			String html = htmlEmailUtil.getHtmlContent("password-reset-success.html");

			Map<String, String> values = new HashMap<>();
			values.put("name", name);
			
			html = htmlEmailUtil.replacePlaceholders(html, values);

			MimeMessage message = javaMailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);

			helper.setTo(toEmail);
			helper.setSubject("Password Updated Successfully");
			helper.setText(html, true);

			javaMailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
