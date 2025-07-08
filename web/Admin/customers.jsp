<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List, model.User" %>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/customers.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:10:07 GMT -->
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
    <style>
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border-radius: 4px;
        }

    </style>

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
                            <li class="breadcrumb-item active">Users</li>
                        </ol>
                        <div class="row justify-content-between">


                            <form action="UserManagementServlet" method="get" class="form-inline mb-3">
                                <input type="hidden" name="action" value="list" />

                                <div class="search-by-name-input mr-2">
                                    <input type="text" name="keyword" class="form-control" placeholder="Search by name or email"
                                           value="${param.keyword}">
                                </div>

                                <div class="input-group mr-2">
                                    <select name="roleID" class="form-control">
                                        <option value="">All Roles</option>
                                        <option value="1" ${param.roleID == '1' ? 'selected' : ''}>Customer</option>
                                        <option value="2" ${param.roleID == '2' ? 'selected' : ''}>Staff</option>
                                        <option value="3" ${param.roleID == '3' ? 'selected' : ''}>Admin</option>
                                        <option value="4" ${param.roleID == '4' ? 'selected' : ''}>Manager</option>
                                    </select>
                                    <div class="input-group-append">
                                        <button class="status-btn hover-btn" type="submit">Search</button>
                                    </div>
                                </div>
                            </form>

                        </div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-title-2">
                                        <h4>All User</h4>
                                    </div>
                                    <div class="card-body-table">
                                        <div class="table-responsive">
                                            <table class="table ucp-table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 40px;"><input type="checkbox" class="check-all"></th>
                                                        <th style="width: 50px;">ID</th>
                                                        <th style="width: 80px;">Avatar</th>
                                                        <th style="width: 100px;">Username</th>
                                                        <th style="width: 120px;">Full Name</th>
                                                        <th style="width: 160px;">Email</th>
                                                        <th style="width: 100px;">Phone</th>
                                                        <th style="width: 150px;">Address</th>
                                                        <th style="width: 80px;">Gender</th>
                                                        <th style="width: 120px;">Date of Birth</th>
                                                        <th style="width: 100px;">Role</th>
                                                        <th style="width: 60px;">Active</th>
                                                        <th style="width: 140px;">Created At</th>
                                                        <th style="width: 140px;">Last Login</th>
                                                        <th style="width: 120px;">Action</th>
                                                    </tr>

                                                </thead>

                                                <tbody>
                                                    <c:forEach var="user" items="${userList}">
                                                        <tr>
                                                            <td><input type="checkbox" name="selectedUsers" value="${user.userId}"></td>
                                                            <td>${user.userId}</td>
                                                            <td>
                                                                <img src="${user.profileImageUrl != null ? user.profileImageUrl : 'images/default-avatar.png'}" 
                                                                     alt="Profile" width="60" height="60" style="object-fit: cover; border-radius: 50%;">
                                                            </td>
                                                            <td>${user.username}</td>
                                                            <td>${user.fullName}</td>
                                                            <td>${user.email}</td>
                                                            <td>${user.phoneNumber}</td>
                                                            <td>${user.address}</td>
                                                            <td>${user.gender}</td>
                                                            <td>${user.dateOfBirth}</td>
                                                            <td>${user.roleName}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${user.active}"><span class="text-success">Y</span></c:when>
                                                                    <c:otherwise><span class="text-danger">N</span></c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>${user.createdDate}</td>
                                                            <td>${user.lastLoginDate}</td>
                                                            <td>
                                                                <a href="${pageContext.request.contextPath}/UserManagementServlet?action=view&id=${user.userId}" class="btn btn-sm btn-info">View</a>
                                                                <a href="${pageContext.request.contextPath}/UserManagementServlet?action=edit&id=${user.userId}" class="btn btn-sm btn-primary">Edit</a>
                                                                <a href="${pageContext.request.contextPath}/UserManagementServlet?action=delete&id=${user.userId}" 
                                                                   class="btn btn-sm btn-danger" 
                                                                   onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>

                                                </tbody>


                                            </table>
                                            <!-- Phân trang dưới bảng -->
                                            <c:set var="queryStr">
                                                keyword=${fn:escapeXml(param.keyword)}&roleID=${param.roleID}
                                            </c:set>

                                            <nav aria-label="Page navigation" class="mt-4">
                                                <ul class="pagination justify-content-center">

                                                    <!-- Previous -->
                                                    <li class="page-item ${page == 1 ? 'disabled' : ''}">
                                                        <a class="page-link"
                                                           href="UserManagementServlet?action=list&page=${page - 1}&${queryStr}">Previous</a>
                                                    </li>

                                                    <!-- Page Numbers -->
                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                        <li class="page-item ${i == page ? 'active' : ''}">
                                                            <a class="page-link"
                                                               href="UserManagementServlet?action=list&page=${i}&${queryStr}">${i}</a>
                                                        </li>
                                                    </c:forEach>

                                                    <!-- Next -->
                                                    <li class="page-item ${page == totalPages || totalPages == 0 ? 'disabled' : ''}">
                                                        <a class="page-link"
                                                           href="UserManagementServlet?action=list&page=${page + 1}&${queryStr}">Next</a>
                                                    </li>

                                                </ul>
                                            </nav>

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
        <script src="Admin/js/jquery.min.js"></script>
        <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="Admin/js/scripts.js"></script>

    </body>

    <!-- Mirrored from gambolthemes.net/html-items/gambo_admin_new/customers.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:10:09 GMT -->
</html>
