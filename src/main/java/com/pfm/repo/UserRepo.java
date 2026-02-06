package com.pfm.repo;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pfm.entity.User;

public interface UserRepo extends JpaRepository<User, Integer> {

	Optional<User> findByEmail(String email);
}
