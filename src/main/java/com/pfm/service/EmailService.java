package com.pfm.service;

import jakarta.mail.MessagingException;

public interface EmailService {
	
	public void sendWelcomeMail(String toEmail,String subject, String username) throws MessagingException;
	
	void sendOtpEmail(String toEmail, String otp);
	
	void sendPasswordResetSuccessEmail(String toEmail, String name);

}
