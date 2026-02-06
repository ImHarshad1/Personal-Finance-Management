package com.pfm.service;

import org.springframework.data.domain.Page;

import com.pfm.dto.FilterTranscationDTO;
import com.pfm.entity.Transaction;

public interface TransactionService {

	Page<Transaction> getFilteredTransactions(
	        FilterTranscationDTO filter,
	        Integer userId,
	        int page,
	        int size
	);

}
