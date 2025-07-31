<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List, model.User" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="FMart Supermarket Admin - User Management">
        <meta name="author" content="FMart">
        <title>User Management - FMart Admin</title>

        <!-- Stylesheets -->
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

        <style>
            .users-header {
                background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
                color: white;
                padding: 2rem;
                border-radius: 15px;
                margin-bottom: 2rem;
                box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            }

            .stats-cards {
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                text-align: center;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                border: 1px solid #e3e6f0;
                transition: all 0.3s ease;
                height: 100%;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 30px rgba(0,0,0,0.15);
            }

            .stat-icon {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1rem;
                font-size: 1.5rem;
                color: white;
            }

            .stat-icon.customers {
                background: linear-gradient(135deg, #28a745, #20c997);
            }
            .stat-icon.staff {
                background: linear-gradient(135deg, #007bff, #6610f2);
            }
            .stat-icon.managers {
                background: linear-gradient(135deg, #fd7e14, #ffc107);
            }
            .stat-icon.admins {
                background: linear-gradient(135deg, #dc3545, #fd7e14);
            }
            .stat-icon.total {
                background: linear-gradient(135deg, #6f42c1, #e83e8c);
            }

            .stat-number {
                font-size: 2.5rem;
                font-weight: 700;
                color: #495057;
                margin-bottom: 0.5rem;
            }

            .stat-label {
                color: #6c757d;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.85rem;
                letter-spacing: 0.5px;
            }

            .search-card {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                border: 1px solid #e3e6f0;
            }

            .search-title {
                display: flex;
                align-items: center;
                margin-bottom: 1.5rem;
                color: #495057;
                font-weight: 600;
            }

            .search-title i {
                margin-right: 0.75rem;
                color: #6f42c1;
                font-size: 1.2rem;
            }

            .form-control, .form-select {
                border: 2px solid #e3e6f0;
                border-radius: 10px;
                padding: 0.75rem 1rem;
                font-size: 0.95rem;
                transition: all 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                border-color: #6f42c1;
                box-shadow: 0 0 0 0.2rem rgba(111, 66, 193, 0.25);
            }

            .btn-search {
                background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
                border: none;
                border-radius: 10px;
                padding: 0.75rem 2rem;
                font-weight: 600;
                color: white;
                transition: all 0.3s ease;
            }

            .btn-search:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(111, 66, 193, 0.4);
                color: white;
            }

            .btn-clear {
                background: #6c757d;
                border: none;
                border-radius: 10px;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                color: white;
                transition: all 0.3s ease;
                margin-left: 0.5rem;
            }

            .btn-clear:hover {
                background: #5a6268;
                transform: translateY(-2px);
                color: white;
            }

            .users-table-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                border: 1px solid #e3e6f0;
            }

            .table-header {
                background: linear-gradient(135deg, #f8f9fc 0%, #e9ecef 100%);
                padding: 1.5rem;
                border-bottom: 2px solid #e3e6f0;
            }

            .table-title {
                display: flex;
                align-items: center;
                justify-content: between;
                margin: 0;
                color: #495057;
                font-weight: 600;
            }

            .table-title i {
                margin-right: 0.75rem;
                color: #6f42c1;
                font-size: 1.2rem;
            }

            .bulk-actions {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .btn-bulk {
                padding: 0.5rem 1rem;
                border-radius: 8px;
                border: none;
                font-size: 0.85rem;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-bulk-activate {
                background: #28a745;
                color: white;
            }

            .btn-bulk-deactivate {
                background: #dc3545;
                color: white;
            }

            .btn-bulk:hover {
                transform: translateY(-1px);
                box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            }

            .table {
                margin: 0;
            }

            .table thead th {
                background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
                color: white;
                border: none;
                font-weight: 600;
                padding: 1rem 0.75rem;
                text-align: center;
                font-size: 0.85rem;
                letter-spacing: 0.5px;
            }

            .table tbody td {
                padding: 1rem 0.75rem;
                vertical-align: middle;
                border-color: #f1f3f4;
                font-size: 0.9rem;
            }

            .table tbody tr {
                transition: all 0.2s ease;
            }

            .table tbody tr:hover {
                background-color: #f8f9fc;
                transform: scale(1.01);
            }

            .user-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #e3e6f0;
                transition: all 0.3s ease;
            }

            .user-avatar:hover {
                border-color: #6f42c1;
                transform: scale(1.1);
            }

            .user-info {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }

            .user-name {
                font-weight: 600;
                color: #495057;
                margin-bottom: 0.25rem;
            }

            .user-username {
                font-size: 0.8rem;
                color: #6c757d;
            }

            .role-badge {
                display: inline-block;
                padding: 0.4rem 0.8rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .role-customer {
                background: #e8f5e8;
                color: #2e7d32;
            }
            .role-staff {
                background: #e3f2fd;
                color: #1976d2;
            }
            .role-manager {
                background: #fff3e0;
                color: #f57c00;
            }
            .role-admin {
                background: #ffebee;
                color: #d32f2f;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                padding: 0.4rem 0.8rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .status-active {
                background: #e8f5e8;
                color: #2e7d32;
            }

            .status-inactive {
                background: #ffebee;
                color: #d32f2f;
            }

            .status-badge i {
                margin-right: 0.4rem;
                font-size: 0.6rem;
            }

            .action-buttons {
                display: flex;
                gap: 0.5rem;
                justify-content: center;
            }

            .btn-action {
                padding: 0.4rem 0.8rem;
                border-radius: 8px;
                border: none;
                font-size: 0.8rem;
                font-weight: 600;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.3rem;
            }

            .btn-view {
                background: #17a2b8;
                color: white;
            }

            .btn-edit {
                background: #28a745;
                color: white;
            }

            .btn-delete {
                background: #dc3545;
                color: white;
            }

            .btn-action:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
                color: white;
            }

            .pagination {
                margin: 2rem 0 0 0;
                justify-content: center;
            }

            .page-item {
                margin: 0 0.2rem;
            }

            .page-link {
                color: #6f42c1;
                border: 2px solid #e3e6f0;
                border-radius: 10px;
                padding: 0.6rem 1rem;
                font-weight: 600;
                background: white;
                transition: all 0.3s ease;
            }

            .page-link:hover {
                background: #f8f9fc;
                border-color: #6f42c1;
                color: #e83e8c;
                transform: translateY(-2px);
            }

            .page-item.active .page-link {
                background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
                border-color: #6f42c1;
                color: white;
                box-shadow: 0 4px 15px rgba(111, 66, 193, 0.4);
            }

            .page-item.disabled .page-link {
                background: #f8f9fa;
                color: #adb5bd;
                border-color: #dee2e6;
            }

            .breadcrumb {
                background: transparent;
                padding: 0;
                margin-bottom: 2rem;
            }

            .breadcrumb-item a {
                color: #6f42c1;
                text-decoration: none;
                font-weight: 500;
            }

            .breadcrumb-item a:hover {
                color: #e83e8c;
            }

            .check-all, .user-checkbox {
                width: 18px;
                height: 18px;
                accent-color: #6f42c1;
            }

            .selected-count {
                background: #fff3cd;
                color: #856404;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                font-size: 0.85rem;
                font-weight: 600;
                margin-right: 1rem;
            }

            @media (max-width: 768px) {
                .users-header {
                    text-align: center;
                    padding: 1.5rem;
                }

                .search-card {
                    padding: 1.5rem;
                }

                .action-buttons {
                    flex-direction: column;
                    gap: 0.3rem;
                }

                .btn-action {
                    width: 100%;
                    justify-content: center;
                }

                .bulk-actions {
                    flex-direction: column;
                    align-items: stretch;
                    gap: 0.5rem;
                }

                .table-responsive {
                    font-size: 0.8rem;
                }
            }

            .empty-state {
                text-align: center;
                padding: 3rem;
                color: #6c757d;
            }

            .empty-state i {
                font-size: 4rem;
                color: #dee2e6;
                margin-bottom: 1rem;
            }

            .loading-spinner {
                display: none;
                text-align: center;
                padding: 2rem;
            }

            .spinner-border {
                color: #6f42c1;
            }
        </style>
    </head>

    <body class="sb-nav-fixed">
        <jsp:include page="header.jsp"></jsp:include>

            <div id="layoutSidenav">
            <jsp:include page="adminsidebar.jsp"></jsp:include>

                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <!-- Breadcrumb -->
                            <nav aria-label="breadcrumb" class="mt-4">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">User Management</li>
                                </ol>
                            </nav>

                            <!-- Header -->
                            <div class="users-header">
                                <div class="row align-items-center">
                                    <div class="col-lg-8">
                                        <h1 class="mb-2"><i class="fas fa-users me-3"></i>User Management</h1>
                                        <p class="mb-0 opacity-75">Manage all users, roles, and permissions in your system</p>
                                    </div>
                                    <div class="col-lg-4 text-end">
                                        <button class="btn btn-light btn-lg">
                                            <i class="fas fa-user-plus me-2"></i>Add New User
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Statistics Cards -->
                            <div class="row stats-cards">
                                <div class="col-lg-2 col-md-4 col-sm-6 mb-3">
                                    <div class="stat-card">
                                        <div class="stat-icon customers">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <div class="stat-number" id="customerCount">${customerCount}</div>
                                    <div class="stat-label">Customers</div>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-4 col-sm-6 mb-3">
                                <div class="stat-card">
                                    <div class="stat-icon staff">
                                        <i class="fas fa-user-tie"></i>
                                    </div>
                                    <div class="stat-number" id="staffCount">${staffCount}</div>
                                    <div class="stat-label">Staff</div>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-4 col-sm-6 mb-3">
                                <div class="stat-card">
                                    <div class="stat-icon managers">
                                        <i class="fas fa-user-crown"></i>
                                    </div>
                                    <div class="stat-number" id="managerCount">${managerCount}</div>
                                    <div class="stat-label">Managers</div>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-4 col-sm-6 mb-3">
                                <div class="stat-card">
                                    <div class="stat-icon admins">
                                        <i class="fas fa-user-shield"></i>
                                    </div>
                                    <div class="stat-number" id="adminCount">${adminCount}</div>
                                    <div class="stat-label">Admins</div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-8 col-sm-12 mb-3">
                                <div class="stat-card">
                                    <div class="stat-icon total">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <div class="stat-number" id="totalCount">${totalUsers}</div>
                                    <div class="stat-label">Total Users</div>
                                </div>
                            </div>
                        </div>


                        <!-- Search Card -->
                        <div class="search-card">
                            <h4 class="search-title">
                                <i class="fas fa-search"></i>Search & Filter Users
                            </h4>

                            <form action="UserManagementServlet" method="get" id="searchForm">
                                <input type="hidden" name="action" value="list" />

                                <div class="row align-items-end">
                                    <div class="col-lg-4 col-md-6 mb-3">
                                        <label class="form-label fw-bold">
                                            <i class="fas fa-search me-2"></i>Search Keyword
                                        </label>
                                        <input type="text" name="keyword" class="form-control" 
                                               placeholder="Search by name, email, or username..."
                                               value="${param.keyword}">
                                    </div>

                                    <div class="col-lg-3 col-md-6 mb-3">
                                        <label class="form-label fw-bold">
                                            <i class="fas fa-user-tag me-2"></i>Role Filter
                                        </label>
                                        <select name="roleID" class="form-select">
                                            <option value="">All Roles</option>
                                            <option value="1" ${param.roleID == '1' ? 'selected' : ''}>Customer</option>
                                            <option value="2" ${param.roleID == '2' ? 'selected' : ''}>Staff</option>
                                            <option value="3" ${param.roleID == '3' ? 'selected' : ''}>Manager</option>
                                            <option value="4" ${param.roleID == '4' ? 'selected' : ''}>Admin</option>
                                        </select>
                                    </div>

                                    <div class="col-lg-3 col-md-6 mb-3">
                                        <label class="form-label fw-bold">
                                            <i class="fas fa-toggle-on me-2"></i>Status Filter
                                        </label>
                                        <select name="status" class="form-select">
                                            <option value="">All Status</option>
                                            <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                                            <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>

                                    <div class="col-lg-2 col-md-6 mb-3">
                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-search flex-fill">
                                                <i class="fas fa-search"></i>
                                            </button>
                                            <button type="button" class="btn btn-clear" onclick="clearSearch()">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Users Table -->
                        <div class="users-table-card">
                            <div class="table-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="table-title">
                                        <i class="fas fa-table"></i>Users List
                                        <span class="badge bg-primary ms-2" id="totalUsersCount">${fn:length(userList)}</span>
                                    </h4>

                                    <div class="bulk-actions" id="bulkActions" style="display: none;">
                                        <span class="selected-count" id="selectedCount">0 selected</span>
                                        <button type="button" class="btn-bulk btn-bulk-activate" onclick="bulkActivate()">
                                            <i class="fas fa-check"></i> Activate
                                        </button>
                                        <button type="button" class="btn-bulk btn-bulk-deactivate" onclick="bulkDeactivate()">
                                            <i class="fas fa-ban"></i> Deactivate
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="loading-spinner" id="loadingSpinner">
                                <div class="spinner-border" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                                <p class="mt-2">Loading users...</p>
                            </div>

                            <div class="table-responsive">
                                <c:choose>
                                    <c:when test="${empty userList}">
                                        <div class="empty-state">
                                            <i class="fas fa-users"></i>
                                            <h4>No Users Found</h4>
                                            <p>No users match your search criteria. Try adjusting your filters.</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <table class="table table-hover mb-0">
                                            <thead>
                                                <tr>
                                                    <th style="width: 50px;">
                                                        <input type="checkbox" class="check-all" id="checkAll">
                                                    </th>
                                                    <th style="width: 60px;">ID</th>
                                                    <th style="width: 80px;">Avatar</th>
                                                    <th style="width: 200px;">User Info</th>
                                                    <th style="width: 180px;">Contact</th>
                                                    <th style="width: 120px;">Role</th>
                                                    <th style="width: 100px;">Status</th>
                                                    <th style="width: 140px;">Created</th>
                                                    <th style="width: 140px;">Last Login</th>
                                                    <th style="width: 150px;">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="user" items="${userList}">
                                                    <tr>
                                                        <td>
                                                            <input type="checkbox" class="user-checkbox" 
                                                                   name="selectedUsers" value="${user.userId}">
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-light text-dark">#${user.userId}</span>
                                                        </td>
                                                        <td>
                                                            <img src="${user.profileImageUrl != null ? user.profileImageUrl : 'images/default-avatar.png'}" 
                                                                 alt="Avatar" class="user-avatar">
                                                        </td>
                                                        <td>
                                                            <div class="user-info">
                                                                <div class="user-name">${user.fullName}</div>
                                                                <div class="user-username">@${user.username}</div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="user-info">
                                                                <div class="user-name">${user.email}</div>
                                                                <div class="user-username">${user.phoneNumber}</div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${user.roleName == 'User'}">
                                                                    <span class="role-badge role-customer">
                                                                        <i class="fas fa-user"></i> Customer
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${user.roleName == 'Staff'}">
                                                                    <span class="role-badge role-staff">
                                                                        <i class="fas fa-user-tie"></i> Staff
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${user.roleName == 'Manager'}">
                                                                    <span class="role-badge role-manager">
                                                                        <i class="fas fa-user-crown"></i> Manager
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${user.roleName == 'Admin'}">
                                                                    <span class="role-badge role-admin">
                                                                        <i class="fas fa-user-shield"></i> Admin
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="role-badge role-customer">
                                                                        <i class="fas fa-user"></i> ${user.roleName}
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${user.active}">
                                                                    <span class="status-badge status-active">
                                                                        <i class="fas fa-circle"></i>Active
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="status-badge status-inactive">
                                                                        <i class="fas fa-circle"></i>Inactive
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <div class="user-info">
                                                                <div class="user-name">
                                                                    <fmt:formatDate value="${user.createdDate}" pattern="dd/MM/yyyy"/>
                                                                </div>
                                                                <div class="user-username">
                                                                    <fmt:formatDate value="${user.createdDate}" pattern="HH:mm"/>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="user-info">
                                                                <div class="user-name">
                                                                    <fmt:formatDate value="${user.lastLoginDate}" pattern="dd/MM/yyyy"/>
                                                                </div>
                                                                <div class="user-username">
                                                                    <fmt:formatDate value="${user.lastLoginDate}" pattern="HH:mm"/>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="action-buttons">
                                                                <a href="${pageContext.request.contextPath}/UserManagementServlet?action=view&id=${user.userId}" 
                                                                   class="btn-action btn-view" title="View Details">
                                                                    <i class="fas fa-eye"></i>
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/UserManagementServlet?action=edit&id=${user.userId}" 
                                                                   class="btn-action btn-edit" title="Edit User">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                                 <a href="${pageContext.request.contextPath}/UserManagementServlet?action=delete&id=${user.userId}" 
                                                                   class="btn btn-sm btn-danger" 
                                                                   onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <c:set var="queryStr">
                                    keyword=${fn:escapeXml(param.keyword)}&roleID=${param.roleID}&status=${param.status}
                                </c:set>

                                <nav aria-label="Page navigation" class="p-3">
                                    <ul class="pagination">
                                        <!-- Previous Button -->
                                        <li class="page-item ${page == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="UserManagementServlet?action=list&page=${page - 1}&${queryStr}">
                                                <i class="fas fa-chevron-left"></i> Previous
                                            </a>
                                        </li>

                                        <!-- Page Numbers -->
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <c:if test="${i <= 3 || i > totalPages - 3 || (i >= page - 1 && i <= page + 1)}">
                                                <li class="page-item ${i == page ? 'active' : ''}">
                                                    <a class="page-link" href="UserManagementServlet?action=list&page=${i}&${queryStr}">
                                                        ${i}
                                                    </a>
                                                </li>
                                            </c:if>

                                            <!-- Dots after page 3 -->
                                            <c:if test="${i == 4 && page > 5}">
                                                <li class="page-item disabled">
                                                    <span class="page-link">...</span>
                                                </li>
                                            </c:if>

                                            <!-- Dots before last 3 pages -->
                                            <c:if test="${i == totalPages - 3 && page < totalPages - 4}">
                                                <li class="page-item disabled">
                                                    <span class="page-link">...</span>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <!-- Next Button -->
                                        <li class="page-item ${page == totalPages || totalPages == 0 ? 'disabled' : ''}">
                                            <a class="page-link" href="UserManagementServlet?action=list&page=${page + 1}&${queryStr}">
                                                Next <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>
                    </div>
                </main>

                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">© 2025 <strong>FMart Supermarket</strong>. All rights reserved.</div>
                            <div>
                                <a href="#" class="text-muted me-3">Privacy Policy</a>
                                <a href="#" class="text-muted">Terms & Conditions</a>
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
                                            // Initialize page
                                            $(document).ready(function () {
                                                updateStatistics();
                                                initializeCheckboxes();
                                            });

                                            // Update statistics counters
                                            function updateStatistics() {
                                                const userList = ${userListJSON || '[]'};
                                                let customerCount = 0, staffCount = 0, managerCount = 0, adminCount = 0, totalCount = userList.length;

                                                // Count users by role (if userListJSON is available)
                                                userList.forEach(user => {
                                                    switch (user.roleName) {
                                                        case 'User':
                                                            customerCount++;
                                                            break;
                                                        case 'Staff':
                                                            staffCount++;
                                                            break;
                                                        case 'Manager':
                                                            managerCount++;
                                                            break;
                                                        case 'Admin':
                                                            adminCount++;
                                                            break;
                                                    }
                                                });

                                                // Animate counters
                                                animateCounter('customerCount', customerCount);
                                                animateCounter('staffCount', staffCount);
                                                animateCounter('managerCount', managerCount);
                                                animateCounter('adminCount', adminCount);
                                                animateCounter('totalCount', totalCount);
                                            }

                                            // Animate counter numbers
                                            function animateCounter(elementId, targetValue) {
                                                const element = document.getElementById(elementId);
                                                const duration = 1000;
                                                const startValue = 0;
                                                const increment = targetValue / (duration / 16);
                                                let currentValue = startValue;

                                                const timer = setInterval(() => {
                                                    currentValue += increment;
                                                    if (currentValue >= targetValue) {
                                                        element.textContent = targetValue;
                                                        clearInterval(timer);
                                                    } else {
                                                        element.textContent = Math.floor(currentValue);
                                                    }
                                                }, 16);
                                            }

                                            // Initialize checkbox functionality
                                            function initializeCheckboxes() {
                                                const checkAll = document.getElementById('checkAll');
                                                const userCheckboxes = document.querySelectorAll('.user-checkbox');
                                                const bulkActions = document.getElementById('bulkActions');
                                                const selectedCount = document.getElementById('selectedCount');

                                                // Check all functionality
                                                checkAll.addEventListener('change', function () {
                                                    const isChecked = this.checked;
                                                    userCheckboxes.forEach(checkbox => {
                                                        checkbox.checked = isChecked;
                                                    });
                                                    updateBulkActions();
                                                });

                                                // Individual checkbox functionality
                                                userCheckboxes.forEach(checkbox => {
                                                    checkbox.addEventListener('change', function () {
                                                        updateCheckAllStatus();
                                                        updateBulkActions();
                                                    });
                                                });

                                                function updateCheckAllStatus() {
                                                    const checkedBoxes = document.querySelectorAll('.user-checkbox:checked');
                                                    const totalBoxes = userCheckboxes.length;

                                                    if (checkedBoxes.length === 0) {
                                                        checkAll.indeterminate = false;
                                                        checkAll.checked = false;
                                                    } else if (checkedBoxes.length === totalBoxes) {
                                                        checkAll.indeterminate = false;
                                                        checkAll.checked = true;
                                                    } else {
                                                        checkAll.indeterminate = true;
                                                        checkAll.checked = false;
                                                    }
                                                }

                                                function updateBulkActions() {
                                                    const checkedBoxes = document.querySelectorAll('.user-checkbox:checked');
                                                    const count = checkedBoxes.length;

                                                    if (count > 0) {
                                                        bulkActions.style.display = 'flex';
                                                        selectedCount.textContent = `${count} selected`;
                                                    } else {
                                                        bulkActions.style.display = 'none';
                                                    }
                                                }
                                            }

                                            // Clear search function
                                            function clearSearch() {
                                                document.querySelector('input[name="keyword"]').value = '';
                                                document.querySelector('select[name="roleID"]').value = '';
                                                document.querySelector('select[name="status"]').value = '';
                                                document.getElementById('searchForm').submit();
                                            }

                                            // Delete user function
                                            function deleteUser(userId, userName) {
                                                if (confirm(`Are you sure you want to delete user "${userName}"?\n\nThis action cannot be undone.`)) {
                                                    window.location.href = `${pageContext.request.contextPath}/UserManagementServlet?action=delete&id=${userId}`;
                                                            }
                                                        }

                                                        // Bulk activate users
                                                        function bulkActivate() {
                                                            const checkedBoxes = document.querySelectorAll('.user-checkbox:checked');
                                                            const userIds = Array.from(checkedBoxes).map(cb => cb.value);

                                                            if (userIds.length === 0) {
                                                                alert('Please select users to activate.');
                                                                return;
                                                            }

                                                            if (confirm(`Are you sure you want to activate ${userIds.length} selected user(s)?`)) {
                                                                // Send AJAX request to bulk activate
                                                                fetch('UserManagementServlet', {
                                                                    method: 'POST',
                                                                    headers: {
                                                                        'Content-Type': 'application/x-www-form-urlencoded',
                                                                    },
                                                                    body: `action=bulkActivate&userIds=${userIds.join(',')}`
                                                                })
                                                                        .then(response => response.json())
                                                                        .then(data => {
                                                                            if (data.success) {
                                                                                showNotification('Users activated successfully!', 'success');
                                                                                setTimeout(() => location.reload(), 1000);
                                                                            } else {
                                                                                showNotification('Error activating users: ' + data.message, 'error');
                                                                            }
                                                                        })
                                                                        .catch(error => {
                                                                            showNotification('Network error occurred', 'error');
                                                                        });
                                                            }
                                                        }

                                                        // Bulk deactivate users
                                                        function bulkDeactivate() {
                                                            const checkedBoxes = document.querySelectorAll('.user-checkbox:checked');
                                                            const userIds = Array.from(checkedBoxes).map(cb => cb.value);

                                                            if (userIds.length === 0) {
                                                                alert('Please select users to deactivate.');
                                                                return;
                                                            }

                                                            if (confirm(`Are you sure you want to deactivate ${userIds.length} selected user(s)?`)) {
                                                                // Send AJAX request to bulk deactivate
                                                                fetch('UserManagementServlet', {
                                                                    method: 'POST',
                                                                    headers: {
                                                                        'Content-Type': 'application/x-www-form-urlencoded',
                                                                    },
                                                                    body: `action=bulkDeactivate&userIds=${userIds.join(',')}`
                                                                })
                                                                        .then(response => response.json())
                                                                        .then(data => {
                                                                            if (data.success) {
                                                                                showNotification('Users deactivated successfully!', 'success');
                                                                                setTimeout(() => location.reload(), 1000);
                                                                            } else {
                                                                                showNotification('Error deactivating users: ' + data.message, 'error');
                                                                            }
                                                                        })
                                                                        .catch(error => {
                                                                            showNotification('Network error occurred', 'error');
                                                                        });
                                                            }
                                                        }

                                                        // Show notification
                                                        function showNotification(message, type) {
                                                            const notification = document.createElement('div');
                                                            notification.className = `alert alert-${type} notification-popup`;
                                                            notification.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    z-index: 9999;
                    min-width: 300px;
                    padding: 15px 20px;
                    border-radius: 10px;
                    box-shadow: 0 4px 20px rgba(0,0,0,0.2);
                    animation: slideInRight 0.3s ease;
                `;

                                                            const iconClass = type === 'success' ? 'check-circle' : 'exclamation-triangle';
                                                            notification.innerHTML = `
                    <div class="d-flex align-items-center">
                        <i class="fas fa-${iconClass} me-2"></i>
                        <span>${message}</span>
                        <button type="button" class="btn-close ms-auto" aria-label="Close"></button>
                    </div>
                `;

                                                            document.body.appendChild(notification);

                                                            // Auto remove after 3 seconds
                                                            setTimeout(() => {
                                                                notification.style.animation = 'slideOutRight 0.3s ease';
                                                                setTimeout(() => notification.remove(), 300);
                                                            }, 3000);

                                                            // Close button functionality
                                                            notification.querySelector('.btn-close').addEventListener('click', () => {
                                                                notification.style.animation = 'slideOutRight 0.3s ease';
                                                                setTimeout(() => notification.remove(), 300);
                                                            });
                                                        }

                                                        // Add CSS animations
                                                        const style = document.createElement('style');
                                                        style.textContent = `
                @keyframes slideInRight {
                    from { transform: translateX(100%); opacity: 0; }
                    to { transform: translateX(0); opacity: 1; }
                }
                @keyframes slideOutRight {
                    from { transform: translateX(0); opacity: 1; }
                    to { transform: translateX(100%); opacity: 0; }
                }
            `;
                                                        document.head.appendChild(style);

                                                        // Loading spinner for search
                                                        document.getElementById('searchForm').addEventListener('submit', function () {
                                                            document.getElementById('loadingSpinner').style.display = 'block';
                                                        });
        </script>
    </body>
</html>