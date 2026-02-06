# 💸 Personal Finance Management System (PFM)

![Java](https://img.shields.io/badge/Java-Programming-blue)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-Framework-green)
![Spring Security](https://img.shields.io/badge/Spring%20Security-Secure-brightgreen)
![OAuth2](https://img.shields.io/badge/OAuth2-Google%20Login-orange)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blueviolet)
![Redis](https://img.shields.io/badge/Redis-Caching-red)
![Docker](https://img.shields.io/badge/Docker-Containerization-blue)
![Chart.js](https://img.shields.io/badge/Chart.js-Analytics-yellow)
![PDF](https://img.shields.io/badge/PDF-Reports-critical)

A full-stack **Personal Finance Management System** built using **Spring Boot + JSP** to help users **track income/expenses**, manage **monthly budgets**, view **real-time analytics**, generate **PDF reports**, and interact with an **AI-powered finance assistant**.

This project focuses on **real-world backend practices**: authentication, caching, data filtering, pagination, dashboards, and AI integration.

---

## ✨ Key Features

### 🔐 Authentication & Security
- **Spring Security** authentication & authorization
- **Google OAuth2 login** (Sign in with Google)
- Secure user session handling

### 💰 Transactions (Income & Expense)
- Add income/expense transactions with categories
- **Edit / Delete transactions**
- **Monthly transaction list**
- **Pagination** for transaction listing
- **Filters**:
  - Type (Income / Expense)
  - Category
  - Date range

### 📊 Interactive Dashboard (4 Charts)
- **Category-wise Expense (Pie)**
- **Income vs Expense (Bar)**
- **Expense Trend (Line)**
- **Budget vs Actual Expense (Bar)**
✅ Charts auto-update based on the **current month** data.

### 🧾 Budget Module
- Set monthly budgets category-wise
- Track **Budget vs Actual** spending
- Highlights **within budget / over budget** status

### 📄 Reports
- Generate and download **PDF reports** (monthly finance report)
- Useful for sharing or maintaining records

### 🤖 AI Finance Assistant (Streaming)
- AI chat assistant that answers based on your **actual finance data**
- Supports queries like:
  - “What are my expenses this month?”
  - “Show budget status (within/over)”
  - “Explain my charts”
  - “How can I save money?”
- Uses **Server-Sent Events (SSE)** for **streaming responses** (live typing)

### ⚡ Performance Optimization (Redis Cache)
- Finance summaries cached per user + month using **Redis**
- Redis run via **Docker**
- Auto cache eviction when transactions/budgets change
- Faster AI responses (summary is reused for 10 minutes TTL)

---

## 🧠 Tech Stack

**Backend:** Java, Spring Boot, Spring MVC  
**Security:** Spring Security, Google OAuth2  
**Database:** PostgreSQL  
**Caching:** Redis (Docker)  
**AI:** Spring AI (Ollama model) + SSE Streaming  
**Frontend:** JSP, HTML, CSS, JavaScript  
**Charts:** Chart.js  
**Reports:** PDF generation

---

## 📐 Architecture

The project follows a **layered architecture**:

- **Controller Layer** → Handles routes & UI navigation
- **Service Layer** → Business logic (summary calc, AI prompt, caching, filters)
- **Repository Layer** → DB operations via Spring Data JPA
- **Entity Layer** → JPA entities (User, Transaction, Budget, Category)
- **DTO Layer** → Clean request handling (TransactionDTO, Filters)
- **Config Layer** → Security, Redis cache config, etc.

### 🔁 Flow (High Level)

```text
Client (JSP UI)
   ↓
Spring MVC Controllers
   ↓
Service Layer (Business Logic)
   ↓
Repository Layer (Spring Data JPA)
   ↓
PostgreSQL Database
   ↓
Redis Cache (for computed finance summary)
   ↓
AI Assistant (Spring AI + streaming SSE)
```
---

## ✅ What I Worked On (Implementation Highlights)

- Built complete Transaction + Budget workflows (CRUD + monthly logic)
- Implemented filters + pagination
- Designed dashboard UI and integrated 4 charts
- Integrated AI assistant with streaming SSE (EventSource)
- Implemented Redis caching for fast AI summaries + performance
- Implemented Google OAuth2 login
- Implemented PDF report generation

---

## 📽 Demo

A demo video is available on LinkedIn showcasing:

- Login (Security + OAuth2)
- Dashboard charts
- Transaction add/edit/delete + live chart update
- Budget module
- AI chat assistant
- PDF report download

--- 

## ⭐ Support

If you like this project:

- ⭐ Star this repository
- 🍴 Fork it
- 🛠 Contribute via PRs

---
