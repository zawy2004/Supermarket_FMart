<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="java.util.List, model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>FMart Supermarket Admin - Edit User</title>
    
    <!-- Stylesheets -->
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/css/admin-style.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #6366f1;
            --primary-dark: #4f46e5;
            --secondary-color: #06b6d4;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --dark-color: #1f2937;
            --light-color: #f8fafc;
            --border-color: #e5e7eb;
            --input-border: #d1d5db;
            --input-focus: #6366f1;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-form: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
        }

        body {
            background: var(--gradient-primary);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container-fluid {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            margin: 20px;
            padding: 30px;
            box-shadow: var(--shadow-lg);
        }

        .page-title {
            color: white;
            font-weight: 700;
            font-size: 2.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .breadcrumb {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50px;
            padding: 12px 24px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .breadcrumb-item a {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .breadcrumb-item a:hover {
            color: white;
        }

        .breadcrumb-item.active {
            color: white;
            font-weight: 600;
        }

        .edit-form-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 24px;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(20px);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .edit-form-container:hover {
            transform: translateY(-2px);
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        .form-header {
            background: var(--gradient-form);
            padding: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .form-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.1'%3E%3Ccircle cx='30' cy='30' r='2'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            animation: float 20s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .form-title {
            color: var(--dark-color);
            font-size: 2rem;
            font-weight: 700;
            margin: 0;
            position: relative;
            z-index: 2;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .form-subtitle {
            color: #6b7280;
            font-size: 1rem;
            margin-top: 8px;
            position: relative;
            z-index: 2;
        }

        .form-body {
            padding: 40px;
        }

        .form-section {
            margin-bottom: 30px;
        }

        .section-title {
            color: var(--dark-color);
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: var(--primary-color);
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-label {
            color: var(--dark-color);
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label i {
            color: var(--primary-color);
            width: 16px;
        }

        .required {
            color: var(--danger-color);
        }

        .form-control {
            border: 2px solid var(--input-border);
            border-radius: 12px;
            padding: 14px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
        }

        .form-control:focus {
            border-color: var(--input-focus);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            background: white;
            outline: none;
        }

        .form-control:read-only {
            background: rgba(243, 244, 246, 0.8);
            cursor: not-allowed;
        }

        .form-control.error {
            border-color: var(--danger-color);
            background: rgba(239, 68, 68, 0.05);
        }

        .form-control.success {
            border-color: var(--success-color);
            background: rgba(16, 185, 129, 0.05);
        }

        .error-message {
            color: var(--danger-color);
            font-size: 0.85rem;
            margin-top: 5px;
            display: none;
        }

        .success-message {
            color: var(--success-color);
            font-size: 0.85rem;
            margin-top: 5px;
            display: none;
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }

        select.form-control {
            cursor: pointer;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px;
            border: 2px solid var(--input-border);
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .checkbox-container:hover {
            border-color: var(--primary-color);
            background: rgba(99, 102, 241, 0.05);
        }

        .checkbox-container input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: var(--primary-color);
        }

        .checkbox-label {
            color: var(--dark-color);
            font-weight: 500;
            cursor: pointer;
            margin: 0;
        }

        .form-actions {
            padding: 30px 40px;
            background: rgba(248, 250, 252, 0.8);
            border-top: 1px solid var(--border-color);
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-enhanced {
            padding: 14px 30px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            min-width: 140px;
            justify-content: center;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background: #6b7280;
            color: white;
        }

        .btn-secondary:hover {
            background: #4b5563;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-danger {
            background: var(--danger-color);
            color: white;
        }

        .btn-danger:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }

        .form-grid-full {
            grid-column: 1 / -1;
        }

        .footer-enhanced {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            padding: 20px 0;
            margin-top: 40px;
            border-radius: 20px 20px 0 0;
        }

        .footer-enhanced .text-muted-1 {
            color: rgba(255, 255, 255, 0.8);
        }

        .footer-enhanced a {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
        }

        .footer-enhanced a:hover {
            color: white;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container-fluid {
                margin: 10px;
                padding: 20px;
            }
            
            .page-title {
                font-size: 2rem;
                flex-direction: column;
                gap: 10px;
            }
            
            .form-body {
                padding: 30px 20px;
            }
            
            .form-actions {
                padding: 20px;
                flex-direction: column;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .btn-enhanced {
                width: 100%;
            }
        }

        /* Animation for form entrance */
        .form-animate {
            opacity: 0;
            transform: translateY(30px);
            animation: slideInUp 0.6s ease forwards;
        }

        @keyframes slideInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Validation styles */
        .validation-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--success-color);
            display: none;
        }

        .form-control.success + .validation-icon {
            display: block;
        }
    </style>
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
                    <h2 class="page-title">
                        <i class="fas fa-user-edit"></i>
                        Edit User Profile
                    </h2>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="customers.jsp"><i class="fas fa-users"></i> Users</a></li>
                        <li class="breadcrumb-item active">Edit User</li>
                    </ol>
                    
                    <div class="row justify-content-center">
                        <div class="col-lg-10 col-xl-8">
                            <div class="edit-form-container form-animate">
                                <!-- Form Header -->
                                <div class="form-header">
                                    <h3 class="form-title">
                                        <i class="fas fa-user-cog"></i>
                                        Update User Information
                                    </h3>
                                    <p class="form-subtitle">Modify user details and permissions</p>
                                </div>

                                <!-- Form Body -->
                                <form id="editUserForm" action="UserManagementServlet" method="post" novalidate>
                                    <input type="hidden" name="action" value="edit">
                                    <input type="hidden" name="id" value="${user.userId}">

                                    <div class="form-body">
                                        <!-- Personal Information Section -->
                                        <div class="form-section">
                                            <h4 class="section-title">
                                                <i class="fas fa-user"></i>
                                                Personal Information
                                            </h4>
                                            
                                            <div class="form-grid">
                                                <div class="form-group">
                                                    <label class="form-label">
                                                        <i class="fas fa-signature"></i>
                                                        Full Name <span class="required">*</span>
                                                    </label>
                                                    <input type="text" 
                                                           name="fullName" 
                                                           class="form-control"
                                                           value="${user.fullName}" 
                                                           placeholder="Enter full name"
                                                           required>
                                                    <i class="fas fa-check validation-icon"></i>
                                                    <div class="error-message">Please enter a valid full name</div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">
                                                        <i class="fas fa-user-tag"></i>
                                                        Username
                                                    </label>
                                                    <input type="text" 
                                                           name="username" 
                                                           class="form-control"
                                                           value="${user.username}" 
                                                           readonly>
                                                    <small class="text-muted">Username cannot be changed</small>
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">
                                                        <i class="fas fa-envelope"></i>
                                                        Email Address <span class="required">*</span>
                                                    </label>
                                                    <input type="email" 
                                                           name="email" 
                                                           class="form-control"
                                                           value="${user.email}" 
                                                           placeholder="Enter email address"
                                                           required>
                                                    <i class="fas fa-check validation-icon"></i>
                                                    <div class="error-message">Please enter a valid email address</div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">
                                                        <i class="fas fa-phone"></i>
                                                        Phone Number
                                                    </label>
                                                    <input type="tel" 
                                                           name="phoneNumber" 
                                                           class="form-control"
                                                           value="${user.phoneNumber}" 
                                                           placeholder="Enter phone number">
                                                    <i class="fas fa-check validation-icon"></i>
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">
                                                        <i class="fas fa-venus-mars"></i>
                                                        Gender
                                                    </label>
                                                    <select name="gender" class="form-control">
                                                        <option value="">Select Gender</option>
                                                        <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                        <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                        <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">
                                                        <i class="fas fa-birthday-cake"></i>
                                                        Date of Birth
                                                    </label>
                                                    <input type="date" 
                                                           name="dateOfBirth" 
                                                           class="form-control"
                                                           value="${user.dateOfBirth}">
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="form-label">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                    Address
                                                </label>
                                                <textarea name="address" 
                                                          class="form-control" 
                                                          placeholder="Enter complete address"
                                                          rows="3">${user.address}</textarea>
                                            </div>
                                        </div>

                                        <!-- Account Settings Section -->
                                        <div class="form-section">
                                            <h4 class="section-title">
                                                <i class="fas fa-cog"></i>
                                                Account Settings
                                            </h4>
                                            
                                            <div class="form-grid">
                                                <div class="form-group">
                                                    <label class="form-label">
                                                        <i class="fas fa-user-shield"></i>
                                                        Role
                                                    </label>
                                                    <select name="roleID" class="form-control" required>
                                                        <option value="1" ${user.roleId == 1 ? 'selected' : ''}>
                                                            <i class="fas fa-user"></i> Customer
                                                        </option>
                                                        <option value="2" ${user.roleId == 2 ? 'selected' : ''}>
                                                            <i class="fas fa-user-tie"></i> Staff
                                                        </option>
                                                        <option value="3" ${user.roleId == 3 ? 'selected' : ''}>
                                                            <i class="fas fa-user-cog"></i> Admin
                                                        </option>
                                                        <option value="4" ${user.roleId == 4 ? 'selected' : ''}>
                                                            <i class="fas fa-user-crown"></i> Manager
                                                        </option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">
                                                        <i class="fas fa-toggle-on"></i>
                                                        Account Status
                                                    </label>
                                                    <div class="checkbox-container">
                                                        <input type="checkbox" 
                                                               id="isActive"
                                                               name="isActive" 
                                                               value="true"
                                                               ${user.active ? 'checked' : ''}>
                                                        <label class="checkbox-label" for="isActive">
                                                            Account is Active
                                                        </label>
                                                    </div>
                                                    <small class="text-muted">Inactive accounts cannot login to the system</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Form Actions -->
                                    <div class="form-actions">
                                        <button type="submit" class="btn-enhanced btn-primary" id="saveBtn">
                                            <i class="fas fa-save"></i>
                                            <span class="btn-text">Save Changes</span>
                                            <div class="loading-spinner"></div>
                                        </button>
                                        
                                        <a href="customers.jsp" class="btn-enhanced btn-secondary">
                                            <i class="fas fa-arrow-left"></i>
                                            Back to Users
                                        </a>
                                        
                                        <button type="button" class="btn-enhanced btn-danger" onclick="resetForm()">
                                            <i class="fas fa-undo"></i>
                                            Reset Form
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            
            <footer class="footer-enhanced">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted-1">
                            © 2025 <b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">FMartthemes</a>
                        </div>
                        <div class="footer-links">
                            <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/privacy_policy.jsp">Privacy Policy</a>
                            <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/term_and_conditions.jsp">Terms & Conditions</a>
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
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('editUserForm');
            const saveBtn = document.getElementById('saveBtn');
            const loadingSpinner = saveBtn.querySelector('.loading-spinner');
            const btnText = saveBtn.querySelector('.btn-text');

            // Form validation
            const validators = {
                fullName: (value) => value.trim().length >= 2,
                email: (value) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value),
                phoneNumber: (value) => !value || /^[\d\s\-\+\(\)]+$/.test(value)
            };

            // Real-time validation
            Object.keys(validators).forEach(fieldName => {
                const field = form.querySelector(`[name="${fieldName}"]`);
                if (field) {
                    field.addEventListener('input', function() {
                        validateField(field, validators[fieldName]);
                    });
                    field.addEventListener('blur', function() {
                        validateField(field, validators[fieldName]);
                    });
                }
            });

            function validateField(field, validator) {
                const isValid = validator(field.value);
                const errorMsg = field.parentNode.querySelector('.error-message');
                
                field.classList.remove('error', 'success');
                if (errorMsg) errorMsg.style.display = 'none';

                if (field.value.trim()) {
                    if (isValid) {
                        field.classList.add('success');
                    } else {
                        field.classList.add('error');
                        if (errorMsg) errorMsg.style.display = 'block';
                    }
                }
            }

            // Form submission
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Validate all required fields
                let isFormValid = true;
                const requiredFields = form.querySelectorAll('[required]');
                
                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        field.classList.add('error');
                        isFormValid = false;
                    }
                });

                if (!isFormValid) {
                    showNotification('Please fill in all required fields', 'error');
                    return;
                }

                // Show loading state
                saveBtn.disabled = true;
                loadingSpinner.style.display = 'block';
                btnText.textContent = 'Saving...';

                // Simulate form submission (replace with actual submission)
                setTimeout(() => {
                    form.submit();
                }, 1000);
            });

            // Phone number formatting
            const phoneField = form.querySelector('[name="phoneNumber"]');
            if (phoneField) {
                phoneField.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value.length >= 10) {
                        value = value.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
                    }
                    e.target.value = value;
                });
            }

            // Auto-expand textarea
            const textareas = form.querySelectorAll('textarea');
            textareas.forEach(textarea => {
                textarea.addEventListener('input', function() {
                    this.style.height = 'auto';
                    this.style.height = this.scrollHeight + 'px';
                });
            });
        });

        function resetForm() {
            if (confirm('Are you sure you want to reset the form? All changes will be lost.')) {
                document.getElementById('editUserForm').reset();
                
                // Remove validation classes
                const fields = document.querySelectorAll('.form-control');
                fields.forEach(field => {
                    field.classList.remove('error', 'success');
                });

                // Hide error messages
                const errorMessages = document.querySelectorAll('.error-message');
                errorMessages.forEach(msg => {
                    msg.style.display = 'none';
                });

                showNotification('Form has been reset', 'info');
            }
        }

        function showNotification(message, type = 'info') {
            // Create notification element
            const notification = document.createElement('div');
            notification.className = `notification notification-${type}`;
            notification.innerHTML = `
                <div class="notification-content">
                    <i class="fas ${getNotificationIcon(type)}"></i>
                    <span>${message}</span>
                    <button class="notification-close" onclick="closeNotification(this.parentElement)">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            `;

            // Add styles
            const style = document.createElement('style');
            style.textContent = `
                .notification {
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    z-index: 10000;
                    max-width: 400px;
                    border-radius: 12px;
                    box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1);
                    transform: translateX(100%);
                    transition: all 0.3s ease;
                    backdrop-filter: blur(10px);
                }

                .notification.show {
                    transform: translateX(0);
                }

                .notification-info {
                    background: rgba(59, 130, 246, 0.95);
                    border-left: 4px solid #3b82f6;
                    color: white;
                }

                .notification-success {
                    background: rgba(16, 185, 129, 0.95);
                    border-left: 4px solid #10b981;
                    color: white;
                }

                .notification-error {
                    background: rgba(239, 68, 68, 0.95);
                    border-left: 4px solid #ef4444;
                    color: white;
                }

                .notification-warning {
                    background: rgba(245, 158, 11, 0.95);
                    border-left: 4px solid #f59e0b;
                    color: white;
                }

                .notification-content {
                    padding: 16px 20px;
                    display: flex;
                    align-items: center;
                    gap: 12px;
                }

                .notification-close {
                    background: none;
                    border: none;
                    color: inherit;
                    cursor: pointer;
                    padding: 4px;
                    border-radius: 4px;
                    margin-left: auto;
                    opacity: 0.8;
                    transition: opacity 0.2s ease;
                }

                .notification-close:hover {
                    opacity: 1;
                    background: rgba(255, 255, 255, 0.2);
                }
            `;

            if (!document.querySelector('#notification-styles')) {
                style.id = 'notification-styles';
                document.head.appendChild(style);
            }

            // Add to DOM
            document.body.appendChild(notification);

            // Show notification
            setTimeout(() => {
                notification.classList.add('show');
            }, 100);

            // Auto-hide after 5 seconds
            setTimeout(() => {
                closeNotification(notification);
            }, 5000);
        }

        function getNotificationIcon(type) {
            const icons = {
                info: 'fa-info-circle',
                success: 'fa-check-circle',
                error: 'fa-exclamation-circle',
                warning: 'fa-exclamation-triangle'
            };
            return icons[type] || icons.info;
        }

        function closeNotification(notification) {
            notification.classList.remove('show');
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.parentNode.removeChild(notification);
                }
            }, 300);
        }

        // Enhanced form interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Add floating label effect
            const formControls = document.querySelectorAll('.form-control');
            formControls.forEach(control => {
                if (control.value) {
                    control.classList.add('has-value');
                }

                control.addEventListener('input', function() {
                    if (this.value) {
                        this.classList.add('has-value');
                    } else {
                        this.classList.remove('has-value');
                    }
                });
            });

            // Add progress indicator
            const progressBar = document.createElement('div');
            progressBar.className = 'form-progress';
            progressBar.innerHTML = `
                <div class="progress-bar">
                    <div class="progress-fill" id="progressFill"></div>
                </div>
                <div class="progress-text">
                    <span id="progressText">Form completion: 0%</span>
                </div>
            `;

            const progressStyles = document.createElement('style');
            progressStyles.textContent = `
                .form-progress {
                    position: sticky;
                    top: 20px;
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(10px);
                    padding: 15px 20px;
                    border-radius: 12px;
                    margin-bottom: 20px;
                    box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
                    z-index: 100;
                }

                .progress-bar {
                    width: 100%;
                    height: 8px;
                    background: #e5e7eb;
                    border-radius: 4px;
                    overflow: hidden;
                    margin-bottom: 8px;
                }

                .progress-fill {
                    height: 100%;
                    background: linear-gradient(90deg, #6366f1, #8b5cf6);
                    border-radius: 4px;
                    transition: width 0.3s ease;
                    width: 0%;
                }

                .progress-text {
                    font-size: 0.9rem;
                    color: #6b7280;
                    font-weight: 500;
                }
            `;

            document.head.appendChild(progressStyles);
            document.querySelector('.form-body').insertBefore(progressBar, document.querySelector('.form-section'));

            // Update progress
            function updateProgress() {
                const requiredFields = document.querySelectorAll('[required]');
                const filledFields = Array.from(requiredFields).filter(field => field.value.trim());
                const percentage = Math.round((filledFields.length / requiredFields.length) * 100);

                document.getElementById('progressFill').style.width = percentage + '%';
                document.getElementById('progressText').textContent = `Form completion: ${percentage}%`;
            }

            // Listen for input changes
            const allInputs = document.querySelectorAll('input, select, textarea');
            allInputs.forEach(input => {
                input.addEventListener('input', updateProgress);
                input.addEventListener('change', updateProgress);
            });

            // Initial progress update
            updateProgress();

            // Add keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Ctrl/Cmd + S to save
                if ((e.ctrlKey || e.metaKey) && e.key === 's') {
                    e.preventDefault();
                    document.getElementById('saveBtn').click();
                }

                // Ctrl/Cmd + R to reset (with confirmation)
                if ((e.ctrlKey || e.metaKey) && e.key === 'r') {
                    e.preventDefault();
                    resetForm();
                }

                // Escape to go back
                if (e.key === 'Escape') {
                    if (confirm('Are you sure you want to leave? Unsaved changes will be lost.')) {
                        window.location.href = 'customers.jsp';
                    }
                }
            });

            // Add tooltips for help
            const helpTooltips = {
                'fullName': 'Enter the user\'s complete full name',
                'email': 'Must be a valid email address format',
                'phoneNumber': 'Optional. Include country code if international',
                'roleID': 'Determines user permissions and access level',
                'isActive': 'Inactive users cannot log into the system'
            };

            Object.keys(helpTooltips).forEach(fieldName => {
                const field = document.querySelector(`[name="${fieldName}"]`);
                if (field) {
                    const label = field.parentNode.querySelector('.form-label');
                    if (label) {
                        const helpIcon = document.createElement('i');
                        helpIcon.className = 'fas fa-question-circle';
                        helpIcon.style.cssText = 'margin-left: 5px; opacity: 0.6; cursor: help;';
                        helpIcon.title = helpTooltips[fieldName];
                        label.appendChild(helpIcon);
                    }
                }
            });
        });

        // Add unsaved changes warning
        let formChanged = false;
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('editUserForm');
            const inputs = form.querySelectorAll('input, select, textarea');

            inputs.forEach(input => {
                input.addEventListener('change', function() {
                    formChanged = true;
                });
            });

            window.addEventListener('beforeunload', function(e) {
                if (formChanged) {
                    e.preventDefault();
                    e.returnValue = '';
                    return '';
                }
            });

            // Reset flag on successful submit
            form.addEventListener('submit', function() {
                formChanged = false;
            });
        });
    </script>
</body>
</html>