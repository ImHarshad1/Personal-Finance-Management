package com.pfm.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pfm.entity.Category;

public interface CategoryRepo extends JpaRepository<Category, Integer>{

}
