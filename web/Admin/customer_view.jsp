<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="java.util.List, model.User" %>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/customer_view.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:10:13 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description-gambolthemes" content="">
        <meta name="author-gambolthemes" content="">
        <title>FMart Supermarket Admin</title>
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">

        <!-- Vendor Stylesheets -->
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

    </head>

    <body class="sb-nav-fixed">
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
            <jsp:include page="adminsidebar.jsp"></jsp:include>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h2 class="mt-30 page-title">Users</h2>
                        <ol class="breadcrumb mb-30">
                            <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="customers.jsp">Users</a></li>
                            <li class="breadcrumb-item active">User View</li>
                        </ol>
                        <div class="row">
                            <div class="col-lg-5 col-md-6">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-body-table pt-4">
                                        <div class="shopowner-content-left text-center pd-20">
                                            <div class="customer_img mb-3">
                                                <img src="${user.profileImageUrl != null ? user.profileImageUrl : 'images/default-avatar.png'}" alt="Profile Image" width="120" height="120" style="object-fit: cover; border-radius: 50%;">
                                            </div>

                                            <div class="shopowner-dt-left mt-4">
                                                <h4>${user.fullName}</h4>
                                                <span>${user.roleName}</span> <!-- Đã JOIN Roles -->
                                            </div>

                                            <ul class="product-dt-purchases my-3">
                                                <li>
                                                    <div class="product-status">
                                                        Purchased <span class="badge-item-2 badge-status">15</span>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="product-status">
                                                        Rewards <span class="badge-item-2 badge-status">5</span>
                                                    </div>
                                                </li>
                                            </ul>

                                            <div class="shopowner-dts">
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">User ID</span>
                                                    <span class="right-dt">${user.userId}</span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Full Name</span>
                                                    <span class="right-dt">${user.fullName}</span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Username</span>
                                                    <span class="right-dt">${user.username}</span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Email</span>
                                                    <span class="right-dt">${user.email}</span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Phone</span>
                                                    <span class="right-dt">${user.phoneNumber}</span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Address</span>
                                                    <span class="right-dt">${user.address}</span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Gender</span>
                                                    <span class="right-dt">${user.gender}</span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Date of Birth</span>
                                                    <span class="right-dt">
                                                        <fmt:formatDate value="${user.dateOfBirth}" pattern="dd/MM/yyyy"/>
                                                    </span>
                                                </div>
                                                
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Auth Provider</span>
                                                    <span class="right-dt">${user.authProvider}</span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">External ID</span>
                                                    <span class="right-dt">${user.externalID}</span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Active</span>
                                                    <span class="right-dt">
                                                        <c:choose>
                                                            <c:when test="${user.active}"><span class="text-success">Yes</span></c:when>
                                                            <c:otherwise><span class="text-danger">No</span></c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Created At</span>
                                                    <span class="right-dt">
                                                        <fmt:formatDate value="${user.createdDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                                    </span>
                                                </div>
                                                <div class="shopowner-dt-list">
                                                    <span class="left-dt">Last Login</span>
                                                    <span class="right-dt">
                                                        <fmt:formatDate value="${user.lastLoginDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> <!-- /.col -->
                        </div>

                    </div>
                </main>
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

        <!-- Javascripts -->
        <script src="js/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>

    </body>

    <!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/customer_view.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:10:13 GMT -->
</html>
