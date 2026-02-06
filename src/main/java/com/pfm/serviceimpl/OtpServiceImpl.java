package com.pfm.serviceimpl;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pfm.entity.Otp;
import com.pfm.repo.OtpRepo;
import com.pfm.service.EmailService;
import com.pfm.service.OtpService;

import jakarta.transaction.Transactional;

@Service
public class OtpServiceImpl implements OtpService {

    @Autowired
    private OtpRepo otpRepo;

    @Autowired
    private EmailService emailService;

    @Override
    @Transactional
    public void generateAndSaveOtp(String email) {
        otpRepo.deleteByEmail(email);

        String otp = String.valueOf(new Random().nextInt(9000) + 1000);

        Otp otpEntity = new Otp();
        otpEntity.setEmail(email);
        otpEntity.setOtp(otp);
        otpEntity.setExpiryTime(LocalDateTime.now().plusMinutes(2));
        otpRepo.save(otpEntity);

        emailService.sendOtpEmail(email, otp);
    }

    @Override
    public boolean validateOtp(String email, String otp) {
        Optional<Otp> optionalOtp = otpRepo.findByEmail(email);
        if (optionalOtp.isPresent()) {
            Otp otpEntity = optionalOtp.get();
            if (otpEntity.getOtp().equals(otp)
                    && otpEntity.getExpiryTime().isAfter(LocalDateTime.now())) {
                otpRepo.delete(otpEntity);
                return true;
            }
        }
        return false;
    }

    @Override
    @Transactional
    public void deleteOtp(String email) {
        otpRepo.deleteByEmail(email);
    }

    @Override
    public Otp findByEmail(String email) {
        return otpRepo.findByEmail(email).orElse(null);
    }
}
