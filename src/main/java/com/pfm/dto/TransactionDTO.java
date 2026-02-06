package com.pfm.dto;

import java.time.LocalDate;

import com.pfm.entity.Category;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class TransactionDTO {
	
	private Integer id;

	private Double amount;

	private String description;

	private LocalDate date;

	private Integer catId;
	
	private Category category;
}
