package com.pfm.controller;

import java.security.Principal;
import java.time.YearMonth;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pfm.dto.FilterTranscationDTO;
import com.pfm.dto.TransactionDTO;
import com.pfm.entity.Category;
import com.pfm.entity.Transaction;
import com.pfm.entity.User;
import com.pfm.repo.CategoryRepo;
import com.pfm.repo.TransactionRepo;
import com.pfm.repo.UserRepo;
import com.pfm.service.FinanceSummaryService;
import com.pfm.service.TransactionService;

@Controller
public class TransactionController {

	@Autowired
	private CategoryRepo categoryRepo;

	@Autowired
	private UserRepo userRepo;

	@Autowired
	private TransactionRepo transactionRepo;

	@Autowired
	private TransactionService transactionService;
	
	@Autowired
	private FinanceSummaryService financeSummaryService;

	@GetMapping("/addtransaction")
	public String addtransaction(Model model, @RequestParam(required = false) String msg) {
		if (msg != null)
			model.addAttribute("msg", msg);
		model.addAttribute("txn", new TransactionDTO());
		List<Category> categories = categoryRepo.findAll();
		model.addAttribute("categories", categories);
		return "addtransaction";
	}

	@PostMapping("/addtransaction")
	public String postMethodName(Principal principal, TransactionDTO txn) {
		
		 if (principal == null) return "redirect:/login";
		 
		 Integer uid = getUid(principal);
		
		Transaction transaction = new Transaction();
		transaction.setAmount(txn.getAmount());
		transaction.setDescription(txn.getDescription());
		transaction.setDate(txn.getDate());

		Category category = categoryRepo.findById(txn.getCatId())
				.orElseThrow(() -> new RuntimeException("Cat not found"));

		transaction.setType(category.getType());
		transaction.setCategory(category);

		String email = principal.getName();

		User user = userRepo.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));

		transaction.setUser(user);
		transactionRepo.save(transaction);

		// refresh cache AFTER save
	    YearMonth ym = YearMonth.now();
	    financeSummaryService.evictSummary(uid, ym.getMonthValue(), ym.getYear()); 
		return "redirect:/addtransaction?msg=Transaction Added";
	}

	@GetMapping("/transactions")
	public String transactionPage(Principal principal, @ModelAttribute FilterTranscationDTO filter,
			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int size, Model model) {

		User user = userRepo.findByEmail(principal.getName()).orElseThrow(() -> new RuntimeException("User not found"));

		Page<Transaction> txnPage = transactionService.getFilteredTransactions(filter, user.getId(), page, size);

		model.addAttribute("txns", txnPage.getContent());
		model.addAttribute("totalPages", txnPage.getTotalPages());
		model.addAttribute("currentPage", page);

		model.addAttribute("categories", categoryRepo.findAll());
		model.addAttribute("filter", filter);
		model.addAttribute("selectedType", filter.getType() != null ? filter.getType().name() : "");

		return "transactions";
	}

	@PostMapping("transactions")
	public String filterTransaction(Principal principal, @ModelAttribute FilterTranscationDTO filter,
			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int size, Model model) {
		User user = userRepo.findByEmail(principal.getName()).orElseThrow(() -> new RuntimeException("User not found"));

		Page<Transaction> txnPage = transactionService.getFilteredTransactions(filter, user.getId(), page, size);

		model.addAttribute("txns", txnPage.getContent());
		model.addAttribute("totalPages", txnPage.getTotalPages());
		model.addAttribute("currentPage", page);

		model.addAttribute("categories", categoryRepo.findAll());
		model.addAttribute("filter", filter);
		model.addAttribute("selectedType", filter.getType() != null ? filter.getType().name() : "");

		return "transactions";
	}

	@GetMapping("/edit")
	public String EditTransactionPage(@RequestParam Integer tid, Model model) {

		Transaction txn = transactionRepo.findById(tid)
				.orElseThrow(() -> new RuntimeException("Transaction not found"));

		TransactionDTO dto = new TransactionDTO();
		dto.setId(txn.getId());
		dto.setAmount(txn.getAmount());
		dto.setDescription(txn.getDescription());
		dto.setDate(txn.getDate());
		dto.setCategory(txn.getCategory());

		model.addAttribute("dto", dto);
		List<Category> categories = categoryRepo.findAll();
		model.addAttribute("categories", categories);

		return "edittransaction";
	}

	@PostMapping("/edittransaction")
	public String EditTransaction(TransactionDTO dto, Principal principal) {

		Integer uid = getUid(principal);
		
		Transaction txn = transactionRepo.findById(dto.getId())
				.orElseThrow(() -> new RuntimeException("Txn not found"));

		txn.setAmount(dto.getAmount());
		txn.setDescription(dto.getDescription());
		txn.setDate(dto.getDate());

		Category category = categoryRepo.findById(dto.getCatId())
				.orElseThrow(() -> new RuntimeException("Txn not found"));
		txn.setCategory(category);
		txn.setType(category.getType());
		
		transactionRepo.save(txn);
		
		YearMonth ym = YearMonth.now();
	    financeSummaryService.evictSummary(uid, ym.getMonthValue(), ym.getYear()); 
		
		return "redirect:/transactions";
	}
 
	@GetMapping("/delete")
	public String deleteTransaction(@RequestParam Integer tid,
	                                RedirectAttributes redirectAttributes, Principal principal) {

		Integer uid = getUid(principal);
	    transactionRepo.deleteById(tid);

	    redirectAttributes.addFlashAttribute(
	        "successMessage",
	        "Transaction deleted successfully."
	    );

	    YearMonth ym = YearMonth.now();
	    financeSummaryService.evictSummary(uid, ym.getMonthValue(), ym.getYear()); 
	    
	    return "redirect:/transactions";
	}
	
	private Integer getUid(Principal principal) {
	    String email = principal.getName();
	    return userRepo.findByEmail(email)
	            .orElseThrow(() -> new RuntimeException("User not found"))
	            .getId();
	}
}
