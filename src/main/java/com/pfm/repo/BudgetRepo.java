package com.pfm.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pfm.entity.Budget;

public interface BudgetRepo extends JpaRepository<Budget, Integer> {

	List<Budget> findByUserId(Integer id);

}
