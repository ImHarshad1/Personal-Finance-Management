# 💸 Personal Finance Management Project

![Java](https://img.shields.io/badge/Java-Programming-blue)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-Framework-green) 
![Hibernate](https://img.shields.io/badge/Hibernate-ORM-orange)
![JPA](https://img.shields.io/badge/JPA-Persistence-yellow)
![Lombok](https://img.shields.io/badge/Lombok-Annotations-lightgrey)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blueviolet)
![RESTful API](https://img.shields.io/badge/REST-API-success)
![Postman](https://img.shields.io/badge/Postman-Testing-critical)
![Spring Security](https://img.shields.io/badge/Spring%20Security-Secure-brightgreen)

A professional **Spring Boot project** for **Personal Finance Management (PFM)** that helps users **track, manage, and analyze** their income, expenses, budgets, and savings.  
This project demonstrates **industry-standard practices** for building scalable and secure financial applications.

---

## ✨ Features

- **👤 User Profile Management** – Register and manage user accounts with secure authentication.  
- **💰 Expense & Income Tracking** – Record daily expenses and income with categories.  
- **📊 Budget Planning** – Create monthly/annual budgets and monitor spending against limits.  
- **📜 Transaction History** – Maintain detailed logs of all financial activities.  
- **📈 Analytics & Reports** – Generate insights with charts and summaries for better decision-making.  
- **🔐 Security** – Authentication and authorization using Spring Security with role-based access.  
- **📄 Export Data** – Generate **PDF/Excel reports** for expenses, income, and budgets.  

---

## 📐 Architecture

The project follows a **multi-layered architecture** ensuring separation of concerns:

- **Controller Layer** (`controller/`) → Handles incoming HTTP requests, maps endpoints, and returns responses.  
- **DTO Layer** (`dto/`) → Defines Data Transfer Objects for clean request/response handling.  
- **Entity Layer** (`entity/`) → Contains JPA entities representing database tables.  
- **Service Layer** (`service/`) → Implements business logic, validations, and orchestrates between controllers and repositories.  
- **Repository Layer** (`repository/`) → Interfaces with the database using Spring Data JPA.  
- **Configuration Layer** (`config/`) → Manages application-wide configurations such as security, CORS, and beans.  
- **Utils Layer** (`utils/`) → Provides helper functions like report generation and common utilities.  

---

### 🔁 Application Architecture Flow

```text
+-------------------+   +---------------------+   +-------------------------+   +------------------+
| Client (Postman)  | → |   Spring Security   | → |  REST Controller Layer  | → |     DTO Layer    |
|        / UI       |   |    AuthN & AuthZ    |   |     (API Endpoints)     |   |  (Data Transfer) |
+-------------------+   +---------------------+   +-------------------------+   +------------------+
                                                               |
                                                               v
+-------------------+   +-------------------------+   +----------------------+   +------------------+
|   Service Layer   | → |     Repository Layer    | → |      Entity Layer     | → |    PostgreSQL   |
| (Business Logic)  |   |  (JPA / Hibernate ORM)  |   |      (DB Mapping)     |   |        DB       |
+-------------------+   +-------------------------+   +-----------------------+   +-----------------+

                                     +----------------------------+
                                     |         Utils Layer        |
                                     | (Reports / Common Helpers) |
                                     +----------------------------+

```

## ⭐ Support 
If you like my work: 
⭐ Star my repositories 
🍴 Fork them 
🛠 Submit pull requests 

---
