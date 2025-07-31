<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>FMart - My Wishlist</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
    <link href="User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="User/css/style.css" rel="stylesheet">
    <link href="User/css/responsive.css" rel="stylesheet">
    <link href="User/css/night-mode.css" rel="stylesheet">
    <style>
        .wishlist-table { background: #fff; border-radius: 10px; box-shadow: 0 1px 7px #e5e5e5; }
        .wishlist-table td, .wishlist-table th { vertical-align: middle !important; border-top: none; border-bottom: 1px solid #f1f1f1; }
        .wishlist-img-thumb { width: 60px; height: 60px; object-fit: cover; border-radius: 7px; box-shadow: 0 0 2px #eee; background: #f7f7f7; }
        @media (max-width: 767px) { .wishlist-table td, .wishlist-table th { font-size: 0.97em; } .wishlist-img-thumb { width: 45px; height: 45px; } }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="wrapper">
    <div class="gambo-Breadcrumb">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Shopping Wishlist</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="dashboard-group">
        <div class="container">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-xl-3 col-lg-4 col-md-12">
                    <div class="left-side-tabs">
                        <div class="dashboard-left-links">
                            <a href="profile?action=overview" class="user-item"><i class="uil uil-apps"></i>Overview</a>
                            <a href="orders" class="user-item"><i class="uil uil-box"></i>My Orders</a>
                            <a href="wishlist" class="user-item active"><i class="uil uil-heart"></i>My Wishlist</a>
                            <a href="profile?action=wallet" class="user-item"><i class="uil uil-wallet"></i>My Wallet</a>
                            <a href="profile?action=addresses" class="user-item"><i class="uil uil-location-point"></i>My Address</a>
                            <a href="logout" class="user-item"><i class="uil uil-exit"></i>Logout</a>
                        </div>
                    </div>
                </div>
                <!-- Main Content -->
                <div class="col-xl-9 col-lg-8 col-md-12">
                    <div class="dashboard-right">
                        <div class="main-title-tab">
                            <h4><i class="uil uil-heart"></i>My Wishlist</h4>
                        </div>
                        <div class="pdpt-bg">
                            <div class="wishlist-body-dtt">
                                <c:choose>
                                    <c:when test="${empty wishlistItems}">
                                        <p style="padding:2rem; text-align:center">Your wishlist is empty.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="card card-static-2 mb-30">
                                            <div class="card-body-table">
                                                <div class="table-responsive">
                                                    <table class="table wishlist-table table-hover">
                                                        <thead>
                                                        <tr>
                                                            <th style="width:60px;">ID</th>
                                                            <th style="width:80px;">Image</th>
                                                            <th>Name & Price</th>
                                                            <th style="width:130px;">Action</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="item" items="${wishlistItems}">
                                                            <tr>
                                                                <td>${item.productID}</td>
                                                                <td>
                                                                    <img src="User/images/product/${item.imageUrl}" 
                                                                         alt="${item.productName}" class="wishlist-img-thumb"
                                                                         onerror="this.onerror=null;this.src='User/images/product/default.jpg';"/>
                                                                </td>
                                                                <td>
                                                                    <div class="wishlist-product-title">${item.productName}</div>
                                                                    <span class="wishlist-product-price">$${item.sellingPrice}</span>
                                                                </td>
                                                                <td>
                                                                    <form method="post" action="${pageContext.request.contextPath}/wishlist" style="display:inline-block">
                                                                        <input type="hidden" name="action" value="add"/>
                                                                        <input type="hidden" name="productId" value="${item.productID}"/>
                                                                        <button type="submit" class="btn btn-success btn-sm" title="Add to Cart">
                                                                            <i class="uil uil-shopping-cart-alt"></i>
                                                                        </button>
                                                                    </form>
                                                                    <button class="btn btn-danger btn-sm remove-wishlist-btn"
                                                                            data-productid="${item.productID}" title="Remove from Wishlist">
                                                                        <i class="uil uil-trash-alt"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
<script src="User/js/jquery.min.js"></script>
<script src="User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="User/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
<script src="User/vendor/OwlCarousel/owl.carousel.js"></script>
<script src="User/js/custom.js"></script>
<script src="User/js/product.thumbnail.slider.js"></script>
<script src="User/js/offset_overlay.js"></script>
<script src="User/js/night-mode.js"></script>
<script>
    $(function () {
        $('.wishlist-table').on('click', '.remove-wishlist-btn', function () {
            var $btn = $(this);
            var productId = $btn.data('productid');
            $.post('${pageContext.request.contextPath}/wishlist', {
                action: 'remove',
                productId: productId
            }, function (response) {
                $btn.closest('tr').fadeOut(250, function () {
                    $(this).remove();
                    if ($('.wishlist-table tbody tr').length === 0) {
                        $('.wishlist-table').replaceWith('<p style="padding:2rem; text-align:center">Your wishlist is empty.</p>');
                    }
                });
            });
            return false;
        });
    });
</script>
</body>
</html>
