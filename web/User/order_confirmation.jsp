<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html>
    <head>
        <title>Đặt hàng thành công - FMart</title>
        <meta charset="UTF-8">
        <style>
            body {
                font-family: Arial,sans-serif;
                background: #f5f7fa;
            }
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
                display:inline-block;
                background: #0c8b3e;
                color:#fff;
                padding: 11px 30px;
                border-radius: 6px;
                text-decoration:none;
                margin-top: 20px;
            }
            .back-btn:hover {
                background: #075b29;
            }
        </style>
    </head>
    <body>
        <div class="confirm-box">
            <h2>🎉 Đặt hàng thành công!</h2>
                <p>Mã đơn hàng: ${order.orderNumber}</p>
                <p>Khách hàng: ${name}</p>
                <p>Số điện thoại: ${phone}</p>
                <p>Địa chỉ giao hàng: ${order.deliveryAddress}</p>
                <p>Số tiền đã thanh toán: <b><fmt:formatNumber value="${finalAmount}" type="number"/> ₫</b></p>
                <p>Phương thức thanh toán: ${order.paymentMethod == 'cod' ? 'Thanh toán khi nhận hàng' : 'VNPAY'}</p>
                <br/>
                <b>Cảm ơn bạn đã mua sắm tại FMart!</b>
            </div>

            <div>
                <b>Chúng tôi sẽ liên hệ và giao hàng sớm nhất có thể.<br>Cảm ơn bạn đã mua sắm tại FMart!</b>
            </div>
            <a href="home" class="back-btn">Tiếp tục mua sắm</a>
        </div>
    </body>
</html>
