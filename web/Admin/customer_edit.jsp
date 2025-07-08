<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="java.util.List, model.User" %>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/customer_edit.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:10:13 GMT -->
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
                            <li class="breadcrumb-item active">User Edit</li>
                        </ol>
                        <div class="row">
                            <div class="col-lg-6 col-md-6">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-title-2">
                                        <h4>Edit User</h4>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/UserManagementServlet" method="post">
                                        <input type="hidden" name="action" value="edit">
                                        <input type="hidden" name="id" value="${user.userId}">

                                        <!-- Full Name -->
                                        <div class="form-group">
                                            <label class="form-label">Full Name*</label>
                                            <input type="text" name="fullName" class="form-control"
                                                   value="${user.fullName}" placeholder="Enter Full Name" required>
                                        </div>

                                        <!-- Username (read-only) -->
                                        <div class="form-group">
                                            <label class="form-label">Username</label>
                                            <input type="text" name="username" class="form-control"
                                                   value="${user.username}" readonly>
                                        </div>

                                        <!-- Email -->
                                        <div class="form-group">
                                            <label class="form-label">Email*</label>
                                            <input type="email" name="email" class="form-control"
                                                   value="${user.email}" placeholder="Enter Email Address" required>
                                        </div>

                                        <!-- Phone -->
                                        <div class="form-group">
                                            <label class="form-label">Phone</label>
                                            <input type="text" name="phoneNumber" class="form-control"
                                                   value="${user.phoneNumber}" placeholder="Enter Phone Number">
                                        </div>

                                        <!-- Address -->
                                        <div class="form-group">
                                            <label class="form-label">Address</label>
                                            <textarea name="address" class="form-control" placeholder="Enter Address">${user.address}</textarea>
                                        </div>

                                        <!-- Gender -->
                                        <div class="form-group">
                                            <label class="form-label">Gender</label>
                                            <select name="gender" class="form-control">
                                                <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>

                                        <!-- Date of Birth -->
                                        <div class="form-group">
                                            <label class="form-label">Date of Birth</label>
                                            <input type="date" name="dateOfBirth" class="form-control"
                                                   value="${user.dateOfBirth}">
                                        </div>

                                        <!-- Role -->
                                        <div class="form-group">
                                            <label class="form-label">Role</label>
                                            <select name="roleID" class="form-control">
                                                <option value="1" ${user.roleId == 1 ? 'selected' : ''}>Customer</option>
                                                <option value="2" ${user.roleId == 2 ? 'selected' : ''}>Staff</option>
                                                <option value="3" ${user.roleId == 3 ? 'selected' : ''}>Admin</option>
                                                <option value="4" ${user.roleId == 4 ? 'selected' : ''}>Manager</option>
                                            </select>
                                        </div>

                                        <!-- IsActive Checkbox -->
                                        <div class="form-group">
                                            <label class="form-label">Active</label><br>
                                            <input type="checkbox" name="isActive" value="true"
                                                   ${user.active ? 'checked' : ''}> Active
                                        </div>

                                        <!-- Submit -->
                                        <button class="save-btn hover-btn" type="submit">Save Changes</button>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-footer mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted-1">ÃÂ© 2025 <b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">FMartlthemes</a></div>
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
        <script src="Admin/js/jquery.min.js"></script>
        <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="Admin/js/scripts.js"></script>

    </body>

    <!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/customer_edit.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:10:13 GMT -->
</html>
