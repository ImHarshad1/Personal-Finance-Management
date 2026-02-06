package com.pfm.repo;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.pfm.entity.Transaction;
import com.pfm.entity.TxnType;

public interface TransactionRepo extends JpaRepository<Transaction, Integer>, JpaSpecificationExecutor<Transaction> {

	List<Transaction> findByUserId(Integer uid);

	List<Transaction> findByUserIdAndTypeAndDateBetween(Integer id, TxnType expense, LocalDate fromDate,
			LocalDate toDate);

	List<Transaction> findByUserIdAndDateBetween(Integer uid, LocalDate atDay, LocalDate atEndOfMonth);

}
