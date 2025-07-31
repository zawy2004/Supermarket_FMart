<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- fallback náº¿u user null --%>
<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null) {
        user = new model.User();
        user.setFullName("Demo User");
        user.setPhoneNumber("+84987654321");
        user.setAddress("123 Default Street, District 1, HCMC");
        session.setAttribute("user", user);
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <title>FMart - My Orders</title>
        <link rel="icon" type="image/png" href="images/fav.png">
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
        <link href="User/css/style.css" rel="stylesheet">
        <link href="User/css/responsive.css" rel="stylesheet">
        <link href="User/css/night-mode.css" rel="stylesheet">
        <link href="User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="User/vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
        <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="User/vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">
        <style>
            .order-detail-table th, .order-detail-table td {
                vertical-align: middle;
            }
            .order-detail-table img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 5px;
            }
            .order-detail-section {
                border-bottom: 1px solid #e9ecef;
                padding-bottom: 15px;
                margin-bottom: 15px;
            }
            .order-detail-section:last-child {
                border-bottom: none;
            }
            .order-detail-section h6 {
                margin-bottom: 10px;
                color: #007bff;
            }
            .order-detail-section p {
                margin-bottom: 5px;
            }
            .order-card {
                border: 1px solid #e9ecef;
                border-radius: 10px;
                transition: all 0.3s ease;
                background: #fff;
            }
            .order-card:hover {
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                transform: translateY(-2px);
            }
            .order-status {
                font-size: 12px;
                padding: 4px 12px;
                border-radius: 20px;
                font-weight: 500;
            }
            .status-pending {
                background: #fff3cd;
                color: #856404;
            }
            .status-processing {
                background: #d1ecf1;
                color: #0c5460;
            }
            .status-shipped {
                background: #d4edda;
                color: #155724;
            }
            .status-delivered {
                background: #d1ecf1;
                color: #0c5460;
            }
            .status-cancelled {
                background: #f8d7da;
                color: #721c24;
            }
            .payment-success {
                color: #28a745;
            }
            .payment-pending {
                color: #ffc107;
            }
            .payment-failed {
                color: #dc3545;
            }
            .order-number {
                color: #007bff;
                font-weight: 600;
            }
            .order-total {
                font-size: 1.1em;
                font-weight: 600;
                color: #28a745;
            }
            .empty-orders {
                text-align: center;
                padding: 60px 20px;
            }
            .empty-orders i {
                font-size: 4rem;
                color: #dee2e6;
                margin-bottom: 20px;
            }
            .order-detail-table img {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="wrapper">
            <div class="gambo-Breadcrumb">
                <div class="container">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="home">Home</a></li>
                        <li class="breadcrumb-item active">My Orders</li>
                    </ol>
                </div>
            </div>

            <div class="dashboard-group">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 text-center">
                            <div class="user-dt">
                                <img src="images/avatar/img-5.jpg" alt="">
                                <h4>${user.fullName}</h4>
                                <p>${user.phoneNumber}</p>
                                <div>Points: ${user.points}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>  

            <div class="container mt-4">
                <div class="row">
                    <div class="col-xl-3 col-lg-4">
                        <div class="left-side-tabs">
                            <div class="dashboard-left-links">
                                <a href="profile?action=overview" class="user-item"><i class="uil uil-apps"></i>Overview</a>
                                <a href="orders" class="user-item active"><i class="uil uil-box"></i>My Orders</a>
                                <a href="wishlist" class="user-item"><i class="uil uil-heart"></i>My Wishlist</a>
                                <a href="profile?action=wallet" class="user-item"><i class="uil uil-wallet"></i>My Wallet</a>
                                <a href="profile?action=addresses" class="user-item"><i class="uil uil-location-point"></i>My Address</a>
                                <a href="logout" class="user-item"><i class="uil uil-exit"></i>Logout</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-9 col-lg-8">
                        <div class="dashboard-right">
                            <div class="main-title-tab mb-4">
                                <h4><i class="uil uil-box"></i>My Orders</h4>
                            </div>
                            <div class="pdpt-bg">
                                <div class="pdpt-title">
                                    <h4>Order History</h4>
                                    <p class="text-muted">Track and manage your orders</p>
                                </div>

                                <c:choose>
                                    <c:when test="${empty orders}">
                                        <div class="empty-orders">
                                            <i class="uil uil-shopping-cart"></i>
                                            <h5>No Orders Yet</h5>
                                            <p class="text-muted">You haven't placed any orders yet. Start shopping to see your orders here!</p>
                                            <a href="home" class="btn btn-primary mt-3">
                                                <i class="uil uil-shop"></i> Start Shopping
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="row g-4">
                                            <c:forEach var="order" items="${orders}">
                                                <div class="col-12">
                                                    <div class="order-card p-4">
                                                        <div class="row align-items-center">
                                                            <div class="col-md-2">
                                                                <div class="order-icon">
                                                                    <i class="uil uil-package" style="font-size: 2rem; color: #007bff;"></i>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <h5 class="order-number mb-2">Order #${order.orderNumber}</h5>
                                                                <div class="order-info">
                                                                    <p class="mb-1">
                                                                        <i class="uil uil-calendar-alt"></i>
                                                                        <strong>Date:</strong> ${order.orderDate}
                                                                    </p>
                                                                    <p class="mb-1">
                                                                        <i class="uil uil-credit-card"></i>
                                                                        <strong>Payment:</strong> ${order.paymentMethod}
                                                                        <span class="payment-${order.paymentStatus.toLowerCase()}">
                                                                            (${order.paymentStatus})
                                                                        </span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-2 text-center">
                                                                <span class="order-status status-${order.status.toLowerCase().replace(' ', '-')}">
                                                                    ${order.status}
                                                                </span>
                                                            </div>
                                                            <div class="col-md-2 text-end">
                                                                <div class="order-total mb-2">${order.finalAmount}VND</div>
                                                                <button class="btn btn-outline-primary btn-sm view-details-btn" 
                                                                        data-order-id="${order.orderID}"
                                                                        data-bs-toggle="modal" data-bs-target="#orderDetailModal">
                                                                    <i class="uil uil-eye"></i> View Details
                                                                </button>
                                                            </div>
                                                        </div>

                                                        <!-- Order Actions -->
                                                        <div class="row mt-3">
                                                            <div class="col-12">
                                                                <div class="order-actions d-flex gap-2">
                                                                    <c:if test="${order.status == 'Processing'}">
                                                                        <button class="btn btn-sm btn-outline-danger" 
                                                                                onclick="cancelOrder('${order.orderID}')">
                                                                            <i class="uil uil-times"></i> Cancel Order
                                                                        </button>
                                                                    </c:if>
                                                                    <c:if test="${order.status == 'Delivered'}">
                                                                        <a href="review?orderID=${order.orderID}" 
                                                                           class="btn btn-sm btn-outline-warning">
                                                                            <i class="uil uil-star"></i> Write Review
                                                                        </a>
                                                                    </c:if>
                                                                    <a href="reorder?orderID=${order.orderID}" 
                                                                       class="btn btn-sm btn-outline-success">
                                                                        <i class="uil uil-redo"></i> Reorder
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>

                                        <!-- Pagination -->
                                        <c:if test="${totalPages > 1}">
                                            <nav class="mt-4">
                                                <ul class="pagination justify-content-center">
                                                    <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                                        <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                                            <a class="page-link" href="orders?page=${pageNum}">${pageNum}</a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </nav>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Success/Error Messages -->
                                <c:if test="${not empty success}">
                                    <div class="alert alert-success mt-3 alert-dismissible fade show">
                                        <i class="uil uil-check-circle"></i> ${success}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger mt-3 alert-dismissible fade show">
                                        <i class="uil uil-exclamation-triangle"></i> ${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>  
        </div>

        <!-- Order Detail Modal -->
        <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="orderDetailModalLabel">Order Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="order-details-content">
                            <div class="text-center">
                                <div class="spinner-border text-primary" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                                <p>Loading order details...</p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

        <script src="User/js/jquery.min.js"></script>
        <script src="User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="User/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
        <script src="User/vendor/OwlCarousel/owl.carousel.js"></script>
        <script src="User/js/jquery.countdown.min.js"></script>
        <script src="User/js/custom.js"></script>
        <script src="User/js/offset_overlay.js"></script>
        <script src="User/js/night-mode.js"></script>

        <script>
                function cancelOrder(orderID) {
                    if (confirm('Are you sure you want to cancel this order?')) {
                        $.ajax({
                            url: 'orders',
                            type: 'POST',
                            data: {
                                action: 'cancel',
                                orderID: orderID
                            },
                            success: function (response) {
                                location.reload();
                            },
                            error: function () {
                                alert('Failed to cancel order. Please try again.');
                            }
                        });
                    }
                }

                // View Order Details
                $(document).ready(function () {
                    $('.view-details-btn').click(function () {
                        var orderID = $(this).data('order-id');
                        $('#order-details-content').html(`
            <div class="text-center">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p>Loading order details...</p>
            </div>
        `);

            $.ajax({
                url: 'order_detail',
                type: 'GET',
                data: {orderID: orderID},
                dataType: 'json',
                success: function (response) {
                    if (response && response.orderNumber) {
                        // Basic order info
                        var orderNumber = response.orderNumber || 'N/A';
                        var orderDate = response.orderDate || 'N/A';
                        var paymentMethod = response.paymentMethod || 'N/A';
                        var paymentStatus = response.paymentStatus || 'N/A';
                        var orderStatus = response.status || 'N/A';
                        var finalAmount = response.finalAmount || 0;
                        var shippingAddress = response.shippingAddress || 'N/A';

                        // Generate content
                        var content = `
                        <div class="order-detail-section">
                            <h6>Order Information</h6>
                            <p><strong>Order #:</strong> ${orderNumber}</p>
                            <p><strong>Date:</strong> ${orderDate}</p>
                            <p><strong>Payment Method:</strong> ${paymentMethod}
                                <span class="payment-${paymentStatus.toLowerCase()}">
                                    (${paymentStatus})
                                </span>
                            </p>
                            <p><strong>Status:</strong>
                                <span class="order-status status-${orderStatus.toLowerCase().replace(' ', '-')}">
            ${orderStatus}
                                </span>
                            </p>
                            <p><strong>Total:</strong> ${finalAmount} VND</p>
                        </div>
                        <div class="order-detail-section">
                            <h6>Shipping Address</h6>
                            <p>${shippingAddress}</p>
                        </div>
                        <div class="order-detail-section">
                            <h6>Products</h6>
                            <table class="table order-detail-table">
                                <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Product Name</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                    `;

                            // Product list
                            if (response.products && response.products.length > 0) {
                                response.products.forEach(function (product) {
                                    var image = product.image || 'images/no-image.png';
                                    var name = product.name || 'Unnamed Product';
                                    var qty = product.quantity || 0;
                                    var price = product.price || 0;
                                    var total = qty * price;

                                    content += `
                        <tr>
                                    <td><img src="${image}" alt="${name}" title="${name}"></td>
                                    <td>${name}</td>
                                    <td>${qty}</td>
                                    <td>${price} VND</td>
                                    <td>${total} VND</td>
                                </tr>
                            `;
                                });
                            } else {
                                content += `
                            <tr>
                                <td colspan="5" class="text-center">No products found for this order.</td>
                            </tr>
                        `;
                        }

                        content += `
                                </tbody>
                            </table>
                        </div>
                    `;

                            $('#order-details-content').html(content);
                        } else {
                            $('#order-details-content').html('<p class="text-danger">No order details available.</p>');
                        }
                    },
                    error: function (xhr, status, error) {
                        $('#order-details-content').html(`
                    <p class="text-danger">Failed to load order details. Please try again later.</p>
                    <p><small>Error: ${xhr.status} - ${error}</small></p>
                `);
                        }
                    });
                });

                // Auto-hide alerts
                setTimeout(function () {
                    $('.alert').fadeOut('slow');
                }, 5000);
            });
        </script>

    </body>
</html>