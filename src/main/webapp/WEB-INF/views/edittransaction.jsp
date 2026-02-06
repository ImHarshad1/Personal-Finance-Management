<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Transaction</title>

<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', system-ui, sans-serif;
        background: #eef2f7;
        min-height: 100vh;
    }

    .page-container {
        max-width: 1200px;
        margin: 40px auto;
        padding: 0;
        background: transparent;
    }

    .page-title {
        text-align: center;
        font-size: 26px;
        font-weight: 700;
        color: #1e293b;
        margin-bottom: 6px;
    }

    .page-subtitle {
        text-align: center;
        color: #64748b;
        font-size: 14px;
        margin-bottom: 32px;
    }

    .transaction-card {
        max-width: 520px;
        margin: 0 auto;
        padding: 42px 38px 46px;
        background: #ffffff;
        border-radius: 20px;
        box-shadow: 0 25px 55px rgba(0,0,0,0.14);
    }

    .form-group {
        margin-bottom: 20px;
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

    .form-group input,
    .form-group select {
        width: 100%;
        height: 46px;
        padding: 0 14px;
        border-radius: 10px;
        border: 1px solid #e2e8f0;
        font-size: 14px;
        color: #334155;
        background-color: #ffffff;
        box-sizing: border-box;
    }

    .form-group select {
        appearance: none;
        background-image:
            url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%2394a3b8' viewBox='0 0 16 16'%3E%3Cpath d='M1.5 5.5l6 6 6-6'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 14px center;
        background-size: 14px;
        padding-right: 42px;
    }

    .form-group input:focus,
    .form-group select:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 2px rgba(37,99,235,0.15);
        outline: none;
    }

    .save-btn {
        width: 100%;
        height: 46px;
        border-radius: 10px;
        border: none;
        background: linear-gradient(135deg, #0d6efd, #003d99);
        color: #fff;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        margin-top: 8px;
    }
    
/* ===== ENHANCED SELECT (GLOBAL) ===== */
.enhanced-select {
    position: relative;
    width: 100%;
}

.enhanced-select select {
    appearance: none;
    width: 100%;
    box-sizing: border-box;
    cursor: pointer;
}

/* Dropdown panel */
.enhanced-select .dropdown {
    position: absolute;
    left: 0;
    width: 100%;
    max-height: 220px;            /* ~5 options */
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 16px 32px rgba(0,0,0,0.15);
    overflow-y: auto;
    opacity: 0;
    transform: translateY(-8px);
    pointer-events: none;
    transition: opacity 0.25s ease, transform 0.25s ease;
    z-index: 50;
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
    background: rgba(0,123,255,0.12);
}

/* Scrollbar */
.enhanced-select .dropdown::-webkit-scrollbar {
    width: 6px;
}
.enhanced-select .dropdown::-webkit-scrollbar-thumb {
    background: #c7d2fe;
    border-radius: 10px;
}

/* FIX input/select alignment */
.form-group > .enhanced-select {
    width: 100%;
}

.form-group > .enhanced-select > select {
    width: 100%;
    box-sizing: border-box;
}

.form-group input {
    box-sizing: border-box;
}


</style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<%
java.util.List<com.pfm.entity.Category> ctgs =
    (java.util.List<com.pfm.entity.Category>) request.getAttribute("categories");

com.pfm.dto.TransactionDTO txn = (com.pfm.dto.TransactionDTO)request.getAttribute("dto");
%>

<div class="page-container">

    <div class="transaction-card">
        <div class="page-title">Edit Transaction</div>
        <div class="page-subtitle">Edit an existing transaction</div>
		<p style="color : green">${msg}</p>
        <form action="edittransaction?id=<%=txn.getId()%>" method="post">
        
          <input type="hidden" name="id"  value="" >
        
      
            <div class="form-group">
                <div class="field-label">
                    <i class="fa-solid fa-indian-rupee-sign"></i>
                    <span>Amount</span>
                </div>
                <input type="number" name="amount" placeholder="Enter amount" value="<%=txn.getAmount()%>" required>
            </div>
			
            <div class="form-group">
                <div class="field-label">
                    <i class="fa-solid fa-file-lines"></i>
                    <span>Description</span>
                </div>
                <input type="text" name="description" placeholder="Enter Description" value="<%=txn.getDescription() %>" required>
            </div>

            <div class="form-group">
                <div class="field-label">
                    <i class="fa-solid fa-calendar-days"></i>
                    <span>Date</span>
                </div>
                <input type="date" name="date" value="<%=txn.getDate()%>" required>
            </div>

            <div class="form-group">
                <div class="field-label">
                    <i class="fa-solid fa-tags"></i>
                    <span>Category</span>
                </div>
                <select name="catId" required>
                    <option value="<%=txn.getCategory().getId()%>"><%=txn.getCategory().getName()%></option>
                    <%
                    if (ctgs != null && !ctgs.isEmpty()) {
                        for (com.pfm.entity.Category c : ctgs) {
                    %>
                        <option value="<%=c.getId()%>"><%=c.getName()%></option>
                    <%
                        }
                    } else {
                    %>
                        <option disabled>No Categories Found</option>
                    <%
                    }
                    %>
                </select>
            </div>

            <button class="save-btn">Update Transaction</button>
        </form>
    </div>

</div>

</body>

<script>
document.addEventListener("DOMContentLoaded", () => {

    document.querySelectorAll(".form-group select").forEach(select => {

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

        // Prevent page scrolling while scrolling dropdown
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
</script>



</html>
