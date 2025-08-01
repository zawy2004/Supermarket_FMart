<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - FMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/night-mode.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .my-coupons-container {
            padding: 20px 0;
        }
        .coupon-stats {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
        }
        .stat-item {
            text-align: center;
            padding: 15px;
        }
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            display: block;
        }
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        .coupon-tabs {
            margin-bottom: 30px;
        }
        .coupon-tabs .nav-link {
            border-radius: 25px;
            margin-right: 10px;
            font-weight: 500;
        }
        .coupon-tabs .nav-link.active {
            background: linear-gradient(135deg, #28a745, #20c997);
            border-color: transparent;
        }
        .user-coupon-card {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            background: white;
            position: relative;
            transition: all 0.3s ease;
        }
        .user-coupon-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .user-coupon-card.available {
            border-color: #28a745;
            background: linear-gradient(135deg, #f8fff9 0%, #e8f5e8 100%);
        }
        .user-coupon-card.used {
            border-color: #6c757d;
            background: #f8f9fa;
            opacity: 0.7;
        }
        .user-coupon-card.expired {
            border-color: #dc3545;
            background: linear-gradient(135deg, #fff8f8 0%, #f8e8e8 100%);
        }
        .coupon-status {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        .status-available {
            background: #28a745;
            color: white;
        }
        .status-used {
            background: #6c757d;
            color: white;
        }
        .status-expired {
            background: #dc3545;
            color: white;
        }
        .coupon-code {
            font-size: 1.5rem;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 10px;
        }
        .coupon-name {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .coupon-discount {
            font-size: 1.3rem;
            font-weight: bold;
            color: #dc3545;
            margin-bottom: 15px;
        }
        .coupon-details {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 15px;
        }
        .detail-item {
            display: flex;
            align-items: center;
            font-size: 0.9rem;
            color: #6c757d;
        }
        .detail-item i {
            margin-right: 5px;
            width: 16px;
        }
        .coupon-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        .no-coupons {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        .no-coupons i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-wallet"></i> ${pageTitle}</h1>
            <p>Quản lý và sử dụng coupon cá nhân của bạn</p>
        </div>
    </div>

    <div class="container my-coupons-container">
        <!-- Coupon Statistics -->
        <c:if test="${not empty couponStats}">
            <div class="coupon-stats">
                <div class="row">
                    <div class="col-md-3">
                        <div class="stat-item">
                            <span class="stat-number">${couponStats.totalAssigned}</span>
                            <span class="stat-label">Tổng số coupon</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <span class="stat-number">${couponStats.available}</span>
                            <span class="stat-label">Khả dụng</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <span class="stat-number">${couponStats.used}</span>
                            <span class="stat-label">Đã sử dụng</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-item">
                            <span class="stat-number">${couponStats.expired}</span>
                            <span class="stat-label">Hết hạn</span>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Navigation Tabs -->
        <ul class="nav nav-pills coupon-tabs">
            <li class="nav-item">
                <a class="nav-link ${empty param.action or param.action eq 'my-coupons' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/user/coupons?action=my-coupons">
                    <i class="fas fa-list"></i> Tất cả
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.action eq 'available' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/user/coupons?action=available">
                    <i class="fas fa-check-circle"></i> Khả dụng
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.action eq 'history' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/user/coupons?action=history">
                    <i class="fas fa-history"></i> Lịch sử
                </a>
            </li>
        </ul>

        <!-- Messages -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${successMessage}
            </div>
        </c:if>

        <!-- Coupon List -->
        <c:choose>
            <c:when test="${not empty userCoupons}">
                <div class="row">
                    <c:forEach var="coupon" items="${userCoupons}">
                        <div class="col-md-6 col-lg-4">
                            <div class="user-coupon-card ${coupon.status.toLowerCase()}">
                                <div class="coupon-status status-${coupon.status.toLowerCase()}">
                                    ${coupon.status eq 'Available' ? 'Khả dụng' : 
                                      coupon.status eq 'Used' ? 'Đã dùng' : 'Hết hạn'}
                                </div>
                                
                                <div class="coupon-code">${coupon.couponCode}</div>
                                <div class="coupon-name">${coupon.couponName}</div>
                                
                                <div class="coupon-discount">
                                    <c:choose>
                                        <c:when test="${coupon.discountType eq 'Percentage'}">
                                            Giảm ${coupon.discountValue}%
                                        </c:when>
                                        <c:otherwise>
                                            Giảm <fmt:formatNumber value="${coupon.discountValue}" type="currency" currencySymbol=""/>₫
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="coupon-details">
                                    <div class="detail-item">
                                        <i class="fas fa-calendar-plus"></i>
                                        <span>Nhận: <fmt:formatDate value="${coupon.assignedDate}" pattern="dd/MM/yyyy"/></span>
                                    </div>
                                    
                                    <c:if test="${not empty coupon.expiryDate}">
                                        <div class="detail-item">
                                            <i class="fas fa-calendar-times"></i>
                                            <span>Hết hạn: <fmt:formatDate value="${coupon.expiryDate}" pattern="dd/MM/yyyy"/></span>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${not empty coupon.usedDate}">
                                        <div class="detail-item">
                                            <i class="fas fa-check"></i>
                                            <span>Đã dùng: <fmt:formatDate value="${coupon.usedDate}" pattern="dd/MM/yyyy"/></span>
                                        </div>
                                    </c:if>
                                    
                                    <div class="detail-item">
                                        <i class="fas fa-user"></i>
                                        <span>Từ: ${coupon.assignedBy}</span>
                                    </div>
                                </div>
                                
                                <c:if test="${not empty coupon.notes}">
                                    <div class="detail-item">
                                        <i class="fas fa-sticky-note"></i>
                                        <span>${coupon.notes}</span>
                                    </div>
                                </c:if>
                                
                                <c:if test="${coupon.status eq 'Available'}">
                                    <div class="coupon-actions">
                                        <button class="btn btn-success btn-sm" onclick="copyCouponCode('${coupon.couponCode}')">
                                            <i class="fas fa-copy"></i> Copy mã
                                        </button>
                                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-sm">
                                            <i class="fas fa-shopping-cart"></i> Mua sắm
                                        </a>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-coupons">
                    <i class="fas fa-wallet"></i>
                    <h3>Chưa có coupon nào</h3>
                    <p>Bạn chưa có coupon cá nhân nào. Hãy mua sắm để nhận thêm coupon nhé!</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                        <i class="fas fa-shopping-cart"></i> Mua sắm ngay
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%@include file="footer.jsp" %>

    <script src="${pageContext.request.contextPath}/User/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        function copyCouponCode(code) {
            navigator.clipboard.writeText(code).then(function() {
                // Show success message
                const btn = event.target.closest('button');
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-check"></i> Đã copy!';
                btn.classList.remove('btn-success');
                btn.classList.add('btn-info');
                
                setTimeout(function() {
                    btn.innerHTML = originalText;
                    btn.classList.remove('btn-info');
                    btn.classList.add('btn-success');
                }, 2000);
            }).catch(function(err) {
                console.error('Could not copy text: ', err);
                alert('Không thể copy mã. Vui lòng copy thủ công: ' + code);
            });
        }
    </script>
</body>
</html>
