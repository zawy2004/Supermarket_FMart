<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description-gambolthemes" content="">
        <meta name="author-gambolthemes" content="">
        <title>FMart Supermarket Admin</title>
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">

        <!-- Vendor Stylesheets -->
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        
        <style>
            /* Enhanced Page Styling */
            body {
                background-color: #f8f9fc;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .page-title {
                color: #2c3e50;
                font-weight: 700;
                font-size: 2.2rem;
                margin-bottom: 0.5rem;
            }

            .breadcrumb {
                background: transparent;
                padding: 0;
                margin-bottom: 2rem;
            }

            .breadcrumb-item a {
                color: #6c757d;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .breadcrumb-item a:hover {
                color: #007bff;
            }

            /* Enhanced Status Summary Boxes */
            .status-summary-box {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 15px;
                padding: 25px 20px;
                margin-bottom: 20px;
                font-size: 16px;
                color: white;
                font-weight: 600;
                box-shadow: 0 8px 25px rgba(0,0,0,0.15);
                transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
                position: relative;
                overflow: hidden;
            }

            .status-summary-box::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                transition: left 0.5s;
            }

            .status-summary-box:hover::before {
                left: 100%;
            }

            .status-summary-box:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            }

            .status-summary-box a {
                display: flex;
                align-items: center;
                justify-content: space-between;
                color: white;
                text-decoration: none;
            }

            .status-summary-box a:hover {
                color: white;
                text-decoration: none;
            }

            .status-count {
                font-size: 2rem;
                font-weight: 700;
            }

            /* Status-specific gradients */
            .status-pending {
                background: linear-gradient(135deg, #ff9a56 0%, #ff6b6b 100%);
            }

            .status-confirmed {
                background: linear-gradient(135deg, #4ecdc4 0%, #44a08d 100%);
            }

            .status-processing {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            .status-completed {
                background: linear-gradient(135deg, #56ab2f 0%, #a8e6cf 100%);
            }

            .status-cancelled {
                background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            }

            /* Enhanced Search Form */
            .search-container {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.08);
                margin-bottom: 30px;
            }

            .search-container h5 {
                color: #2c3e50;
                font-weight: 600;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 10px;
                padding: 12px 15px;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,.15);
            }

            .search-btn {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 10px;
                padding: 12px 30px;
                color: white;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .search-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102,126,234,0.4);
            }

            /* Enhanced Table */
            .orders-table-container {
                background: white;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.08);
                overflow: hidden;
            }

            .table-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 20px 30px;
                margin: 0;
                font-weight: 600;
            }

            .table {
                margin-bottom: 0;
            }

            .table thead th {
                background-color: #f8f9fa;
                border: none;
                padding: 15px;
                font-weight: 600;
                color: #2c3e50;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .table tbody tr {
                transition: all 0.3s ease;
            }

            .table tbody tr:hover {
                background-color: #f8f9fc;
                transform: scale(1.005);
            }

            .table tbody td {
                padding: 15px;
                vertical-align: middle;
                border-bottom: 1px solid #f1f3f4;
            }

            /* Enhanced Status Badges */
            .badge-status {
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border: none;
            }

            /* Action Buttons */
            .action-btns {
                display: flex;
                gap: 8px;
            }

            .action-btn {
                width: 35px;
                height: 35px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
                transition: all 0.3s ease;
                border: none;
            }

            .views-btn {
                background: linear-gradient(135deg, #17a2b8, #138496);
                color: white;
            }

            .edit-btn {
                background: linear-gradient(135deg, #28a745, #20c997);
                color: white;
            }

            .action-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
                color: white;
            }

            /* Enhanced Pagination */
            .pagination {
                margin-top: 2rem;
                justify-content: center;
            }

            .pagination .page-item {
                margin: 0 3px;
            }

            .pagination .page-link {
                color: #667eea;
                border: 2px solid #e9ecef;
                padding: 10px 15px;
                border-radius: 10px;
                font-weight: 600;
                background-color: #fff;
                transition: all 0.3s ease;
            }

            .pagination .page-link:hover {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-color: #667eea;
                transform: translateY(-2px);
            }

            .pagination .active .page-link {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-color: #667eea;
                color: #fff;
                font-weight: 700;
            }

            .pagination .disabled .page-link {
                background-color: #f8f9fa;
                color: #adb5bd;
                border-color: #dee2e6;
                cursor: not-allowed;
            }

            /* Custom Checkbox */
            .custom-checkbox {
                width: 18px;
                height: 18px;
                border: 2px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .status-summary-box {
                    margin-bottom: 15px;
                }
                
                .search-container {
                    padding: 20px;
                }
                
                .table-responsive {
                    font-size: 14px;
                }
            }

            /* Date inputs styling */
            input[type="date"] {
                position: relative;
            }

            /* Loading animation */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .fade-in-up {
                animation: fadeInUp 0.6s ease-out;
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
                        <!-- Page Header -->
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <div>
                                <h1 class="page-title">
                                    <i class="fas fa-shopping-cart me-2"></i>
                                    Order Management
                                </h1>
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                                        <li class="breadcrumb-item active">Orders</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>

                        <!-- Status Summary Cards -->
                        <div class="row mb-4 fade-in-up">
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-3">
                                <div class="status-summary-box status-pending">
                                    <a href="OrderManagementServlet?status=Pending">
                                        <div>
                                            <div style="font-size: 14px; opacity: 0.9;">Pending Orders</div>
                                            <div class="status-count">${pendingCount}</div>
                                        </div>
                                        <i class="fas fa-clock fa-2x" style="opacity: 0.7;"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-3">
                                <div class="status-summary-box status-confirmed">
                                    <a href="OrderManagementServlet?status=Confirmed">
                                        <div>
                                            <div style="font-size: 14px; opacity: 0.9;">Confirmed Orders</div>
                                            <div class="status-count">${confirmedCount}</div>
                                        </div>
                                        <i class="fas fa-check-circle fa-2x" style="opacity: 0.7;"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-3">
                                <div class="status-summary-box status-processing">
                                    <a href="OrderManagementServlet?status=Processing">
                                        <div>
                                            <div style="font-size: 14px; opacity: 0.9;">Processing Orders</div>
                                            <div class="status-count">${processingCount}</div>
                                        </div>
                                        <i class="fas fa-cog fa-spin fa-2x" style="opacity: 0.7;"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-3">
                                <div class="status-summary-box status-completed">
                                    <a href="OrderManagementServlet?status=Completed">
                                        <div>
                                            <div style="font-size: 14px; opacity: 0.9;">Completed Orders</div>
                                            <div class="status-count">${completedCount}</div>
                                        </div>
                                        <i class="fas fa-check-double fa-2x" style="opacity: 0.7;"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-3">
                                <div class="status-summary-box status-cancelled">
                                    <a href="OrderManagementServlet?status=Cancelled">
                                        <div>
                                            <div style="font-size: 14px; opacity: 0.9;">Cancelled Orders</div>
                                            <div class="status-count">${cancelledCount}</div>
                                        </div>
                                        <i class="fas fa-times-circle fa-2x" style="opacity: 0.7;"></i>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Search Form -->
                        <div class="search-container fade-in-up">
                            <h5><i class="fas fa-search"></i> Search & Filter Orders</h5>
                            <form action="OrderManagementServlet" method="get">
                                <div class="row">
                                    <div class="col-lg-3 col-md-6 mb-3">
                                        <label class="form-label">Customer Name</label>
                                        <input type="text" name="searchName" value="${param.searchName}" 
                                               class="form-control" placeholder="Enter customer name">
                                    </div>
                                    <div class="col-lg-2 col-md-6 mb-3">
                                        <label class="form-label">Status</label>
                                        <select name="status" class="form-control">
                                            <option value="">All Status</option>
                                            <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                            <option value="Confirmed" ${param.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                            <option value="Processing" ${param.status == 'Processing' ? 'selected' : ''}>Processing</option>
                                            <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                            <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                        </select>
                                    </div>
                                    <div class="col-lg-2 col-md-6 mb-3">
                                        <label class="form-label">From Date</label>
                                        <input type="date" name="fromDate" value="${param.fromDate}" class="form-control">
                                    </div>
                                    <div class="col-lg-2 col-md-6 mb-3">
                                        <label class="form-label">To Date</label>
                                        <input type="date" name="toDate" value="${param.toDate}" class="form-control">
                                    </div>
                                    <div class="col-lg-3 col-md-12 mb-3 d-flex align-items-end">
                                        <button class="search-btn w-100" type="submit">
                                            <i class="fas fa-search me-2"></i>Search Orders
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Orders Table -->
                        <div class="orders-table-container fade-in-up">
                            <div class="table-header">
                                <i class="fas fa-list me-2"></i>All Orders
                            </div>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th style="width:50px">
                                                <input type="checkbox" class="custom-checkbox check-all">
                                            </th>
                                            <th style="width:120px">Order ID</th>
                                            <th style="width:150px">Date</th>
                                            <th style="width:300px">Delivery Address</th>
                                            <th style="width:120px">Status</th>
                                            <th style="width:120px">Total Amount</th>
                                            <th style="width:100px">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${orderList}">
                                            <tr>
                                                <td>
                                                    <input type="checkbox" class="custom-checkbox check-item" 
                                                           name="ids[]" value="${order.orderID}">
                                                </td>
                                                <td>
                                                    <strong>${order.orderNumber}</strong>
                                                </td>
                                                <td>
                                                    <span class="text-muted">
                                                        <i class="fas fa-calendar-alt me-1"></i>
                                                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                                    </span>
                                                </td>
                                                <td>
                                                    <i class="fas fa-map-marker-alt me-1 text-muted"></i>
                                                    ${order.deliveryAddress}
                                                </td>
                                                <td>
                                                    <span class="badge badge-status 
                                                          ${order.status == 'Pending' ? 'status-pending' :
                                                            order.status == 'Confirmed' ? 'status-confirmed' :
                                                            order.status == 'Processing' ? 'status-processing' :
                                                            order.status == 'Completed' ? 'status-completed' :
                                                            order.status == 'Cancelled' ? 'status-cancelled' : ''}">
                                                        ${order.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <strong>
                                                        <fmt:formatNumber value="${order.finalAmount}" type="currency" 
                                                                        currencySymbol="₫" groupingUsed="true" minFractionDigits="0"/>
                                                    </strong>
                                                </td>
                                                <td class="action-btns">
                                                    <a href="OrderManagementServlet?action=view&id=${order.orderID}" 
                                                       class="action-btn views-btn" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="OrderManagementServlet?action=edit&id=${order.orderID}" 
                                                       class="action-btn edit-btn" title="Edit Order">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Pagination -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="OrderManagementServlet?page=${currentPage - 1}&searchName=${param.searchName}&status=${param.status}">
                                                <i class="fas fa-chevron-left"></i> Previous
                                            </a>
                                        </li>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <c:if test="${i <= 3 || i > totalPages - 3 || (i >= currentPage - 1 && i <= currentPage + 1)}">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="OrderManagementServlet?page=${i}&searchName=${param.searchName}&status=${param.status}">${i}</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${i == 4 && currentPage > 5}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                            </c:if>
                                            <c:if test="${i == totalPages - 3 && currentPage < totalPages - 4}">
                                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                            </c:if>
                                        </c:forEach>

                                        <li class="page-item ${currentPage == totalPages || totalPages == 0 ? 'disabled' : ''}">
                                            <a class="page-link" href="OrderManagementServlet?page=${currentPage + 1}&searchName=${param.searchName}&status=${param.status}">
                                                Next <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </main>

                <footer class="py-4 bg-footer mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted-1">© 2025 <b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">Gambolthemes</a></div>
                            <div class="footer-links">
                                <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/privacy_policy.jsp">Privacy Policy</a>
                                <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/term_and_conditions.jsp">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>

        <script src="Admin/js/jquery.min.js"></script>
        <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="Admin/js/scripts.js"></script>

        <script>
            // Enhanced checkbox functionality
            $(document).ready(function() {
                $('.check-all').on('change', function() {
                    $('.check-item').prop('checked', $(this).prop('checked'));
                });

                $('.check-item').on('change', function() {
                    if ($('.check-item:checked').length === $('.check-item').length) {
                        $('.check-all').prop('checked', true);
                    } else {
                        $('.check-all').prop('checked', false);
                    }
                });

                // Add loading effect to search button
                $('form').on('submit', function() {
                    $('.search-btn').html('<i class="fas fa-spinner fa-spin me-2"></i>Searching...');
                });
            });
        </script>
    </body>
</html>