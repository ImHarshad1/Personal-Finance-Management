package com.pfm.serviceimpl;

import java.util.Collections;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.pfm.entity.User;
import com.pfm.repo.UserRepo;
import com.pfm.service.EmailService;

import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

	@Autowired
    private final UserRepo userRepo;
    
    @Autowired
	private EmailService emailService;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) {

        
        OAuth2User oauthUser = super.loadUser(userRequest);

        Map<String, Object> attributes = oauthUser.getAttributes();

        String email = (String) attributes.get("email");
        String name  = (String) attributes.get("name");

//        if (email == null) {
//            throw new RuntimeException("Email not found from OAuth provider");
//        }

        Optional<User> existingUser = userRepo.findByEmail(email);

        if (existingUser.isEmpty()) {
            User user = new User();
            user.setEmail(email);
            user.setName(name);
            user.setPassword(null);

            userRepo.save(user);
            try {
				emailService.sendWelcomeMail(email, "Welcome to PFM Service", name);
			} catch (MessagingException e) {
				e.printStackTrace();
			}

        }

        return new DefaultOAuth2User(
                Collections.singleton(new SimpleGrantedAuthority("ROLE_USER")),
                attributes,
                "email"
        );
    }
}
