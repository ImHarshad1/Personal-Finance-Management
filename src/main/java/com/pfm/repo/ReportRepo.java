package com.pfm.repo;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pfm.entity.Transaction;
import com.pfm.entity.TxnType;
import com.pfm.entity.User;

public interface ReportRepo extends JpaRepository<Transaction, Integer> {

	List<Transaction> findByUserAndDateBetweenAndType(User user, LocalDate startDate, LocalDate endDate, TxnType type);

	List<Transaction> findByUserAndDateBetween(User user, LocalDate startDate, LocalDate endDate);
}