<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Add Product to Import Receipt</title>
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/css/admin-style.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
</head>

<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
        <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
        <a href="index.jsp" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
        <ul class="navbar-nav ms-auto mr-md-0">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="fas fa-user fa-fw"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="edit_profile.jsp">Edit Profile</a>
                    <a class="dropdown-item" href="change_password.jsp">Change Password</a>
                    <a class="dropdown-item" href="login.jsp">Logout</a>
                </div>
            </li>
        </ul>
    </nav>

    <div id="layoutSidenav">
        <jsp:include page="adminsidebar.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <h2 class="mt-30 page-title">Add Product to Import Receipt</h2>
                    <ol class="breadcrumb mb-30">
                        <li class="breadcrumb-item"><a href="ImportReceiptServlet">Import Receipts</a></li>
                        <li class="breadcrumb-item"><a href="ImportDetailServlet?action=list&importID=${importID}">Import Details</a></li>
                        <li class="breadcrumb-item active">Add Product</li>
                    </ol>

                    <div class="row">
                        <div class="col-xl-10 col-md-12">
                            <div class="card card-static-2 mb-30">
                                <div class="card-body-table">
                                    <form action="ImportDetailServlet" method="post">
                                        <input type="hidden" name="action" value="save">
                                        <input type="hidden" name="importID" value="${importID}">

                                        <div class="form-group mb-3">
                                            <label for="productID">Product</label>
                                            <select name="productID" id="productID" class="form-control" required>
                                                <option value="">-- Select Product --</option>
                                                <c:forEach var="product" items="${products}">
                                                    <option value="${product.productID}">${product.productName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="quantity">Quantity</label>
                                            <input type="number" name="quantity" id="quantity" class="form-control" min="1" required>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="unitPrice">Unit Price</label>
                                            <input type="number" step="0.01" name="unitPrice" id="unitPrice" class="form-control" min="0" required>
                                        </div>

                                        <button type="submit" class="btn btn-success">Add Product</button>
                                        <a href="ImportDetailServlet?action=list&importID=${importID}" class="btn btn-secondary">Cancel</a>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </main>

            <footer class="py-4 bg-footer mt-auto">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted-1">© 2025 <b>FMart Supermarket</b>. by <a href="#">FMartlthemes</a></div>
                        <div class="footer-links">
                            <a href="#">Privacy Policy</a>
                            <a href="#">Terms &amp; Conditions</a>
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
