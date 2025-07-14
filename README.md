# FMart Supermarket Management System

**FPT University – Da Nang, June 2025**

---

## 📝 Overview

**FMart** is a modern supermarket management system developed as a capstone project for FPT University. The system leverages **Java Servlet technology**, runs on **Tomcat 10**, uses **Microsoft SQL Server** as the database, and integrates **AI-powered product recommendation** features.  
It supports both online and in-store operations: inventory, order, user, promotion management, reporting, and intelligent recommendations, with separate dashboards for admins, staff, and customers.

---

## 🚀 Key Features

- User registration, login, account and profile management
- Browse/search products, view details, customer ratings, and **AI-powered product recommendations**
- Add to cart, apply coupons, checkout and payment
- Order management: order history, tracking, cancellation, invoice printing
- Inventory management: real-time stock, stock-in/out, low-stock alerts
- **Admin dashboard:** user & role management, product/category/promotion management, advanced reporting
- **Staff dashboard:** process orders, confirm payments, inventory check & restock
- **Analytics & reports:** revenue, best-sellers, customer trends

---

## 👤 User Roles

- **Admin:** Full system control (user/role, products, promotions, analytics)
- **Management:** View analytics and business reports
- **Staff:** Process orders, confirm payments, manage inventory
- **Customer:** Shop, order, track, review products, get AI recommendations
- **Guest:** Browse products only

---

## 🛠️ Technologies Used

- **Backend:** Java Servlet API (Jakarta EE)
- **Application Server:** Tomcat 10.x
- **Database:** Microsoft SQL Server
- **Frontend:** JSP, HTML5, CSS3, JavaScript (Bootstrap)
- **AI/Recommendation:** Embedded AI module (Java-based or via RESTful API) for personalized product suggestions
- **Other:** JDBC, JSTL, Apache Commons, (optionally) Maven or Gradle for dependency management

---

## ⚙️ System Architecture

- **Multi-layered:** Controller (Servlet) – Service – DAO – Database
- **Session-based authentication & authorization**
- **MVC Pattern**: JSP views, Servlet controllers, Java beans/models
- **AI Recommendation**: Hybrid filtering (content & collaborative) using in-database logic and external Java modules

---

## 📦 System Modules

- **Account:** Registration, login, user profile, password reset/change, roles & permissions
- **Product:** Listing, search, details, customer ratings, **AI recommendations**
- **Order & Cart:** Cart management, checkout, payment, order tracking, cancellation
- **Inventory:** Stock management, stock-in/out, restock requests, alerts
- **Dashboard:** Admin & staff-specific management tools
- **Promotions:** Discount codes, campaign management, coupon validation
- **Reports:** Revenue, inventory, best-sellers, customer insights

---

## 🗄️ Database Design (Brief)

- **Main tables:**  
  - Users, Roles, Products, Categories, Suppliers  
  - Inventory, Orders, OrderDetails, ShoppingCart  
  - Payments, Promotions, Coupons  
  - Reviews, Wishlist, StockMovements, AI_Recommendations
- **All tables** use primary/foreign keys, constraints, and stored procedures where needed.

---

## 📋 Business Rules

- Secure registration, password encryption, session management
- Permissions enforced strictly by user role (Servlet Filter/Interceptor)
- Only available products can be ordered; promotions/coupons validated at checkout
- AI recommends products based on user profile, history, and trending products
- Only admins can view analytics, manage users/roles, or modify system-wide settings

---

## ⚠️ Assumptions & Limitations

- Requires Java 17+, Tomcat 10+, SQL Server 2019+
- Users must access via a web browser; no mobile app in this version
- Internet connection required for online features and AI API if external
- 3rd-party payment/shipping integration optional (VNPay, GHN, etc.)
- No phone orders, pre-orders, installments, or out-of-stock purchases

---

## 🚦 Quick Start Guide

### 1. Clone the project

```bash
git clone https://github.com/zawy2004/Supermarket_FMart.git
cd Supermarket_FMart
