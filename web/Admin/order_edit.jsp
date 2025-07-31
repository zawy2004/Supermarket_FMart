<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="FMart Supermarket Admin - Order Edit">
        <meta name="author" content="FMart">
        <title>Edit Order - FMart Admin</title>

        <!-- Stylesheets -->
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

        <style>
            .edit-header {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                color: white;
                padding: 2rem;
                border-radius: 10px;
                margin-bottom: 2rem;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }

            .form-card {
                background: white;
                border-radius: 10px;
                padding: 2rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 15px rgba(0,0,0,0.08);
                border: 1px solid #e3e6f0;
                transition: all 0.3s ease;
            }

            .form-card:hover {
                box-shadow: 0 4px 25px rgba(0,0,0,0.15);
            }

            .section-title {
                display: flex;
                align-items: center;
                margin-bottom: 1.5rem;
                color: #495057;
                font-weight: 600;
            }

            .section-title i {
                margin-right: 0.75rem;
                color: #28a745;
                font-size: 1.2rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                font-weight: 600;
                color: #495057;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
            }

            .form-label i {
                margin-right: 0.5rem;
                color: #6c757d;
                width: 16px;
            }

            .form-control, .form-select {
                border: 2px solid #e3e6f0;
                border-radius: 8px;
                padding: 0.75rem 1rem;
                font-size: 0.95rem;
                transition: all 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                border-color: #28a745;
                box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
            }

            .status-select {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                font-weight: 600;
            }

            .info-display {
                background: #f8f9fc;
                border: 2px solid #e3e6f0;
                border-radius: 8px;
                padding: 0.75rem 1rem;
                color: #495057;
                font-weight: 500;
            }

            .order-table {
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 15px rgba(0,0,0,0.08);
                border: 1px solid #e3e6f0;
            }

            .table thead th {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                color: white;
                border: none;
                font-weight: 600;
                padding: 1rem;
                text-align: center;
            }

            .table tbody td {
                padding: 1rem;
                vertical-align: middle;
                border-color: #e3e6f0;
                text-align: center;
            }

            .table tbody tr:hover {
                background-color: #f8f9fc;
            }

            .product-info {
                display: flex;
                align-items: center;
                text-align: left;
            }

            .product-badge {
                background: #e3f2fd;
                color: #1976d2;
                padding: 0.25rem 0.75rem;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: 600;
                margin-left: 0.5rem;
            }

            .quantity-badge {
                background: #e8f5e8;
                color: #2e7d32;
                padding: 0.4rem 0.8rem;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.9rem;
            }

            .price-text {
                font-weight: 600;
                color: #495057;
            }

            .total-text {
                font-weight: 700;
                color: #28a745;
                font-size: 1.05rem;
            }

            .summary-card {
                background: linear-gradient(135deg, #f8f9fc 0%, #e9ecef 100%);
                border-radius: 10px;
                padding: 1.5rem;
                border: 2px solid #e3e6f0;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.75rem 0;
                border-bottom: 1px solid #dee2e6;
            }

            .summary-row:last-child {
                border-bottom: 3px solid #28a745;
                font-weight: 700;
                font-size: 1.15rem;
                color: #28a745;
                margin-top: 0.5rem;
            }

            .breadcrumb {
                background: transparent;
                padding: 0;
                margin-bottom: 2rem;
            }

            .breadcrumb-item a {
                color: #28a745;
                text-decoration: none;
                font-weight: 500;
            }

            .breadcrumb-item a:hover {
                color: #20c997;
            }

            .btn-group-custom {
                display: flex;
                gap: 1rem;
                justify-content: flex-end;
                margin-top: 2rem;
            }

            .btn-custom {
                padding: 0.75rem 2rem;
                border-radius: 25px;
                font-weight: 600;
                border: none;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
            }

            .btn-primary-custom {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                color: white;
            }

            .btn-secondary-custom {
                background: #6c757d;
                color: white;
            }

            .btn-outline-custom {
                background: transparent;
                border: 2px solid #6c757d;
                color: #6c757d;
            }

            .btn-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0,0,0,0.2);
                color: white;
            }

            .btn-custom i {
                margin-right: 0.5rem;
            }

            .alert-info-custom {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d9ff 100%);
                border: 1px solid #0066cc;
                color: #004080;
                border-radius: 10px;
                padding: 1rem 1.5rem;
                margin-bottom: 1.5rem;
            }

            .status-badge {
                display: inline-block;
                padding: 0.4rem 1rem;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.85rem;
            }

            .status-pending {
                background: #fff3cd;
                color: #856404;
            }
            .status-confirmed {
                background: #d1ecf1;
                color: #0c5460;
            }
            .status-processing {
                background: #cce5ff;
                color: #004085;
            }
            .status-completed {
                background: #d4edda;
                color: #155724;
            }
            .status-cancelled {
                background: #f8d7da;
                color: #721c24;
            }

            @media (max-width: 768px) {
                .edit-header {
                    text-align: center;
                }

                .btn-group-custom {
                    flex-direction: column;
                    align-items: stretch;
                }

                .btn-custom {
                    margin-bottom: 0.5rem;
                    justify-content: center;
                }
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
                                    <li class="breadcrumb-item active" aria-current="page">Edit Order</li>
                                </ol>
                            </nav>

                            <!-- Header -->
                            <div class="edit-header">
                                <div class="row align-items-center">
                                    <div class="col-lg-8">
                                        <h1 class="mb-2"><i class="fas fa-edit me-3"></i>Edit Order</h1>
                                        <h3 class="mb-0">Order #${order.orderNumber}</h3>
                                </div>
                                <div class="col-lg-4 text-end">
                                    <div class="status-badge status-${order.status.toLowerCase()}">
                                        <i class="fas fa-circle me-2"></i>Current: ${order.status}
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Alert -->
                        <div class="alert alert-info-custom">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>Note:</strong> Changes to this order will be immediately reflected in the system. Please verify all information before saving.
                        </div>

                        <form action="OrderManagementServlet" method="post" id="orderEditForm">
                            <input type="hidden" name="action" value="update" />
                            <input type="hidden" name="id" value="${order.orderID}" />

                            <div class="row">
                                <!-- Order Information -->
                                <div class="col-lg-6">
                                    <div class="form-card">
                                        <h4 class="section-title">
                                            <i class="fas fa-info-circle"></i>Order Information
                                        </h4>

                                        <div class="form-group">
                                            <label class="form-label">
                                                <i class="fas fa-calendar-alt"></i>Order Date
                                            </label>
                                            <div class="info-display">
                                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">
                                                <i class="fas fa-tag"></i>Order Type
                                            </label>
                                            <div class="info-display">
                                                ${order.orderType}
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="status">
                                                <i class="fas fa-tasks"></i>Order Status *
                                            </label>
                                            <select name="status" id="status" class="form-select status-select" required>
                                                <option value="Pending" ${order.status == 'Pending' ? 'selected' : ''}>
                                                <i class="fas fa-clock"></i> Pending
                                                </option>
                                                <option value="Confirmed" ${order.status == 'Confirmed' ? 'selected' : ''}>
                                                <i class="fas fa-check"></i> Confirmed
                                                </option>
                                                <option value="Processing" ${order.status == 'Processing' ? 'selected' : ''}>
                                                <i class="fas fa-cog"></i> Processing
                                                </option>
                                                <option value="Completed" ${order.status == 'Completed' ? 'selected' : ''}>
                                                <i class="fas fa-check-circle"></i> Completed
                                                </option>
                                                <option value="Cancelled" ${order.status == 'Cancelled' ? 'selected' : ''}>
                                                <i class="fas fa-times-circle"></i> Cancelled
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Delivery Information -->
                                <div class="col-lg-6">
                                    <div class="form-card">
                                        <h4 class="section-title">
                                            <i class="fas fa-shipping-fast"></i>Delivery Information
                                        </h4>

                                        <div class="form-group">
                                            <label class="form-label">
                                                <i class="fas fa-map-marker-alt"></i>Delivery Address
                                            </label>
                                            <textarea class="form-control" rows="3" name="deliveryAddress" readonly>${order.deliveryAddress}</textarea>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="notes">
                                                <i class="fas fa-sticky-note"></i>Order Notes
                                            </label>
                                            <textarea class="form-control" rows="2" name="notes" id="notes" placeholder="Add any special instructions or notes...">${order.notes}</textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Order Items -->
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-card">
                                        <h4 class="section-title">
                                            <i class="fas fa-list-ul"></i>Order Items
                                        </h4>

                                        <div class="order-table">
                                            <div class="table-responsive">
                                                <table class="table table-hover mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 60px;">#</th>
                                                            <th>Product</th>
                                                            <th>Unit Price</th>
                                                            <th>Quantity</th>
                                                            <th>Total</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="item" items="${orderDetails}" varStatus="loop">
                                                            <tr>
                                                                <td>
                                                                    <div class="d-flex align-items-center justify-content-center">
                                                                        <span class="badge bg-light text-dark fw-bold">${loop.index + 1}</span>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="product-info">
                                                                        <strong> ${item.productName}</strong>
                                                                        <span class="product-badge">ID: ${item.orderDetailID}</span>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <span class="price-text">
                                                                        <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <span class="quantity-badge">${item.quantity}</span>
                                                                </td>
                                                                <td>
                                                                    <span class="total-text">
                                                                        <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Order Summary -->
                            <div class="row justify-content-end">
                                <div class="col-lg-5">
                                    <div class="form-card">
                                        <h4 class="section-title">
                                            <i class="fas fa-calculator"></i>Order Summary
                                        </h4>

                                        <div class="summary-card">
                                            <div class="summary-row">
                                                <span><i class="fas fa-list me-2"></i>Subtotal:</span>
                                                <span class="fw-bold">
                                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                                </span>
                                            </div>

                                            <div class="summary-row">
                                                <span><i class="fas fa-shipping-fast me-2"></i>Delivery Fees:</span>
                                                <span class="fw-bold">₫0</span>
                                            </div>

                                            <div class="summary-row">
                                                <span><i class="fas fa-money-bill-wave me-2"></i><strong>Total Amount:</strong></span>
                                                <span>
                                                    <fmt:formatNumber value="${order.finalAmount}" type="currency" currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="row">
                                <div class="col-12">
                                    <div class="btn-group-custom">
                                        <a href="OrderManagementServlet" class="btn-custom btn-outline-custom">
                                            <i class="fas fa-times"></i>Cancel
                                        </a>
                                        <button type="button" class="btn-custom btn-secondary-custom" onclick="resetForm()">
                                            <i class="fas fa-undo"></i>Reset
                                        </button>
                                        <button type="submit" class="btn-custom btn-primary-custom" onclick="return confirmUpdate()">
                                            <i class="fas fa-save"></i>Update Order
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
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

        <script>
                                            function confirmUpdate() {
                                                const currentStatus = '${order.status}';
                                                const newStatus = document.getElementById('status').value;

                                                if (currentStatus !== newStatus) {
                                                    return confirm(`Are you sure you want to change the order status from "${currentStatus}" to "${newStatus}"?`);
                                                }

                                                return confirm('Are you sure you want to update this order?');
                                            }

                                            function resetForm() {
                                                if (confirm('Are you sure you want to reset all changes?')) {
                                                    document.getElementById('orderEditForm').reset();
                                                }
                                            }

                                            // Status change highlighting
                                            document.getElementById('status').addEventListener('change', function () {
                                                const currentStatus = '${order.status}';
                                                const newStatus = this.value;

                                                if (currentStatus !== newStatus) {
                                                    this.style.backgroundColor = '#fff3cd';
                                                    this.style.borderColor = '#ffeaa7';
                                                } else {
                                                    this.style.backgroundColor = '';
                                                    this.style.borderColor = '';
                                                }
                                            });

                                            // Form validation
                                            document.getElementById('orderEditForm').addEventListener('submit', function (e) {
                                                const status = document.getElementById('status').value;

                                                if (!status) {
                                                    e.preventDefault();
                                                    alert('Please select an order status.');
                                                    document.getElementById('status').focus();
                                                    return false;
                                                }
                                            });
        </script>
    </body>
</html>