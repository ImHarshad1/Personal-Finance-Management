package com.pfm.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pfm.entity.Transaction;
import com.pfm.service.ReportService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ReportController {

	@GetMapping("/report")
	public String ReportPage() {
		return "report";
	}

	@Autowired
	private ReportService reportService;

	@PostMapping("/report")
	public String monthlyReport(@RequestParam(required = false) String fromDate,
			@RequestParam(required = false) String toDate, @RequestParam(required = false) String type,
			Principal principal, Model model) {

		List<Transaction> transactions = reportService.fetchFilteredTransactions(fromDate, toDate, type, principal);

		model.addAttribute("transactions", transactions);
		model.addAttribute("selectedType", type );
		model.addAttribute("fromDate", fromDate); 
		model.addAttribute("toDate", toDate);

		return "report";
	}

	@GetMapping("/report/pdf")
	public void downloadPdf(@RequestParam(required = false) String fromDate,
			@RequestParam(required = false) String toDate, @RequestParam(required = false) String type,
			Principal principal, HttpServletResponse response) throws Exception {

		List<Transaction> transactions = reportService.fetchFilteredTransactions(fromDate, toDate, type, principal);

		byte[] pdfData = reportService.generatePdf(transactions);

		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=transactions_report.pdf");
		response.getOutputStream().write(pdfData);
	}

}
