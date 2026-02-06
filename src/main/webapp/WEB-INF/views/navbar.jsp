<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">


<style>
    .navbar-wrapper {
        background: #eef2f7;
        padding: 20px;
    }

    .navbar {
        max-width: 1200px;
        margin: auto;
        height: 64px;
        background:
            radial-gradient(circle at top left, rgba(255,255,255,0.15), transparent 40%),
            linear-gradient(135deg, #0d6efd, #003d99);
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 30px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    }

    .navbar-title {
        font-size: 20px;
        font-weight: 700;
        color: white;
        text-decoration: none;
    }

    .navbar-title:hover {
        opacity: 0.9;
    }

    .navbar-menu {
        display: flex;
        gap: 18px;
    }

    /* NAV LINKS */
    .navbar-menu a {
        color: rgba(255,255,255,0.9);
        text-decoration: none;              /* remove underline */
        font-size: 14px;
        font-weight: 600;
        padding: 8px 16px;                  /* space for hover box */
        border-radius: 20px;
        transition: all 0.25s ease;
    }

    /* LIGHT BOX HOVER EFFECT */
    .navbar-menu a:hover {
        background: rgba(255, 255, 255, 0.18); /* light box */
        color: #ffffff;
    }

    /* OPTIONAL ACTIVE STATE */
    .navbar-menu a.active {
        background: rgba(255, 255, 255, 0.25);
        color: #ffffff;
    }

    /* LOGOUT BUTTON */
    .logout-btn {
        background: white;
        border: none;
        color: #003d99;
        padding: 8px 18px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: 0.3s ease;
    }

    .logout-btn:hover {
        background: #dc2626;
        color: white;
    }

    @media (max-width: 768px) {
        .navbar-menu {
            display: none;
        }
    }
</style>

<div class="navbar-wrapper">
    <div class="navbar">

        <a href="dashboard" class="navbar-title">
            Finance Dashboard
        </a>

        <div class="navbar-menu">
            <a href="/transactions">Transactions</a>
            <a href="/addtransaction">Add Transaction</a>
            <a href="/budget">Budget</a>
            <a href="category">Category</a>
            <a href="report">Report</a>
        </div>

        <form action="logout" method="post" style="margin:0;">
            <button type="submit" class="logout-btn">Logout</button>
        </form>

    </div>
</div>
