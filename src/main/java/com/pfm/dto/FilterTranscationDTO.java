package com.pfm.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.pfm.entity.TxnType;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FilterTranscationDTO {

    private Integer  category;
    private TxnType type;   // INCOME or EXPENSE
   
    
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate fromDate;
    
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate toDate;

   
}
