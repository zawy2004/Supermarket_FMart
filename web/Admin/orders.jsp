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
            .pagination {
                margin-top: 1rem;
            }

            .pagination .page-item {
                margin: 0 3px;
            }

            .pagination .page-link {
                color: #007bff;
                border: 1px solid #dee2e6;
                padding: 6px 12px;
                border-radius: 5px;
                font-weight: 500;
                background-color: #fff;
                transition: all 0.2s ease-in-out;
            }

            .pagination .page-link:hover {
                background-color: #e9f0ff;
                text-decoration: none;
                border-color: #007bff;
                color: #0056b3;
            }

            .pagination .active .page-link {
                background-color: #007bff;
                border-color: #007bff;
                color: #fff;
                font-weight: bold;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            }

            .pagination .disabled .page-link {
                background-color: #f8f9fa;
                color: #adb5bd;
                border-color: #dee2e6;
                cursor: not-allowed;
            }

            .pagination .page-link:focus {
                box-shadow: none;
            }

            /* Dot (...) style */
            .pagination .page-item.disabled span.page-link {
                background: none;
                border: none;
                font-weight: bold;
                color: #6c757d;
                cursor: default;
            }
        </style>
    </head>

    <body class="sb-nav-fixed">
       <jsp:include page="header.jsp"></jsp:include>

        <div id="layoutSidenav">
            <jsp:include page="staffsidebar.jsp"></jsp:include>

                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid">
                            <h2 class="mt-30 page-title">Orders</h2>
                            <ol class="breadcrumb mb-30">
                                <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                                <li class="breadcrumb-item active">Orders</li>
                            </ol>

                            <!-- Search Form -->
                            <div class="row justify-content-between">
                                <div class="col-lg-5 col-md-6">
                                    <div class="bulk-section mb-30">
                                        <form action="OrderManagementServlet" method="get">
                                            <div class="search-by-name-input">
                                                <input type="text" name="searchName" value="${param.searchName}" class="form-control" placeholder="Search by Customer Name">
                                        </div>
                                        <div class="input-group">
                                            <select name="status" class="form-control">
                                                <option value="">All Status</option>
                                                <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                                <option value="Confirmed" ${param.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                                <option value="Processing" ${param.status == 'Processing' ? 'selected' : ''}>Processing</option>
                                                <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                                <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                            </select>
                                        </div>

                                        <div class="input-group">
                                            <!-- Input for From Date -->
                                            <input type="date" name="fromDate" value="${param.fromDate}" class="form-control">
                                            <!-- Input for To Date -->
                                            <input type="date" name="toDate" value="${param.toDate}" class="form-control">
                                        </div>

                                        <div class="input-group-append">
                                            <button class="status-btn hover-btn" type="submit">Search Orders</button>
                                        </div>
                                    </form>

                                </div>
                            </div>

                            <!-- Orders Table -->
                            <div class="col-lg-12 col-md-12">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-title-2">
                                        <h4>All Orders</h4>
                                    </div>
                                    <div class="card-body-table">
                                        <div class="table-responsive">
                                            <table class="table ucp-table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th style="width:60px"><input type="checkbox" class="check-all"></th>
                                                        <th style="width:130px">Order ID</th>
                                                        <th>Item</th>
                                                        <th style="width:200px">Date</th>
                                                        <th style="width:300px">Address</th>
                                                        <th style="width:130px">Status</th>
                                                        <th style="width:130px">Total</th>
                                                        <th style="width:100px">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${orderList}">
                                                        <tr>
                                                            <td><input type="checkbox" class="check-item" name="ids[]" value="${order.orderID}"></td>
                                                            <td>${order.orderNumber}</td>
                                                            <td>
                                                                <a href="OrderManagementServlet?action=view&id=${order.orderID}" target="_blank">
                                                                    View Details
                                                                </a>
                                                            </td>
                                                            <td>
                                                                <span class="delivery-time">
                                                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                                                </span>
                                                            </td>
                                                            <td>${order.deliveryAddress}</td>
                                                            <td>
                                                                <span class="badge-item badge-status">${order.status}</span>
                                                            </td>
                                                            <td>$<fmt:formatNumber value="${order.finalAmount}" type="number" minFractionDigits="2" /></td>
                                                            <td class="action-btns">
                                                                <a href="OrderManagementServlet?action=view&id=${order.orderID}" class="views-btn">
                                                                    <i class="fas fa-eye"></i>
                                                                </a>
                                                                <a href="OrderManagementServlet?action=edit&id=${order.orderID}" class="edit-btn">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
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

                        <!-- Pagination -->
                        <div class="row">
                            <div class="col-lg-12">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="OrderManagementServlet?page=${currentPage - 1}&searchName=${param.searchName}&status=${param.status}">Previous</a>
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
                                            <a class="page-link" href="OrderManagementServlet?page=${currentPage + 1}&searchName=${param.searchName}&status=${param.status}">Next</a>
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

    </body>
</html>
