package com.pfm.service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.pfm.dto.FinanceSummary;
import com.pfm.entity.Budget;
import com.pfm.entity.Transaction;
import com.pfm.entity.TxnType;
import com.pfm.repo.BudgetRepo;
import com.pfm.repo.TransactionRepo;

@Service
public class FinanceSummaryService {

	@Autowired
	private TransactionRepo transactionRepo;
	@Autowired
	private BudgetRepo budgetRepo;
	
    // cache per user 
	@Cacheable(value = "financeSummary", key = "#uid + '-' + #month + '-' + #year")
	public FinanceSummary getSummary(Integer uid, int month, int year) {
		
		YearMonth ym = YearMonth.of(year, month);
		LocalDate fromtDate = ym.atDay(1);
		LocalDate toDate = ym.atEndOfMonth();
		
		 List<Transaction> txns = transactionRepo.findByUserIdAndDateBetween(uid, fromtDate, toDate);
		 List<Budget> budgets = budgetRepo.findByUserId(uid);
		 
		 double totalIncome = 0.0, totalExpense = 0.0;
		 
		 Map<String, Double> incomeByCat = new HashMap<>();
		 Map<String, Double> expenseByCat = new HashMap<>();
		 
		 for(Transaction t:txns) {
			 String catName = (t.getCategory() != null) ? t.getCategory().getName() : "Uncategorized";
			 TxnType type = (t.getCategory() != null && t.getCategory().getType() != null) 
					 	? t.getCategory().getType()
                        : TxnType.EXPENSE;
			 
			 double amt = t.getAmount();
			 
			 if(type == TxnType.INCOME) {
				 totalIncome += amt;
				 incomeByCat.put(catName, incomeByCat.getOrDefault(catName, 0.0) + amt);
			 } else {
				 totalExpense += amt;
				 expenseByCat.put(catName, expenseByCat.getOrDefault(catName, 0.0) + amt);
			 }
		 }
		 
		// sort top to bottom
		 StringBuilder incomeSummary = new StringBuilder();
		 incomeByCat.entrySet().stream()
		 			.sorted((a,b) -> Double.compare(b.getValue(), a.getValue()))
		 			.forEach(e -> incomeSummary.append(e.getKey())
		 					.append(": ₹").append(String.format("%,.2f", e.getValue())).append("\n"));
		
		 StringBuilder expenseSummary = new StringBuilder();
		 expenseByCat.entrySet().stream()
		 			.sorted((a,b) -> Double.compare(b.getValue(), a.getValue()))
		 			.forEach(e -> expenseSummary.append(e.getKey())
		 					.append(": ₹").append(String.format("%,.2f", e.getValue())).append("\n"));        
		 
		// budgets for current month only
	        StringBuilder budgetSummary = new StringBuilder();
	        if(budgets != null && !budgets.isEmpty()) {
	        	for(Budget b : budgets) {
	        		if(b.getMonth() != month || b.getYear() != year) continue;
	        		String bcat = (b.getCategory() != null) ? b.getCategory().getName() : "Unknown";
	        		budgetSummary.append(bcat)
	        					.append(": ₹").append(String.format("%,.2f", b.getAmount()))
	        					.append(" (").append(b.getMonth()).append(" ").append(b.getYear()).append(")")
	        					.append("\n");
	        	}
	        	if(budgetSummary.length() == 0) budgetSummary.append("Not Available\n");
	        } else {
	        	budgetSummary.append("Not Available\n");
	        }
	        
// ===== Budget vs Actual (current month) =====
	        Map<String, Double> actualThisMonthByCat = new HashMap<>();
	        for (Transaction t : txns) {
	            TxnType type = (t.getCategory() != null && t.getCategory().getType() != null)
	                    ? t.getCategory().getType()
	                    : TxnType.EXPENSE;
	            if (type != TxnType.EXPENSE) continue;

	            String catName = (t.getCategory() != null) ? t.getCategory().getName() : "Uncategorized";
	            actualThisMonthByCat.put(catName, actualThisMonthByCat.getOrDefault(catName, 0.0) + t.getAmount());
	        }

	        StringBuilder budgetVsActual = new StringBuilder();
	        StringBuilder overspend = new StringBuilder();

	        if (budgets != null && !budgets.isEmpty()) {
	            for (Budget b : budgets) {
	                if (b.getMonth() != month || b.getYear() != year) continue;

	                String cat = (b.getCategory() != null) ? b.getCategory().getName() : "Unknown";
	                double budgetAmt = b.getAmount();
	                double actualAmt = actualThisMonthByCat.getOrDefault(cat, 0.0);
	                double diff = budgetAmt - actualAmt;

	                String status = (diff >= 0) ? "✅ Within" : "⚠️ Over";
	                budgetVsActual.append(cat)
	                        .append(": Budget ₹").append(String.format("%,.2f", budgetAmt))
	                        .append(" | Spent ₹").append(String.format("%,.2f", actualAmt))
	                        .append(" | ").append(status)
	                        .append("\n");

	                if (diff < 0) {
	                    overspend.append(cat)
	                            .append(": Over by ₹").append(String.format("%,.2f", Math.abs(diff)))
	                            .append("\n");
	                }
	            }
	            if (budgetVsActual.length() == 0) budgetVsActual.append("Not Available\n");
	            if (overspend.length() == 0) overspend.append("None 🎉\n");
	        } else {
	            budgetVsActual.append("Not Available\n");
	            overspend.append("Not Available\n");
	        }

	        // ===== Trend (this month vs last month total expense) =====
	        YearMonth now = ym;
	        YearMonth last = ym.minusMonths(1);
	        
	     // get last month expenses from DB (recommended)
	        List<Transaction> lastMonthTxns = transactionRepo.findByUserIdAndDateBetween(uid, last.atDay(1), last.atEndOfMonth());
	        
	        double thisMonthExpense = txns.stream()
	        		.filter(t -> t.getCategory() != null && t.getCategory().getType() == TxnType.EXPENSE)
	        		.mapToDouble(Transaction::getAmount).sum();
	        
	        double lastMonthExpense = lastMonthTxns.stream()
	        		.filter(t -> t.getCategory() != null && t.getCategory().getType() == TxnType.EXPENSE)
	        		.mapToDouble(Transaction::getAmount).sum();
	        
	        StringBuilder trend = new StringBuilder();
	        trend.append("This month: ₹").append(String.format("%,.2f", thisMonthExpense)).append("\n")
	             .append("Last month: ₹").append(String.format("%,.2f", lastMonthExpense)).append("\n");

	        // ===== Chart explanation data (text) =====
	        StringBuilder charts = new StringBuilder();
	        charts.append("1) Income vs Expense (bar): compares total income and expense.\n")
	              .append("2) Category-wise Spending (pie): shows which categories take most expense.\n")
	              .append("3) Monthly Trend (line): compares this month vs last month expense.\n")
	              .append("4) Budget vs Actual (bars): shows category budget vs spent, within/over.\n");

	        double net = totalIncome - totalExpense;
	        
	     // LIMIT TEXT (keeps prompt small + fast)
	        String income = topNLines(incomeSummary.toString(), 5);
	        String expense = topNLines(expenseSummary.toString(), 8);
	        String budget = topNLines(budgetSummary.toString(), 8);

	        // ✅ also trim other long blocks (recommended)
	        String budgetVsActualTrim = topNLines(budgetVsActual.toString(), 8);
	        String overspendTrim = topNLines(overspend.toString(), 5);
	        String trendTrim = topNLines(trend.toString(), 6);

	        return new FinanceSummary(
	        		month, year,
	        	    totalIncome, totalExpense, net,
	        	    income, expense, budget,
	        	    budgetVsActualTrim,
	        	    overspendTrim,
	        	    trendTrim,
	        	    charts.toString()
	        	);
	    }
	
	private String topNLines(String text, int n) {
	    if (text == null) return "";
	    String[] lines = text.split("\n");
	    StringBuilder sb = new StringBuilder();
	    int count = 0;

	    for (String line : lines) {
	        if (line == null) continue;
	        line = line.trim();
	        if (line.isEmpty()) continue;

	        sb.append(line).append("\n");
	        count++;

	        if (count >= n) break;
	    }
	    return sb.toString();
	}

	  
	 // When user adds/updates/deletes txn or budget, clear cache
	 @CacheEvict(value = "financeSummary", key = "#uid + '-' + #month + '-' + #year")
	 public void evictSummary(Integer uid, int month, int year) {
		 
	 }

}