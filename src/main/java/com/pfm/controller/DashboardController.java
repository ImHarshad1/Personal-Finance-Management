package com.pfm.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.pfm.entity.Budget;
import com.pfm.entity.Category;
import com.pfm.entity.Transaction;
import com.pfm.entity.TxnType;
import com.pfm.entity.User;
import com.pfm.repo.BudgetRepo;
import com.pfm.repo.CategoryRepo;
import com.pfm.repo.TransactionRepo;
import com.pfm.repo.UserRepo;
import com.pfm.service.FinanceSummaryService;

import jakarta.servlet.http.HttpSession;


@Controller
public class DashboardController {
	
	@Autowired
	private CategoryRepo categoryRepo;

	@Autowired
    private UserRepo userRepo;
	
	@Autowired
	private BudgetRepo budgetRepo;
	
	@Autowired
	private TransactionRepo transactionRepo;
	
	@Autowired
	private FinanceSummaryService financeSummaryService;
	
	@GetMapping("/dashboard")
    public String dashboard(HttpSession session, Principal principal, Model model) {
		
        String email = principal.getName();        
        User user = userRepo.findByEmail(email).orElse(null);
        
		Integer uid = getUid(principal);
		
        if (user == null) {
            return "redirect:/login?error=User not found";
        }
 
            session.setAttribute("userName", user.getName());
        
     //FULL current month range
        YearMonth ym = YearMonth.now();
        LocalDate fromDate = ym.atDay(1);
        LocalDate toDate   = ym.atEndOfMonth();
        
// Chart 1: Category-wise Expense
        List<Transaction> expenses = transactionRepo.findByUserIdAndTypeAndDateBetween(
        		user.getId(), 
        		TxnType.EXPENSE, 
        		fromDate, 
        		toDate
        		);
        
        //Chart 1: Calculate category-wise totals
        Map<String, Double> categoryExpenseMap = new LinkedHashMap<>();
        for(Transaction t : expenses) {
        	String category = (t.getCategory() != null) ? t.getCategory().getName() : "Uncategorized";
        	
        	categoryExpenseMap.put(
        			category, 
        			categoryExpenseMap.getOrDefault(category, 0.0) + t.getAmount()
        			);
        }
        
        //Send data to JSP
        model.addAttribute("categoryExpenseMap", categoryExpenseMap);
        
//Chart 2:INCOME vs EXPENSE :- Fetch filtered INC transactions, EXP is already filtered above
        List<Transaction> incomes = transactionRepo.findByUserIdAndTypeAndDateBetween(
        		user.getId(),
        		TxnType.INCOME,
        		fromDate,
        		toDate
        		);
        
        Double totalIncome = 0.0;
        for(Transaction i : incomes) {
        	
        	totalIncome += i.getAmount();
        }
        
        Double totalExpense = 0.0;
        for(Transaction e : expenses) {
        	
        	totalExpense += e.getAmount();
        }
        
        model.addAttribute("totalIncome", totalIncome);
        model.addAttribute("totalExpense", totalExpense);
        
//Chart 3: Expense Trend-Line - expenses change over time, as expenses is already fetched above
        Map<LocalDate, Double> dateExpenseMap = new TreeMap<>();
        for(Transaction e : expenses) {
        	if (e.getDate() == null) continue;
        		dateExpenseMap.put(
        				e.getDate(), 
        				dateExpenseMap.getOrDefault(e.getDate(), 0.0) + e.getAmount()
        				);
        }
        
        model.addAttribute("dateExpenseMap", dateExpenseMap);

//CHART 4: BUDGET vs EXPENSE 
        
       // budgets are stored with month/year in your Budget table
        int m = ym.getMonthValue();
        int y = ym.getYear();
        
        List<Budget> budgets = budgetRepo.findByUserId(user.getId());//Logged in users budget 
        
        Map<String , Double> budgetMap = new LinkedHashMap<>();
        for(Budget b : budgets) {
        	if (b.getMonth() != m || b.getYear() != y) continue;
        	String cat = (b.getCategory() != null) ? b.getCategory().getName() : "Unknown";
        	budgetMap.put(cat, b.getAmount());
        }
        
     // Expenses already filtered for this month above ✅
        Map<String, Double> expenseMap = new LinkedHashMap<>();
        for(Transaction e : expenses) {
        	String cat = (e.getCategory() != null) ? e.getCategory().getName() : "Uncategorized";
        	expenseMap.put(
        			cat, 
        			expenseMap.getOrDefault(cat, 0.0) + e.getAmount());
        }
        
        model.addAttribute("budgetMap", budgetMap);
        model.addAttribute("expenseMap", expenseMap);
        
        financeSummaryService.evictSummary(uid, ym.getMonthValue(), ym.getYear());
        
        return "dashboard";
    }
	
	@GetMapping("/category")
	public String CategoryPage(Model model) {
		List<Category> categories = categoryRepo.findAll();
		model.addAttribute("categories", categories);
		
		return "category";
	}
	
	private Integer getUid(Principal principal) {
	    String email = principal.getName();
	    return userRepo.findByEmail(email)
	            .orElseThrow(() -> new RuntimeException("User not found"))
	            .getId();
	}

}
