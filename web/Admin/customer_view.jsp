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
    <title>FMart Supermarket Admin - User Profile</title>
    
    <!-- Stylesheets -->
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/css/admin-style.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #06b6d4;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --dark-color: #1f2937;
            --light-color: #f8fafc;
            --border-color: #e5e7eb;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-secondary: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
        }

        .breadcrumb {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50px;
            padding: 12px 24px;
            backdrop-filter: blur(10px);
        }

        .breadcrumb-item a {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
        }

        .breadcrumb-item.active {
            color: white;
            font-weight: 600;
        }

        .user-profile-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 24px;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(20px);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .user-profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        .profile-header {
            background: var(--gradient-primary);
            padding: 40px 30px 60px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .profile-header::before {
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

        .profile-avatar {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            border: 6px solid rgba(255, 255, 255, 0.3);
            box-shadow: var(--shadow-lg);
            object-fit: cover;
            position: relative;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .profile-avatar:hover {
            transform: scale(1.05);
            border-color: rgba(255, 255, 255, 0.5);
        }

        .profile-name {
            color: white;
            font-size: 2rem;
            font-weight: 700;
            margin: 20px 0 8px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            position: relative;
            z-index: 2;
        }

        .profile-role {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
            font-weight: 500;
            position: relative;
            z-index: 2;
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 20px;
            border-radius: 50px;
            display: inline-block;
            backdrop-filter: blur(10px);
        }

        .stats-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 30px;
            position: relative;
            z-index: 2;
        }

        .stat-item {
            text-align: center;
            color: white;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            display: block;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
            font-weight: 500;
        }

        .profile-details {
            padding: 40px 30px;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0;
            border-bottom: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .detail-item:hover {
            background: rgba(79, 70, 229, 0.05);
            margin: 0 -20px;
            padding-left: 20px;
            padding-right: 20px;
            border-radius: 12px;
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .detail-label i {
            color: var(--primary-color);
            width: 20px;
            text-align: center;
        }

        .detail-value {
            font-weight: 500;
            color: #6b7280;
            text-align: right;
        }

        .status-active {
            background: var(--success-color);
            color: white;
            padding: 4px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-inactive {
            background: var(--danger-color);
            color: white;
            padding: 4px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .action-buttons {
            padding: 30px;
            border-top: 1px solid var(--border-color);
            background: rgba(248, 250, 252, 0.8);
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .btn-action {
            padding: 12px 24px;
            border-radius: 50px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background: #4338ca;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background: var(--secondary-color);
            color: white;
        }

        .btn-secondary:hover {
            background: #0891b2;
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
            }
            
            .stats-container {
                flex-direction: column;
                gap: 15px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .detail-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
            
            .detail-value {
                text-align: left;
            }
        }

        /* Loading Animation */
        @keyframes shimmer {
            0% { background-position: -200px 0; }
            100% { background-position: calc(200px + 100%) 0; }
        }

        .loading {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200px 100%;
            animation: shimmer 1.5s infinite;
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
                        <i class="fas fa-user-circle"></i> User Profile
                    </h2>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="customers.jsp"><i class="fas fa-users"></i> Users</a></li>
                        <li class="breadcrumb-item active">User View</li>
                    </ol>
                    
                    <div class="row justify-content-center">
                        <div class="col-lg-8 col-xl-7">
                            <div class="user-profile-card">
                                <!-- Profile Header -->
                                <div class="profile-header">
                                    <img src="${user.profileImageUrl != null ? user.profileImageUrl : 'images/default-avatar.png'}" 
                                         alt="Profile Image" 
                                         class="profile-avatar">
                                    
                                    <h3 class="profile-name">${user.fullName}</h3>
                                    <div class="profile-role">${user.roleName}</div>
                                    
                                    <div class="stats-container">
                                        <div class="stat-item">
                                            <span class="stat-number">15</span>
                                            <span class="stat-label">Purchases</span>
                                        </div>
                                        <div class="stat-item">
                                            <span class="stat-number">5</span>
                                            <span class="stat-label">Rewards</span>
                                        </div>
                                        <div class="stat-item">
                                            <span class="stat-number">4.8</span>
                                            <span class="stat-label">Rating</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Profile Details -->
                                <div class="profile-details">
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-id-card"></i>
                                            User ID
                                        </span>
                                        <span class="detail-value">${user.userId}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-user"></i>
                                            Username
                                        </span>
                                        <span class="detail-value">${user.username}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-envelope"></i>
                                            Email
                                        </span>
                                        <span class="detail-value">${user.email}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-phone"></i>
                                            Phone
                                        </span>
                                        <span class="detail-value">${user.phoneNumber}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-map-marker-alt"></i>
                                            Address
                                        </span>
                                        <span class="detail-value">${user.address}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-venus-mars"></i>
                                            Gender
                                        </span>
                                        <span class="detail-value">${user.gender}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-birthday-cake"></i>
                                            Date of Birth
                                        </span>
                                        <span class="detail-value">
                                            <fmt:formatDate value="${user.dateOfBirth}" pattern="dd/MM/yyyy"/>
                                        </span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-shield-alt"></i>
                                            Auth Provider
                                        </span>
                                        <span class="detail-value">${user.authProvider}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-external-link-alt"></i>
                                            External ID
                                        </span>
                                        <span class="detail-value">${user.externalID}</span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-toggle-on"></i>
                                            Status
                                        </span>
                                        <span class="detail-value">
                                            <c:choose>
                                                <c:when test="${user.active}">
                                                    <span class="status-active">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-inactive">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-calendar-plus"></i>
                                            Created At
                                        </span>
                                        <span class="detail-value">
                                            <fmt:formatDate value="${user.createdDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                        </span>
                                    </div>
                                    
                                    <div class="detail-item">
                                        <span class="detail-label">
                                            <i class="fas fa-clock"></i>
                                            Last Login
                                        </span>
                                        <span class="detail-value">
                                            <fmt:formatDate value="${user.lastLoginDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                        </span>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="action-buttons">
                                    <a href="UserManagementServlet?action=edit&id=${user.userId}" class="btn-action btn-primary">
                                        <i class="fas fa-edit"></i>
                                        Edit User
                                    </a>
                                    <a href="user_orders.jsp?id=${user.userId}" class="btn-action btn-secondary">
                                        <i class="fas fa-shopping-cart"></i>
                                        View Orders
                                    </a>
                                    <button class="btn-action btn-danger" onclick="confirmDelete(${user.userId})">
                                        <i class="fas fa-trash"></i>
                                        Delete User
                                    </button>
                                </div>
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
    <script src="js/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
    
    <script>
        function confirmDelete(userId) {
            if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                // Add your delete logic here
                window.location.href = 'delete_user.jsp?id=' + userId;
            }
        }

        // Add smooth scroll effect
        document.addEventListener('DOMContentLoaded', function() {
            // Add entrance animation
            const profileCard = document.querySelector('.user-profile-card');
            profileCard.style.opacity = '0';
            profileCard.style.transform = 'translateY(30px)';
            
            setTimeout(() => {
                profileCard.style.transition = 'all 0.6s ease';
                profileCard.style.opacity = '1';
                profileCard.style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>