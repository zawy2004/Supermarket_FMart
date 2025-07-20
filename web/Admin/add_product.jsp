<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Product, model.Category" %>
<%@ page import="dao.ProductDAO,dao.CategoryDAO" %>


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
            <jsp:include page="header.jsp"></jsp:include>
        <div id="layoutSidenav">
            <!-- Sidebar -->
            <jsp:include page="managersidebar.jsp"></jsp:include>
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
                                                    <c:forEach var="cat" items="${categories}">
                                                        
                                                             <option value="${cat.categoryID}">${cat.categoryName}</option>
                                                    </c:forEach>

                                                   
                                                    
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
        <script src="Admin/vendor/chart/highcharts.js"></script>
        <script src="Admin/vendor/chart/exporting.js"></script>
        <script src="Admin/vendor/chart/export-data.js"></script>
        <script src="Admin/vendor/chart/accessibility.js"></script>
        <script src="Admin/js/scripts.js"></script>
        <script src="Admin/js/chart.js"></script>
    </body>
</html>
