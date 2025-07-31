<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List, model.Coupon" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FMart Admin - Quản lý Coupon</title>
    
    <!-- CSS Files -->
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/css/admin-style.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    
    <style>
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border-radius: 4px;
        }
        .coupon-status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-active { background-color: #d4edda; color: #155724; }
        .status-inactive { background-color: #f8d7da; color: #721c24; }
        .status-expired { background-color: #fff3cd; color: #856404; }
        .discount-badge {
            background-color: #e7f3ff;
            color: #0066cc;
            padding: 2px 6px;
            border-radius: 3px;
            font-size: 11px;
        }
    </style>
</head>

<body class="sb-nav-fixed">
    <!-- Navigation Bar -->
    <nav class="sb-topnav navbar navbar-expand navbar-light bg-clr">
        <a class="navbar-brand logo-brand" href="index.jsp">FMart Supermarket</a>
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
        <a href="${pageContext.request.contextPath}/index.jsp" class="frnt-link"><i class="fas fa-external-link-alt"></i>Home</a>
        
        <ul class="navbar-nav ms-auto mr-md-0">
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
        <!-- Sidebar -->
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <a class="nav-link" href="index.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                            Dashboard
                        </a>
                        
                        <!-- Products Section -->
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseProducts">
                            <div class="sb-nav-link-icon"><i class="fas fa-box"></i></div>
                            Products
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseProducts">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link sub_nav_link" href="products.jsp">All Products</a>
                                <a class="nav-link sub_nav_link" href="add_product.jsp">Add Product</a>
                            </nav>
                        </div>
                        
                        <a class="nav-link" href="orders.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-cart-arrow-down"></i></div>
                            Orders
                        </a>
                        
                        <a class="nav-link" href="customers.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                            Customers
                        </a>
                        
                        <!-- Coupon Management - Active -->
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/coupon">
                            <div class="sb-nav-link-icon"><i class="fas fa-gift"></i></div>
                            Quản lý Coupon
                        </a>
                        
                        <a class="nav-link" href="pages.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                            Pages
                        </a>
                        
                        <!-- Settings -->
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseSettings">
                            <div class="sb-nav-link-icon"><i class="fas fa-cog"></i></div>
                            Setting
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseSettings">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link sub_nav_link" href="general_setting.jsp">General Settings</a>
                                <a class="nav-link sub_nav_link" href="payment_setting.jsp">Payment Settings</a>
                                <a class="nav-link sub_nav_link" href="email_setting.jsp">Email Settings</a>
                            </nav>
                        </div>
                        
                        <a class="nav-link" href="reports.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-chart-bar"></i></div>
                            Reports
                        </a>
                    </div>
                </div>
            </nav>
        </div>

        <!-- Main Content -->
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <h2 class="mt-30 page-title">
                        <i class="fas fa-gift"></i> Quản lý Coupon
                    </h2>
                    
                    <ol class="breadcrumb mb-30">
                        <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item active">Quản lý Coupon</li>
                    </ol>

                    <!-- Success/Error Messages -->
                    <c:if test="${param.success == 'created'}">
                        <div class="alert alert-success alert-dismissible fade show">
                            <i class="fas fa-check-circle"></i> Tạo coupon thành công!
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${param.success == 'updated'}">
                        <div class="alert alert-success alert-dismissible fade show">
                            <i class="fas fa-check-circle"></i> Cập nhật coupon thành công!
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty param.success && param.success != 'created' && param.success != 'updated'}">
                        <div class="alert alert-success alert-dismissible fade show">
                            <i class="fas fa-check-circle"></i> ${param.success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Action Bar -->
                    <div class="row justify-content-between mb-3">
                        <div class="col-lg-6">
                            <a href="${pageContext.request.contextPath}/admin/coupon?action=create" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Tạo Coupon Mới
                            </a>
                        </div>
                        
                        <!-- Search Form -->
                        <div class="col-lg-6">
                            <form action="${pageContext.request.contextPath}/admin/coupon" method="get" class="form-inline justify-content-end">
                                <input type="hidden" name="action" value="list" />
                                
                                <div class="input-group mr-2">
                                    <input type="text" name="keyword" class="form-control" 
                                           placeholder="Tìm theo mã, tên coupon..." 
                                           value="${keyword}" style="width: 200px;">
                                </div>
                                
                                <div class="input-group mr-2">
                                    <select name="status" class="form-control">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="active" ${statusFilter == 'active' ? 'selected' : ''}>Đang hoạt động</option>
                                        <option value="inactive" ${statusFilter == 'inactive' ? 'selected' : ''}>Tạm dừng</option>
                                        <option value="expired" ${statusFilter == 'expired' ? 'selected' : ''}>Hết hạn</option>
                                        <option value="valid" ${statusFilter == 'valid' ? 'selected' : ''}>Có hiệu lực</option>
                                    </select>
                                </div>
                                
                                <div class="input-group mr-2">
                                    <select name="type" class="form-control">
                                        <option value="">Tất cả loại</option>
                                        <option value="Percentage" ${typeFilter == 'Percentage' ? 'selected' : ''}>Phần trăm</option>
                                        <option value="Fixed" ${typeFilter == 'Fixed' ? 'selected' : ''}>Số tiền cố định</option>
                                    </select>
                                </div>
                                
                                <button class="btn btn-outline-primary" type="submit">
                                    <i class="fas fa-search"></i> Tìm kiếm
                                </button>
                            </form>
                        </div>
                    </div>

                    <!-- Bulk Actions -->
                    <div class="row justify-content-between mb-3">
                        <div class="col-lg-6">
                            <form id="bulkActionForm" action="${pageContext.request.contextPath}/admin/coupon" method="post">
                                <input type="hidden" name="action" value="bulk_action">
                                <div class="input-group">
                                    <select name="bulk_action" class="form-control" style="max-width: 200px;">
                                        <option value="">Chọn thao tác...</option>
                                        <option value="activate">Kích hoạt</option>
                                        <option value="deactivate">Tạm dừng</option>
                                        <option value="delete">Xóa</option>
                                    </select>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button" onclick="executeBulkAction()">
                                            <i class="fas fa-play"></i> Thực hiện
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        
                        <div class="col-lg-6 text-right">
                            <small class="text-muted">
                                Hiển thị ${fn:length(coupons)} / ${totalCoupons} coupon
                            </small>
                        </div>
                    </div>

                    <!-- Coupon Table -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card card-static-2 mb-30">
                                <div class="card-title-2">
                                    <h4>Danh sách Coupon</h4>
                                </div>
                                <div class="card-body-table">
                                    <div class="table-responsive">
                                        <table class="table ucp-table table-hover">
                                            <thead>
                                                <tr>
                                                    <th style="width: 40px;">
                                                        <input type="checkbox" class="check-all" onchange="toggleAllCheckboxes(this)">
                                                    </th>
                                                    <th style="width: 50px;">ID</th>
                                                    <th style="width: 120px;">Mã Coupon</th>
                                                    <th style="width: 150px;">Tên Coupon</th>
                                                    <th style="width: 100px;">Loại giảm</th>
                                                    <th style="width: 100px;">Giá trị</th>
                                                    <th style="width: 120px;">Đơn tối thiểu</th>
                                                    <th style="width: 80px;">Đã dùng</th>
                                                    <th style="width: 80px;">Giới hạn</th>
                                                    <th style="width: 100px;">Ngày bắt đầu</th>
                                                    <th style="width: 100px;">Ngày kết thúc</th>
                                                    <th style="width: 80px;">Trạng thái</th>
                                                    <th style="width: 150px;">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${empty coupons}">
                                                        <tr>
                                                            <td colspan="13" class="text-center py-4">
                                                                <i class="fas fa-gift fa-3x text-muted mb-3"></i>
                                                                <p class="text-muted">Không tìm thấy coupon nào</p>
                                                                <a href="${pageContext.request.contextPath}/admin/coupon?action=create" class="btn btn-primary">
                                                                    <i class="fas fa-plus"></i> Tạo Coupon Đầu Tiên
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="coupon" items="${coupons}">
                                                            <tr>
                                                                <td>
                                                                    <input type="checkbox" name="coupon_ids" value="${coupon.couponId}" class="coupon-checkbox">
                                                                </td>
                                                                <td>${coupon.couponId}</td>
                                                                <td>
                                                                    <strong class="text-primary">${coupon.couponCode}</strong>
                                                                </td>
                                                                <td>
                                                                    <div class="coupon-name">
                                                                        ${coupon.couponName}
                                                                        <c:if test="${not empty coupon.description}">
                                                                            <br><small class="text-muted">${fn:substring(coupon.description, 0, 50)}${fn:length(coupon.description) > 50 ? '...' : ''}</small>
                                                                        </c:if>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <span class="discount-badge">
                                                                        <c:choose>
                                                                            <c:when test="${coupon.discountType == 'Percentage'}">
                                                                                <i class="fas fa-percent"></i> Phần trăm
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <i class="fas fa-dollar-sign"></i> Cố định
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <strong>
                                                                        <c:choose>
                                                                            <c:when test="${coupon.discountType == 'Percentage'}">
                                                                                <fmt:formatNumber value="${coupon.discountValue}" pattern="#,##0.##"/>%
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <fmt:formatNumber value="${coupon.discountValue}" pattern="#,##0"/> VND
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </strong>
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${coupon.minOrderAmount > 0}">
                                                                            <fmt:formatNumber value="${coupon.minOrderAmount}" pattern="#,##0"/> VND
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="text-muted">Không</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <span class="badge badge-info">${coupon.usageCount}</span>
                                                                </td>
                                                                <td>
                                                                    <span class="badge badge-secondary">${coupon.usageLimit}</span>
                                                                </td>
                                                                <td>
                                                                    <fmt:formatDate value="${coupon.startDate}" pattern="dd/MM/yyyy"/>
                                                                </td>
                                                                <td>
                                                                    <fmt:formatDate value="${coupon.endDate}" pattern="dd/MM/yyyy"/>
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${coupon.active && coupon.endDate.time >= System.currentTimeMillis()}">
                                                                            <span class="coupon-status status-active">
                                                                                <i class="fas fa-check-circle"></i> Hoạt động
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${coupon.endDate.time < System.currentTimeMillis()}">
                                                                            <span class="coupon-status status-expired">
                                                                                <i class="fas fa-clock"></i> Hết hạn
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="coupon-status status-inactive">
                                                                                <i class="fas fa-pause-circle"></i> Tạm dừng
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <div class="btn-group" role="group">
                                                                        <a href="${pageContext.request.contextPath}/admin/coupon?action=view&couponId=${coupon.couponId}"
                                                                           class="btn btn-sm btn-info" title="Xem chi tiết">
                                                                            <i class="fas fa-eye"></i>
                                                                        </a>
                                                                        <a href="${pageContext.request.contextPath}/admin/coupon?action=edit&couponId=${coupon.couponId}"
                                                                           class="btn btn-sm btn-primary" title="Chỉnh sửa">
                                                                            <i class="fas fa-edit"></i>
                                                                        </a>
                                                                        <button type="button" class="btn btn-sm btn-warning"
                                                                                onclick="toggleCouponStatus(${coupon.couponId}, ${!coupon.active})"
                                                                                title="${coupon.active ? 'Tạm dừng' : 'Kích hoạt'}">
                                                                            <i class="fas fa-${coupon.active ? 'pause' : 'play'}"></i>
                                                                        </button>
                                                                        <button type="button" class="btn btn-sm btn-danger"
                                                                                onclick="deleteCoupon(${coupon.couponId}, '${coupon.couponCode}')"
                                                                                title="Xóa">
                                                                            <i class="fas fa-trash"></i>
                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <c:set var="queryStr">
                            keyword=${fn:escapeXml(keyword)}&status=${statusFilter}&type=${typeFilter}
                        </c:set>

                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <!-- Previous -->
                                <li class="page-item ${page == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/coupon?action=list&page=${page - 1}&${queryStr}">
                                        <i class="fas fa-chevron-left"></i> Trước
                                    </a>
                                </li>

                                <!-- Page Numbers -->
                                <c:set var="startPage" value="${page - 2 < 1 ? 1 : page - 2}" />
                                <c:set var="endPage" value="${startPage + 4 > totalPages ? totalPages : startPage + 4}" />

                                <c:if test="${startPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/coupon?action=list&page=1&${queryStr}">1</a>
                                    </li>
                                    <c:if test="${startPage > 2}">
                                        <li class="page-item disabled">
                                            <span class="page-link">...</span>
                                        </li>
                                    </c:if>
                                </c:if>

                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                    <li class="page-item ${i == page ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/coupon?action=list&page=${i}&${queryStr}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${endPage < totalPages}">
                                    <c:if test="${endPage < totalPages - 1}">
                                        <li class="page-item disabled">
                                            <span class="page-link">...</span>
                                        </li>
                                    </c:if>
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/coupon?action=list&page=${totalPages}&${queryStr}">${totalPages}</a>
                                    </li>
                                </c:if>

                                <!-- Next -->
                                <li class="page-item ${page == totalPages || totalPages == 0 ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/coupon?action=list&page=${page + 1}&${queryStr}">
                                        Sau <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </main>

            <!-- Footer -->
            <footer class="py-4 bg-footer mt-auto">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted-1">© 2024 <b>FMart Supermarket</b></div>
                        <div class="footer-links">
                            <a href="privacy_policy.jsp">Privacy Policy</a>
                            <a href="term_and_conditions.jsp">Terms & Conditions</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <!-- JavaScript Files -->
    <script src="Admin/js/jquery.min.js"></script>
    <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="Admin/js/scripts.js"></script>

    <script>
        // Toggle all checkboxes
        function toggleAllCheckboxes(masterCheckbox) {
            const checkboxes = document.querySelectorAll('.coupon-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = masterCheckbox.checked;
            });
        }

        // Execute bulk action
        function executeBulkAction() {
            const selectedCoupons = document.querySelectorAll('.coupon-checkbox:checked');
            const bulkAction = document.querySelector('select[name="bulk_action"]').value;

            if (selectedCoupons.length === 0) {
                alert('Vui lòng chọn ít nhất một coupon');
                return;
            }

            if (!bulkAction) {
                alert('Vui lòng chọn thao tác cần thực hiện');
                return;
            }

            let confirmMessage = '';
            switch(bulkAction) {
                case 'activate':
                    confirmMessage = `Bạn có chắc muốn kích hoạt ${selectedCoupons.length} coupon đã chọn?`;
                    break;
                case 'deactivate':
                    confirmMessage = `Bạn có chắc muốn tạm dừng ${selectedCoupons.length} coupon đã chọn?`;
                    break;
                case 'delete':
                    confirmMessage = `Bạn có chắc muốn xóa ${selectedCoupons.length} coupon đã chọn? Hành động này không thể hoàn tác!`;
                    break;
            }

            if (confirm(confirmMessage)) {
                document.getElementById('bulkActionForm').submit();
            }
        }

        // Toggle coupon status
        function toggleCouponStatus(couponId, newStatus) {
            const action = newStatus ? 'kích hoạt' : 'tạm dừng';

            if (confirm(`Bạn có chắc muốn ${action} coupon này?`)) {
                $.post('${pageContext.request.contextPath}/admin/coupon', {
                    action: 'toggle_status',
                    couponId: couponId,
                    status: newStatus
                }, function(response) {
                    const data = JSON.parse(response);
                    if (data.success) {
                        location.reload();
                    } else {
                        alert('Lỗi: ' + data.message);
                    }
                }).fail(function() {
                    alert('Có lỗi xảy ra khi cập nhật trạng thái coupon');
                });
            }
        }

        // Delete coupon
        function deleteCoupon(couponId, couponCode) {
            if (confirm(`Bạn có chắc muốn xóa coupon "${couponCode}"? Hành động này không thể hoàn tác!`)) {
                $.post('${pageContext.request.contextPath}/admin/coupon', {
                    action: 'delete',
                    couponId: couponId
                }, function(response) {
                    const data = JSON.parse(response);
                    if (data.success) {
                        location.reload();
                    } else {
                        alert('Lỗi: ' + data.message);
                    }
                }).fail(function() {
                    alert('Có lỗi xảy ra khi xóa coupon');
                });
            }
        }

        // Auto-submit search form when filters change
        $(document).ready(function() {
            $('select[name="status"], select[name="type"]').change(function() {
                $(this).closest('form').submit();
            });
        });
    </script>
</body>
</html>
