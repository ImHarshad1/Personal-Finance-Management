<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="header.jsp"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Monthly Report</title>

<style>
/* ===== General ===== */
body {
    margin: 0;
    font-family: 'Segoe UI', system-ui, sans-serif;
    background: #eef2f7;
    min-height: 100vh;
}

.page-container {
    max-width: 1200px;
    margin: 40px auto;
    display: flex;
    gap: 30px;
    padding: 0 20px;
}

/* ===== FILTER CARD ===== */
.filter-card {
    width: 280px;
    background: #ffffff;
    border-radius: 18px;
    padding: 26px 22px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.12);
    align-self: flex-start;
}

.filter-card h3 {
    text-align: center;
    color: #1e293b;
    margin-bottom: 22px;
    margin-top: 0px;
    font-size: 25px;
    font-weight: 700;
}

.filter-group {
    margin-bottom: 18px;
}

/* ICON + LABEL */
.field-label {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    font-weight: 600;
    color: #64748b;
    margin-bottom: 6px;
}

.field-label i {
    color: #3b82f6;
    font-size: 13px;
}

.filter-group input,
.filter-group select {
    width: 100%;
    height: 44px;
    padding: 0 14px;
    border-radius: 10px;
    border: 1px solid #e2e8f0;
    font-size: 14px;
    color: #334155;
    background: #ffffff;
    box-sizing: border-box;
}

.filter-group input:focus,
.filter-group select:focus {
    border-color: #2563eb;
    box-shadow: 0 0 0 2px rgba(37,99,235,0.15);
    outline: none;
}

/* TYPE BUTTONS */
.type-buttons {
    display: flex;
    gap: 12px;
    margin-top: 10px;
}

.type-btn {
    flex: 1;
    height: 42px;
    border-radius: 10px;
    border: none;
    font-weight: 600;
    font-size: 13px;
    cursor: pointer;
    background: #e0e7ff;
    color: #1e3a8a;
    transition: all 0.2s;
}

.type-btn.active {
    background: #1e3a8a;
    color: #fff;
}

.type-btn:hover {
    background: #c7d2fe;
}

