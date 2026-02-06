<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', system-ui, sans-serif;
		background: linear-gradient(135deg, #eef2ff, #f8fafc);
        min-height: 100vh;
    }

    .dashboard-container {
        max-width: 1200px;
        margin: 30px auto;
        padding: 40px;
        background: #ffffff;
        border-radius: 18px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
        animation: fadeIn 0.6s ease;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(15px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .dashboard-header {
        text-align: center;
        margin-bottom: 40px;
    }

    .dashboard-header h1 {
        margin: 0;
        font-size: 34px;
        color: #1e293b;
        font-weight: 700;
    }

    .dashboard-header span {
        color: #0d6efd;
    }

    .dashboard-header p {
        margin-top: 10px;
        font-size: 16px;
        color: #64748b;
    }

	.charts-grid {
	    display: grid;
	    grid-template-columns: repeat(2, 1fr);
	    gap: 32px;
	    margin-top: 30px;
	}

	.chart-card {
	    background: linear-gradient(180deg, #ffffff, #f9fafb);
	    padding: 26px;
		height: 420px;
	    border-radius: 20px;
	    box-shadow:
	        0 10px 25px rgba(0,0,0,0.08),
	        0 2px 8px rgba(0,0,0,0.04);
	    transition: transform 0.25s ease, box-shadow 0.25s ease;
	}
	
	.chart-card canvas {
	    max-height: 320px;
	}

	.chart-card:hover {
	    transform: translateY(-6px);
	    box-shadow:
	        0 18px 40px rgba(0,0,0,0.12),
	        0 6px 14px rgba(0,0,0,0.08);
	}

	.chart-card h3 {
	    margin-bottom: 18px;
	    color: #0f172a;
	    font-weight: 700;
	    font-size: 18px;
	    text-align: center;
	    letter-spacing: 0.3px;
	}
	.chart-card:hover h3 {
	    color: #2563eb;
	}

	canvas {
	    background: #ffffff;
	    padding: 12px;
	    border-radius: 14px;
	}


/*  Mobile responsive    */
	@media (max-width: 900px) {
	.charts-grid {
		grid-template-columns: 1fr;
	 	   }
	}

</style>

</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="dashboard-container">

    <!-- HEADER -->
    <div class="dashboard-header">
        <h1>Welcome, <span>${sessionScope.userName}</span></h1>
        <p>Your financial health snapshot</p>
    </div>

    <!-- CHARTS GRID -->
    <div class="charts-grid">

        <!-- Chart 1 -->
        <div class="chart-card">
            <h3>Category-wise Expense</h3>
            <canvas id="categoryExpenseChart"></canvas>
        </div>

        <!-- Chart 2 -->
        <div class="chart-card">
            <h3>Income vs Expense</h3>
            <canvas id="incomeExpenseChart"></canvas>
        </div>

        <!-- Chart 3 -->
        <div class="chart-card">
            <h3>Expense Trend</h3>
            <canvas id="expenseTrendChart"></canvas>
        </div>

        <!-- Chart 4 (future) -->
        <div class="chart-card">
            <h3>Budget vs Expense</h3>
            <canvas id="budgetExpenseChart"></canvas>
        </div>

    </div>
</div>
<jsp:include page="header.jsp"/>

<script>
/* ================= CHART 1: CATEGORY PIE ================= */

const categoryLabels = [];
const categoryValues = [];

<c:if test="${not empty categoryExpenseMap}">
<c:forEach var="entry" items="${categoryExpenseMap}">
    categoryLabels.push("${entry.key}");
    categoryValues.push(Number("${entry.value}"));
</c:forEach>
</c:if>

if (categoryLabels.length > 0) {
    new Chart(document.getElementById("categoryExpenseChart"), {
        type: "pie",
        data: {
            labels: categoryLabels,
            datasets: [{
                data: categoryValues,
				backgroundColor: [
				    "#22c55e",
				    "#f97316", 
				    "#3b82f6", 
				    "#ec4899", 
				    "#a855f7", 
				    "#20b2aa", 
				    "#facc15", 
				    "#06b6d4", 
				    "#ff4500", 
				    "#DC143C", 
				    "#6A5ACD", 
				    "#FF7F50"  
				]

            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: "bottom"
                }
            }
        }
    });
}

/* ================= CHART 2: INCOME vs EXPENSE ================= */

const totalIncome = Number("${totalIncome}");
const totalExpense = Number("${totalExpense}");

if (!isNaN(totalIncome) && !isNaN(totalExpense)) {
    new Chart(document.getElementById("incomeExpenseChart"), {
        type: "bar",
        data: {
            labels: ["Income", "Expense"],
            datasets: [{
                data: [totalIncome, totalExpense],
                backgroundColor: [
                    "rgba(34,197,94,0.85)",
                    "rgba(239,68,68,0.85)"
                ],
                borderRadius: 10,
                barThickness: 70
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: { beginAtZero: true },
                x: { grid: { display: false } }
            },
            plugins: {
                legend: { display: false }
            }
        }
    });
}

/* ================= CHART 3: EXPENSE TREND ================= */

const trendLabels = [];
const trendValues = [];

<c:if test="${not empty dateExpenseMap}">
<c:forEach var="entry" items="${dateExpenseMap}">
    trendLabels.push("${entry.key.toString()}");
    trendValues.push(Number("${entry.value}"));
</c:forEach>
</c:if>

if (trendLabels.length > 0) {
    new Chart(document.getElementById("expenseTrendChart"), {
        type: "line",
        data: {
            labels: trendLabels,
            datasets: [{
                label: "Daily Expense",
                data: trendValues,
                borderColor: "#2563eb",
                backgroundColor: "rgba(37,99,235,0.18)",
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: { beginAtZero: true },
                x: { grid: { display: false } }
            }
        }
    });
}

/* ===== CHART 4: BUDGET vs EXPENSE ===== */

const budgetLabels = [];
const budgetValues = [];
const actualExpenseValues = [];

<c:if test="${not empty budgetMap}">
<c:forEach var="entry" items="${budgetMap}">
    budgetLabels.push("${entry.key}");
    budgetValues.push(Number("${entry.value}"));
    actualExpenseValues.push(
        Number("${expenseMap[entry.key] != null ? expenseMap[entry.key] : 0}")
    );
</c:forEach>
</c:if>

if (budgetLabels.length > 0) {
    new Chart(document.getElementById("budgetExpenseChart"), {
        type: "bar",
        data: {
            labels: budgetLabels,
            datasets: [
                {
                    label: "Budget",
                    data: budgetValues,
                    backgroundColor: "rgba(59,130,246,0.8)",
                    borderRadius: 8
                },
                {
                    label: "Actual Expense",
                    data: actualExpenseValues,
                    backgroundColor: "rgba(239,68,68,0.8)",
                    borderRadius: 8
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: { beginAtZero: true },
                x: { grid: { display: false } }
            },
            plugins: {
                legend: {
                    position: "top"
                }
            }
        }
    });
}

</script>

</body>
</html>
