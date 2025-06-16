<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Category List</title>
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/css/admin-style.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
</head>
<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
        <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
        <a href="index.jsp" class="frnt-link"><i class="fas fa-external-link-alt"></i> Home</a>
    </nav>

    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <a class="nav-link active" href="CategoryServlet">
                            <div class="sb-nav-link-icon"><i class="fas fa-list"></i></div>
                            Categories
                        </a>
                        <a class="nav-link active" href="ProductServlet">
                            <div class="sb-nav-link-icon"><i class="fas fa-list"></i></div>
                            Products
                        </a>
                    </div>
                </div>
            </nav>
        </div>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <h2 class="mt-30 page-title">Categories</h2>
                    <ol class="breadcrumb mb-30">
                        <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item active">Categories</li>
                    </ol>

                    <div class="row justify-content-between">
                        <div class="col-lg-12">
                            <a href="CategoryServlet?action=add" class="btn btn-primary mb-3">Add New Category</a>
                        </div>
                        <div class="col-lg-12 col-md-12">
                            <div class="card card-static-2 mt-30 mb-30">
                                <div class="card-title-2">
                                    <h4>All Categories</h4>
                                </div>
                                <div class="card-body-table">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Parent ID</th>
                                                    <th>Image</th>
                                                    <th>Status</th>
                                                    <th>Order</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% if (categories != null && !categories.isEmpty()) {
                                                    for (Category c : categories) { %>
                                                        <tr>
                                                            <td><%= c.getCategoryID() %></td>
                                                            <td><%= c.getCategoryName() %></td>
                                                            <td><%= c.getParentCategoryID() %></td>
                                                            <td>
                                                                <% if (c.getImageUrl() != null && !c.getImageUrl().isEmpty()) { %>
                                                                    <img src="<%= c.getImageUrl() %>" width="60"/>
                                                                <% } %>
                                                            </td>
                                                            <td>
                                                                <span class="badge badge-<%= c.getIsActive() ? "success" : "danger" %>">
                                                                    <%= c.getIsActive() ? "Active" : "Inactive" %>
                                                                </span>
                                                            </td>
                                                            <td><%= c.getDisplayOrder() %></td>
                                                            <td>
                                                                <a href="CategoryServlet?action=edit&id=<%= c.getCategoryID() %>" class="btn btn-sm btn-info">Edit</a>
                                                                <a href="CategoryServlet?action=delete&id=<%= c.getCategoryID() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                                                            </td>
                                                        </tr>
                                                <%  }
                                                } else { %>
                                                    <tr>
                                                        <td colspan="7" class="text-center">No categories found.</td>
                                                    </tr>
                                                <% } %>
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
                        <div class="text-muted">© 2025 FMart Supermarket</div>
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
