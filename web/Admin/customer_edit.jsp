<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>FMart - Edit User</title>

        <!-- Bootstrap CSS -->
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="Admin/css/styles.css" rel="stylesheet">

        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .main-content {
                padding: 20px;
            }

            .page-header {
                background: white;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .page-title {
                margin: 0;
                color: #2c3e50;
                font-weight: 600;
            }

            .breadcrumb {
                background: transparent;
                padding: 0;
                margin: 10px 0 0 0;
            }

            .breadcrumb-item a {
                color: #6c757d;
                text-decoration: none;
            }

            .breadcrumb-item a:hover {
                color: #007bff;
            }

            .form-card {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .form-header {
                background: linear-gradient(135deg, #007bff, #0056b3);
                color: white;
                padding: 20px;
                text-align: center;
            }

            .form-header h4 {
                margin: 0;
                font-weight: 600;
            }

            .form-body {
                padding: 30px;
            }

            .section-title {
                color: #495057;
                font-weight: 600;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e9ecef;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-label {
                font-weight: 600;
                color: #495057;
                margin-bottom: 5px;
            }

            .required {
                color: #dc3545;
            }

            .form-control {
                border: 1px solid #ced4da;
                border-radius: 4px;
                padding: 10px 12px;
                font-size: 14px;
            }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
            }

            .form-control:read-only {
                background-color: #e9ecef;
            }

            .form-actions {
                background: #f8f9fa;
                padding: 20px 30px;
                border-top: 1px solid #dee2e6;
                text-align: center;
            }

            .btn {
                padding: 10px 20px;
                border-radius: 4px;
                font-weight: 500;
                margin: 0 5px;
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #004085;
            }

            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
            }

            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
            }

            .text-muted {
                font-size: 12px;
                color: #6c757d !important;
            }

            .checkbox-wrapper {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .checkbox-wrapper input[type="checkbox"] {
                transform: scale(1.2);
            }

            @media (max-width: 768px) {
                .main-content {
                    padding: 10px;
                }

                .form-body {
                    padding: 20px;
                }

                .form-actions {
                    padding: 15px 20px;
                }

                .btn {
                    width: 100%;
                    margin: 5px 0;
                }
            }
        </style>
    </head>

    <body class="sb-nav-fixed">
        <!-- Navigation -->
        <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
            <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>
            <a href="index.jsp" class="frnt-link">
                <i class="fas fa-external-link-alt"></i> Home
            </a>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-user fa-fw"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-end">
                        <a class="dropdown-item" href="edit_profile.jsp">Edit Profile</a>
                        <a class="dropdown-item" href="change_password.jsp">Change Password</a>
                        <a class="dropdown-item" href="login.jsp">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>

        <div id="layoutSidenav">
            <jsp:include page="adminsidebar.jsp"></jsp:include>

                <div id="layoutSidenav_content">
                    <main>
                        <div class="main-content">
                            <!-- Page Header -->
                            <div class="page-header">
                                <h2 class="page-title">
                                    <i class="fas fa-user-edit"></i> Edit User
                                </h2>
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item">
                                            <a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a>
                                        </li>
                                        <li class="breadcrumb-item">
                                            <a href="customers.jsp"><i class="fas fa-users"></i> Users</a>
                                        </li>
                                        <li class="breadcrumb-item active">Edit User</li>
                                    </ol>
                                </nav>
                            </div>

                            <!-- Form Container -->
                            <div class="container-fluid">
                                <div class="row justify-content-center">
                                    <div class="col-lg-10">
                                        <div class="form-card">
                                            <!-- Form Header -->
                                            <div class="form-header">
                                                <h4><i class="fas fa-user-cog"></i> Update User Information</h4>
                                            </div>

                                            <!-- Form -->
                                            <form action="UserManagementServlet" method="post">
                                                <input type="hidden" name="action" value="edit">
                                                <input type="hidden" name="id" value="${user.userId}">

                                            <div class="form-body">
                                                <!-- Personal Information -->
                                                <div class="mb-4">
                                                    <h5 class="section-title">
                                                        <i class="fas fa-user"></i> Personal Information
                                                    </h5>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="form-label">
                                                                    Full Name <span class="required">*</span>
                                                                </label>
                                                                <input type="text" 
                                                                       name="fullName" 
                                                                       class="form-control"
                                                                       value="${user.fullName}" 
                                                                       required>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="form-label">Username</label>
                                                                <input type="text" 
                                                                       name="username" 
                                                                       class="form-control"
                                                                       value="${user.username}" 
                                                                       readonly>
                                                                <small class="text-muted">Username cannot be changed</small>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="form-label">
                                                                    Email <span class="required">*</span>
                                                                </label>
                                                                <input type="email" 
                                                                       name="email" 
                                                                       class="form-control"
                                                                       value="${user.email}" 
                                                                       required>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="form-label">Phone Number</label>
                                                                <input type="tel" 
                                                                       name="phoneNumber" 
                                                                       class="form-control"
                                                                       value="${user.phoneNumber}">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="form-label">Gender</label>
                                                                <select name="gender" class="form-control">
                                                                    <option value="">Select Gender</option>
                                                                    <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                                    <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                                    <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="form-label">Date of Birth</label>
                                                                <input type="date" 
                                                                       name="dateOfBirth" 
                                                                       class="form-control"
                                                                       value="${user.dateOfBirth}">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="form-label">Address</label>
                                                        <textarea name="address" 
                                                                  class="form-control" 
                                                                  rows="3">${user.address}</textarea>
                                                    </div>
                                                </div>

                                                <!-- Account Settings -->
                                                <div class="mb-4">
                                                    <h5 class="section-title">
                                                        <i class="fas fa-cog"></i> Account Settings
                                                    </h5>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="form-label">Role <span class="required">*</span></label>
                                                                <select name="roleID" class="form-control" required>
                                                                    <option value="1" ${user.roleId == 1 ? 'selected' : ''}>Customer</option>
                                                                    <option value="2" ${user.roleId == 2 ? 'selected' : ''}>Staff</option>
                                                                    <option value="3" ${user.roleId == 3 ? 'selected' : ''}>Admin</option>
                                                                    <option value="4" ${user.roleId == 4 ? 'selected' : ''}>Manager</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="form-label">Account Status</label>
                                                                <div class="checkbox-wrapper">
                                                                    <input type="checkbox" 
                                                                           id="isActive"
                                                                           name="isActive" 
                                                                           value="true"
                                                                           ${user.active ? 'checked' : ''}>
                                                                    <label for="isActive">Account is Active</label>
                                                                </div>
                                                                <small class="text-muted">Inactive accounts cannot login</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Form Actions -->
                                            <div class="form-actions">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save"></i> Save Changes
                                                </button>

                                                <a href="UserManagementServlet" class="btn btn-secondary">
                                                    <i class="fas fa-arrow-left"></i> Back to Users
                                                </a>


                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>

                <!-- Footer -->
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">
                                © 2025 <strong>FMart Supermarket</strong>
                            </div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>

        <!-- Scripts -->
        <script src="Admin/js/jquery.min.js"></script>
        <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="Admin/js/scripts.js"></script>

        <script>
            // Simple form validation
            document.querySelector('form').addEventListener('submit', function (e) {
                const requiredFields = this.querySelectorAll('[required]');
                let isValid = true;

                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        field.style.borderColor = '#dc3545';
                        isValid = false;
                    } else {
                        field.style.borderColor = '#ced4da';
                    }
                });

                if (!isValid) {
                    e.preventDefault();
                    alert('Please fill in all required fields.');
                }
            });

            // Reset form styling on input
            document.querySelectorAll('.form-control').forEach(input => {
                input.addEventListener('input', function () {
                    this.style.borderColor = '#ced4da';
                });
            });
        </script>
    </body>
</html>