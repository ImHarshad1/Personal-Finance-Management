package com.pfm.service;

import com.pfm.entity.Otp;

public interface OtpService {

    void generateAndSaveOtp(String email);

    boolean validateOtp(String email, String otp);

    void deleteOtp(String email);
    
    Otp findByEmail(String email);
    


}
