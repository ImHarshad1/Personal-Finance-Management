package com.pfm.specification;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import com.pfm.entity.Transaction;
import com.pfm.entity.TxnType;
import jakarta.persistence.criteria.Predicate;

public class TransactionSpecification {

	public static Specification<Transaction> filter(LocalDate fromDate, LocalDate toDate, TxnType type,
			Integer categoryId, Integer userId) {
		return (root, query, cb) -> {
			List<Predicate> predicates = new ArrayList<>();

			if (fromDate != null && toDate != null) {
				predicates.add(cb.between(root.get("date"), fromDate, toDate));
			} else if (fromDate != null) {
				predicates.add(cb.greaterThanOrEqualTo(root.get("date"), fromDate));
			} else if (toDate != null) {
				predicates.add(cb.lessThanOrEqualTo(root.get("date"), toDate));
			}

			if (type != null) {
				predicates.add(cb.equal(root.get("type"), type));
			}

			if (categoryId != null) {
				predicates.add(cb.equal(root.get("category").get("id"), categoryId));
			}
			
			predicates.add(cb.equal(root.get("user").get("id"), userId));

			return cb.and(predicates.toArray(new Predicate[0]));
		};
	}
}
