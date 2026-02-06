package com.pfm.service;

import java.security.Principal;
import java.time.LocalDate;
import java.util.List;

import com.pfm.entity.Transaction;
import com.pfm.entity.User;

public interface ReportService {

	List<Transaction> getFilteredTransactions(User user, LocalDate from, LocalDate to, String type);

	List<Transaction> fetchFilteredTransactions(String fromDate, String toDate, String type, Principal principal);

	byte[] generatePdf(List<Transaction> transactions);
}
