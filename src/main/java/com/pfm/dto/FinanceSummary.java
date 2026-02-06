package com.pfm.dto;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public class FinanceSummary {
	
	private int month;
	private int year;

	public double totalIncome;
	public double totalExpense;
	public double netSavings;
	
    public String incomeSummary;
    public String expenseSummary;
    public String budgetSummary;

    public String budgetVsActualSummary;   
    public String overspendSummary;        
    public String trendSummary;           
    public String chartSummary;

}
