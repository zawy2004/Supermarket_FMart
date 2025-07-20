<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">


    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description-gambolthemes" content="">
        <meta name="author-gambolthemes" content="">
        <title>FMart Supermarket Admin</title>
        <link href="Admin/css/styles.css" rel="stylesheet">
        <link href="Admin/css/admin-style.css" rel="stylesheet">

        <!-- Vendor Stylesheets -->
        <link href="Admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

    </head>

    <body class="sb-nav-fixed">
        <jsp:include page="header.jsp"></jsp:include>

            <div id="layoutSidenav">
            <jsp:include page="staffsidebar.jsp"></jsp:include>
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid">
                            <h2 class="mt-30 page-title">Orders</h2>
                            <ol class="breadcrumb mb-30">
                                <li class="breadcrumb-item"><a href="AdminServlet">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="OrderManagementServlet">Orders</a></li>
                                <li class="breadcrumb-item active">Order View</li>
                            </ol>
                            <div class="row">
                                <div class="col-xl-12 col-md-12">
                                    <div class="card card-static-2 mb-30">
                                        <div class="card-title-2">
                                            <h2 class="title1458">Invoice</h2>
                                            <span class="order-id">
                                                Order #${order.orderNumber}
                                        </span>
                                    </div>
                                    <div class="invoice-content">
                                        <div class="row">
                                            <div class="col-lg-6 col-sm-6">
                                                <div class="ordr-date">
                                                    <b>Order Date :</b>
                                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                                </div>
                                                <div>
                                                    <b>Order Type:</b> ${order.orderType}
                                                </div>
                                                <div>
                                                    <b>Status:</b> ${order.status}
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-sm-6">
                                                <div class="ordr-date right-text">
                                                    <b>Delivery Address:</b><br>
                                                    ${order.deliveryAddress}
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="card card-static-2 mb-30 mt-30">
                                                    <div class="card-title-2">
                                                        <h4>Order Details</h4>
                                                    </div>
                                                    <div class="card-body-table">
                                                        <div class="table-responsive">
                                                            <table class="table ucp-table table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>#</th>
                                                                        <th>Product ID</th>
                                                                        <th class="text-center">Unit Price</th>
                                                                        <th class="text-center">Qty</th>
                                                                        <th class="text-center">Discount (%)</th>
                                                                        <th class="text-center">Discount (Amount)</th>
                                                                        <th class="text-center">Total</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="item" items="${orderDetails}" varStatus="loop">
                                                                        <tr>
                                                                            <td>${loop.index + 1}</td>
                                                                            <td>${item.productID}</td>
                                                                            <td class="text-center">
                                                                                <fmt:formatNumber value="${item.unitPrice}" type="number" minFractionDigits="2" />
                                                                            </td>
                                                                            <td class="text-center">${item.quantity}</td>
                                                                            <td class="text-center">
                                                                                <fmt:formatNumber value="${item.discountPercent}" type="number" minFractionDigits="2" />%
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <fmt:formatNumber value="${item.discountAmount}" type="number" minFractionDigits="2" />
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <fmt:formatNumber value="${item.totalPrice}" type="number" minFractionDigits="2" />
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-7"></div>
                                            <div class="col-lg-5">
                                                <div class="order-total-dt">
                                                    <div class="order-total-left-text">
                                                        Sub Total
                                                    </div>
                                                    <div class="order-total-right-text">
                                                        $<fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" />
                                                    </div>
                                                </div>
                                                <div class="order-total-dt">
                                                    <div class="order-total-left-text">
                                                        Discount
                                                    </div>
                                                    <div class="order-total-right-text">
                                                        $<fmt:formatNumber value="${order.discountAmount}" type="number" minFractionDigits="2" />
                                                    </div>
                                                </div>
                                                <div class="order-total-dt">
                                                    <div class="order-total-left-text">
                                                        Tax
                                                    </div>
                                                    <div class="order-total-right-text">
                                                        $<fmt:formatNumber value="${order.taxAmount}" type="number" minFractionDigits="2" />
                                                    </div>
                                                </div>
                                                <div class="order-total-dt">
                                                    <div class="order-total-left-text fsz-18">
                                                        Total Amount
                                                    </div>
                                                    <div class="order-total-right-text fsz-18">
                                                        $<fmt:formatNumber value="${order.finalAmount}" type="number" minFractionDigits="2" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-7"></div>
                                            <div class="col-lg-5">
                                                <div class="select-status">
                                                    <label for="status">Status*</label>
                                                    <div class="status-active">
                                                        ${order.status}
                                                    </div>
                                                    <div>
                                                        <b>Payment Status:</b> ${order.paymentStatus}
                                                    </div>
                                                    <div>
                                                        <b>Payment Method:</b> ${order.paymentMethod}
                                                    </div>
                                                    <div>
                                                        <b>Notes:</b> ${order.notes}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-footer mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted-1">Â© 2025<b>FMart Supermarket</b>. by <a href="https://themeforest.net/user/gambolthemes">Gambolthemes</a></div>
                            <div class="footer-links">
                                <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/privacy_policy.jsp">Privacy Policy</a>
                                <a href="http://gambolthemes.net/html-items/gambo_supermarket_demo/term_and_conditions.jsp">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="Admin/js/jquery.min.js"></script>
        <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="Admin/js/scripts.js"></script>

    </body>


</html>