/* Apply Filter Button */
.apply-btn {
    width: 100%;
    height: 46px;
    margin-top: 14px;
    border-radius: 12px;
    border: none;
    background: linear-gradient(135deg, #2563eb, #1e3a8a);
    color: #fff;
    font-weight: 600;
    font-size: 14px;
    cursor: pointer;
}

.apply-btn:hover {
    background: linear-gradient(135deg, #2563eb, #0d6efd);
}

/* Clear Filters Button */
.clear-btn {
    width: 100%;
    height: 44px;
    margin-top: 10px;
    border-radius: 12px;
    border: 1px solid #c7d2fe;
    background: #ffffff;
    color: #1e3a8a;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s ease;
}

.clear-btn:hover {
    background: #eef2ff;
}

/* ===== REPORT CARD ===== */
.report-card {
    flex: 1;
    background: #ffffff;
    border-radius: 18px;
    padding: 24px;
    box-shadow: 0 12px 30px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
}

.report-card h2 {
    text-align: center;
    font-size: 26px;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 18px;
    margin-top: 0px;
}

/* TABLE */
table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 14px;
    overflow: hidden;
    font-size: 14px;
}

.table-wrapper {
    flex: 1;
    overflow-x: auto;
    margin-bottom: 24px;
}

thead {
    background: linear-gradient(135deg, #1e3a8a, #2563eb);
}

thead th {
    color: #ffffff;
    padding: 14px;
    text-align: center;
    font-size: 14px;
}

tbody td {
    padding: 14px;
    text-align: center;
    color: #475569;
}

tbody tr:nth-child(even) {
    background: #f8fafc;
}

.empty-row {
    text-align: center;
    padding: 25px 0;
    color: #64748b;
    font-style: italic;
}

.report-divider { 
    height: 1px;
    background: #e5e7eb; 
    margin: 16px 0 24px;
}

.download-btn {
    margin-top: auto;
    width: 100%;
    padding: 13px;
    background: linear-gradient(135deg, #2563eb, #1e3a8a);
    color: white;
    border: none;
    border-radius: 14px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
}

.download-btn:hover {
    background: linear-gradient(135deg, #2563eb, #0d6efd);
}

@media (max-width: 900px) {
    .page-container {
        flex-direction: column;
    }

    .filter-card {
        width: 100%;
    }
}
</style>
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<div class="page-container"> 

	    <!-- FILTERS -->
	    <div class="filter-card">
	        <h3>Filters</h3>

	        <form action="${pageContext.request.contextPath}/report" method="post" id="filterForm">

	            <div class="filter-group">
	                <div class="field-label">
	                    <i class="fa-solid fa-calendar"></i>
	                    <span>From Date</span>
	                </div>
	              	<input type="date" name="fromDate" value="${fromDate}" required>
	            </div>

	            <div class="filter-group">
	                <div class="field-label">
	                    <i class="fa-solid fa-calendar-check"></i>
	                    <span>To Date</span>
	                </div>
					<input type="date" name="toDate" value="${toDate}" required>
	            </div>
	            <div class="filter-group">
	                <div class="field-label">
	                    <i class="fa-solid fa-tag"></i>
	                    <span>Type</span>
	                </div>
	                <div class="type-buttons">
	                    <button type="button" class="type-btn" data-type="EXPENSE">EXPENSE</button>
	                    <button type="button" class="type-btn" data-type="INCOME">INCOME</button>
	                    <button type="button" class="type-btn" data-type="BOTH">BOTH</button>
	                </div>
	               
	              <input type="hidden" name="type" id="typeInput" value="${selectedType}">
	            </div>

	            <button type="submit" class="apply-btn">Apply Filters</button>
	            <button type="button" class="clear-btn" onclick="clearFilters()">Clear Filters</button>

	        </form>
	    </div>

	    <!-- REPORT -->
	    <div class="report-card">
	        <h2>Monthly Transactions</h2>
	        <div class="table-wrapper">
	            <table>
	                <thead>
	                    <tr>
	                        <th>Date</th>
	                        <th>Description</th>
	                        <th>Category</th>
	                        <th>Type</th>
	                        <th>Amount</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:choose>
	                        <c:when test="${not empty transactions}">
	                            <c:forEach var="txn" items="${transactions}">
	                                <tr>
	                                    <td>${txn.date}</td>
	                                    <td>${txn.description}</td>
	                                    <td>${txn.category.name}</td>
	                                    <td>${txn.type}</td>
	                                    <td>${txn.amount}</td>
	                                </tr>
	                            </c:forEach>
	                        </c:when>
	                        <c:otherwise>
	                            <tr>
	                                <td colspan="5" class="empty-row">
	                                    No transactions found for selected filters.
	                                </td>
	                            </tr>
	                        </c:otherwise>
	                    </c:choose>
	                </tbody>
	            </table>
	        </div>
	        <div class="report-divider"></div>
	        <button class="download-btn" type="button" onclick="downloadPdf()">
	            Download PDF
	        </button>
	    </div>

	</div>


	<script>
	const contextPath = "${pageContext.request.contextPath}";

	
	let currentFilters = {
	    fromDate: '${fromDate}',
	    toDate: '${toDate}',
	    type: '${selectedType}'
	};

	document.addEventListener('DOMContentLoaded', () => {
	    const typeButtons = document.querySelectorAll('.type-btn');
	    const typeInput = document.getElementById('typeInput');

	    const currentType = typeInput.value || 'EXPENSE';
	    const activeBtn = document.querySelector(`.type-btn[data-type="${currentType}"]`);
	    if (activeBtn) activeBtn.classList.add('active');

	    typeButtons.forEach(btn => {
	        btn.addEventListener('click', () => {
	            typeButtons.forEach(b => b.classList.remove('active'));
	            btn.classList.add('active');
	            typeInput.value = btn.getAttribute('data-type');
	        });
	    });
	});

	
	document.getElementById('filterForm').addEventListener('submit', function() {
	    currentFilters.fromDate = document.querySelector('input[name="fromDate"]').value;
	    currentFilters.toDate = document.querySelector('input[name="toDate"]').value;
	    currentFilters.type = document.getElementById('typeInput').value;
	});

	function clearFilters() {
	    const form = document.getElementById('filterForm');
	    form.reset();

	    document.querySelector('input[name="fromDate"]').value = '';
	    document.querySelector('input[name="toDate"]').value = '';

	    const typeButtons = document.querySelectorAll('.type-btn');
	    typeButtons.forEach(b => b.classList.remove('active'));

	    document.getElementById('typeInput').value = '';
	}

	function downloadPdf() {
		if (!currentFilters.fromDate || !currentFilters.toDate) {
		       alert("No data to download. Please apply filters first.");
		       return;
		   }
	   	    const url = contextPath + '/report/pdf?fromDate=' + currentFilters.fromDate + 
	                '&toDate=' + currentFilters.toDate + '&type=' + currentFilters.type;
	    
	    window.location.href = url;
	}
	</script>





</body>
</html>
