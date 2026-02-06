package com.pfm.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.pfm.entity.User;
import com.pfm.repo.UserRepo;
import com.pfm.serviceimpl.CustomOAuth2UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired
	private UserRepo userRepo;
	
	@Autowired
	private CustomOAuth2UserService customOAuth2UserService;

	@Bean
	public PasswordEncoder getEncoder() {
		return new BCryptPasswordEncoder();
	}
				
	@Bean
	public SecurityFilterChain getFilterChain(HttpSecurity http) throws Exception {

	    http
	        .csrf(c -> c.disable())

	        //for Ai-chat, as Spring Security blocking iframes
	        .headers(h -> h
	            .frameOptions(f -> f.sameOrigin())
	        )

	        .authorizeHttpRequests(req -> req
	            .requestMatchers("/register","/login",
	                "/forgot-password",
	                "/send-otp",
	                "/verify-otp",
	                "/reset-password",
	                "/ai/**",
	                "/oauth2/**"
	            ).permitAll()
	            .requestMatchers("/WEB-INF/**").permitAll()
	            .anyRequest().authenticated()
	        )

	        .formLogin(l -> l
	        	    .loginPage("/login")
	        	    .loginProcessingUrl("/login")
	        	    .defaultSuccessUrl("/dashboard")
	        	    .successHandler((request, response, authentication) -> {
	        	        String email = authentication.getName();
	        	        User user = userRepo.findByEmail(email).orElse(null);
	        	        if (user != null) {
	        	            request.getSession().setAttribute("userId", user.getId());
	        	        }
	        	        response.sendRedirect("/dashboard");
	        	    })
	        	    .failureUrl("/login?error=Invalid Credentials")//GET
	        	)
	        .oauth2Login(oauth -> oauth
					.loginPage("/login")
					.userInfoEndpoint(userInfo ->
							userInfo.userService(customOAuth2UserService)
					)
					.defaultSuccessUrl("/dashboard", true)
				)
	        .logout(l -> l.logoutUrl("/logout"));

	    return http.build();
	}

}
