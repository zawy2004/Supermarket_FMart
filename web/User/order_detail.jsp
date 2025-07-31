<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.OrderDetail" %>

<%
    List<OrderDetail> orderDetails = (List<OrderDetail>) request.getAttribute("orderDetails");
    int orderId = (Integer) request.getAttribute("orderId");
%>

<html>
<head>
    <title>Order Details - Order #<%= orderId %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3 class="mb-4">Order Details for Order ID: <%= orderId %></h3>
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>#</th>
            <th>Product ID</th>
            <th>Quantity</th>
            <th>Unit Price</th>
            <th>Discount %</th>
            <th>Discount Amount</th>
            <th>Total Price</th>
        </tr>
        </thead>
        <tbody>
        <%
            double grandTotal = 0;
            int i = 1;
            for (OrderDetail detail : orderDetails) {
                grandTotal += detail.getTotalPrice();
        %>
        <tr>
            <td><%= i++ %></td>
            <td><%= detail.getProductID() %></td>
            <td><%= detail.getQuantity() %></td>
            <td>$<%= detail.getUnitPrice() %></td>
            <td><%= detail.getDiscountPercent() %> %</td>
            <td>$<%= detail.getDiscountAmount() %></td>
            <td>$<%= detail.getTotalPrice() %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <h5 class="text-end">Total Order Value: <strong>$<%= String.format("%.2f", grandTotal) %></strong></h5>
    <a href="orders" class="btn btn-secondary mt-3">← Back to My Orders</a>
</div>
</body>
</html>