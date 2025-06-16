<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>

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
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <a class="nav-link" href="index.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                            Dashboard
                        </a>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseProducts" aria-expanded="true" aria-controls="collapseProducts">
                            <div class="sb-nav-link-icon"><i class="fas fa-box"></i></div>
                            Products
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse show" id="collapseProducts" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link sub_nav_link" href="products.jsp">All Products</a>
                                <a class="nav-link sub_nav_link active" href="add_product.jsp">Add Product</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseCategories" aria-expanded="false" aria-controls="collapseCategories">
                            <div class="sb-nav-link-icon"><i class="fas fa-list"></i></div>
                            Categories
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseCategories" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link sub_nav_link" href="category.jsp">All Categories</a>
                                <a class="nav-link sub_nav_link" href="add_category.jsp">Add Category</a>
                            </nav>
                        </div>
                        <!-- Thêm các m?c sidebar khác ? ?ây n?u mu?n -->
                        <a class="nav-link" href="orders.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-cart-arrow-down"></i></div>
                            Orders
                        </a>
                        <a class="nav-link" href="customers.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                            Customers
                        </a>
                        <a class="nav-link" href="reports.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-chart-bar"></i></div>
                            Reports
                        </a>
                    </div>
                </div>
            </nav>
        </div>
        <!-- Main content -->
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <h2 class="mt-30 page-title">Add New Product</h2>
                    <ol class="breadcrumb mb-30">
                        <li class="breadcrumb-item"><a href="products.jsp">Products</a></li>
                        <li class="breadcrumb-item active">Add Product</li>
                    </ol>
                    <div class="row">
                        <div class="col-xl-10 col-md-12">
                            <div class="card card-static-2 mb-30">
                                <div class="card-body-table">
                                    <form action="ProductServlet" method="post">
                                        <input type="hidden" name="action" value="add">

                                        <div class="form-group mb-3">
                                            <label for="productName">Product Name</label>
                                            <input type="text" class="form-control" id="productName" name="productName" required>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="sku">SKU</label>
                                            <input type="text" class="form-control" id="sku" name="sku" required>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="sellingPrice">Selling Price</label>
                                            <input type="number" step="0.01" class="form-control" id="sellingPrice" name="sellingPrice" required>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="costPrice">Cost Price</label>
                                            <input type="number" step="0.01" class="form-control" id="costPrice" name="costPrice" required>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="categoryID">Category</label>
                                            <select class="form-control" id="categoryID" name="categoryID" required>
                                                <option value="1">Fruits & Vegetables</option>
                                                <option value="2">Grocery & Staples</option>
                                            </select>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="supplierID">Supplier ID</label>
                                            <input type="number" class="form-control" id="supplierID" name="supplierID" required>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="description">Description</label>
                                            <textarea class="form-control" id="description" name="description"></textarea>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="unit">Unit</label>
                                            <input type="text" class="form-control" id="unit" name="unit">
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="minStockLevel">Min Stock Level</label>
                                            <input type="number" class="form-control" id="minStockLevel" name="minStockLevel">
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="isActive">Status</label>
                                            <select name="isActive" id="isActive" class="form-control">
                                                <option value="true">Active</option>
                                                <option value="false">Inactive</option>
                                            </select>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="weight">Weight</label>
                                            <input type="number" step="0.01" class="form-control" id="weight" name="weight">
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="dimensions">Dimensions</label>
                                            <input type="text" class="form-control" id="dimensions" name="dimensions">
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="expiryDays">Expiry Days</label>
                                            <input type="number" class="form-control" id="expiryDays" name="expiryDays">
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="brand">Brand</label>
                                            <input type="text" class="form-control" id="brand" name="brand">
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="origin">Origin</label>
                                            <input type="text" class="form-control" id="origin" name="origin">
                                        </div>

                                        <button type="submit" class="btn btn-success">Add Product</button>
                                        <a href="ProductServlet" class="btn btn-secondary">Cancel</a>
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
                        <div class="text-muted-1">Â© 2025 <b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">FMartlthemes</a></div>
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
    <script src="Admin/vendor/chart/highcharts.js"></script>
    <script src="Admin/vendor/chart/exporting.js"></script>
    <script src="Admin/vendor/chart/export-data.js"></script>
    <script src="Admin/vendor/chart/accessibility.js"></script>
    <script src="Admin/js/scripts.js"></script>
    <script src="Admin/js/chart.js"></script>
</body>
</html>
