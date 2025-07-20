<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Add Category</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    </head>
    <body class="sb-nav-fixed">
        <!-- Header -->
        <!-- Header -->
        <jsp:include page="header.jsp"></jsp:include>
            <div id="layoutSidenav">
                <!-- Sidebar -->
            <jsp:include page="managersidebar.jsp"></jsp:include>
            <!-- Main content -->
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h2 class="mt-30 page-title">Add Category</h2>
                        <ol class="breadcrumb mb-30">
                            <li class="breadcrumb-item"><a href="category.jsp">Categories</a></li>
                            <li class="breadcrumb-item active">Add Category</li>
                        </ol>
                        <div class="row">
                            <div class="col-xl-8 col-md-10">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-body-table">
                                        <form action="CategoryServlet" method="post">
                                            <input type="hidden" name="action" value="add">
                                            <div class="mb-3">
                                                <label class="form-label">Category Name</label>
                                                <input name="categoryName" class="form-control" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Description</label>
                                                <textarea name="description" class="form-control"></textarea>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Parent Category ID</label>
                                                <input type="number" name="parentCategoryID" class="form-control" value="0">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Image URL</label>
                                                <input name="imageUrl" class="form-control">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Status</label>
                                                <select name="isActive" class="form-control">
                                                    <option value="true">Active</option>
                                                    <option value="false">Inactive</option>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Display Order</label>
                                                <input type="number" name="displayOrder" class="form-control" value="1">
                                            </div>
                                            <button type="submit" class="btn btn-success">Save</button>
                                            <a href="CategoryServlet" class="btn btn-secondary">Cancel</a>
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

        <!-- Scripts -->
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
