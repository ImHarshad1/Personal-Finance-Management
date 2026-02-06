package com.pfm.controller;

import java.security.Principal;
import java.time.YearMonth;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.pfm.dto.FinanceSummary;
import com.pfm.entity.Budget;
import com.pfm.entity.Transaction;
import com.pfm.entity.TxnType;
import com.pfm.entity.User;
import com.pfm.repo.BudgetRepo;
import com.pfm.repo.TransactionRepo;
import com.pfm.repo.UserRepo;
import com.pfm.service.AiService;
import com.pfm.service.FinanceSummaryService;

import jakarta.servlet.http.HttpSession;
import reactor.core.publisher.Flux;

@Controller
@RequestMapping("/ai")
public class AiController {

	@Autowired
	private AiService aiService;
	@Autowired
	private UserRepo userRepo;
	@Autowired
	private ObjectMapper objectMapper;
	
	@Autowired
	private FinanceSummaryService financeSummaryService;
    // ================= AI CHAT PAGE =================
	@GetMapping("/chat")
	public String chatPage() {
		return "ai-chat";
	}
	
    // ================= ASYNC AI CHAT =================
	@PostMapping("/ask-async")
	@ResponseBody
	public String askAsync(@RequestParam String question, Principal principal) {

	    if (principal == null) return "Please login again.";

	    String email = principal.getName();
	    User user = userRepo.findByEmail(email).orElse(null);
	    if (user == null) return "Please login again.";

	 	Integer uid = getUid(principal);

	 	//Redis cached
	 	YearMonth ym = YearMonth.now();
	 	FinanceSummary s = financeSummaryService.getSummary(uid, ym.getMonthValue(), ym.getYear());

		   String prompt = """
				   You are a Personal Finance Assistant for an Indian user. Currency is INR (₹).
				   Use ONLY the data below. DO NOT guess.

				   Greeting rule:
				   If the user message is only a greeting (hi/hello/hey), respond EXACTLY:
				   Hello %s 👋 Welcome back!
				   What would you like to do today?
				   • 📌 Expense summary (this month)
				   • 🧾 Budget status (within/over)
				   • 📈 Trends (this month vs last month)
				   • 📊 Explain my charts
				   • 💡 Savings tips
				   (Stop.)

		   			STYLE RULES (MUST FOLLOW ALWAYS):
		   		- Always start with a heading line.
		   		- Always use bullets (•) only. Never use '*' bullets.
		   		- Put every point on a new line.
		   		- For items like "Income vs Expense:", keep the label before ':' so UI can bold it.
		   		- Use these headings when relevant:
		   			📌 Summary
		   			📊 Details
		   			📈 Trends
		   			✅ Insights
		   			🎯 Actions
		   		
		   		If the user asks about charts/explain charts:
		   		Return under heading: 📊 Details
		   		Use bullets like:
		   			• Income vs Expense: <1 line meaning>
		   			• Category-wise Spending: <1 line meaning>
		   			• Monthly Trend: <1 line meaning>
		   			• Budget vs Actual: <1 line meaning>


				   Routing rules (VERY IMPORTANT):
				   - If user asks about expenses -> use EXPENSE_DATA + TOTALS.
				   - If user asks about income -> use INCOME_DATA + TOTALS.
				   - If user asks about budgets -> use BUDGET_DATA + BUDGET_VS_ACTUAL.
				   - If user asks “over budget / within budget / left budget” -> use BUDGET_VS_ACTUAL + OVERSPEND.
				   - If user asks trends / last month / compare -> use TREND_DATA.
				   - If user asks charts -> use CHART_DATA and reference totals.
				   - Give exactly 2 actionable suggestions ONLY if user asks advice/tips/save/reduce.

				   Output format:
				   - Headings + bullets
				   - No long paragraphs
				   - Money format ₹43,947.00

				   DATA:
				   INCOME_TOTAL: ₹%s
				   EXPENSE_TOTAL: ₹%s
				   NET_SAVINGS: ₹%s

				   INCOME_DATA:
				   %s

				   EXPENSE_DATA:
				   %s

				   BUDGET_DATA:
				   %s

				   BUDGET_VS_ACTUAL:
				   %s

				   OVERSPEND:
				   %s

				   TREND_DATA:
				   %s

				   CHART_DATA:
				   %s

				   User Question: %s
				   Return plain text only.
				   """.formatted(
				       user.getName(),
				       String.format("%,.2f", s.totalIncome),
				       String.format("%,.2f", s.totalExpense),
				       String.format("%,.2f", s.netSavings),
				       s.incomeSummary,
				       s.expenseSummary,
				       s.budgetSummary,
				       s.budgetVsActualSummary,
				       s.overspendSummary,
				       s.trendSummary,
				       s.chartSummary,
				       question
				   );

	    return aiService.ask(prompt);
	}

	
    // ================= SMART CATEGORY =================
	@PostMapping("/suggest-category")
	@ResponseBody
	public String suggestCategory(@RequestParam String description) {
		
		String prompt = """
				Categorize this expense.
				Respond ONLY in this format:
				Category: <name>
				Type: Expense or Income
				
				Description: %s
				""".formatted(description);
		
		return aiService.ask(prompt);
	}
	
	
	@GetMapping(value="/ask-stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	@ResponseBody
	public Flux<String> askStream(@RequestParam String question, Principal principal) {

		 if (principal == null) {
		        return Flux.just("Please login again.");
		    }

		 	Integer uid = getUid(principal);
		    User user = userRepo.findById(uid).orElse(null);
		    
		    if (user == null) return Flux.just("Please login again.");

		 //Redis cached 
		    YearMonth ym = YearMonth.now();
		    FinanceSummary s = financeSummaryService.getSummary(uid, ym.getMonthValue(), ym.getYear());
		    
		   String prompt = """
				   You are a Personal Finance Assistant for an Indian user. Currency is INR (₹).
				   Use ONLY the data below. DO NOT guess.

				   Greeting rule:
				   If the user message is only a greeting (hi/hello/hey), respond EXACTLY:
				   Hello %s 👋 Welcome back!
				   What would you like to do today?
				   • 📌 Expense summary (this month)
				   • 🧾 Budget status (within/over)
				   • 📈 Trends (this month vs last month)
				   • 📊 Explain my charts
				   • 💡 Savings tips
				   
				   STYLE RULES (MUST FOLLOW ALWAYS):
		   		- Always start with a heading line.
		   		- Always use bullets (•) only. Never use '*' bullets.
		   		- Put every point on a new line.
		   		- For items like "Income vs Expense:", keep the label before ':' so UI can bold it.
		   		- Use these headings when relevant:
		   			📌 Summary
		   			📊 Details
		   			📈 Trends
		   			✅ Insights
		   			🎯 Actions

				   Routing rules (VERY IMPORTANT):
				   - If user asks about expenses -> use EXPENSE_DATA + TOTALS.
				   - If user asks about income -> use INCOME_DATA + TOTALS.
				   - If user asks about budgets -> use BUDGET_DATA + BUDGET_VS_ACTUAL.
				   - If user asks “over budget / within budget / left budget” -> use BUDGET_VS_ACTUAL + OVERSPEND.
				   - If user asks trends / last month / compare -> use TREND_DATA.
				   - If user asks charts -> use CHART_DATA and reference totals.
				   - Give exactly 2 actionable suggestions ONLY if user asks advice/tips/save/reduce.

				   Output format:
				   - Use Headings + bullets
				   - Each bullet on new line
				   - No long paragraphs
				   - always format Money like ₹43,947.00

				   DATA:
				   INCOME_TOTAL: ₹%s
				   EXPENSE_TOTAL: ₹%s
				   NET_SAVINGS: ₹%s

				   INCOME_DATA:
				   %s

				   EXPENSE_DATA:
				   %s

				   BUDGET_DATA:
				   %s

				   BUDGET_VS_ACTUAL:
				   %s

				   OVERSPEND:
				   %s

				   TREND_DATA:
				   %s

				   CHART_DATA:
				   %s

				   User Question: %s
				   Return plain text only.
				   """.formatted(
				       user.getName(),
				       String.format("%,.2f", s.totalIncome),
				       String.format("%,.2f", s.totalExpense),
				       String.format("%,.2f", s.netSavings),
				       s.incomeSummary,
				       s.expenseSummary,
				       s.budgetSummary,
				       s.budgetVsActualSummary,
				       s.overspendSummary,
				       s.trendSummary,
				       s.chartSummary,
				       question
				   );

		   return aiService.askStream(prompt)
				    .map(tok -> {
				        try {
				            return objectMapper.writeValueAsString(java.util.Map.of("t", tok));
				        } catch (Exception e) {
				            return "{\"t\":\"\"}";
				        }
				    })
				    .onErrorResume(ex ->
				        Flux.just("{\"t\":\"\\n⚠️ AI error: " + ex.getMessage().replace("\"","'") + "\"}")
				    );
	}
	
	private Integer getUid(Principal principal) {
	    String email = principal.getName();
	    return userRepo.findByEmail(email)
	            .orElseThrow(() -> new RuntimeException("User not found"))
	            .getId();
	}
}