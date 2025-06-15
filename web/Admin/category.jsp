<%@page import="model.Category"%>
<%@page import="dao.CategoryDAO"%>
<%@ page import="java.util.List" %>


<%
    // T?o ??i t??ng DAO và l?y t?t c? danh m?c t? c? s? d? li?u
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getAllCategories();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FMart Supermarket Admin</title>
    <link href="css/styles.css" rel="stylesheet">
    <link href="css/admin-style.css" rel="stylesheet">
    <!-- Vendor Stylesheets -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
</head>
<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
        <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
        <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/index.jsp" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
    </nav>
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <a class="nav-link" href="category.jsp">Categories</a>
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
                            <a href="add_category.jsp" class="add-btn hover-btn">Add New</a>
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
                                                    <th style="width:60px">ID</th>
                                                    <th style="width:130px">Image</th>
                                                    <th>Name</th>
                                                    <th>Description</th>
                                                    <th>Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% 
                                                    // Duy?t qua danh sách danh m?c và hi?n th? các tr??ng
                                                    for (Category category : categories) { 
                                                %>
                                                <tr>
                                                    <td><input type="checkbox" class="check-item" name="ids[]" value="<%= category.getCategoryID() %>"></td>
                                                    <td><%= category.getCategoryID() %></td>
                                                    <td>
                                                        <div class="cate-img">
                                                            <!-- C?p nh?t ???ng d?n hình ?nh t? c? s? d? li?u -->
                                                            <img src="<%= category.getImageUrl() %>" alt="">
                                                        </div>
                                                    </td>
                                                    <td><%= category.getCategoryName() %></td>
                                                    <td><%= category.getDescription() %></td>
                                                    <td>
                                                        <span class="badge-item badge-status">
                                                            <!-- Hi?n th? tr?ng thái -->
                                                            <%= (category.getIsActive() ? "Active" : "Inactive") %>
                                                        </span>
                                                    </td>
                                                    <td class="action-btns">
                                                        <a href="edit_category.jsp?id=<%= category.getCategoryID() %>" class="edit-btn">
                                                            <i class="fas fa-edit"></i> Edit
                                                        </a>
                                                    </td>
                                                </tr>
                                                <% 
                                                    }
                                                %>
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
                        <div class="text-muted-1">© 2025 <b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">FMartthemes</a></div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    <script src="js/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>
