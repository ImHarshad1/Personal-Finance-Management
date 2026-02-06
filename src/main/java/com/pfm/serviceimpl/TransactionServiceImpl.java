package com.pfm.serviceimpl;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pfm.entity.Transaction;
import com.pfm.repo.TransactionRepo;
import com.pfm.service.TransactionService;
import com.pfm.specification.TransactionSpecification;
import com.pfm.dto.FilterTranscationDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

@Service
public class TransactionServiceImpl implements TransactionService {

	@Autowired
	private TransactionRepo transactionRepo;

	@Override
	public Page<Transaction> getFilteredTransactions(
	        FilterTranscationDTO filter,
	        Integer userId,
	        int page,
	        int size
	) {
	    Pageable pageable = PageRequest.of(page, size);

	    return transactionRepo.findAll(
	            TransactionSpecification.filter(
	                    filter.getFromDate(),
	                    filter.getToDate(),
	                    filter.getType(),
	                    filter.getCategory(),
	                    userId
	            ),
	            pageable
	    );
	}

}