<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FMart Admin - Chi tiết Coupon</title>
    
    <!-- CSS Files -->
    <link href="Admin/css/styles.css" rel="stylesheet">
    <link href="Admin/css/admin-style.css" rel="stylesheet">
    <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    
    <style>
        .coupon-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .coupon-code {
            font-size: 2rem;
            font-weight: bold;
            letter-spacing: 3px;
            text-align: center;
            margin-bottom: 15px;
        }
        .coupon-name {
            font-size: 1.2rem;
            text-align: center;
            margin-bottom: 20px;
            opacity: 0.9;
        }
        .coupon-stats {
            display: flex;
            justify-content: space-around;
            text-align: center;
        }
        .stat-item {
            flex: 1;
        }
        .stat-number {
            font-size: 1.5rem;
            font-weight: bold;
            display: block;
        }
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.8;
        }
        .info-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.9rem;
        }
        .status-active { background-color: #d4edda; color: #155724; }
        .status-inactive { background-color: #f8d7da; color: #721c24; }
        .status-expired { background-color: #fff3cd; color: #856404; }
        .usage-progress {
            background-color: #e9ecef;
            border-radius: 10px;
            height: 20px;
            overflow: hidden;
            margin-top: 10px;
        }
        .usage-bar {
            background: linear-gradient(90deg, #28a745, #20c997);
            height: 100%;
            transition: width 0.3s ease;
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
                        
                        <!-- Coupon Management - Active -->
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/coupon">
                            <div class="sb-nav-link-icon"><i class="fas fa-gift"></i></div>
                            Quản lý Coupon
                        </a>
                        
                        <a class="nav-link" href="products.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-box"></i></div>
                            Products
                        </a>
                        
                        <a class="nav-link" href="orders.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-cart-arrow-down"></i></div>
                            Orders
                        </a>
                        
                        <a class="nav-link" href="customers.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                            Customers
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
                        <i class="fas fa-gift"></i> Chi tiết Coupon
                    </h2>
                    
                    <ol class="breadcrumb mb-30">
                        <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/coupon">Quản lý Coupon</a></li>
                        <li class="breadcrumb-item active">Chi tiết Coupon</li>
                    </ol>

                    <c:if test="${not empty coupon}">
                        <!-- Coupon Display Card -->
                        <div class="coupon-card">
                            <div class="coupon-code">${coupon.couponCode}</div>
                            <div class="coupon-name">${coupon.couponName}</div>
                            
                            <div class="coupon-stats">
                                <div class="stat-item">
                                    <span class="stat-number">
                                        <c:choose>
                                            <c:when test="${coupon.discountType == 'Percentage'}">
                                                <fmt:formatNumber value="${coupon.discountValue}" pattern="#,##0.##"/>%
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${coupon.discountValue}" pattern="#,##0"/> VND
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span class="stat-label">Giá trị giảm</span>
                                </div>
                                
                                <div class="stat-item">
                                    <span class="stat-number">${coupon.usageCount}</span>
                                    <span class="stat-label">Đã sử dụng</span>
                                </div>
                                
                                <div class="stat-item">
                                    <span class="stat-number">${coupon.usageLimit}</span>
                                    <span class="stat-label">Giới hạn</span>
                                </div>
                                
                                <div class="stat-item">
                                    <span class="stat-number">
                                        <fmt:formatNumber value="${(coupon.usageCount * 100.0) / coupon.usageLimit}" pattern="#,##0.#"/>%
                                    </span>
                                    <span class="stat-label">Tỷ lệ sử dụng</span>
                                </div>
                            </div>
                            
                            <!-- Usage Progress Bar -->
                            <div class="usage-progress">
                                <div class="usage-bar" style="width: ${(coupon.usageCount * 100.0) / coupon.usageLimit}%"></div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <a href="${pageContext.request.contextPath}/admin/coupon?action=edit&couponId=${coupon.couponId}" 
                                   class="btn btn-primary">
                                    <i class="fas fa-edit"></i> Chỉnh sửa
                                </a>
                                
                                <button type="button" class="btn btn-warning" 
                                        onclick="toggleCouponStatus(${coupon.couponId}, ${!coupon.active})">
                                    <i class="fas fa-${coupon.active ? 'pause' : 'play'}"></i> 
                                    ${coupon.active ? 'Tạm dừng' : 'Kích hoạt'}
                                </button>
                                
                                <a href="${pageContext.request.contextPath}/admin/coupon" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </div>

                        <!-- Coupon Information -->
                        <div class="row">
                            <!-- Basic Information -->
                            <div class="col-lg-6">
                                <div class="info-card">
                                    <h5><i class="fas fa-info-circle"></i> Thông tin cơ bản</h5>
                                    <table class="table table-borderless">
                                        <tr>
                                            <td><strong>Mã Coupon:</strong></td>
                                            <td>${coupon.couponCode}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Tên Coupon:</strong></td>
                                            <td>${coupon.couponName}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Mô tả:</strong></td>
                                            <td>${not empty coupon.description ? coupon.description : 'Không có mô tả'}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Trạng thái:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${coupon.active && coupon.endDate.time >= System.currentTimeMillis()}">
                                                        <span class="status-badge status-active">
                                                            <i class="fas fa-check-circle"></i> Đang hoạt động
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${coupon.endDate.time < System.currentTimeMillis()}">
                                                        <span class="status-badge status-expired">
                                                            <i class="fas fa-clock"></i> Đã hết hạn
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-inactive">
                                                            <i class="fas fa-pause-circle"></i> Tạm dừng
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Ngày tạo:</strong></td>
                                            <td><fmt:formatDate value="${coupon.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>

                            <!-- Discount Information -->
                            <div class="col-lg-6">
                                <div class="info-card">
                                    <h5><i class="fas fa-percentage"></i> Thông tin giảm giá</h5>
                                    <table class="table table-borderless">
                                        <tr>
                                            <td><strong>Loại giảm giá:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${coupon.discountType == 'Percentage'}">
                                                        <i class="fas fa-percent text-info"></i> Phần trăm
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-dollar-sign text-success"></i> Số tiền cố định
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Giá trị giảm:</strong></td>
                                            <td>
                                                <strong class="text-primary">
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
                                        </tr>
                                        <tr>
                                            <td><strong>Đơn hàng tối thiểu:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${coupon.minOrderAmount > 0}">
                                                        <fmt:formatNumber value="${coupon.minOrderAmount}" pattern="#,##0"/> VND
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Không yêu cầu</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Giảm tối đa:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${coupon.maxDiscountAmount > 0}">
                                                        <fmt:formatNumber value="${coupon.maxDiscountAmount}" pattern="#,##0"/> VND
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Không giới hạn</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Validity Period -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="info-card">
                                    <h5><i class="fas fa-calendar-alt"></i> Thời gian hiệu lực</h5>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <table class="table table-borderless">
                                                <tr>
                                                    <td><strong>Ngày bắt đầu:</strong></td>
                                                    <td>
                                                        <i class="fas fa-play-circle text-success"></i>
                                                        <fmt:formatDate value="${coupon.startDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Ngày kết thúc:</strong></td>
                                                    <td>
                                                        <i class="fas fa-stop-circle text-danger"></i>
                                                        <fmt:formatDate value="${coupon.endDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="col-md-6">
                                            <table class="table table-borderless">
                                                <tr>
                                                    <td><strong>Thời gian còn lại:</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${coupon.endDate.time > System.currentTimeMillis()}">
                                                                <span class="text-success">
                                                                    <i class="fas fa-clock"></i>
                                                                    <script>
                                                                        document.write(Math.ceil((${coupon.endDate.time} - Date.now()) / (1000 * 60 * 60 * 24)) + ' ngày');
                                                                    </script>
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-danger">
                                                                    <i class="fas fa-exclamation-triangle"></i> Đã hết hạn
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Giới hạn sử dụng:</strong></td>
                                                    <td>
                                                        <span class="badge badge-info">${coupon.usageCount}</span> /
                                                        <span class="badge badge-secondary">${coupon.usageLimit}</span>
                                                        <c:if test="${coupon.orderLimit > 0}">
                                                            <br><small class="text-muted">Tối đa ${coupon.orderLimit} lần/khách hàng</small>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Usage History -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card card-static-2 mb-30">
                                    <div class="card-title-2">
                                        <h4><i class="fas fa-history"></i> Lịch sử sử dụng</h4>
                                    </div>
                                    <div class="card-body-table">
                                        <div class="table-responsive">
                                            <table class="table ucp-table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Mã đơn hàng</th>
                                                        <th>Khách hàng</th>
                                                        <th>Số tiền giảm</th>
                                                        <th>Ngày sử dụng</th>
                                                        <th>Trạng thái đơn</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:choose>
                                                        <c:when test="${empty usageHistory}">
                                                            <tr>
                                                                <td colspan="6" class="text-center py-4">
                                                                    <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                                                    <p class="text-muted">Chưa có lịch sử sử dụng</p>
                                                                </td>
                                                            </tr>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="usage" items="${usageHistory}">
                                                                <tr>
                                                                    <td>${usage.usageID}</td>
                                                                    <td>
                                                                        <a href="${pageContext.request.contextPath}/admin/orders?action=view&orderId=${usage.orderID}"
                                                                           class="text-primary">
                                                                            #${usage.orderNumber}
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <c:if test="${not empty usage.customerName}">
                                                                            ${usage.customerName}
                                                                        </c:if>
                                                                        <c:if test="${not empty usage.customerEmail}">
                                                                            <br><small class="text-muted">${usage.customerEmail}</small>
                                                                        </c:if>
                                                                    </td>
                                                                    <td>
                                                                        <strong class="text-success">
                                                                            <fmt:formatNumber value="${usage.discountAmount}" pattern="#,##0"/> VND
                                                                        </strong>
                                                                    </td>
                                                                    <td>
                                                                        <fmt:formatDate value="${usage.usedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${usage.orderStatus == 'Completed'}">
                                                                                <span class="badge badge-success">Hoàn thành</span>
                                                                            </c:when>
                                                                            <c:when test="${usage.orderStatus == 'Processing'}">
                                                                                <span class="badge badge-info">Đang xử lý</span>
                                                                            </c:when>
                                                                            <c:when test="${usage.orderStatus == 'Cancelled'}">
                                                                                <span class="badge badge-danger">Đã hủy</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="badge badge-warning">${usage.orderStatus}</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
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
                    </c:if>

                    <c:if test="${empty coupon}">
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle"></i>
                            Không tìm thấy thông tin coupon.
                            <a href="${pageContext.request.contextPath}/admin/coupon" class="btn btn-primary btn-sm ml-2">
                                Quay lại danh sách
                            </a>
                        </div>
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
    </script>
</body>
</html>
