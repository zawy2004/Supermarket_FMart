
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=9">
    <meta name="description" content="FMart Supermarket">
    <meta name="author" content="Your Team">
    <title>FMart - ${product.productName}</title>
    <link rel="icon" type="image/png" href="User/images/fav.png">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href='User/vendor/unicons-2.0.1/css/unicons.css' rel='stylesheet'>
    <link href="User/css/style.css" rel="stylesheet">
    <link href="User/css/responsive.css" rel="stylesheet">
    <link href="User/css/night-mode.css" rel="stylesheet">
    <link href="User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="User/vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
    <link href="User/vendor/OwlCarousel/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="User/vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">
    <style>
        .product-radio ul.kggrm-now li label {
            cursor: pointer;
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        .product-radio ul.kggrm-now li input:checked + label {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }
        .stock-qty.out-of-stock {
            color: red;
        }
        .toast-notification {
            position: fixed;
            top: 10px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .quantity-input-container {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
            background-color: #f8f9fa;
            padding: 8px 12px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .quantity-input {
            width: 70px;
            padding: 6px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 4px;
            outline: none;
        }
        .quantity-input:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        label[for="custom-quantity"] {
            font-weight: 500;
            color: #333;
            margin: 0;
        }
        .wishlist-icon {
            font-size: 28px;
            margin-left: 10px;
            vertical-align: middle;
            cursor: pointer;
            color: #ccc;
            transition: all 0.3s ease;
        }
        .wishlist-icon.active {
            color: #e91e63;
        }
        .wishlist-icon:hover {
            color: #ff4081;
            transform: scale(1.1);
        }
    </style>
</head>
<body>
    <jsp:include page="search_model.jsp"></jsp:include>
    <jsp:include page="cart_sidebar.jsp"></jsp:include>
    <jsp:include page="header.jsp"></jsp:include>
    <div class="wrapper">
        <div class="gambo-Breadcrumb">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                                <c:if test="${not empty category}">
                                    <li class="breadcrumb-item"><a href="shop?categoryId=${category.categoryID}">${category.categoryName}</a></li>
                                </c:if>
                                <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <div class="all-product-grid">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product-dt-view">
                            <div class="row">
                                <div class="col-lg-4 col-md-4">
                                    <div id="sync1" class="owl-carousel owl-theme">
                                        <c:choose>
                                            <c:when test="${not empty productImages}">
                                                <c:forEach var="image" items="${productImages}">
                                                    <div class="item">
                                                        <img src="http://localhost:8080/Supermarket_FMart/User/${image.imageUrl}" alt="${image.altText}">
                                                        <p style="display: none;">Debug: Image URL = ${image.imageUrl}, ProductID = ${image.productID}</p>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="item">
                                                    <img src="images/product/default.jpg" alt="Default Product Image">
                                                    <p style="display: none;">Debug: No images found for ProductID = ${product.productID}</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div id="sync2" class="owl-carousel owl-theme">
                                        <c:choose>
                                            <c:when test="${not empty productImages}">
                                                <c:forEach var="image" items="${productImages}">
                                                    <div class="item">
                                                        <img src="http://localhost:8080/Supermarket_FMart/User/${image.imageUrl}" alt="${image.altText}">
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="item">
                                                    <img src="images/product/default.jpg" alt="Default Product Image">
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="col-lg-8 col-md-8">
                                    <div class="product-dt-right">
                                        <h2>${product.productName}</h2>
                                        <div class="no-stock">
                                            <p class="pd-no">Product No.<span>${product.sku}</span></p>
                                            <p class="stock-qty ${product.minStockLevel > 0 ? '' : 'out-of-stock'}">
                                                ${product.minStockLevel > 0 ? 'Available (In Stock)' : 'Out of Stock'}
                                            </p>
                                        </div>
                                        <div class="product-radio">
                                            <ul class="product-now">
                                                <li>
                                                    <input type="radio" id="unit1" name="unit" value="${product.unit}" checked>
                                                    <label for="unit1">${product.unit}</label>
                                                </li>
                                            </ul>
                                        </div>
                                        <p class="pp-descp">${product.description}</p>
                                        <div class="product-group-dt">
                                            <ul>
                                                <li>
                                                    <div class="main-price color-discount">Price
                                                        <span id="product-price" class="price-value"><fmt:formatNumber value="${product.sellingPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                                                    </div>
                                                </li>
                                                <c:if test="${product.costPrice > 0 && product.sellingPrice < product.costPrice}">
                                                    <li>
                                                        <div class="main-price mrp-price">MRP Price
                                                            <span><fmt:formatNumber value="${product.costPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                                                        </div>
                                                    </li>
                                                </c:if>
                                            </ul>
                                            <ul class="gty-wish-share">
                                                <li>
                                                    <div class="qty-product">
                                                        <div class="quantity buttons_added">
                                                            <input type="button" value="-" class="minus product-minus-btn">
                                                            <input type="number" step="1" name="quantity" value="1" class="input-text qty text product-qty-input" min="1" id="quantity-input">
                                                            <input type="button" value="+" class="plus product-plus-btn">
                                                        </div>
                                                        <div class="quantity-input-container">
                                                            <label for="custom-quantity">Enter Quantity:</label>
                                                            <input type="number" id="custom-quantity" class="quantity-input product-qty-input" min="1" value="1">
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                            <ul class="ordr-crt-share">
                                                <c:if test="${product.minStockLevel > 0}">
                                                    <li><button class="add-cart-btn hover-btn" onclick="addToCart(${product.productID})">
                                                        <i class="uil uil-shopping-cart-alt"></i>Add to Cart
                                                    </button></li>
                                                    <li><button class="order-btn hover-btn" onclick="orderNow(${product.productID}, '${product.productName}', ${product.sellingPrice})">
                                                        Order Now
                                                    </button></li>
                                                </c:if>
                                                <c:if test="${product.minStockLevel <= 0}">
                                                    <li><button class="add-cart-btn hover-btn disabled" disabled>Out of Stock</button></li>
                                                </c:if>
                                            </ul>
                                            <div class="wishlist-container" style="margin-top: 10px; text-align: right;">
                                                <span class="wishlist-icon save-icon ${isInWishlist ? 'active' : ''}" 
                                                      title="wishlist" 
                                                      onclick="addToWishlist(${product.productID})"><i class="fas fa-heart"></i></span>
                                            </div>
                                        </div>
                                        <div class="pdp-details">
                                            <ul>
                                                <li>
                                                    <div class="pdp-group-dt">
                                                        <div class="pdp-icon"><i class="uil uil-usd-circle"></i></div>
                                                        <div class="pdp-text-dt">
                                                            <span>Lowest Price Guaranteed</span>
                                                            <p>Get difference refunded if you find it cheaper anywhere else.</p>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="pdp-group-dt">
                                                        <div class="pdp-icon"><i class="uil uil-cloud-redo"></i></div>
                                                        <div class="pdp-text-dt">
                                                            <span>Easy Returns & Refunds</span>
                                                            <p>Return products at doorstep and get refund in seconds.</p>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="pdp-details">
                                            <ul>
                                                <li>
                                                    <div class="pdp-group-dt">
                                                        <div class="pdp-icon"><i class="uil uil-box"></i></div>
                                                        <div class="pdp-text-dt">
                                                            <span>Weight</span>
                                                            <p>${product.weight} ${product.unit}</p>
                                                        </div>
                                                    </div>
                                                </li>
                                                <c:if test="${not empty product.dimensions}">
                                                    <li>
                                                        <div class="pdp-group-dt">
                                                            <div class="pdp-icon"><i class="uil uil-ruler"></i></div>
                                                            <div class="pdp-text-dt">
                                                                <span>Dimensions</span>
                                                                <p>${product.dimensions}</p>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:if>
                                                <c:if test="${product.expiryDays > 0}">
                                                    <li>
                                                        <div class="pdp-group-dt">
                                                            <div class="pdp-icon"><i class="uil uil-clock"></i></div>
                                                            <div class="pdp-text-dt">
                                                                <span>Expiry Days</span>
                                                                <p>${product.expiryDays} days</p>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:if>
                                                <c:if test="${not empty product.brand}">
                                                    <li>
                                                        <div class="pdp-group-dt">
                                                            <div class="pdp-icon"><i class="uil uil-tag"></i></div>
                                                            <div class="pdp-text-dt">
                                                                <span>Brand</span>
                                                                <p>${product.brand}</p>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:if>
                                                <c:if test="${not empty product.origin}">
                                                    <li>
                                                        <div class="pdp-group-dt">
                                                            <div class="pdp-icon"><i class="uil uil-globe"></i></div>
                                                            <div class="pdp-text-dt">
                                                                <span>Origin</span>
                                                                <p>${product.origin}</p>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-4 col-md-12">
                                    <div class="pdpt-bg">
                                        <div class="pdpt-title">
                                            <h4>More Like This</h4>
                                        </div>
                                        <div class="pdpt-body scrollstyle_4">
                                            <c:set var="currentCategoryId" value="${product.categoryID}" />
                                            <c:forEach var="relatedProduct" items="${relatedProducts}">
                                                <c:if test="${relatedProduct.categoryID == currentCategoryId && relatedProduct.productID != product.productID}">
                                                    <div class="cart-item border_radius">
                                                        <a href="single_product?productId=${relatedProduct.productID}" class="cart-product-img">
                                                            <img src="${relatedProductImages[relatedProduct.productID]}" alt="${relatedProduct.productName}">
                                                            <p style="display: none;">Debug: Image URL = ${relatedProductImages[relatedProduct.productID]}, ProductID = ${relatedProduct.productID}</p>
                                                            <c:if test="${relatedProduct.costPrice > 0 && relatedProduct.sellingPrice < relatedProduct.costPrice}">
                                                                <c:set var="discount" value="${((relatedProduct.costPrice - relatedProduct.sellingPrice) / relatedProduct.costPrice) * 100}"/>
                                                                <div class="offer-badge"><fmt:formatNumber value="${discount}" maxFractionDigits="0"/>% OFF</div>
                                                            </c:if>
                                                        </a>
                                                        <div class="cart-text">
                                                            <h4>${relatedProduct.productName}</h4>
                                                            <div class="cart-radio">
                                                                <ul class="kggrm-now">
                                                                    <li>
                                                                        <input type="radio" id="r${relatedProduct.productID}" name="cart${relatedProduct.productID}" checked>
                                                                        <label for="r${relatedProduct.productID}">${relatedProduct.unit}</label>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="qty-group">
                                                                <div class="quantity buttons_added">
                                                                    <input type="button" value="-" class="minus related-minus-btn">
                                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text related-qty-input" min="1">
                                                                    <input type="button" value="+" class="plus related-plus-btn">
                                                                </div>
                                                                <div class="cart-item-price">
                                                                    <fmt:formatNumber value="${relatedProduct.sellingPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                                                                    <c:if test="${relatedProduct.costPrice > 0 && relatedProduct.sellingPrice < relatedProduct.costPrice}">
                                                                        <span><fmt:formatNumber value="${relatedProduct.costPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${empty relatedProducts || fn:length(relatedProducts) == 0}">
                                                <div class="text-center p-4">
                                                    <p class="text-muted">No similar products found.</p>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-8 col-md-12">
                                    <div class="pdpt-bg">
                                        <div class="pdpt-title">
                                            <h4>Product Details</h4>
                                        </div>
                                        <div class="pdpt-body scrollstyle_4">
                                            <div class="pdct-dts-1">
                                                <div class="pdct-dt-step">
                                                    <h4>Description</h4>
                                                    <p>${product.description}</p>
                                                </div>
                                                <c:if test="${not empty product.brand}">
                                                    <div class="pdct-dt-step">
                                                        <h4>Brand</h4>
                                                        <div class="product_attr">${product.brand}</div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty product.origin}">
                                                    <div class="pdct-dt-step">
                                                        <h4>Origin</h4>
                                                        <div class="product_attr">${product.origin}</div>
                                                    </div>
                                                </c:if>
                                                <div class="pdct-dt-step">
                                                    <h4>Seller</h4>
                                                    <div class="product_attr">${product.supplierID}</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="section145">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="main-title-tt">
                                                <div class="main-title-left">
                                                    <span>For You</span>
                                                    <h2>Top Featured Products</h2>
                                                </div>
                                                <a href="shop" class="see-more-btn">See All</a>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="owl-carousel featured-slider owl-theme">
                                                <c:forEach var="featuredProduct" items="${featuredProducts}">
                                                    <div class="item">
                                                        <div class="product-item">
                                                            <a href="single_product?productId=${featuredProduct.productID}" class="product-img">
                                                                <img src="${featuredProductImages[featuredProduct.productID]}" alt="${featuredProduct.productName}">
                                                                <p style="display: none;">Debug: Image URL = ${featuredProductImages[featuredProduct.productID]}, ProductID = ${featuredProduct.productID}</p>
                                                                <div class="product-absolute-options">
                                                                    <c:if test="${featuredProduct.costPrice > 0 && featuredProduct.sellingPrice < featuredProduct.costPrice}">
                                                                        <c:set var="discount" value="${((featuredProduct.costPrice - featuredProduct.sellingPrice) / featuredProduct.costPrice) * 100}"/>
                                                                        <div class="offer-badge"><fmt:formatNumber value="${discount}" maxFractionDigits="0"/>% OFF</div>
                                                                    </c:if>
                                                                    <span class="wishlist-icon" title="wishlist" onclick="addToWishlist(${featuredProduct.productID})"><i class="fas fa-heart"></i></span>
                                                                </div>
                                                            </a>
                                                            <div class="product-text-dt">
                                                                <p>${featuredProduct.minStockLevel > 0 ? 'Available (In Stock)' : '<span class="text-danger">Out of Stock</span>'}</p>
                                                                <h4>${featuredProduct.productName}</h4>
                                                                <div class="product-price">
                                                                    <fmt:formatNumber value="${featuredProduct.sellingPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                                                                    <c:if test="${featuredProduct.costPrice > 0 && featuredProduct.sellingPrice < featuredProduct.costPrice}">
                                                                        <span><fmt:formatNumber value="${featuredProduct.costPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                                                                    </c:if>
                                                                </div>
                                                                <div class="qty-cart">
                                                                    <c:if test="${featuredProduct.minStockLevel > 0}">
                                                                        <div class="quantity buttons_added">
                                                                            <input type="button" value="-" class="minus featured-minus-btn">
                                                                            <input type="number" step="1" name="quantity" value="1" class="input-text qty text featured-qty-input" min="1">
                                                                            <input type="button" value="+" class="plus featured-plus-btn">
                                                                        </div>
                                                                        <span class="cart-icon" onclick="addToCart(${featuredProduct.productID})">
                                                                            <i class="uil uil-shopping-cart-alt"></i>
                                                                        </span>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
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
        <jsp:include page="footer.jsp"></jsp:include>
        <script src="User/js/jquery.min.js"></script>
        <script src="User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="User/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
        <script src="User/vendor/OwlCarousel/owl.carousel.js"></script>
        <script src="User/js/jquery.countdown.min.js"></script>
        <!-- <script src="User/js/custom.js"></script> --> <!-- Commented out to avoid conflicts -->
        <script src="User/js/product.thumbnail.slider.js"></script>
        <script src="User/js/offset_overlay.js"></script>
        <script src="User/js/night-mode.js"></script>
        <script>
            function isUserLoggedIn(callback) {
                $.ajax({
                    url: 'checkLogin',
                    type: 'GET',
                    success: function(response) {
                        console.log('CheckLogin response:', response);
                        callback(response.loggedIn);
                    },
                    error: function(xhr) {
                        console.error('CheckLogin error:', xhr.responseText);
                        callback(false);
                    }
                });
            }

            function updatePrice(quantityInput) {
                const quantity = parseInt(quantityInput.value) || 1;
                const basePrice = parseFloat('${product.sellingPrice}');
                const totalPrice = basePrice * quantity;
                document.getElementById('product-price').textContent = totalPrice.toLocaleString('vi-VN', { 
                    style: 'decimal', 
                    minimumFractionDigits: 0, 
                    maximumFractionDigits: 0 
                }) + ' ₫';
            }

            function syncQuantities() {
                const qtyInput = document.getElementById('quantity-input');
                const customQtyInput = document.getElementById('custom-quantity');
                if (qtyInput && customQtyInput) {
                    const value = parseInt(qtyInput.value) || 1;
                    customQtyInput.value = value;
                    updatePrice(qtyInput);
                }
            }

            function updateQuantityFromInput() {
                const customQtyInput = document.getElementById('custom-quantity');
                const qtyInput = document.getElementById('quantity-input');
                let newValue = parseInt(customQtyInput.value) || 1;
                if (newValue < 1) newValue = 1;
                if (newValue > ${product.minStockLevel}) newValue = ${product.minStockLevel};
                qtyInput.value = newValue;
                customQtyInput.value = newValue;
                updatePrice(qtyInput);
            }

            // Handle product +/- buttons
            document.addEventListener('DOMContentLoaded', function() {
                const qtyInput = document.getElementById('quantity-input');
                const customQtyInput = document.getElementById('custom-quantity');

                document.querySelectorAll('.product-minus-btn').forEach(button => {
                    button.addEventListener('click', function() {
                        let currentValue = parseInt(qtyInput.value) || 1;
                        if (currentValue > 1) {
                            currentValue -= 1;
                            qtyInput.value = currentValue;
                            customQtyInput.value = currentValue;
                            updatePrice(qtyInput);
                        }
                    });
                });

                document.querySelectorAll('.product-plus-btn').forEach(button => {
                    button.addEventListener('click', function() {
                        let currentValue = parseInt(qtyInput.value) || 1;
                        if (currentValue < ${product.minStockLevel}) {
                            currentValue += 1;
                            qtyInput.value = currentValue;
                            customQtyInput.value = currentValue;
                            updatePrice(qtyInput);
                        }
                    });
                });

                qtyInput.addEventListener('change', function() {
                    let value = parseInt(this.value) || 1;
                    if (value < 1) value = 1;
                    if (value > ${product.minStockLevel}) value = ${product.minStockLevel};
                    this.value = value;
                    customQtyInput.value = value;
                    updatePrice(this);
                });

                customQtyInput.addEventListener('change', function() {
                    let value = parseInt(this.value) || 1;
                    if (value < 1) value = 1;
                    if (value > ${product.minStockLevel}) value = ${product.minStockLevel};
                    this.value = value;
                    qtyInput.value = value;
                    updatePrice(qtyInput);
                });

                // Handle related and featured products +/- buttons
                document.querySelectorAll('.related-minus-btn, .featured-minus-btn').forEach(button => {
                    button.addEventListener('click', function() {
                        const qtyInput = this.parentElement.querySelector('.related-qty-input, .featured-qty-input');
                        let currentValue = parseInt(qtyInput.value) || 1;
                        if (currentValue > 1) {
                            qtyInput.value = currentValue - 1;
                        }
                    });
                });

                document.querySelectorAll('.related-plus-btn, .featured-plus-btn').forEach(button => {
                    button.addEventListener('click', function() {
                        const qtyInput = this.parentElement.querySelector('.related-qty-input, .featured-qty-input');
                        let currentValue = parseInt(qtyInput.value) || 1;
                        qtyInput.value = currentValue + 1;
                    });
                });

                document.querySelectorAll('.related-qty-input, .featured-qty-input').forEach(input => {
                    input.addEventListener('change', function() {
                        let value = parseInt(this.value) || 1;
                        if (value < 1) value = 1;
                        this.value = value;
                    });
                });

                syncQuantities();
                updatePrice(qtyInput);
            });

            function addToCart(productId) {
                isUserLoggedIn(function(loggedIn) {
                    if (!loggedIn) {
                        showNotification('Please log in to add items to cart!', 'error');
                        window.location.href = 'login';
                        return;
                    }
                    const quantityInput = document.getElementById('quantity-input');
                    const quantity = parseInt(quantityInput.value) || 1;
                    const unit = document.querySelector('input[name="unit"]:checked').value;

                    $.ajax({
                        url: 'cart',
                        type: 'POST',
                        data: {
                            action: 'add',
                            productId: productId,
                            quantity: quantity,
                            unit: unit
                        },
                        success: function(response) {
                            showNotification('Added ' + quantity + ' item(s) to cart!', 'success');
                            $.ajax({
                                url: 'cart',
                                type: 'GET',
                                success: function(cartData) {
                                    $('#cartSidebar').html(cartData);
                                },
                                error: function(xhr) {
                                    console.error('Error updating cart: ', xhr.responseText);
                                }
                            });
                        },
                        error: function(xhr) {
                            showNotification('Error adding to cart: ' + xhr.responseText, 'error');
                        }
                    });
                });
            }

            function orderNow(productId, productName, sellingPrice) {
                isUserLoggedIn(function(loggedIn) {
                    if (!loggedIn) {
                        showNotification('Please log in to place an order!', 'error');
                        window.location.href = 'login';
                        return;
                    }
                    const quantityInput = document.getElementById('quantity-input');
                    const quantity = parseInt(quantityInput.value) || 1;
                    const unit = document.querySelector('input[name="unit"]:checked').value;
                    const totalPrice = sellingPrice * quantity;

                    window.location.href = 'checkout?productId=' + productId + 
                        '&productName=' + encodeURIComponent(productName) + 
                        '&quantity=' + quantity + 
                        '&unit=' + encodeURIComponent(unit) + 
                        '&sellingPrice=' + sellingPrice + 
                        '&totalPrice=' + totalPrice;
                });
            }

            function addToWishlist(productId) {
                isUserLoggedIn(function(loggedIn) {
                    if (!loggedIn) {
                        showNotification('Please log in to add to wishlist!', 'error');
                        window.location.href = 'login';
                        return;
                    }
                    const heartIcon = event.target;
                    const isActive = heartIcon.classList.contains('active');

                    $.ajax({
                        url: 'wishlist',
                        type: 'POST',
                        data: {
                            action: isActive ? 'remove' : 'add',
                            productId: productId
                        },
                        success: function(response) {
                            if (isActive) {
                                heartIcon.classList.remove('active');
                                showNotification('Removed from wishlist', 'info');
                            } else {
                                heartIcon.classList.add('active');
                                showNotification('Added to wishlist!', 'success');
                            }
                        },
                        error: function(xhr) {
                            showNotification('Error updating wishlist: ' + xhr.responseText, 'error');
                        }
                    });
                });
            }

            function showNotification(message, type) {
                const existingNotifications = document.querySelectorAll('.toast-notification');
                existingNotifications.forEach(notif => notif.remove());

                const notification = document.createElement('div');
                const alertType = type === 'success' ? 'success' : type === 'info' ? 'info' : 'danger';
                notification.className = 'alert alert-' + alertType + ' alert-dismissible fade show toast-notification';
                notification.style.cssText = 'top: 10px; right: 20px; z-index: 9999; min-width: 300px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);';

                const icon = type === 'success' ? 'check-circle' : type === 'info' ? 'info-circle' : 'exclamation-circle';
                notification.innerHTML = 
                    '<button type="button" class="btn-close" data-bs-dismiss="alert" style="position: absolute; top: 5px; right: 10px;"></button>' + 
                    '<i class="fas fa-' + icon + ' me-2"></i>' + 
                    message;

                document.body.appendChild(notification);

                setTimeout(function() {
                    if (notification.parentNode) {
                        notification.remove();
                    }
                }, 3000);
            }

            $(document).ready(function() {
                const sync1 = $("#sync1");
                const sync2 = $("#sync2");
                const slidesPerPage = 4;
                const syncedSecondary = true;

                sync1.owlCarousel({
                    items: 1,
                    slideSpeed: 3000,
                    nav: true,
                    autoplay: false,
                    dots: true,
                    loop: true,
                    responsiveRefreshRate: 200,
                    navText: ['<i class="fas fa-chevron-left"></i>', '<i class="fas fa-chevron-right"></i>']
                }).on('changed.owl.carousel', syncPosition);

                sync2.on('initialized.owl.carousel', function() {
                    sync2.find(".owl-item").eq(0).addClass("current");
                }).owlCarousel({
                    items: slidesPerPage,
                    dots: true,
                    nav: true,
                    smartSpeed: 200,
                    slideSpeed: 500,
                    slideBy: slidesPerPage,
                    responsiveRefreshRate: 100,
                    navText: ['<i class="fas fa-chevron-left"></i>', '<i class="fas fa-chevron-right"></i>']
                }).on('changed.owl.carousel', syncPosition2);

                function syncPosition(el) {
                    const count = el.item.count - 1;
                    let current = Math.round(el.item.index - (el.item.count / 2) - .5);
                    if (current < 0) {
                        current = count;
                    }
                    if (current > count) {
                        current = 0;
                    }
                    sync2.find(".owl-item").removeClass("current").eq(current).addClass("current");
                    const onscreen = sync2.find('.owl-item.active').length - 1;
                    const start = sync2.find('.owl-item.active').first().index();
                    const end = sync2.find('.owl-item.active').last().index();
                    if (current > end) {
                        sync2.data('owl.carousel').to(current, 100, true);
                    }
                    if (current < start) {
                        sync2.data('owl.carousel').to(current - onscreen, 100, true);
                    }
                }

                function syncPosition2(el) {
                    if (syncedSecondary) {
                        const number = el.item.index;
                        sync1.data('owl.carousel').to(number, 100, true);
                    }
                }

                sync2.on("click", ".owl-item", function(e) {
                    e.preventDefault();
                    const number = $(this).index();
                    sync1.data('owl.carousel').to(number, 300, true);
                });
            });
        </script>
</body>
</html>
