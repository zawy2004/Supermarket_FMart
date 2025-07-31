<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="FMart Supermarket Admin - Order Management">
    <meta name="author" content="FMart">
    <title>Order Details - FMart Admin</title>
    
    <!-- Stylesheets -->
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/css/admin-style.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    
    <style>
        .order-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .order-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            margin: 0.25rem;
        }
        
        .status-pending { background: #fff3cd; color: #856404; }
        .status-confirmed { background: #d1ecf1; color: #0c5460; }
        .status-processing { background: #cce5ff; color: #004085; }
        .status-completed { background: #d4edda; color: #155724; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
        
        .info-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border: 1px solid #e3e6f0;
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid #f8f9fc;
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #5a5c69;
            display: flex;
            align-items: center;
        }
        
        .info-label i {
            margin-right: 0.5rem;
            color: #858796;
        }
        
        .info-value {
            color: #3a3b45;
            font-weight: 500;
        }
        
        .order-table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .table thead th {
            background: #f8f9fc;
            border: none;
            font-weight: 600;
            color: #5a5c69;
            padding: 1rem;
        }
        
        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-color: #e3e6f0;
        }
        
        .table tbody tr:hover {
            background-color: #f8f9fc;
        }
        
        .total-summary {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border: 1px solid #e3e6f0;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid #f8f9fc;
        }
        
        .total-row:last-child {
            border-bottom: 2px solid #667eea;
            font-weight: 700;
            font-size: 1.1rem;
            color: #667eea;
        }
        
        .breadcrumb {
            background: transparent;
            padding: 0;
            margin-bottom: 2rem;
        }
        
        .breadcrumb-item a {
            color: #667eea;
            text-decoration: none;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .btn-custom {
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            border: none;
            transition: all 0.3s ease;
        }
        
        .btn-primary-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-secondary-custom {
            background: #e3e6f0;
            color: #5a5c69;
        }
        
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        
        .section-title {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            color: #5a5c69;
        }
        
        .section-title i {
            margin-right: 0.75rem;
            color: #667eea;
        }
    </style>
</head>

<body class="sb-nav-fixed">
    <jsp:include page="header.jsp"></jsp:include>

    <div id="layoutSidenav">
        <jsp:include page="staffsidebar.jsp"></jsp:include>
        
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <!-- Breadcrumb -->
                    <nav aria-label="breadcrumb" class="mt-4">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="AdminServlet"><i class="fas fa-home"></i> Dashboard</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="OrderManagementServlet"><i class="fas fa-shopping-cart"></i> Orders</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">Order Details</li>
                        </ol>
                    </nav>

                    <!-- Order Header -->
                    <div class="order-header">
                        <div class="row align-items-center">
                            <div class="col-lg-8">
                                <h1 class="mb-2"><i class="fas fa-receipt me-3"></i>Order Invoice</h1>
                                <h3 class="mb-0">Order #${order.orderNumber}</h3>
                            </div>
                            <div class="col-lg-4 text-end">
                                <div class="order-badge status-${order.status.toLowerCase()}">
                                    <i class="fas fa-circle me-2"></i>${order.status}
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Order Information -->
                        <div class="col-lg-6">
                            <div class="info-card">
                                <h4 class="section-title">
                                    <i class="fas fa-info-circle"></i>Order Information
                                </h4>
                                
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-calendar-alt"></i>Order Date
                                    </span>
                                    <span class="info-value">
                                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                    </span>
                                </div>
                                
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-tag"></i>Order Type
                                    </span>
                                    <span class="info-value">${order.orderType}</span>
                                </div>
                                
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-credit-card"></i>Payment Method
                                    </span>
                                    <span class="info-value">${order.paymentMethod}</span>
                                </div>
                                
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-check-circle"></i>Payment Status
                                    </span>
                                    <span class="info-value">
                                        <span class="order-badge status-${order.paymentStatus.toLowerCase()}">
                                            ${order.paymentStatus}
                                        </span>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Delivery Information -->
                        <div class="col-lg-6">
                            <div class="info-card">
                                <h4 class="section-title">
                                    <i class="fas fa-shipping-fast"></i>Delivery Information
                                </h4>
                                
                                <div class="info-item">
                                    <span class="info-label">
                                        <i class="fas fa-map-marker-alt"></i>Delivery Address
                                    </span>
                                    <span class="info-value">${order.deliveryAddress}</span>
                                </div>
                                
                                <c:if test="${not empty order.notes}">
                                    <div class="info-item">
                                        <span class="info-label">
                                            <i class="fas fa-sticky-note"></i>Notes
                                        </span>
                                        <span class="info-value">${order.notes}</span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Order Details Table -->
                    <div class="row">
                        <div class="col-12">
                            <div class="order-table">
                                <h4 class="section-title p-3 mb-0">
                                    <i class="fas fa-list-ul"></i>Order Items
                                </h4>
                                
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 50px;">#</th>
                                                <th>Product</th>
                                                <th class="text-center">Unit Price</th>
                                                <th class="text-center">Quantity</th>
                                                <th class="text-center">Discount %</th>
                                                <th class="text-center">Discount Amount</th>
                                                <th class="text-center">Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${orderDetails}" varStatus="loop">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center justify-content-center">
                                                            <span class="badge bg-light text-dark">${loop.index + 1}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <strong>${item.productName}</strong>
                                                    </td>
                                                    <td class="text-center">
                                                        <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                                    </td>
                                                    <td class="text-center">
                                                        <span class="badge bg-info">${item.quantity}</span>
                                                    </td>
                                                    <td class="text-center">
                                                        <fmt:formatNumber value="${item.discountPercent}" type="number" minFractionDigits="1" />%
                                                    </td>
                                                    <td class="text-center">
                                                        <fmt:formatNumber value="${item.discountAmount}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                                    </td>
                                                    <td class="text-center">
                                                        <strong>
                                                            <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                                        </strong>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Summary -->
                    <div class="row justify-content-end mt-4">
                        <div class="col-lg-5">
                            <div class="total-summary">
                                <h4 class="section-title">
                                    <i class="fas fa-calculator"></i>Order Summary
                                </h4>
                                
                                <div class="total-row">
                                    <span>Subtotal:</span>
                                    <span>
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                    </span>
                                </div>
                                
                                <div class="total-row">
                                    <span>Discount:</span>
                                    <span class="text-success">
                                        -<fmt:formatNumber value="${order.discountAmount}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                    </span>
                                </div>
                                
                                <div class="total-row">
                                    <span>Tax:</span>
                                    <span>
                                        <fmt:formatNumber value="${order.taxAmount}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                    </span>
                                </div>
                                
                                <div class="total-row">
                                    <span><strong>Total Amount:</strong></span>
                                    <span>
                                        <strong>
                                            <fmt:formatNumber value="${order.finalAmount}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                        </strong>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="row">
                        <div class="col-12">
                            <div class="action-buttons justify-content-end d-flex">
                                <button type="button" class="btn btn-secondary-custom btn-custom">
                                    <i class="fas fa-print me-2"></i>Print Invoice
                                </button>
                                <button type="button" class="btn btn-primary-custom btn-custom">
                                    <i class="fas fa-edit me-2"></i>Update Status
                                </button>
                                <a href="OrderManagementServlet" class="btn btn-secondary-custom btn-custom">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Orders
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid px-4">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted">© 2025 <strong>FMart Supermarket</strong>. All rights reserved.</div>
                        <div>
                            <a href="#" class="text-muted me-3">Privacy Policy</a>
                            <a href="#" class="text-muted">Terms & Conditions</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <!-- Scripts -->
    <script src="Admin/js/jquery.min.js"></script>
    <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="Admin/js/scripts.js"></script>
</body>
</html>