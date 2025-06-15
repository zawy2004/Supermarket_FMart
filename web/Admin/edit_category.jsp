<%@ page import="model.Category" %>
<%
    Category category = (Category) request.getAttribute("category");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Edit Category</title>
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    </head>

    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
            <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
        </nav>

        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <a class="nav-link" href="CategoryServlet">Categories</a>
                        </div>
                    </div>
                </nav>
            </div>

            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h2 class="mt-30 page-title">Edit Category</h2>
                        <ol class="breadcrumb mb-30">
                            <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="CategoryServlet">Categories</a></li>
                            <li class="breadcrumb-item active">Edit Category</li>
                        </ol>

                        <div class="row">
                            <div class="col-lg-6 col-md-6">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-title-2">
                                        <h4>Edit Category</h4>
                                    </div>
                                    <form action="CategoryServlet" method="post">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="categoryID" value="<%= category.getCategoryID()%>">

                                        <div class="form-group">
                                            <label>Name</label>
                                            <input name="categoryName" class="form-control" value="<%= category.getCategoryName()%>" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Description</label>
                                            <textarea name="description" class="form-control"><%= category.getDescription()%></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label>Parent ID</label>
                                            <input type="number" name="parentCategoryID" class="form-control" value="<%= category.getParentCategoryID()%>">
                                        </div>
                                        <div class="form-group">
                                            <label>Image URL</label>
                                            <input name="imageUrl" class="form-control" value="<%= category.getImageUrl()%>">
                                        </div>
                                        <div class="form-group">
                                            <label>Status</label>
                                            <select name="isActive" class="form-control">
                                                <option value="true" <%= category.getIsActive() ? "selected" : ""%>>Active</option>
                                                <option value="false" <%= !category.getIsActive() ? "selected" : ""%>>Inactive</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Display Order</label>
                                            <input type="number" name="displayOrder" class="form-control" value="<%= category.getDisplayOrder()%>">
                                        </div>
                                        <button type="submit" class="btn btn-primary">Update</button>
                                        <a href="CategoryServlet" class="btn btn-secondary">Cancel</a>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-footer mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">© 2025 FMart Supermarket</div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>

        <!-- Scripts -->
        <script src="Admin/js/jquery.min.js"></script>
        <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="Admin/js/scripts.js"></script>
    </body>
</html>
