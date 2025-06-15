<%@ page import="dao.CategoryDAO" %>
<%@ page import="model.Category" %>
<%@ page import="java.sql.*" %>

<%
    // L?y tham s? categoryID t? URL (ho?c t? form n?u c?n)
    String categoryIDParam = request.getParameter("categoryID");

    // Ki?m tra n?u categoryID không t?n t?i trong URL, chuy?n h??ng v? trang danh m?c
    if (categoryIDParam == null || categoryIDParam.isEmpty()) {
        response.sendRedirect("category.jsp"); // Redirect v? trang danh m?c n?u không có categoryID
        return;
    }

    int categoryID = 0;
    try {
        categoryID = Integer.parseInt(categoryIDParam); // C? g?ng chuy?n ??i thành int
    } catch (NumberFormatException e) {
        // N?u không th? chuy?n ??i thành int, redirect v? danh m?c
        response.sendRedirect("category.jsp");
        return;
    }

    // L?y ??i t??ng Category t? DAO
    CategoryDAO categoryDAO = new CategoryDAO();
    Category category = categoryDAO.getCategoryByID(categoryID);
    
    if (category == null) {
        // N?u không tìm th?y danh m?c, chuy?n h??ng v? danh m?c
        response.sendRedirect("category.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Edit Category</title>
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
                    <h2 class="mt-30 page-title">Edit Category</h2>
                    <ol class="breadcrumb mb-30">
                        <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="category.jsp">Categories</a></li>
                        <li class="breadcrumb-item active">Edit Category</li>
                    </ol>

                    <!-- Edit Category Form -->
                    <div class="row justify-content-between">
                        <div class="col-lg-12 col-md-12">
                            <form action="update_category.jsp" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="categoryID" value="<%= category.getCategoryID() %>">
                                <div class="form-group">
                                    <label for="categoryName">Category Name</label>
                                    <input type="text" class="form-control" id="categoryName" name="categoryName" value="<%= category.getCategoryName() %>" required>
                                </div>

                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <textarea class="form-control" id="description" name="description" required><%= category.getDescription() %></textarea>
                                </div>

                                <div class="form-group">
                                    <label for="imageUrl">Image URL</label>
                                    <input type="text" class="form-control" id="imageUrl" name="imageUrl" value="<%= category.getImageUrl() %>">
                                </div>

                                <div class="form-group">
                                    <label for="status">Status</label>
                                    <select class="form-control" id="status" name="status">
                                        <option value="1" <%= category.getIsActive() ? "selected" : "" %>>Active</option>
                                        <option value="0" <%= !category.getIsActive() ? "selected" : "" %>>Inactive</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="js/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>
