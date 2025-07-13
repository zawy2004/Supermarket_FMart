<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=9">
    <meta name="description" content="Gambolthemes">
    <meta name="author" content="Gambolthemes">		
    <title>FMart - ${pageTitle != null ? pageTitle : 'Shop'}</title>

    <!-- Favicon Icon -->
    <link rel="icon" type="image/png" href="User/images/fav.png">

    <!-- Stylesheets -->
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href='User/vendor/unicons-2.0.1/css/unicons.css' rel='stylesheet'>
    <link href="User/css/style.css" rel="stylesheet">
    <link href="User/css/responsive.css" rel="stylesheet">
    <link href="User/css/night-mode.css" rel="stylesheet">

    <!-- Vendor Stylesheets -->
    <link href="User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="User/vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
    <link href="User/vendor/OwlCarousel/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="User/vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">
    
    <style>
        .filter-dropdown {
            position: relative;
            display: inline-block;
        }
        
        .filter-dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 250px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            right: 0;
            top: 100%;
            border-radius: 5px;
            padding: 15px;
        }
        
        .filter-dropdown.show .filter-dropdown-content {
            display: block;
        }
        
        .sort-dropdown {
            position: relative;
            display: inline-block;
        }
        
        .sort-dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 200px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            right: 0;
            top: 100%;
            border-radius: 5px;
        }
        
        .sort-dropdown.show .sort-dropdown-content {
            display: block;
        }
        
        .sort-option {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            cursor: pointer;
        }
        
        .sort-option:hover {
            background-color: #f1f1f1;
        }
        
        .sort-option.active {
            background-color: #007bff;
            color: white;
        }
        
        .filter-section {
            margin-bottom: 20px;
        }
        
        .filter-section h6 {
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .price-range-inputs {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
        }
        
        .price-range-inputs input {
            flex: 1;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        
        .quick-price-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            margin-bottom: 10px;
        }
        
        .quick-price-btn {
            padding: 5px 10px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
        }
        
        .quick-price-btn:hover,
        .quick-price-btn.active {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }
        
        .apply-filters-btn {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        
        .apply-filters-btn:hover {
            background: #0056b3;
        }
        
        .clear-filters-btn {
            width: 100%;
            padding: 8px;
            background: #6c757d;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            margin-top: 5px;
        }
        
        .clear-filters-btn:hover {
            background: #5a6268;
        }
        
        .category-filter {
            max-height: 200px;
            overflow-y: auto;
        }
        
        .category-filter .form-check {
            margin-bottom: 8px;
        }
        
        .filter-btn, .sort-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
        }
        
        .filter-btn:hover, .sort-btn:hover {
            background: #0056b3;
            color: white;
        }

        /* New styles for right-aligned controls */
        .product-top-dt {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .product-left-title {
            flex: 1;
            min-width: 200px;
        }

        .product-controls {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-shrink: 0;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .product-top-dt {
                flex-direction: column;
                align-items: stretch;
            }
            
            .product-controls {
                justify-content: flex-end;
                width: 100%;
            }
        }
    </style>
</head>

<body>	
    <!-- Category Model Start-->
    <div class="header-cate-model main-gambo-model modal fade" id="category_model" tabindex="-1" role="dialog" aria-modal="false">
        <div class="modal-dialog category-area" role="document">
            <div class="category-area-inner">
                <div class="modal-header">
                    <button type="button" class="close btn-close" data-dismiss="modal" aria-label="Close">
                        <i class="uil uil-multiply"></i>
                    </button>
                </div>
                <div class="category-model-content modal-content"> 
                    <div class="cate-header">
                        <h4>Select Category</h4>
                    </div>
                    <ul class="category-by-cat">
                        <li><a href="shop?categoryId=1" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-1.svg" alt=""></div><div class="text">Vegetables & Fruits</div></a></li>
                        <li><a href="shop?categoryId=2" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-2.svg" alt=""></div><div class="text">Grocery & Staples</div></a></li>
                        <li><a href="shop?categoryId=3" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-3.svg" alt=""></div><div class="text">Dairy & Eggs</div></a></li>
                        <li><a href="shop?categoryId=4" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-4.svg" alt=""></div><div class="text">Beverages</div></a></li>
                        <li><a href="shop?categoryId=5" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-5.svg" alt=""></div><div class="text">Snacks</div></a></li>
                        <li><a href="shop?categoryId=6" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-6.svg" alt=""></div><div class="text">Home Care</div></a></li>
                        <li><a href="shop?categoryId=7" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-7.svg" alt=""></div><div class="text">Noodles & Sauces</div></a></li>
                        <li><a href="shop?categoryId=8" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-8.svg" alt=""></div><div class="text">Personal Care</div></a></li>
                        <li><a href="shop?categoryId=9" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-9.svg" alt=""></div><div class="text">Pet Care</div></a></li>
                        <li><a href="shop?categoryId=10" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-10.svg" alt=""></div><div class="text">Meat & Seafood</div></a></li>
                        <li><a href="shop?categoryId=11" class="single-cat-item"><div class="icon"><img src="User/images/category/icon-11.svg" alt=""></div><div class="text">Electronics</div></a></li>
                    </ul>
                    <a href="shop" class="morecate-btn"><i class="uil uil-apps"></i>More Categories</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Category Model End-->
    
    <!-- Search Model Start-->
    <div id="search_model" class="header-cate-model main-gambo-model modal fade" tabindex="-1" role="dialog" aria-modal="false">
        <div class="modal-dialog search-ground-area" role="document">
            <div class="category-area-inner">
                <div class="modal-header">
                    <button type="button" class="close btn-close" data-dismiss="modal" aria-label="Close">
                        <i class="uil uil-multiply"></i>
                    </button>
                </div>
                <div class="category-model-content modal-content"> 
                    <div class="search-header">
                        <form action="shop" method="get">
                            <input type="search" name="search" placeholder="Search for products..." value="${search}">
                            <button type="submit"><i class="uil uil-search"></i></button>
                        </form>
                    </div>
                    <div class="search-by-cat">
                        <a href="shop?categoryId=1" class="single-cat"><div class="icon"><img src="User/images/category/icon-1.svg" alt=""></div><div class="text">Vegetables & Fruits</div></a>
                        <a href="shop?categoryId=2" class="single-cat"><div class="icon"><img src="User/images/category/icon-2.svg" alt=""></div><div class="text">Grocery & Staples</div></a>
                        <a href="shop?categoryId=3" class="single-cat"><div class="icon"><img src="User/images/category/icon-3.svg" alt=""></div><div class="text">Dairy & Eggs</div></a>
                        <a href="shop?categoryId=4" class="single-cat"><div class="icon"><img src="User/images/category/icon-4.svg" alt=""></div><div class="text">Beverages</div></a>
                        <a href="shop?categoryId=5" class="single-cat"><div class="icon"><img src="User/images/category/icon-5.svg" alt=""></div><div class="text">Snacks</div></a>
                        <a href="shop?categoryId=6" class="single-cat"><div class="icon"><img src="User/images/category/icon-6.svg" alt=""></div><div class="text">Home Care</div></a>
                        <a href="shop?categoryId=7" class="single-cat"><div class="icon"><img src="User/images/category/icon-7.svg" alt=""></div><div class="text">Noodles & Sauces</div></a>
                        <a href="shop?categoryId=8" class="single-cat"><div class="icon"><img src="User/images/category/icon-8.svg" alt=""></div><div class="text">Personal Care</div></a>
                        <a href="shop?categoryId=9" class="single-cat"><div class="icon"><img src="User/images/category/icon-9.svg" alt=""></div><div class="text">Pet Care</div></a>
                        <a href="shop?categoryId=10" class="single-cat"><div class="icon"><img src="User/images/category/icon-10.svg" alt=""></div><div class="text">Meat & Seafood</div></a>
                        <a href="shop?categoryId=11" class="single-cat"><div class="icon"><img src="User/images/category/icon-11.svg" alt=""></div><div class="text">Electronics</div></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Search Model End-->
    
    <!-- Cart Sidebar Offcanvas Start-->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
        <div class="offcanvas-header bs-canvas-header side-cart-header p-3">
            <div class="d-inline-block main-cart-title" id="offcanvasRightLabel">My Cart <span>(2 Items)</span></div>
            <button type="button" class="close-btn" data-bs-dismiss="offcanvas" aria-label="Close">
                <i class="uil uil-multiply"></i>
            </button>
        </div>
        <div class="offcanvas-body p-0">
            <div class="cart-top-total p-4">
                <div class="cart-total-dil">
                    <h4>FMart Super Market</h4>
                    <span>$34</span>
                </div>
                <div class="cart-total-dil pt-2">
                    <h4>Delivery Charges</h4>
                    <span>$1</span>
                </div>
            </div>
            <div class="side-cart-items">
                <div class="cart-item">
                    <div class="cart-product-img">
                        <img src="User/images/product/img-1.jpg" alt="">
                        <div class="offer-badge">6% OFF</div>
                    </div>
                    <div class="cart-text">
                        <h4>Product Title Here</h4>
                        <div class="qty-group">
                            <div class="quantity buttons_added">
                                <input type="button" value="-" class="minus minus-btn">
                                <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                <input type="button" value="+" class="plus plus-btn">
                            </div>
                            <div class="cart-item-price">$10 <span>$15</span></div>
                        </div>
                        <button type="button" class="cart-close-btn"><i class="uil uil-multiply"></i></button>
                    </div>
                </div>
            </div>
        </div>
        <div class="offcanvas-footer">
            <div class="cart-total-dil saving-total ">
                <h4>Total Saving</h4>
                <span>$11</span>
            </div>
            <div class="main-total-cart">
                <h2>Total</h2>
                <span>$35</span>
            </div>
            <div class="checkout-cart">
                <a href="#" class="promo-code">Have a promocode?</a>
                <a href="checkout.jsp" class="cart-checkout-btn hover-btn">Proceed to Checkout</a>
            </div>
        </div>
    </div>	
    <!-- Cart Sidebar Offcanvas End-->
    
    <!-- Header Start -->
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="cart_sidebar.jsp"></jsp:include>
    <!-- Header End -->
    
    <!-- Body Start -->
    <div class="wrapper">
        <div class="gambo-Breadcrumb">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                                <c:choose>
                                    <c:when test="${currentCategory != null}">
                                        <li class="breadcrumb-item active" aria-current="page">${currentCategory.categoryName}</li>
                                    </c:when>
                                    <c:when test="${not empty search}">
                                        <li class="breadcrumb-item active" aria-current="page">Search: ${search}</li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="breadcrumb-item active" aria-current="page">All Products</li>
                                    </c:otherwise>
                                </c:choose>
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
                        <div class="product-top-dt">
                            <div class="product-left-title">
                                <h2>${pageTitle != null ? pageTitle : 'All Products'}</h2>
                                <c:if test="${totalProducts != null}">
                                    <p class="text-muted">Found ${totalProducts} products</p>
                                </c:if>
                            </div>
                            
                            <!-- Enhanced Filter & Sort Controls - Now Right Aligned -->
                            <div class="product-controls">
                                <!-- Sort Dropdown -->
                                <div class="sort-dropdown">
                                    <button class="sort-btn" onclick="toggleSortDropdown()">
                                        <i class="fas fa-sort"></i> 
                                        <span id="current-sort">
                                            <c:choose>
                                                <c:when test="${sortBy == 'price_asc'}">Price: Low to High</c:when>
                                                <c:when test="${sortBy == 'price_desc'}">Price: High to Low</c:when>
                                                <c:when test="${sortBy == 'name_asc'}">Name A-Z</c:when>
                                                <c:when test="${sortBy == 'name_desc'}">Name Z-A</c:when>
                                                <c:when test="${sortBy == 'newest'}">Newest First</c:when>
                                                <c:when test="${sortBy == 'discount'}">Highest Discount</c:when>
                                                <c:otherwise>Popularity</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <i class="fas fa-chevron-down"></i>
                                    </button>
                                    <div class="sort-dropdown-content">
                                        <div class="sort-option ${empty sortBy ? 'active' : ''}" onclick="applySorting('')">Popularity</div>
                                        <div class="sort-option ${sortBy == 'price_asc' ? 'active' : ''}" onclick="applySorting('price_asc')">Price: Low to High</div>
                                        <div class="sort-option ${sortBy == 'price_desc' ? 'active' : ''}" onclick="applySorting('price_desc')">Price: High to Low</div>
                                        <div class="sort-option ${sortBy == 'name_asc' ? 'active' : ''}" onclick="applySorting('name_asc')">Name A-Z</div>
                                        <div class="sort-option ${sortBy == 'name_desc' ? 'active' : ''}" onclick="applySorting('name_desc')">Name Z-A</div>
                                        <div class="sort-option ${sortBy == 'newest' ? 'active' : ''}" onclick="applySorting('newest')">Newest First</div>
                                        <div class="sort-option ${sortBy == 'discount' ? 'active' : ''}" onclick="applySorting('discount')">Highest Discount</div>
                                    </div>
                                </div>
                                
                                <!-- Filter Dropdown -->
                                <div class="filter-dropdown">
                                    <button class="filter-btn" onclick="toggleFilterDropdown()">
                                        <i class="fas fa-filter"></i> Filters
                                        <c:if test="${not empty categoryId or not empty minPrice or not empty maxPrice or not empty search}">
                                            <span class="badge badge-primary">●</span>
                                        </c:if>
                                    </button>
                                    <div class="filter-dropdown-content">
                                        <!-- Category Filter -->
                                        <div class="filter-section">
                                            <h6>Categories</h6>
                                            <div class="category-filter">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="filterCategory" id="cat-all" value="" ${empty categoryId ? 'checked' : ''}>
                                                    <label class="form-check-label" for="cat-all">All Categories</label>
                                                </div>
                                                <c:forEach var="category" items="${categories}">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="filterCategory" 
                                                               id="cat-${category.categoryID}" value="${category.categoryID}"
                                                               ${categoryId == category.categoryID ? 'checked' : ''}>
                                                        <label class="form-check-label" for="cat-${category.categoryID}">
                                                            ${category.categoryName}
                                                            <c:if test="${categoryProductCount[category.categoryID] != null}">
                                                                <small class="text-muted">(${categoryProductCount[category.categoryID]})</small>
                                                            </c:if>
                                                        </label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        
                                        <!-- Price Filter -->
                                        <div class="filter-section">
                                            <h6>Price Range</h6>
                                            <div class="price-range-inputs">
                                                <input type="number" id="filter-min-price" placeholder="Min ($)" 
                                                       value="${minPrice}" min="0" step="0.01">
                                                <input type="number" id="filter-max-price" placeholder="Max ($)" 
                                                       value="${maxPrice}" min="0" step="0.01">
                                            </div>
                                            <div class="quick-price-filters">
                                                <button type="button" class="quick-price-btn" onclick="setQuickPrice(0, 2)">Under $2</button>
                                                <button type="button" class="quick-price-btn" onclick="setQuickPrice(2, 5)">$2 - $5</button>
                                                <button type="button" class="quick-price-btn" onclick="setQuickPrice(5, 10)">$5 - $10</button>
                                                <button type="button" class="quick-price-btn" onclick="setQuickPrice(10, 20)">$10 - $20</button>
                                                <button type="button" class="quick-price-btn" onclick="setQuickPrice(20, 999)">$20+</button>
                                            </div>
                                        </div>
                                        
                                        <!-- Filter Buttons -->
                                        <button class="apply-filters-btn" onclick="applyFilters()">Apply Filters</button>
                                        <button class="clear-filters-btn" onclick="clearAllFilters()">Clear All</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="product-list-view">
                    <div class="row">
                        <!-- Products from servlet -->
                        <c:forEach var="product" items="${products}">
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product?productId=${product.productID}" class="product-img">
                                        <img src="User/images/product/img-${(product.productID ) }.jpg" alt="${product.productName}">
                                        <div class="product-absolute-options">
                                            <c:if test="${product.costPrice > 0 && product.sellingPrice < product.costPrice}">
                                                <c:set var="discount" value="${((product.costPrice - product.sellingPrice) / product.costPrice) * 100}"/>
                                                <span class="offer-badge-1"><fmt:formatNumber value="${discount}" maxFractionDigits="0"/>% off</span>
                                            </c:if>
                                            <span class="like-icon" title="wishlist" onclick="addToWishlist(${product.productID})"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>
                                            <c:choose>
                                                <c:when test="${product.minStockLevel > 0}">
                                                    Available<span>(In Stock)</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-danger">Out of Stock</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <h4>${product.productName}</h4>
                                        <c:if test="${not empty product.description}">
                                            <p class="product-desc small text-muted">
                                                <c:choose>
                                                    <c:when test="${fn:length(product.description) > 60}">
                                                        ${fn:substring(product.description, 0, 60)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${product.description}
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </c:if>
                                        <div class="product-price">
                                            $<fmt:formatNumber value="${product.sellingPrice}" maxFractionDigits="2"/>
                                            <c:if test="${product.costPrice > 0 && product.sellingPrice < product.costPrice}">
                                                <span>$<fmt:formatNumber value="${product.costPrice}" maxFractionDigits="2"/></span>
                                            </c:if>
                                        </div>
                                        <div class="qty-cart">
                                            <c:if test="${product.minStockLevel > 0}">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text" min="1">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon" onclick="addToCart(${product.productID})">
                                                    <i class="uil uil-shopping-cart-alt"></i>
                                                </span>
                                            </c:if>
                                            <c:if test="${product.minStockLevel <= 0}">
                                                <span class="text-muted">Out of Stock</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <!-- No products message -->
                        <c:if test="${empty products}">
                            <div class="col-12">
                                <div class="text-center py-5">
                                    <i class="uil uil-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                    <h4 class="mt-3 text-muted">No products found</h4>
                                    <p class="text-muted">
                                        <c:choose>
                                            <c:when test="${not empty search}">
                                                Try searching with different keywords or <a href="shop">view all products</a>
                                            </c:when>
                                            <c:when test="${currentCategory != null}">
                                                This category doesn't have any products yet. <a href="shop">View all products</a>
                                            </c:when>
                                            <c:otherwise>
                                                No products available at the moment.
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                        </c:if>
                        
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="col-md-12">
                                <div class="more-product-btn">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-center">
                                            <!-- Previous button -->
                                            <c:if test="${currentPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="javascript:void(0)" onclick="goToPage(${currentPage - 1})" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                            
                                            <!-- Page numbers -->
                                            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                                <c:if test="${pageNum == currentPage}">
                                                    <li class="page-item active">
                                                        <span class="page-link">${pageNum}</span>
                                                    </li>
                                                </c:if>
                                                <c:if test="${pageNum != currentPage}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="javascript:void(0)" onclick="goToPage(${pageNum})">${pageNum}</a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>
                                            
                                            <!-- Next button -->
                                            <c:if test="${currentPage < totalPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="javascript:void(0)" onclick="goToPage(${currentPage + 1})" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Body End -->
    
    <!-- Footer Start -->
    <jsp:include page="footer.jsp"></jsp:include>
    <!-- Footer End -->

    <!-- Javascripts -->
    <script src="User/js/jquery.min.js"></script>
    <script src="User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="User/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
    <script src="User/vendor/OwlCarousel/owl.carousel.js"></script>
    <script src="User/js/jquery.countdown.min.js"></script>
    <script src="User/js/custom.js"></script>
    <script src="User/js/offset_overlay.js"></script>
    <script src="User/js/night-mode.js"></script>
    
    <script>
        // ============= ENHANCED FILTERING & SORTING FUNCTIONALITY =============
        
        // Toggle Sort Dropdown
        function toggleSortDropdown() {
            var dropdown = document.querySelector('.sort-dropdown');
            var filterDropdown = document.querySelector('.filter-dropdown');
            
            // Close filter dropdown if open
            filterDropdown.classList.remove('show');
            
            dropdown.classList.toggle('show');
        }
        
        // Toggle Filter Dropdown
        function toggleFilterDropdown() {
            var dropdown = document.querySelector('.filter-dropdown');
            var sortDropdown = document.querySelector('.sort-dropdown');
            
            // Close sort dropdown if open
            sortDropdown.classList.remove('show');
            
            dropdown.classList.toggle('show');
        }
        
        // Apply Sorting
        function applySorting(sortValue) {
            var url = new URL(window.location);
            
            if (sortValue) {
                url.searchParams.set('sortBy', sortValue);
            } else {
                url.searchParams.delete('sortBy');
            }
            
            url.searchParams.set('page', '1'); // Reset to first page
            window.location.href = url.toString();
        }
        
        // Set Quick Price Range
        function setQuickPrice(min, max) {
            // Remove active class from all quick price buttons
            var quickPriceBtns = document.querySelectorAll('.quick-price-btn');
            for (var i = 0; i < quickPriceBtns.length; i++) {
                quickPriceBtns[i].classList.remove('active');
            }
            
            // Add active class to clicked button
            event.target.classList.add('active');
            
            // Set price inputs
            document.getElementById('filter-min-price').value = min > 0 ? min : '';
            document.getElementById('filter-max-price').value = max < 999 ? max : '';
        }
        
        // Apply Filters
        function applyFilters() {
            var url = new URL(window.location);
            
            // Get selected category
            var selectedCategory = document.querySelector('input[name="filterCategory"]:checked');
            if (selectedCategory && selectedCategory.value) {
                url.searchParams.set('categoryId', selectedCategory.value);
            } else {
                url.searchParams.delete('categoryId');
            }
            
            // Get price range
            var minPrice = document.getElementById('filter-min-price').value;
            var maxPrice = document.getElementById('filter-max-price').value;
            
            if (minPrice) {
                url.searchParams.set('minPrice', minPrice);
            } else {
                url.searchParams.delete('minPrice');
            }
            
            if (maxPrice) {
                url.searchParams.set('maxPrice', maxPrice);
            } else {
                url.searchParams.delete('maxPrice');
            }
            
            // Reset to first page
            url.searchParams.set('page', '1');
            
            // Apply filters
            window.location.href = url.toString();
        }
        
        // Clear All Filters
        function clearAllFilters() {
            var url = new URL(window.location);
            
            // Remove all filter parameters
            url.searchParams.delete('categoryId');
            url.searchParams.delete('minPrice');
            url.searchParams.delete('maxPrice');
            url.searchParams.delete('search');
            url.searchParams.delete('sortBy');
            url.searchParams.set('page', '1');
            
            window.location.href = url.toString();
        }
        
        // Pagination
        function goToPage(page) {
            var url = new URL(window.location);
            url.searchParams.set('page', page);
            window.location.href = url.toString();
        }
        
        // ============= PRODUCT INTERACTION =============
        
        // Add to Cart
        function addToCart(productId) {
            var quantityInput = event.target.closest('.product-item').querySelector('input[name="quantity"]');
            var quantity = quantityInput ? quantityInput.value : 1;
            
            // Show loading state
            var cartIcon = event.target.closest('.cart-icon');
            var originalContent = cartIcon.innerHTML;
            cartIcon.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            
            // Simulate API call - replace with actual cart functionality
            setTimeout(function() {
                cartIcon.innerHTML = originalContent;
                showNotification('Added ' + quantity + ' item(s) to cart!', 'success');
            }, 500);
        }
        
        // Add to Wishlist
        function addToWishlist(productId) {
            var heartIcon = event.target;
            
            // Toggle heart state
            if (heartIcon.style.color === 'rgb(233, 30, 99)') {
                heartIcon.style.color = '';
                showNotification('Removed from wishlist', 'info');
            } else {
                heartIcon.style.color = '#e91e63';
                showNotification('Added to wishlist!', 'success');
            }
        }
        
        // Show Notification
        function showNotification(message, type) {
            // Remove existing notifications
            var existingNotifications = document.querySelectorAll('.toast-notification');
            for (var i = 0; i < existingNotifications.length; i++) {
                existingNotifications[i].remove();
            }
            
            // Create new notification
            var notification = document.createElement('div');
            var alertType = type === 'success' ? 'success' : type === 'info' ? 'info' : 'primary';
            notification.className = 'alert alert-' + alertType + ' alert-dismissible fade show position-fixed toast-notification';
            notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);';
            
            var icon = type === 'success' ? 'check-circle' : type === 'info' ? 'info-circle' : 'shopping-cart';
            notification.innerHTML = 
                '<i class="fas fa-' + icon + ' me-2"></i>' +
                message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
            
            document.body.appendChild(notification);
            
            // Auto remove after 3 seconds
            setTimeout(function() {
                if (notification.parentNode) {
                    notification.remove();
                }
            }, 3000);
        }
        
        // ============= QUANTITY CONTROLS =============
        
        document.addEventListener('click', function(e) {
            // Plus button
            if (e.target.classList.contains('plus-btn')) {
                const input = e.target.previousElementSibling;
                const currentValue = parseInt(input.value) || 1;
                input.value = currentValue + 1;
            }
            
            // Minus button
            if (e.target.classList.contains('minus-btn')) {
                const input = e.target.nextElementSibling;
                const currentValue = parseInt(input.value) || 1;
                if (currentValue > 1) {
                    input.value = currentValue - 1;
                }
            }
        });
        
        // ============= INITIALIZATION =============
        
        // Close dropdowns when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.sort-dropdown') && !e.target.closest('.filter-dropdown')) {
                document.querySelector('.sort-dropdown').classList.remove('show');
                document.querySelector('.filter-dropdown').classList.remove('show');
            }
        });
        
        // Initialize price range highlighting
        document.addEventListener('DOMContentLoaded', function() {
            var minPrice = parseFloat('${minPrice}') || 0;
            var maxPrice = parseFloat('${maxPrice}') || 999;
            
            // Highlight active price range button
            var quickPriceBtns = document.querySelectorAll('.quick-price-btn');
            for (var i = 0; i < quickPriceBtns.length; i++) {
                var btn = quickPriceBtns[i];
                var onClick = btn.getAttribute('onclick');
                if (onClick) {
                    var matches = onClick.match(/setQuickPrice\((\d+),\s*(\d+)\)/);
                    if (matches) {
                        var btnMin = parseInt(matches[1]);
                        var btnMax = parseInt(matches[2]);
                        
                        if (minPrice === btnMin && (maxPrice === btnMax || (btnMax === 999 && maxPrice >= 999))) {
                            btn.classList.add('active');
                        }
                    }
                }
            }
            
            console.log('Shop page loaded with enhanced filtering and sorting!');
        });
        
        // ============= KEYBOARD SHORTCUTS =============
        
        document.addEventListener('keydown', function(e) {
            // ESC to close dropdowns
            if (e.key === 'Escape') {
                document.querySelector('.sort-dropdown').classList.remove('show');
                document.querySelector('.filter-dropdown').classList.remove('show');
            }
            
            // Enter to apply filters when in filter inputs
            if (e.key === 'Enter' && (e.target.id === 'filter-min-price' || e.target.id === 'filter-max-price')) {
                applyFilters();
            }
        });
        
    </script>

</body>
</html>