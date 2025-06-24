<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/coupon.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:10:07 GMT -->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description-gambolthemes" content="">
    <meta name="author-gambolthemes" content="">
    <title>FMart Supermarket Admin - Tạo mã giảm giá</title>
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/css/admin-style.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
</head>

<body class="sb-nav-fixed">
<nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
    <a class="navbar-brand logo-brand" href="${pageContext.request.contextPath}/index.jsp">FMart Supermarket</a>
    <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
    <a href="${pageContext.request.contextPath}/index.jsp" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
    <ul class="navbar-nav ms-auto mr-md-0">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
            <div class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                <a class="dropdown-item admin-dropdown-item" href="${pageContext.request.contextPath}/edit_profile.jsp">Edit Profile</a>
                <a class="dropdown-item admin-dropdown-item" href="${pageContext.request.contextPath}/change_password.jsp">Change Password</a>
                <a class="dropdown-item admin-dropdown-item" href="${pageContext.request.contextPath}/login.jsp">Logout</a>
            </div>
        </li>
    </ul>
</nav>
<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Dashboard
                    </a>
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                        <div class="sb-nav-link-icon"><i class="fas fa-newspaper"></i></div>
                        Posts
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/posts.jsp">All Posts</a>
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/add_post.jsp">Add New</a>
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/post_categories.jsp">Categories</a>
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/post_tags.jsp">Tags</a>
                        </nav>
                    </div>
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLocations" aria-expanded="false" aria-controls="collapseLocations">
                        <div class="sb-nav-link-icon"><i class="fas fa-map-marker-alt"></i></div>
                        Locations
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseLocations" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/locations.jsp">All Locations</a>
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/add_location.jsp">Add Location</a>
                        </nav>
                    </div>
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseAreas" aria-expanded="false" aria-controls="collapseAreas">
                        <div class="sb-nav-link-icon"><i class="fas fa-map-marked-alt"></i></div>
                        Areas
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseAreas" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/areas.jsp">All Areas</a>
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/add_area.jsp">Add Area</a>
                        </nav>
                    </div>
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseCategories" aria-expanded="false" aria-controls="collapseCategories">
                        <div class="sb-nav-link-icon"><i class="fas fa-list"></i></div>
                        Categories
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseCategories" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/category.jsp">All Categories</a>
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/add_category.jsp">Add Category</a>
                        </nav>
                    </div>
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseShops" aria-expanded="false" aria-controls="collapseShops">
                        <div class="sb-nav-link-icon"><i class="fas fa-store"></i></div>
                        Shops
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseShops" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/shops.jsp">All Shops</a>
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/add_shop.jsp">Add Shop</a>
                        </nav>
                    </div>
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseProducts" aria-expanded="false" aria-controls="collapseProducts">
                        <div class="sb-nav-link-icon"><i class="fas fa-box"></i></div>
                        Products
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseProducts" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/products.jsp">All Products</a>
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/add_product.jsp">Add Product</a>
                        </nav>
                    </div>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                        <div class="sb-nav-link-icon"><i class="fas fa-cart-arrow-down"></i></div>
                        Orders
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/customers.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                        Customers
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/coupon.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-gift"></i></div>
                        Offers
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/pages.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                        Pages
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/menu.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-layer-group"></i></div>
                        Menu
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/updater.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-cloud-upload-alt"></i></div>
                        Updater
                    </a>
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseSettings" aria-expanded="false" aria-controls="collapseSettings">
                        <div class="sb-nav-link-icon"><i class="fas fa-cog"></i></div>
                        Setting
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseSettings" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/general_setting.jsp">General Settings</a>
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/payment_setting.jsp">Payment Settings</a>
                            <a class="nav-link sub_nav_link" href="${pageContext.request.contextPath}/email_setting.jsp">Email Settings</a>
                        </nav>
                    </div>
                    <a class="nav-link" href="${pageContext.request.contextPath}/reports.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-chart-bar"></i></div>
                        Reports
                    </a>
                </div>
            </div>
        </nav>
    </div>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid">
                <h2 class="mt-30 page-title">Tạo mã giảm giá</h2>
                <ol class="breadcrumb mb-30">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Dashboard</a></li>
                    <li class="breadcrumb-item active">Tạo mã giảm giá</li>
                </ol>
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-8">
                        <div class="card card-static-2 mb-30">
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/CouponManagementServlet" method="post">
                                    <input type="hidden" name="action" value="create">
                                    <div class="form-group">
                                        <label>Mã giảm giá:</label>
                                        <input type="text" name="couponCode" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Tên mã:</label>
                                        <input type="text" name="couponName" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Mô tả:</label>
                                        <input type="text" name="description" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Loại giảm giá:</label>
                                        <select name="discountType" class="form-control" required>
                                            <option value="Percentage">Phần trăm (%)</option>
                                            <option value="Fixed">Số tiền cố định</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Giá trị giảm:</label>
                                        <input type="number" step="0.01" name="discountValue" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Đơn hàng tối thiểu:</label>
                                        <input type="number" step="0.01" name="minOrderAmount" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Giảm tối đa:</label>
                                        <input type="number" step="0.01" name="maxDiscountAmount" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Giới hạn sử dụng:</label>
                                        <input type="number" name="usageLimit" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Giới hạn đơn hàng:</label>
                                        <input type="number" name="orderLimit" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày bắt đầu:</label>
                                        <input type="datetime-local" name="startDate" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày kết thúc:</label>
                                        <input type="datetime-local" name="endDate" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Người tạo:</label>
                                        <input type="number" name="createdBy" value="1" class="form-control" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Tạo mã giảm giá</button>
                                </form>
                                <c:if test="${not empty errorMessage}">
                                    <p class="text-danger mt-2">${errorMessage}</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <footer class="py-4 bg-footer mt-auto">
            <div class="container-fluid">
                <div class="d-flex align-items-center justify-content-between small">
                    <div class="text-muted-1">© 2024 <b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">Gambolthemes</a></div>
                    <div class="footer-links">
                        <a href="${pageContext.request.contextPath}/privacy_policy.jsp">Privacy Policy</a>
                        <a href="${pageContext.request.contextPath}/term_and_conditions.jsp">Terms & Conditions</a>
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