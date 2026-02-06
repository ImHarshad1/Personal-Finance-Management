package com.pfm.controller;

import java.security.Principal;
import java.time.YearMonth;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pfm.dto.BudgetDTO;
import com.pfm.entity.Budget;
import com.pfm.entity.Category;
import com.pfm.entity.User;
import com.pfm.repo.BudgetRepo;
import com.pfm.repo.CategoryRepo;
import com.pfm.repo.UserRepo;
import com.pfm.service.FinanceSummaryService;

@Controller
public class BudgetController {
	
	@Autowired
	private CategoryRepo categoryRepo;
	
	@Autowired
	private BudgetRepo budgetRepo;
	
	@Autowired
	private FinanceSummaryService financeSummaryService;
	
	@Autowired
	private UserRepo userRepo;
	
	@GetMapping("/budget")
	public String addBudget(Model model,Principal principal,@RequestParam(required = false)String successMsg) {
		model.addAttribute("bdg", new BudgetDTO());
		List<Category> categories = categoryRepo.findAll();
		model.addAttribute("categories", categories);
		
		Integer uid = getUid(principal);

		if (successMsg!=null) {
			model.addAttribute("successMsg", successMsg);
		}
		
		// add budgets list 
		// findBudgets By User
		String email = principal.getName();
		User user = userRepo.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));
		
		List<Budget> budgets = budgetRepo.findByUserId(user.getId());
		
		model.addAttribute("budgets", budgets);
		
	    YearMonth ym = YearMonth.now();
	    financeSummaryService.evictSummary(uid, ym.getMonthValue(), ym.getYear()); 
	    
		return "budget";
	}
	 
	@PostMapping("/budget")
	public String saveBudget(Principal principal, BudgetDTO budgetDTO, Model model) {
		Budget budget = new Budget();
		budget.setMonth(budgetDTO.getMonth());
		budget.setYear(budgetDTO.getYear());
		budget.setAmount(budgetDTO.getAmount());
		
		Category category = categoryRepo.findById(budgetDTO.getCatId())
				.orElseThrow(() -> new RuntimeException("Category not found"));
		budget.setCategory(category);
		
		String email =principal.getName();
		User user = userRepo.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));
		budget.setUser(user);
		
		budgetRepo.save(budget);
		
		return "redirect:/budget?successMsg=Budget saved successfully!";
	}
	
	private Integer getUid(Principal principal) {
	    String email = principal.getName();
	    return userRepo.findByEmail(email)
	            .orElseThrow(() -> new RuntimeException("User not found"))
	            .getId();
	}
}