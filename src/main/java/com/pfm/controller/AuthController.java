package com.pfm.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pfm.dto.RegisterDTO;
import com.pfm.entity.Otp;
import com.pfm.entity.User;
import com.pfm.repo.UserRepo;
import com.pfm.service.EmailService;
import com.pfm.service.OtpService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

	@Autowired
	private UserRepo userRepo;

	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private EmailService emailService;
	@Autowired
	private OtpService otpService;

	@GetMapping("/register")
	public String registerPage(Model model) {
		model.addAttribute("register", new RegisterDTO());
		return "register";
	}

	@GetMapping("/login")
	public String loginPage(Model model, @RequestParam(required = false) String error) {
		model.addAttribute("error", error);
		return "login";
	}

	@PostMapping("/register")
	public String registerUser(RegisterDTO register, Model model) throws MessagingException {

		Optional<User> opt = userRepo.findByEmail(register.getEmail());

		if (opt.isPresent()) {
			model.addAttribute("error", "Already Registered");
			return "login";
		} else {
			User user = new User();
			user.setEmail(register.getEmail());
			user.setName(register.getName());
			user.setPassword(passwordEncoder.encode(register.getPassword()));

			userRepo.save(user);

			model.addAttribute("success", "Registered Successfully");
			emailService.sendWelcomeMail(register.getEmail(), "Welcome to PFM Service", register.getName());

			return "login";
		}
	}

	@GetMapping("/forgot-password")
	public String forgotPasswordPage() {
		return "forgot-password";
	}

	@PostMapping("/send-otp")
	public String sendOtp(@RequestParam String email, Model model) {
		Optional<User> userEntity = userRepo.findByEmail(email);

		if (userEntity.isEmpty()) {
			model.addAttribute("error", "User not Registered!!");
			return "forgot-password";
		}

		otpService.generateAndSaveOtp(email);
		model.addAttribute("email", email);
		model.addAttribute("success", "OTP sent to your email");
		model.addAttribute("otpRemainingSeconds", 120);

		return "verify-otp";
	}

	@PostMapping("/verify-otp")
	public String verifyOtp(@RequestParam String email, @RequestParam String otp, Model model, HttpSession session) {

		Otp otpEntity = otpService.findByEmail(email);

		if (otpEntity == null || otpEntity.getExpiryTime().isBefore(LocalDateTime.now())) {
			model.addAttribute("email", email);
			model.addAttribute("error", "OTP expired! Please resend OTP.");
			model.addAttribute("otpRemainingSeconds", 0);
			return "verify-otp";
		}

		if (!otpEntity.getOtp().equals(otp)) {
			model.addAttribute("email", email);
			model.addAttribute("error", "Invalid OTP");

			int remaining = (int) Math.max(0,
					Duration.between(LocalDateTime.now(), otpEntity.getExpiryTime()).getSeconds());

			model.addAttribute("otpRemainingSeconds", remaining);
			return "verify-otp";
		}

		session.setAttribute("OTP_VERIFIED_EMAIL", email);
		otpService.deleteOtp(email);

		return "reset-password";
	}

	@PostMapping("/reset-password")
	public String resetPassword(@RequestParam String newPassword, @RequestParam String confirmPassword, Model model,
			HttpSession session) {

		String email = (String) session.getAttribute("OTP_VERIFIED_EMAIL");

		if (email == null) {
			model.addAttribute("error", "Session expired. Please try again.");
			return "login";
		}

		if (!newPassword.equals(confirmPassword)) {
			model.addAttribute("error", "Passwords didn't matched");
			return "reset-password";
		}

		Optional<User> optionalUser = userRepo.findByEmail(email);
		if (optionalUser.isEmpty()) {
			model.addAttribute("error", "User not found");
			return "reset-password";
		}

		User user = optionalUser.get();

		if (passwordEncoder.matches(newPassword, user.getPassword())) {
			model.addAttribute("error", "Please enter a new password. Old password cannot be reused.");
			return "reset-password";
		}

		user.setPassword(passwordEncoder.encode(newPassword));
		userRepo.save(user);

		session.removeAttribute("OTP_VERIFIED_EMAIL");

		model.addAttribute("success", "Password updated successfully. Please login!");
		emailService.sendPasswordResetSuccessEmail(user.getEmail(), user.getName());

		return "login";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login?logout=true";
	}
}
