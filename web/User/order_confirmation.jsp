<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FMart - Xác nhận đơn hàng</title>
    <link href="${pageContext.request.contextPath}/User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/style.css" rel="stylesheet">
    <style>
        .confirm-box {
            max-width: 550px;
            margin: 60px auto;
            background: #fff;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 2px 16px #0001;
            text-align: center;
        }
        .confirm-box h2 {
            color: #32bb5a;
            margin-bottom: 18px;
        }
        .order-detail {
            margin: 30px 0;
            text-align: left;
        }
        .order-detail span {
            display: block;
            margin: 3px 0;
        }
        .back-btn {
            display: inline-block;
            background: #0c8b3e;
            color: #fff;
            padding: 11px 30px;
            border-radius: 6px;
            text-decoration: none;
            margin-top: 20px;
        }
        .back-btn:hover {
            background: #075b29;
        }
    </style>
</head>
<body>
    <c:if test="${sessionScope.user == null || sessionScope.user.roleName != 'User'}">
        <c:redirect url="/login"/>
    </c:if>

    <div class="container">
        <div class="confirm-box">
            <h2>🎉 Đặt hàng thành công!</h2>
            <div class="order-detail">
                <span>Mã đơn hàng: ${order.orderNumber}</span>
                <span>Khách hàng: ${sessionScope.user.fullName}</span>
                <span>Số điện thoại: ${sessionScope.user.phoneNumber}</span>
                <span>Địa chỉ giao hàng: ${order.deliveryAddress}</span>
                <c:if test="${sessionScope.appliedCouponCode != null && sessionScope.appliedDiscount > 0}">
                    <span>Mã giảm giá: ${sessionScope.appliedCouponCode}</span>
                    <span>Số tiền giảm: <fmt:formatNumber value="${sessionScope.appliedDiscount}" type="currency" currencyCode="VND"/></span>
                </c:if>
                <span>Số tiền đã thanh toán: <b><fmt:formatNumber value="${order.finalAmount}" type="currency" currencyCode="VND"/></b></span>
                <span>Phương thức thanh toán: ${order.paymentMethod == 'COD' ? 'Thanh toán khi nhận hàng' : order.paymentMethod}</span>
            </div>
            <p><b>Cảm ơn bạn đã mua sắm tại FMart!</b></p>
            <p>Chúng tôi sẽ liên hệ và giao hàng sớm nhất có thể.</p>
            <a href="${pageContext.request.contextPath}/home" class="back-btn">Tiếp tục mua sắm</a>
            <a href="${pageContext.request.contextPath}/order-history" class="back-btn">Xem lịch sử đơn hàng</a>
        </div>
    </div>
</body>
</html>