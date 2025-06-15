<%@page import="model.Category"%>
<%@page import="dao.CategoryDAO"%>
<%@ page import="java.util.List" %>

<%
    // L?y danh sách category t? DAO
    List<Category> categories = CategoryDAO.getAllCategories();
    request.setAttribute("categories", categories);
%>

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
                            <a class="nav-link" href="CategoryServlet">
                                <div class="sb-nav-link-icon"><i class="fas fa-list"></i></div>
                                Categories
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
                                <a href="CategoryServlet?action=add" class="btn btn-sm btn-primary">Add New</a>
                            </div>
                            <div class="col-lg-12 col-md-12">
                                <div class="card card-static-2 mt-30 mb-30">
                                    <div class="card-title-2">
                                        <h4>All Categories</h4>
                                    </div>
                                    <div class="card-body-table">
                                        <div class="table-responsive">
                                            <table class="table ucp-table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th style="width:60px"><input type="checkbox" class="check-all"></th>
                                                        <th>ID</th>
                                                        <th>Image</th>
                                                        <th>Name</th>
                                                        <th>Description</th>
                                                        <th>Status</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (Category category : categories) {%>
                                                    <tr>
                                                        <td><input type="checkbox" class="check-item" name="ids[]" value="<%= category.getCategoryID()%>"></td>
                                                        <td><%= category.getCategoryID()%></td>
                                                        <td><img src="<%= category.getImageUrl()%>" alt="" width="80"></td>
                                                        <td><%= category.getCategoryName()%></td>
                                                        <td><%= category.getDescription()%></td>
                                                        <td>
                                                            <span class="badge badge-<%= category.getIsActive() ? "success" : "danger"%>">
                                                                <%= category.getIsActive() ? "Active" : "Inactive"%>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <a href="CategoryServlet?action=edit&id=<%= category.getCategoryID()%>" class="btn btn-sm btn-info">Edit</a>
                                                            <a href="CategoryServlet?action=delete&id=<%= category.getCategoryID()%>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                                                        </td>
                                                    </tr>
                                                    <% }%>
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
                            <div class="text-muted">&copy; 2025 FMart Supermarket</div>
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
