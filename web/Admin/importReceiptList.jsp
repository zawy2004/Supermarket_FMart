<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List, model.ImportReceipt, model.Warehouse" %>

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
</head>

<style>
    .pagination a.active {
        background-color: #007bff;
        color: white;
        border-radius: 4px;
    }
</style>

<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
        <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
        <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/index.jsp" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
        <ul class="navbar-nav ms-auto mr-md-0">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-bs-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                    <a class="dropdown-item admin-dropdown-item" href="edit_profile.jsp">Edit Profile</a>
                    <a class="dropdown-item admin-dropdown-item" href="change_password.jsp">Change Password</a>
                    <a class="dropdown-item admin-dropdown-item" href="login.jsp">Logout</a>
                </div>
            </li>
        </ul>
    </nav>
    <div id="layoutSidenav">
        <jsp:include page="adminsidebar.jsp"></jsp:include>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <h2 class="mt-30 page-title">Import Receipts</h2>
                    <ol class="breadcrumb mb-30">
                        <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item active">Import Receipts</li>
                    </ol>
                    <div class="col-lg-12">
                        <a href="ImportReceiptServlet?action=add" class="btn btn-sm btn-primary">Add New</a>
                    </div>
                    <div class="row justify-content-between">
                        <!-- Bộ lọc ngày tháng năm -->
                        <form action="ImportReceiptServlet" method="get" class="form-inline mb-3">
                            <input type="hidden" name="action" value="list" />

                            <div class="input-group mr-2">
                                <label class="mr-1">From:</label>
                                <input type="date" name="fromDate" class="form-control" value="${param.fromDate}">
                            </div>
                            <div class="input-group mr-2">
                                <label class="mr-1">To:</label>
                                <input type="date" name="toDate" class="form-control" value="${param.toDate}">
                            </div>
                            <div class="input-group mr-2">
                                <select name="warehouseID" class="form-control">
                                    <option value="">All Warehouses</option>
                                    <c:forEach var="warehouse" items="${warehouses}">
                                        <option value="${warehouse.warehouseID}" ${warehouse.warehouseID == param.warehouseID ? 'selected' : ''}>
                                            ${warehouse.warehouseName}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="input-group-append">
                                    <button class="status-btn hover-btn" type="submit">Filter</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="card card-static-2 mb-30">
                                <div class="card-title-2">
                                    <h4>All Import Receipts</h4>
                                </div>
                                <div class="card-body-table">
                                    <div class="table-responsive">
                                        <table class="table ucp-table table-hover">
                                            <thead>
                                                <tr>
                                                    <th style="width: 50px;">ID</th>
                                                    <th style="width: 150px;">Supplier</th>
                                                    <th style="width: 150px;">Warehouse</th>
                                                    <th style="width: 150px;">Date</th>
                                                    <th style="width: 120px;">Notes</th>
                                                    <th style="width: 120px;">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:if test="${not empty importReceipts}">
                                                    <c:forEach var="receipt" items="${importReceipts}">
                                                        <tr>
                                                            <td>${receipt.importID}</td>
                                                            <td>${receipt.supplierName}</td>
                                                            <td>${receipt.warehouseName}</td>
                                                            <td><fmt:formatDate value="${receipt.importDate}" pattern="yyyy-MM-dd" /></td>
                                                            <td>${receipt.notes}</td>
                                                            <td>
                                                                <a href="${pageContext.request.contextPath}/ImportDetailServlet?importID=${receipt.importID}"
                                                                   class="btn btn-sm btn-primary">Edit</a>
                                                                <a href="${pageContext.request.contextPath}/ImportReceiptServlet?action=delete&importID=${receipt.importID}"
                                                                   class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this receipt?')">Delete</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${empty importReceipts}">
                                                    <tr>
                                                        <td colspan="6" class="text-center">No import receipts found.</td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                        <!-- Pagination -->
                                        <c:set var="queryStr">
                                            fromDate=${fn:escapeXml(param.fromDate)}&toDate=${fn:escapeXml(param.toDate)}&warehouseID=${param.warehouseID}
                                        </c:set>
                                        <nav aria-label="Page navigation" class="mt-4">
                                            <ul class="pagination justify-content-center">
                                                <li class="page-item ${page == 1 ? 'disabled' : ''}">
                                                    <a class="page-link"
                                                       href="ImportReceiptServlet?page=${page - 1}&${queryStr}">Previous</a>
                                                </li>
                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <li class="page-item ${i == page ? 'active' : ''}">
                                                        <a class="page-link" href="ImportReceiptServlet?page=${i}&${queryStr}">${i}</a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item ${page == totalPages || totalPages == 0 ? 'disabled' : ''}">
                                                    <a class="page-link"
                                                       href="ImportReceiptServlet?page=${page + 1}&${queryStr}">Next</a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <footer class="py-4 bg-footer mt-auto">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted-1">© 2025 <b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">FMartlthemes</a></div>
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
