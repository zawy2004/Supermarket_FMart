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
    <link href="User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
    <link href="User/css/style.css" rel="stylesheet">
    <link href="User/css/responsive.css" rel="stylesheet">
    <link href="User/css/night-mode.css" rel="stylesheet">
    <link href="User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .coupon-container {
            padding: 20px 0;
        }
        .coupon-card {
            border: 2px dashed #28a745;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            position: relative;
            overflow: hidden;
        }
        .coupon-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #28a745, #20c997);
        }
        .coupon-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .coupon-code {
            font-size: 24px;
            font-weight: bold;
            color: #28a745;
            font-family: 'Courier New', monospace;
        }
        .coupon-discount {
            font-size: 20px;
            font-weight: bold;
            color: #dc3545;
        }
        .coupon-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        .coupon-description {
            color: #666;
            margin-bottom: 15px;
        }
        .coupon-details {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 15px;
        }
        .coupon-detail-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #555;
        }
        .coupon-detail-item i {
            color: #28a745;
        }
        .coupon-expired {
            border-color: #dc3545;
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            opacity: 0.7;
        }
        .coupon-expired::before {
            background: linear-gradient(90deg, #dc3545, #c82333);
        }
        .coupon-expired .coupon-code {
            color: #dc3545;
        }
        .copy-btn {
            background: #28a745;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .copy-btn:hover {
            background: #218838;
            transform: translateY(-2px);
        }
        .no-coupons {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .no-coupons i {
            font-size: 64px;
            color: #ddd;
            margin-bottom: 20px;
        }
        .page-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
        }
        .page-header h1 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: 600;
        }
        .page-header p {
            margin: 10px 0 0 0;
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-ticket-alt"></i> ${pageTitle}</h1>
            <p>Sử dụng mã giảm giá để tiết kiệm chi phí mua sắm</p>
        </div>
    </div>

    <div class="container coupon-container">
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

        <c:choose>
            <c:when test="${not empty coupons}">
                <div class="row">
                    <c:forEach var="coupon" items="${coupons}">
                        <div class="col-md-6 col-lg-4">
                            <div class="coupon-card ${coupon.isExpired ? 'coupon-expired' : ''}">
                                <div class="coupon-header">
                                    <div class="coupon-code">${coupon.code}</div>
                                    <button class="copy-btn" onclick="copyCouponCode('${coupon.code}')" 
                                            ${coupon.isExpired ? 'disabled' : ''}>
                                        <i class="fas fa-copy"></i> Copy
                                    </button>
                                </div>
                                
                                <div class="coupon-name">${coupon.name}</div>
                                
                                <div class="coupon-discount">
                                    <c:choose>
                                        <c:when test="${coupon.discountType == 'Percentage'}">
                                            Giảm ${coupon.discountValue}%
                                        </c:when>
                                        <c:otherwise>
                                            Giảm <fmt:formatNumber value="${coupon.discountValue}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <c:if test="${not empty coupon.description}">
                                    <div class="coupon-description">${coupon.description}</div>
                                </c:if>
                                
                                <div class="coupon-details">
                                    <div class="coupon-detail-item">
                                        <i class="fas fa-shopping-cart"></i>
                                        <span>Đơn tối thiểu: <fmt:formatNumber value="${coupon.minOrderAmount}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫</span>
                                    </div>
                                    
                                    <c:if test="${coupon.maxDiscountAmount > 0}">
                                        <div class="coupon-detail-item">
                                            <i class="fas fa-limit"></i>
                                            <span>Giảm tối đa: <fmt:formatNumber value="${coupon.maxDiscountAmount}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫</span>
                                        </div>
                                    </c:if>
                                    
                                    <div class="coupon-detail-item">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>HSD: <fmt:formatDate value="${coupon.endDate}" pattern="dd/MM/yyyy"/></span>
                                    </div>
                                    
                                    <c:if test="${coupon.usageLimit > 0}">
                                        <div class="coupon-detail-item">
                                            <i class="fas fa-users"></i>
                                            <span>Còn lại: ${coupon.usageLimit - coupon.usedCount}</span>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-coupons">
                    <i class="fas fa-ticket-alt"></i>
                    <h3>Không có mã giảm giá nào</h3>
                    <p>Hiện tại chưa có mã giảm giá khả dụng. Hãy quay lại sau nhé!</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%@include file="footer.jsp" %>

    <script src="User/vendor/jquery/jquery.min.js"></script>
    <script src="User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        function copyCouponCode(code) {
            navigator.clipboard.writeText(code).then(function() {
                // Show success message
                const btn = event.target.closest('.copy-btn');
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-check"></i> Copied!';
                btn.style.background = '#28a745';
                
                setTimeout(function() {
                    btn.innerHTML = originalText;
                    btn.style.background = '#28a745';
                }, 2000);
            }).catch(function(err) {
                console.error('Could not copy text: ', err);
                alert('Không thể copy mã. Vui lòng copy thủ công: ' + code);
            });
        }
    </script>
</body>
</html>
