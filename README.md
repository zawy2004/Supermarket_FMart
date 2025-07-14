# FMart Supermarket Management System


**FPT University – Da Nang, June 2025**

---

## Overview

FMart is a modern supermarket management system designed for FPT University, supporting both online and in-store sales, inventory management, order processing, user management, promotions, reporting, and more for admins, staff, and customers.

---

## Key Features

- User registration, login, account management
- Browse products, search, view details, ratings, and product recommendations
- Add to cart, apply coupons, checkout and payment
- Order management: history, tracking, cancelation, invoice printing
- Inventory management: real-time stock, stock-in/out, low stock alerts
- Admin dashboard: user/role management, products, categories, promotions, reporting
- Staff dashboard: process orders, confirm payments, inventory check
- Reporting: revenue, best-selling products, customer trends

---

## User Roles

- **Admin:** Full system control
- **Customer:** Shop, track orders, rate products
- **Staff:** Process orders, manage inventory
- **Guest:** Browse products only
- **Management:** View analytics and reports

---

## System Modules

- **Account:** Registration, login, profile, password reset/change
- **Product:** Listing, searching, details, ratings, recommendations
- **Order & Cart:** Cart, order placement, checkout, tracking/cancelation
- **Inventory:** Stock management, stock-in/out, restock requests
- **Dashboards:** Admin and staff functionalities
- **Promotions:** Discount codes, campaigns
- **Reports:** Revenue, stock, customer trends

---

## Database Design (Brief)

- **Tables:** Users, Products, Categories, Suppliers, Inventory, Orders, OrderDetails, ShoppingCart, Payments, Promotions, Coupons, Reviews, Wishlist, StockMovements, etc.
- All tables enforce foreign keys and data integrity

---

## Business Rules (Summary)

- Secure registration, login, and user data management
- Guests and customers can browse, shop, and apply promotions (if eligible)
- Staff manage orders, inventory, and confirm payments
- Admins have full management, permissions, reports, and promotions control

---

## Assumptions & Limitations

- Users must have internet access
- Third-party integration: payment, shipping (VNPay, GHN, etc.)
- No order via phone, no pre-orders or installments, no ordering unavailable products

---

## Quick Start Guide

1. **Clone the project:**
   ```bash
   git clone https://github.com/zawy2004/Supermarket_FMart.git
