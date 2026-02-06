package com.pfm.dto;

import lombok.Data;

@Data
public class BudgetDTO {

	private Integer month;

	private Integer year;
	
	private Integer catId;
	
	private Double amount;

}
