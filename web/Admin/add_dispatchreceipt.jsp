<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Warehouse" %>
<%@ page import="dao.WarehouseDAO" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>FMart Supermarket Admin</title>
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    </head>

    <body class="sb-nav-fixed">
        <!-- Header -->
        <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
            <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
            <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/index.jsp" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
            <ul class="navbar-nav ms-auto mr-md-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <a class="dropdown-item admin-dropdown-item" href="edit_profile.jsp">Edit Profile</a>
                        <a class="dropdown-item admin-dropdown-item" href="change_password.jsp">Change Password</a>
                        <a class="dropdown-item admin-dropdown-item" href="login.jsp">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>

        <div id="layoutSidenav">
            <!-- Sidebar -->
            <jsp:include page="adminsidebar.jsp"></jsp:include>
                <!-- Main content -->
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid">
                            <h2 class="mt-30 page-title">Add New Dispatch Receipt</h2>
                            <ol class="breadcrumb mb-30">
                                <li class="breadcrumb-item"><a href="dispatchReceiptList.jsp">Dispatch Receipts</a></li>
                                <li class="breadcrumb-item active">Add Dispatch Receipt</li>
                            </ol>
                            <div class="row">
                                <div class="col-xl-10 col-md-12">
                                    <div class="card card-static-2 mb-30">
                                        <div class="card-body-table">
                                            <form action="DispatchReceiptServlet" method="post">
                                                <input type="hidden" name="action" value="save">

                                                <div class="form-group mb-3">
                                                    <label for="warehouseID">Warehouse</label>
                                                    <select class="form-control" id="warehouseID" name="warehouseID" required>
                                                    <c:forEach var="warehouse" items="${warehouses}">
                                                        <option value="${warehouse.warehouseID}">${warehouse.warehouseName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="form-group mb-3">
                                                <label for="dispatchType">Dispatch Type</label>
                                                <select class="form-control" id="dispatchType" name="dispatchType" required>
                                                    <option value="">Select Type</option>
                                                    <option value="Return to Supplier">Return to Supplier</option>
                                                    <option value="Write-off">Write-off</option>
                                                    <option value="Internal Transfer">Internal Transfer</option>
                                                    <option value="Internal Use">Internal Use</option>
                                                </select>
                                            </div>


                                            <div class="form-group mb-3">
                                                <label for="reference">Reference</label>
                                                <input type="text" class="form-control" id="reference" name="reference">
                                            </div>

                                            <div class="form-group mb-3">
                                                <label for="notes">Notes</label>
                                                <textarea class="form-control" id="notes" name="notes"></textarea>
                                            </div>

                                            <div class="form-group mb-3">
                                                <label for="date">Date</label>
                                                <input type="date" class="form-control" id="date" name="date" required>
                                            </div>

                                            <button type="submit" class="btn btn-success">Add Dispatch Receipt</button>
                                            <a href="DispatchReceiptServlet" class="btn btn-secondary">Cancel</a>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <!-- Footer -->
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
