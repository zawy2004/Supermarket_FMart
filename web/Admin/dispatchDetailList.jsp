<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List, model.DispatchDetail, model.Product, model.Warehouse" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>FMart Supermarket Admin</title>
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">
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
       <!-- Header -->
            <jsp:include page="header.jsp"></jsp:include>
        <div id="layoutSidenav">
            <!-- Sidebar -->
            <jsp:include page="managersidebar.jsp"></jsp:include>
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid">
                            <h2 class="mt-30 page-title">Dispatch Receipt Details</h2>
                            <ol class="breadcrumb mb-30">
                                <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="DispatchReceiptServlet">Dispatch Receipts</a></li>
                                <li class="breadcrumb-item active">Dispatch Receipt Details</li>
                            </ol>

                            <div class="row justify-content-between">
                                <div class="col-lg-12">
                                    <a href="DispatchDetailServlet?action=add&dispatchID=${dispatchID}" class="btn btn-sm btn-primary">Add Product</a>
                                <a href="DispatchReceiptServlet?action=delete&dispatchID=${dispatchID}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this receipt?')">Delete</a>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 col-md-12">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-title-2">
                                        <h4>Dispatch Details</h4>
                                    </div>
                                    <div class="card-body-table">
                                        <div class="table-responsive">
                                            <table class="table ucp-table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 50px;">Product ID</th>
                                                        <th style="width: 150px;">Product Name</th>
                                                        <th style="width: 100px;">Quantity</th>
                                                        <th style="width: 120px;">Unit Cost</th>
                                                        <th style="width: 120px;">Total Cost</th>
                                                        <th style="width: 120px;">Reason</th>
                                                        <th style="width: 120px;">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:if test="${not empty dispatchDetails}">
                                                        <c:forEach var="detail" items="${dispatchDetails}">
                                                            <tr>
                                                                <td>${detail.productID}</td>
                                                                <td>
                                                                    <c:forEach var="p" items="${products}">
                                                                        <c:if test="${p.productID == detail.productID}">
                                                                            ${p.productName}
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </td>

                                                                <td>${detail.quantity}</td>
                                                                <td>${detail.unitCost}</td>
                                                                <td>${detail.quantity * detail.unitCost}</td>
                                                                <td>${detail.reason}</td>
                                                                <td>
                                                                    <a href="DispatchDetailServlet?action=delete&dispatchDetailID=${detail.dispatchDetailID}&dispatchID=${dispatchID}"
                                                                       class="btn btn-sm btn-danger"
                                                                       onclick="return confirm('Are you sure you want to delete this detail?')">Delete</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:if>
                                                    <c:if test="${empty dispatchDetails}">
                                                        <tr>
                                                            <td colspan="7" class="text-center">No details found for this receipt.</td>
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
