<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List, model.ImportDetail, model.Product, model.Warehouse" %>

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
            <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/index.jsp" class="frnt-link"><i
                    class="fas fa-external-link-alt"></i>Home</a>
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
                            <h2 class="mt-30 page-title">Import Receipt Details</h2>
                            <ol class="breadcrumb mb-30">
                                <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="importreceipt.jsp">Import Receipts</a></li>
                                <li class="breadcrumb-item active">Import Receipt Details</li>
                            </ol>

                            <div class="row justify-content-between">
                                <div class="col-lg-12">
                                    <a href="ImportDetailServlet?action=add&importID=${param.importID}" class="btn btn-sm btn-primary">AddProduct</a>
                                <a href="ImportReceiptServlet?action=delete&importID=${param.importID}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this receipt?')">Delete</a>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 col-md-12">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-title-2">
                                        <h4>Import Details</h4>
                                    </div>
                                    <div class="card-body-table">
                                        <div class="table-responsive">
                                            <table class="table ucp-table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 50px;">Product ID</th>
                                                        <th style="width: 150px;">Product Name</th>
                                                        <th style="width: 100px;">Quantity</th>
                                                        <th style="width: 120px;">Unit Price</th>
                                                        <th style="width: 120px;">Total Price</th>
                                                        <th style="width: 120px;">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:if test="${not empty importDetails}">
                                                        <c:forEach var="detail" items="${importDetails}">
                                                            <tr>
                                                                <td>${detail.productID}</td>
                                                                <td>${detail.productName}</td>
                                                                <td>${detail.quantity}</td>
                                                                <td>${detail.unitPrice}</td>S
                                                                <td>${detail.quantity * detail.unitPrice}</td>
                                                                <td>
                                                                        <a href="${pageContext.request.contextPath}/ImportDetailServlet?action=delete&importDetailID=${detail.importDetailID}&importID=${param.importID}"
                                                                       class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this receipt?')">Delete</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:if>
                                                    <c:if test="${empty importDetails}">
                                                        <tr>
                                                            <td colspan="5" class="text-center">No details found for this receipt.</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
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
                            <div class="text-muted-1">© 2025 <b>FMart Supermarket</b>. by <a
                                    href="https://themeforest.net/user/gambolthemes">FMartlthemes</a></div>
                            <div class="footer-links">
                                <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/privacy_policy.jsp">Privacy
                                    Policy</a>
                                <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/term_and_conditions.jsp">Terms
                                    &amp; Conditions</a>
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
