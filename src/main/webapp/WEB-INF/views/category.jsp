<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Categories</title>

<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', system-ui, sans-serif;
        background: linear-gradient(180deg, #eef2f7 0%, #f8fafc 100%);
        min-height: 100vh;
    }

    .page-container {
        max-width: 1100px;
        margin: 40px auto;
        padding: 35px;
        background: rgba(255, 255, 255, 0.96);
        border-radius: 22px;
        box-shadow:
            0 25px 50px rgba(0,0,0,0.12),
            inset 0 1px 0 rgba(255,255,255,0.6);
        animation: fadeIn 0.5s ease;
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

    .page-title {
		text-align:center;
        font-size: 26px;
        font-weight: 700;
        color: #1e293b;
        margin-bottom: 25px;
    }

    .table-wrapper {
        overflow-x: auto;
        border-radius: 14px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
        background: #ffffff;
    }

    thead {
        background: linear-gradient(135deg, #1e3a8a, #2563eb);
    }

    thead th {
        color: #ffffff;
        padding: 14px 16px;
        text-align: center;
        font-weight: 600;
        letter-spacing: 0.4px;
    }

    tbody tr {
        transition: background 0.2s ease;
    }

    tbody tr:nth-child(even) {
        background: #f8fafc;
    }

    tbody tr:hover {
        background: #eef2ff;
    }

    tbody td {
        padding: 14px 16px;
        color: #334155;
        border-bottom: 1px solid #e2e8f0;
		text-align: center;  
		vertical-align: middle; 
		
    }

   
    .badge {
        display: inline-block;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 700;
        letter-spacing: 0.5px;
    }

    .badge-income {
        background: #dcfce7;
        color: #16a34a;
    }

    .badge-expense {
        background: #fee2e2;
        color: #dc2626;
    }

    @media (max-width: 768px) {
        .page-container {
            margin: 20px;
            padding: 25px;
        }

        .page-title {
            font-size: 22px;
        }
    }
</style>

</head>
<body>

<jsp:include page="navbar.jsp" />

<%
           java.util.List<com.pfm.entity.Category> ctgs =(java.util.List<com.pfm.entity.Category>) request.getAttribute("categories");
%>

<div class="page-container">

    <div class="page-title">All Categories</div>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Category Name</th>
                    <th>Type</th>
                </tr>
            </thead>
            <tbody>
               <%
                	if(!ctgs.isEmpty())
                	{
                		for(com.pfm.entity.Category cat : ctgs)
                		{
                %>
                	<tr>
                    	<td><%=cat.getName()%></td>
                    	<td><span class="badge <%= cat.getType() == com.pfm.entity.TxnType.INCOME 
                    		? "badge-income" : "badge-expense" %>"><%=cat.getType()%></span></td>
               		</tr>
               	<%
                		}
                	}else{
               	%>
               		<tr>
                    	<td style="color: red">Categories Not Found!!!!</td>
               		</tr>
               		<%
               		}
               		%>
            </tbody>
        </table>
    </div>

</div>
<jsp:include page="header.jsp"/>

</body>
</html>
