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
            .cart-close-btn {
                background-color: transparent;
                border: none;
                color: #e91e63;
                font-size: 20px;
                cursor: pointer;
            }
            .cart-close-btn:hover {
                color: #ff4081;
            }
            .add-cart-btn {
                background-color: #28a745;
                color: #fff;
                border: none;
                padding: 5px 12px;
                border-radius: 4px;
                cursor: pointer;
            }
            .add-cart-btn:hover {
                background-color: #218838;
            }
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
                                    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
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
                        <div class="col-xl-3 col-lg-4 col-md-12">
                            <div class="left-side-tabs">
                            <div class="dashboard-left-links">
                                <a href="profile?action=overview" class="user-item active"><i class="uil uil-apps"></i>Overview</a>
                                <a href="profile?action=orders" class="user-item"><i class="uil uil-box"></i>My Orders</a>
                                <a href="profile?action=wishlist" class="user-item"><i class="uil uil-heart"></i>My Wishlist</a>
                                <a href="profile?action=wallet" class="user-item"><i class="uil uil-wallet"></i>My Wallet</a>
                                <a href="profile?action=addresses" class="user-item"><i class="uil uil-location-point"></i>My Address</a>
                                <a href="logout" class="user-item"><i class="uil uil-exit"></i>Logout</a>
                            </div>
                            </div>
                        </div>
                        <div class="col-xl-9 col-lg-8 col-md-12">
                            <div class="dashboard-right">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="main-title-tab">
                                            <h4><i class="uil uil-heart"></i>My Wishlist</h4>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12">
                                        <div class="pdpt-bg">
                                            <div class="wishlist-body-dtt">
                                                <c:choose>
                                                    <c:when test="${empty wishlistItems}">
                                                        <p style="padding:1rem">Your wishlist is empty.</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="item" items="${wishlistItems}">
                                                            <div class="cart-item">
                                                                <div class="cart-product-img">
                                                                    <img src="${wishlistImages[item.productID]}" alt="${item.productName}">

                                                                    
                                                                </div>
                                                                <div class="cart-text">
                                                                    <h4>${item.productName}</h4>
                                                                    <div class="cart-item-price">
                                                                        $${item.sellingPrice}
                                                                        
                                                                    </div>
                                                                    <div style="margin-top:5px;">
                                                                        <form method="post" action="${pageContext.request.contextPath}/cart" style="display:inline-block">
                                                                            <input type="hidden" name="action" value="add">
                                                                            <input type="hidden" name="productId" value="${item.productID}">
                                                                            <input type="hidden" name="quantity" value="1">
                                                                            <button type="submit" class="add-cart-btn"><i class="uil uil-shopping-cart-alt"></i> Add to Cart</button>
                                                                        </form>
                                                                        <form method="post" action="${pageContext.request.contextPath}/wishlist" style="display:inline-block">
                                                                            <input type="hidden" name="action" value="remove">
                                                                            <input type="hidden" name="productId" value="${item.productID}">
                                                                            <button type="submit" class="cart-close-btn" title="Remove from Wishlist"><i class="uil uil-trash-alt"></i></button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>

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
    </body>
</html>
