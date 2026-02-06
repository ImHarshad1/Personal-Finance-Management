<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transactions</title>

<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', system-ui, sans-serif;
        background: linear-gradient(180deg, #eef2f7, #f8fafc);
        min-height: 100vh;
    }

    .page-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px;
    }

    .content-grid {
        display: grid;
        grid-template-columns: 280px 1fr;
        gap: 30px;
    }

/* 	filter card */
    .filters-card {
        background: #ffffff;
        padding: 26px 22px;
        border-radius: 18px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.12);
    }

    .filters-card h3 {
        text-align: center;
        color: #1e293b;
        margin-bottom: 22px;
        margin-top: 0px;
        font-size: 25px;
        font-weight: 700;
    }

    .field-label {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        font-weight: 600;
        color: #64748b;
        margin-bottom: 6px;
    }

    .field-label i {
        color: #3b82f6;
        font-size: 13px;
    }

    .filter-group {
        margin-bottom: 18px;
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

    /* select arrow */
    .filter-group select {
        appearance: none;
        background-image:
          url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' fill='%2394a3b8' viewBox='0 0 16 16'%3E%3Cpath d='M1.5 5.5l6 6 6-6'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 14px center;
        padding-right: 40px;
    }

    /* TYPE BUTTONS */
    .type-buttons {
        display: flex;
        gap: 12px;
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
    }

    .type-btn:hover {
        background: #c7d2fe;
    }
	
	.type-btn.active {
	    background: #1e3a8a;
	    color: #fff;
	}

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
    

    /* TABLE */
    .table-card {
        background: #ffffff;
        padding: 24px;
        border-radius: 18px;
        box-shadow: 0 12px 30px rgba(0,0,0,0.1);
        max-width: 850px;
    	width: 100%;
    }

    .table-title {
        text-align: center;
        font-size: 26px;
        font-weight: 700;
        color: #1e293b;
        margin-bottom: 18px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 14px;
        overflow: hidden;
        font-size: 14px;
    }

    thead {
        background: linear-gradient(135deg, #1e3a8a, #2563eb);
    }

    thead th {
        color: #ffffff;
        padding: 14px;
        font-size: 14px;
        text-align: center;
    }

    tbody td {
        padding: 14px;
        text-align: center;
        border-bottom: 1px solid #e2e8f0;
        font-size: 14px;
        color: #475569;
    }

    tbody tr:nth-child(even) {
        background: #f8fafc;
    }

    .no-data {
        color: #dc2626;
        font-weight: 600;
        padding: 20px;
    }
    
    /* ===== ENHANCED SELECT (GLOBAL – TRANSACTIONS) ===== */
.enhanced-select {
    position: relative;
    width: 100%;
}

.enhanced-select select {
    appearance: none;
    width: 100%;
    cursor: pointer;
}

/* ===== PAGINATION ===== */
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin-top: 22px;
    padding-top: 14px;
    border-top: 1px solid #e2e8f0;
}

/* Pagination links */
.pagination a {
    min-width: 38px;
    height: 38px;
    padding: 0 12px;

    display: inline-flex;
    align-items: center;
    justify-content: center;

    font-size: 14px;
    font-weight: 600;
    text-decoration: none;

    border-radius: 10px;
    border: 1px solid #c7d2fe;

    background: #ffffff;
    color: #1e3a8a;

    transition: all 0.25s ease;
}

/* Hover effect */
.pagination a:hover {
    background: #eef2ff;
    transform: translateY(-1px);
}

/* Active page */
.pagination a.active {
    background: linear-gradient(135deg, #2563eb, #1e3a8a);
    color: #ffffff;
    border-color: transparent;
    box-shadow: 0 6px 18px rgba(37, 99, 235, 0.35);
}

/* Optional disabled look */
.pagination a.disabled {
    pointer-events: none;
    opacity: 0.5;
}



/* Dropdown panel */
.enhanced-select .dropdown {
    position: absolute;
    left: 0;
    width: 100%;
    max-height: 220px;           /* ~5 options */
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 16px 32px rgba(0,0,0,0.15);
    overflow-y: auto;
    opacity: 0;
    transform: translateY(-8px);
    pointer-events: none;
    transition: opacity 0.25s ease, transform 0.25s ease;
    z-index: 100;
    overscroll-behavior: contain; /* prevents page scroll */
}

.enhanced-select.open .dropdown {
    opacity: 1;
    transform: translateY(0);
    pointer-events: auto;
}

.enhanced-select .option {
    padding: 11px 14px;
    font-size: 14px;
    cursor: pointer;
    white-space: nowrap;
}

.enhanced-select .option:hover {
    background: rgba(37,99,235,0.12);
}

/* Scrollbar */
.enhanced-select .dropdown::-webkit-scrollbar {
    width: 6px;
}
.enhanced-select .dropdown::-webkit-scrollbar-thumb {
    background: #c7d2fe;
    border-radius: 10px;
}
    
    /* ===== FIX FILTER SELECT ALIGNMENT ===== */
.filter-group > .enhanced-select {
    width: 100%;
}

.filter-group > .enhanced-select > select {
    width: 100%;
    box-sizing: border-box;
}

.filter-group input {
    box-sizing: border-box;
}
    
/* ===== ACTION BUTTONS (EDIT / DELETE) ===== */
.action-cell {
    display: flex;
    justify-content: center;
    gap: 10px;
}

.action-btn {
    padding: 6px 14px;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 600;
    text-decoration: none;

    border: none;              
    outline: none;
    background: transparent;   
    cursor: pointer;

    display: inline-flex;
    align-items: center;
    justify-content: center;

    transition: all 0.25s ease;
}


/* Edit Button */
.edit-btn {
    background: #e0e7ff;
    color: #1e3a8a;
}

.edit-btn:hover {
    background: #c7d2fe;
    transform: translateY(-1px);
}

/* Delete Button */
.delete-btn {
    background: #ffe4e6;   
    color: #9f1239;
}

.delete-btn:hover {
    background: #fecdd3;
    transform: translateY(-1px);
}


/* ===== DELETE MODAL ===== */
.modal-overlay {
    position: fixed;
    inset: 0;
    background: rgba(15, 23, 42, 0.55);
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 999;
}

.modal-box {
    background: #ffffff;
    width: 360px;
    padding: 26px;
    text-align: center;
    box-shadow: 0 25px 60px rgba(0,0,0,0.25);
    animation: scaleIn 0.25s ease;
}

.modal-box h3 {
    margin: 0 0 10px;
    font-size: 20px;
    color: #1e293b;
}

.modal-box p {
    font-size: 14px;
    color: #475569;
    margin-bottom: 22px;
    line-height: 1.5;
}

.modal-actions {
    display: flex;
    gap: 12px;
}

.modal-btn {
    flex: 1;
    height: 42px;
    font-weight: 600;
    border: none;
    cursor: pointer;
}

/* Buttons */
.cancel-btn {
    background: #e5e7eb;
    color: #374151;
}

.cancel-btn:hover {
    background: #d1d5db;
}

.confirm-btn {
    background: linear-gradient(135deg, #dc2626, #b91c1c);
    color: #ffffff;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
}

.confirm-btn:hover {
    opacity: 0.95;
}

/* Animation */
@keyframes scaleIn {
    from {
        transform: scale(0.92);
        opacity: 0;
    }
    to {
        transform: scale(1);
        opacity: 1;
    }
}

/* ===== DASHBOARD SUCCESS MESSAGE ===== */
.alert-success {
    max-width: 880px;
    margin: 18px auto 28px;
    padding: 14px 20px;

    display: flex;
    align-items: center;
    gap: 12px;

    background: #ffffff;
    color: #0f766e;

    border-radius: 16px;
    border-left: 6px solid #22c55e;

    box-shadow: 0 10px 28px rgba(0, 0, 0, 0.08);

    font-size: 14.5px;
    font-weight: 600;

    animation: slideFadeIn 0.4s ease;
}

/* Icon */
.alert-success::before {
    content: "✓";
    width: 28px;
    height: 28px;

    display: flex;
    align-items: center;
    justify-content: center;

    background: #22c55e;
    color: #ffffff;

    border-radius: 50%;
    font-size: 15px;
    flex-shrink: 0;
}

/* Entrance animation */
@keyframes slideFadeIn {
    from {
        opacity: 0;
        transform: translateY(-8px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}



</style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<%
 java.util.List<com.pfm.entity.Transaction> txns = 
		 (java.util.List<com.pfm.entity.Transaction>) request.getAttribute("txns");
%>

<%
    String successMessage = (String) request.getAttribute("successMessage");
%>

<% if (successMessage != null) { %>
    <div class="alert-success">
        <%= successMessage %>
    </div>
<% } %>



<div class="page-container">
    <div class="content-grid">

        <!-- FILTERS -->
        <form class="filters-card" action="transactions" method="post">

            <h3>Filters</h3>

            <div class="filter-group">
                <div class="field-label">
                    <i class="fa-solid fa-list"></i>
                    <span>Type</span>
                </div>
				<div class="type-buttons">
				    <button type="button" class="type-btn ${selectedType == 'EXPENSE' ? 'active' : ''}" data-type="EXPENSE">EXPENSE</button>
				    <button type="button" class="type-btn ${selectedType == 'INCOME' ? 'active' : ''}" data-type="INCOME">INCOME</button>
				</div>
				<input type="hidden" name="type" id="typeInput" value="${selectedType}">
            </div>

            <div class="filter-group">
                <div class="field-label">
                    <i class="fa-solid fa-tags"></i>
                    <span>Category</span>
                </div>
               
				<select name="category"> 
				    <option value="">Select Category</option>

				    <c:choose>
				        <c:when test="${not empty categories}">
				            <c:forEach var="c" items="${categories}">
				                <option value="${c.id}" 
				                    ${filter.category != null && filter.category == c.id ? "selected" : ""}>
				                    ${c.name}
				                </option>
				            </c:forEach>
				        </c:when>
				        <c:otherwise>
				            <option disabled>No Categories Found</option>
				        </c:otherwise>
				    </c:choose>
				</select>
            </div>

            <div class="filter-group">
                <div class="field-label">
                    <i class="fa-solid fa-calendar"></i>
                    <span>From Date</span>
                </div>
                <input type="date" name="fromDate" value="${filter.fromDate}">
            </div>

            <div class="filter-group">
                <div class="field-label">
                    <i class="fa-solid fa-calendar-check"></i>
                    <span>To Date</span>
                </div>
                <input type="date" name="toDate" value="${filter.toDate}">
            </div>

            <button class="apply-btn">Apply Filters</button>
			<button type="button"
			        class="clear-btn"
			        onclick="window.location.href='transactions'">
			    Clear Filters
			</button>
            
        </form>

        <!-- TABLE -->
        <div class="table-card">
            <div class="table-title">Monthly Transactions</div>

            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Type</th>
                        <th>Amount</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    	if(txns!=null && !txns.isEmpty())
                    	{
                    		for(com.pfm.entity.Transaction txn : txns)
                    		{
                    %>		
                    			 <tr>
                        				<td><%=txn.getDate() %></td>
                        				<td><%=txn.getDescription()%></td>
                        				<td><%=txn.getCategory().getName()%></td>
                        				<td><%=txn.getType()%></td>
                        				<td><%=txn.getAmount()%></td>
										
									
									<td class="action-cell">
									    <a class="action-btn edit-btn" href="/edit?tid=<%= txn.getId()%>">Edit</a>

									    <button 
									        type="button"
									        class="action-btn delete-btn"
									        onclick="openDeleteModal(<%= txn.getId() %>)">
									        Delete
									    </button>
									</td>

										
                    			</tr>
                    <%
                    		}
                    	}else{
                    %>
                   				<tr>
                        				<td colspan="6" class="no-data">No Transactions Found</td>
                    			</tr>
                    <%
                    	}
                    %>
                </tbody>
            </table>
				<%-- <tbody>
				    <c:choose>
				        <c:when test="${not empty txns}">
				            <c:forEach var="txn" items="${txns}">
				                <tr>
				                    <td>${txn.date}</td>
				                    <td>${txn.description}</td>
				                    <td>${txn.category.name}</td>
				                    <td>${txn.type}</td>
				                    <td>${txn.amount}</td>

				                    <td class="action-cell">
				                        <a class="action-btn edit-btn" href="/edit?tid=${txn.id}">Edit</a>

				                        <button 
				                            type="button"
				                            class="action-btn delete-btn"
				                            onclick="openDeleteModal(${txn.id})">
				                            Delete
				                        </button>
				                    </td>
				                </tr>
				            </c:forEach>
				        </c:when>

				        <c:otherwise>
				            <tr>
				                <td colspan="6" class="no-data">No Transactions Found</td>
				            </tr>
				        </c:otherwise>
				    </c:choose>
				</tbody>
			</table> --%>

			<!-- ===== PAGINATION ===== -->
			<c:if test="${totalPages > 1}">
			    <div class="pagination">

			        <c:set var="typeParam" value="${filter.type != null ? filter.type : ''}" />
			        <c:set var="categoryParam" value="${filter.category != null ? filter.category : ''}" />
			        <c:set var="fromDateParam" value="${filter.fromDate != null ? filter.fromDate : ''}" />
			        <c:set var="toDateParam" value="${filter.toDate != null ? filter.toDate : ''}" />

			        <!-- Previous Button -->
			        <c:if test="${currentPage > 0}">
			            <a class="page-btn" href="transactions?page=${currentPage - 1}
			                <c:if test='${typeParam != ""}'> &type=${typeParam}</c:if>
			                <c:if test='${categoryParam != ""}'> &category=${categoryParam}</c:if>
			                <c:if test='${fromDateParam != ""}'> &fromDate=${fromDateParam}</c:if>
			                <c:if test='${toDateParam != ""}'> &toDate=${toDateParam}</c:if>">
			                Previous
			            </a>
			        </c:if>

			        <!-- Page Numbers -->
			        <c:forEach begin="0" end="${totalPages - 1}" var="i">
			            <a class="page-btn ${i == currentPage ? 'active' : ''}" href="transactions?page=${i}
			                <c:if test='${typeParam != ""}'> &type=${typeParam}</c:if>
			                <c:if test='${categoryParam != ""}'> &category=${categoryParam}</c:if>
			                <c:if test='${fromDateParam != ""}'> &fromDate=${fromDateParam}</c:if>
			                <c:if test='${toDateParam != ""}'> &toDate=${toDateParam}</c:if>">
			                ${i + 1}
			            </a>
			        </c:forEach>

			        <!-- Next Button -->
			        <c:if test="${currentPage < totalPages - 1}">
			            <a class="page-btn" href="transactions?page=${currentPage + 1}
			                <c:if test='${typeParam != ""}'> &type=${typeParam}</c:if>
			                <c:if test='${categoryParam != ""}'> &category=${categoryParam}</c:if>
			                <c:if test='${fromDateParam != ""}'> &fromDate=${fromDateParam}</c:if>
			                <c:if test='${toDateParam != ""}'> &toDate=${toDateParam}</c:if>">
			                Next
			            </a>
			        </c:if>

			    </div>
			</c:if>


			


			
        </div>

    </div>
</div>

<!-- DELETE CONFIRM MODAL -->
<div id="deleteModal" class="modal-overlay">
    <div class="modal-box">
        <h3>Delete Transaction</h3>
        <p>Are you sure you want to delete this transaction?<br>This action cannot be undone.</p>

        <div class="modal-actions">
            <button class="modal-btn cancel-btn" onclick="closeDeleteModal()">Cancel</button>
            <a id="confirmDeleteBtn" class="modal-btn confirm-btn">Delete</a>
        </div>
    </div>
</div>


</body>
<jsp:include page="header.jsp"/>

<script>
document.addEventListener("DOMContentLoaded", () => {
	
	const buttons = document.querySelectorAll(".type-btn");
	  	   buttons.forEach(btn => {
	       btn.addEventListener("click", function () {

	        
	          document.getElementById("typeInput").value = this.dataset.type;

	           
	           buttons.forEach(b => b.classList.remove("active"));
	           this.classList.add("active");
	       });
	   });

	   function clearFilters() {
		document.querySelectorAll(".type-btn")
		        .forEach(btn => btn.classList.remove("active"));
	       window.location.href = '/transactions';
	   }
	   
    document.querySelectorAll(".filter-group select").forEach(select => {

        // Prevent double enhancement
        if (select.dataset.enhanced === "true") return;
        select.dataset.enhanced = "true";

        const wrapper = document.createElement("div");
        wrapper.className = "enhanced-select";

        const dropdown = document.createElement("div");
        dropdown.className = "dropdown";

        // Build options
        Array.from(select.options).forEach(option => {
            if (!option.value) return;

            const div = document.createElement("div");
            div.className = "option";
            div.textContent = option.textContent;

            div.addEventListener("click", () => {
                select.value = option.value;
                select.dispatchEvent(new Event("change", { bubbles: true }));
                wrapper.classList.remove("open");
            });

            dropdown.appendChild(div);
        });

        // Prevent page scroll while scrolling dropdown
        dropdown.addEventListener("wheel", e => {
            e.stopPropagation();
        });

        // Wrap select
        select.parentNode.insertBefore(wrapper, select);
        wrapper.appendChild(select);
        wrapper.appendChild(dropdown);

        // Toggle dropdown
        select.addEventListener("mousedown", e => {
            e.preventDefault();
            e.stopPropagation();

            // Close other dropdowns
            document.querySelectorAll(".enhanced-select.open")
                .forEach(el => el !== wrapper && el.classList.remove("open"));

            // Auto direction (up/down)
            dropdown.style.top = "";
            dropdown.style.bottom = "";

            const rect = wrapper.getBoundingClientRect();
            const dropdownHeight = dropdown.scrollHeight;
            const spaceBelow = window.innerHeight - rect.bottom;
            const spaceAbove = rect.top;

            if (spaceBelow < dropdownHeight && spaceAbove > dropdownHeight) {
                dropdown.style.bottom = "calc(100% + 6px)";
            } else {
                dropdown.style.top = "calc(100% + 6px)";
            }

            wrapper.classList.toggle("open");
        });

        // Close on outside click
        document.addEventListener("click", e => {
            if (!wrapper.contains(e.target)) {
                wrapper.classList.remove("open");
            }
        });

        // Close on ESC
        document.addEventListener("keydown", e => {
            if (e.key === "Escape") {
                wrapper.classList.remove("open");
            }
        });

    });

});

//
function openDeleteModal(tid) {
    const modal = document.getElementById("deleteModal");
    const confirmBtn = document.getElementById("confirmDeleteBtn");

    confirmBtn.href = "/delete?tid=" + tid;
    modal.style.display = "flex";
}

function closeDeleteModal() {
    document.getElementById("deleteModal").style.display = "none";
}

/* Close modal on background click */
document.getElementById("deleteModal").addEventListener("click", e => {
    if (e.target.id === "deleteModal") {
        closeDeleteModal();
    }
});

    setTimeout(() => {
        const alert = document.querySelector('.alert-success');
        if (alert) {
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-6px)';
            setTimeout(() => alert.remove(), 400);
        }
    }, 3000);

</script>
</html>
