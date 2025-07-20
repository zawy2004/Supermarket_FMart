<%-- 
    Document   : vnpay_result
    Created on : Jul 15, 2025, 10:30:38 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>${message}</h2>
<c:if test="${not empty orderNumber}">
    <p>Mã đơn hàng: <b>${orderNumber}</b></p>
    <p>Số tiền đã thanh toán: <b><fmt:formatNumber value="${amount}" type="number"/> ₫</b></p>
</c:if>

    </body>
</html>
