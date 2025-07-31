<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
﻿<!DOCTYPE html>
<html lang="en">
   <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 11:59:29 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <meta name="description" content="Gambolthemes">
        <meta name="author" content="Gambolthemes">		
        <title>FMart - Index</title>

        <!-- Favicon Icon -->
        <link rel="icon" type="image/png" href="User/images/fav.png">

        <!-- Stylesheets -->
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet">
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
                            <li>
                                <a href="shop?categoryId=1" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-1.svg" alt="">
                                    </div>
                                    <div class="text"> Fruits and Vegetables </div>
                                </a>
                            </li>
                            <li>
                                <a href="shop?categoryId=2" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-2.svg" alt="">
                                    </div>
                                    <div class="text"> Grocery & Staples </div>
                                </a>
                            </li>
                            <li>
                                <a href="shop?categoryId=3" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-3.svg" alt="">
                                    </div>
                                    <div class="text"> Dairy & Eggs </div>
                                </a>
                            </li>
                            <li>
                                <a href="shop?categoryId=4" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-4.svg" alt="">
                                    </div>
                                    <div class="text"> Beverages </div>
                                </a>
                            </li>
                            <li>
                                <a href="shop?categoryId=5" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-5.svg" alt="">
                                    </div>
                                    <div class="text"> Snacks </div>
                                </a>
                            </li>
                            <li>
                                <a href="shop?categoryId=6" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-6.svg" alt="">
                                    </div>
                                    <div class="text"> Home Care </div>
                                </a>
                            </li>
                            <li>
                                <a href="shop?categoryId=7" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-7.svg" alt="">
                                    </div>
                                    <div class="text"> Noodles & Sauces </div>
                                </a>
                            </li>
                            <li>
                                <a href="shop?categoryId=8" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-8.svg" alt="">
                                    </div>
                                    <div class="text"> Personal Care </div>
                                </a>
                            </li>
                            <li>
                                <a href="shop?categoryId=9" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-9.svg" alt="">
                                    </div>
                                    <div class="text"> Pet Care </div>
                                </a>
                            </li>
                            <li>
                                <a href="shop?categoryId=10" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-10.svg" alt="">
                                    </div>
                                    <div class="text"> Meat & Seafood </div>
                                </a>
                            </li>
                            <li>
                                <a href="shop?categoryId=11" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-11.svg" alt="">
                                    </div>
                                    <div class="text"> Electronics </div>
                                </a>
                            </li>
                        </ul>
                        <a href="#" class="morecate-btn"><i class="uil uil-apps"></i>More Categories</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Category Model End-->
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
                            <div class="cart-radio">
                                <ul class="kggrm-now">
                                    <li>
                                        <input type="radio" id="a1" name="cart1">
                                        <label for="a1">0.50</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="a2" name="cart1">
                                        <label for="a2">1kg</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="a3" name="cart1">
                                        <label for="a3">2kg</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="a4" name="cart1">
                                        <label for="a4">3kg</label>
                                    </li>
                                </ul>
                            </div>
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
                    <div class="cart-item">
                        <div class="cart-product-img">
                            <img src="User/images/product/img-2.jpg" alt="">
                            <div class="offer-badge">6% OFF</div>
                        </div>
                        <div class="cart-text">
                            <h4>Product Title Here</h4>
                            <div class="cart-radio">
                                <ul class="kggrm-now">
                                    <li>
                                        <input type="radio" id="a5" name="cart2">
                                        <label for="a5">0.50</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="a6" name="cart2">
                                        <label for="a6">1kg</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="a7" name="cart2">
                                        <label for="a7">2kg</label>
                                    </li>
                                </ul>
                            </div>
                            <div class="qty-group">
                                <div class="quantity buttons_added">
                                    <input type="button" value="-" class="minus minus-btn">
                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                    <input type="button" value="+" class="plus plus-btn">
                                </div>
                                <div class="cart-item-price">$24 <span>$30</span></div>
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
        <!-- Header End -->
        <!-- Body Start -->
        <div class="wrapper">
            <!-- Offers Start -->
            <div class="main-banner-slider">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="owl-carousel offers-banner owl-theme">
                                <div class="item">
                                    <div class="offer-item">								
                                        <div class="offer-item-img">
                                            <div class="gambo-overlay"></div>
                                            <img src="User/images/banners/offer-1.jpg" alt="">
                                        </div>
                                        <div class="offer-text-dt">
                                            <div class="offer-top-text-banner">
                                                <p>6% Off</p>
                                                <div class="top-text-1">Buy More & Save More</div>
                                                <span>Fresh Vegetables</span>
                                            </div>
                                            <a href="shop" class="Offer-shop-btn hover-btn">Shop Now</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="offer-item">								
                                        <div class="offer-item-img">
                                            <div class="gambo-overlay"></div>
                                            <img src="User/images/banners/offer-2.jpg" alt="">
                                        </div>
                                        <div class="offer-text-dt">
                                            <div class="offer-top-text-banner">
                                                <p>5% Off</p>
                                                <div class="top-text-1">Buy More & Save More</div>
                                                <span>Fresh Fruits</span>
                                            </div>
                                            <a href="shop" class="Offer-shop-btn hover-btn">Shop Now</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="offer-item">								
                                        <div class="offer-item-img">
                                            <div class="gambo-overlay"></div>
                                            <img src="User/images/banners/offer-3.jpg" alt="">
                                        </div>
                                        <div class="offer-text-dt">
                                            <div class="offer-top-text-banner">
                                                <p>3% Off</p>
                                                <div class="top-text-1">Hot Deals on New Items</div>
                                                <span>Daily Essentials Eggs & Dairy</span>
                                            </div>
                                            <a href="shop" class="Offer-shop-btn hover-btn">Shop Now</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="offer-item">								
                                        <div class="offer-item-img">	
                                            <div class="gambo-overlay"></div>
                                            <img src="User/images/banners/offer-4.jpg" alt="">
                                        </div>
                                        <div class="offer-text-dt">
                                            <div class="offer-top-text-banner">
                                                <p>2% Off</p>
                                                <div class="top-text-1">Buy More & Save More</div>
                                                <span>Beverages</span>
                                            </div>
                                            <a href="shop" class="Offer-shop-btn hover-btn">Shop Now</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="offer-item">								
                                        <div class="offer-item-img">
                                            <div class="gambo-overlay"></div>
                                            <img src="User/images/banners/offer-5.jpg" alt="">
                                        </div>
                                        <div class="offer-text-dt">
                                            <div class="offer-top-text-banner">
                                                <p>3% Off</p>
                                                <div class="top-text-1">Buy More & Save More</div>
                                                <span>Nuts & Snacks</span>
                                            </div>
                                            <a href="shop" class="Offer-shop-btn hover-btn">Shop Now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Offers End -->
            <!-- Categories Start -->
            <div class="section145">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="main-title-tt">
                                <div class="main-title-left">
                                    <span>Shop By</span>
                                    <h2>Categories</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="owl-carousel cate-slider owl-theme">
                                <div class="item">
                                   <a href="shop?categoryId=1" class="category-item">  <!-- cho Vegetables & Fruits -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-1.svg" alt="">
                                        </div>
                                        <h4>Vegetables & Fruits</h4>
                                    </a>
                                </div>
                                <div class="item">
                                   <a href="shop?categoryId=2" class="category-item">  <!-- cho Grocery & Staples -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-2.svg" alt="">
                                        </div>
                                        <h4> Grocery & Staples </h4>
                                    </a>
                                </div>
                                <div class="item">
                                    <a href="shop?categoryId=3" class="category-item">  <!-- cho Dairy & Eggs -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-3.svg" alt="">
                                        </div>
                                        <h4> Dairy & Eggs </h4>
                                    </a>
                                </div>
                                <div class="item">
                                    <a href="shop?categoryId=4" class="category-item">  <!-- cho Beverages -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-4.svg" alt="">
                                        </div>
                                        <h4> Beverages </h4>
                                    </a>
                                </div>
                                <div class="item">
                                    <a href="shop?categoryId=5" class="category-item">  <!-- cho Snacks -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-5.svg" alt="">
                                        </div>
                                        <h4> Snacks </h4>
                                    </a>
                                </div>
                                <div class="item">
                                    <a href="shop?categoryId=6" class="category-item">  <!-- cho Home Care -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-6.svg" alt="">
                                        </div>
                                        <h4> Home Care </h4>
                                    </a>
                                </div>
                                <div class="item">
                                   <a href="shop?categoryId=7" class="category-item">  <!-- cho Noodles & Sauces -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-7.svg" alt="">
                                        </div>
                                        <h4> Noodles & Sauces </h4>
                                    </a>
                                </div>
                                <div class="item">
                                    <a href="shop?categoryId=8" class="category-item">  <!-- cho Personal Care -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-8.svg" alt="">
                                        </div>
                                        <h4> Personal Care </h4>
                                    </a>
                                </div>
                                <div class="item">
                                    <a href="shop?categoryId=9" class="category-item">  <!-- cho Pet Care -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-9.svg" alt="">
                                        </div>
                                        <h4> Pet Care </h4>
                                    </a>
                                </div>
                                <div class="item">
                                    <a href="shop?categoryId=10" class="category-item"> <!-- cho Meat & Seafood -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-10.svg" alt="">
                                        </div>
                                        <h4> Meat & Seafood </h4>
                                    </a>
                                </div>
                                <div class="item">
                                    <a href="shop?categoryId=11" class="category-item"> <!-- cho Electronics -->
                                        <div class="cate-img">
                                            <img src="User/images/category/icon-11.svg" alt="">
                                        </div>
                                        <h4> Electronics </h4>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Categories End -->
            <!-- Featured Products Start -->
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
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=22" class="product-img">
                                            <img src="User/images/product/img-22.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">6% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Acecook Hảo Hảo Shrimp </h4>
                                            <div class="product-price">12,250  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=41" class="product-img">
                                            <img src="User/images/product/img-41.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">2% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Vinamilk Fresh Milk</h4>
                                            <div class="product-price">87,250  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=82" class="product-img">
                                            <img src="User/images/product/img-82.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">5% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Mars Snickers Bar</h4>
                                            <div class="product-price">49,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=117" class="product-img">
                                            <img src="User/images/product/img-117.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">3% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>FMart Facial Tissue</h4>
                                            <div class="product-price">74,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=150" class="product-img">
                                            <img src="User/images/product/img-150.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">2% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Unilever Clear Shampoo</h4>
                                            <div class="product-price">199,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=210" class="product-img">
                                            <img src="User/images/product/img-210.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">2% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>FMart Bluetooth Earbuds</h4>
                                            <div class="product-price">999,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=181" class="product-img">
                                            <img src="User/images/product/img-181.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">1% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Vissan Fresh Chicken Breast</h4>
                                            <div class="product-price">324,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=59" class="product-img">
                                            <img src="User/images/product/img-59.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">3% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Nutifood Strawberry Yogurt</h4>
                                            <div class="product-price">132.250 ₫  <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Featured Products End -->
            <!-- Best Values Offers Start -->
            <div class="section145">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="main-title-tt">
                                <div class="main-title-left">
                                    <span>Offers</span>
                                    <h2>Best Values</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <a href="#" class="best-offer-item">
                                <img src="User/images/best-offers/offer-1.jpg" alt="">
                            </a>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <a href="#" class="best-offer-item">
                                <img src="User/images/best-offers/offer-2.jpg" alt="">
                            </a>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <a href="#" class="best-offer-item offr-none">
                                <img src="User/images/best-offers/offer-3.jpg" alt="">
                                <div class="cmtk_dt">
                                    <div class="product_countdown-timer offer-counter-text" data-countdown="2022/08/09"></div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-12">
                            <a href="#" class="code-offer-item">
                                <img src="User/images/best-offers/offer-4.jpg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Best Values Offers End -->
            <!-- Vegetables and Fruits Start -->
            <div class="section145">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="main-title-tt">
                                <div class="main-title-left">
                                    <span>For You</span>
                                    <h2>Fresh Vegetables & Fruits</h2>
                                </div>
                                <a href="shop" class="see-more-btn">See All</a>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="owl-carousel featured-slider owl-theme">
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=18" class="product-img">
                                            <img src="User/images/product/img-18.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">6% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Fresh Strawberries</h4>
                                            <div class="product-price">62,250  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=12" class="product-img">
                                            <img src="User/images/product/img-12.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">2% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Fresh Tomatoes</h4>
                                            <div class="product-price">62,250  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=13" class="product-img">
                                            <img src="User/images/product/img-13.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">5% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Fresh Carrots</h4>
                                            <div class="product-price">44,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=1" class="product-img">
                                            <img src="User/images/product/img-1.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">3% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Fresh Spinach</h4>
                                            <div class="product-price">49.750  ₫  <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=5" class="product-img">
                                            <img src="User/images/product/img-5.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">2% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Fresh Dragon Fruit</h4>
                                            <div class="product-price">99,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=6" class="product-img">
                                            <img src="User/images/product/img-6.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">2% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Fresh Pineapple</h4>
                                            <div class="product-price">82,250  ₫<span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=14" class="product-img">
                                            <img src="User/images/product/img-14.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">1% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Fresh Bananas</h4>
                                            <div class="product-price">49,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=3" class="product-img">
                                            <img src="User/images/product/img-3.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">3% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Fresh Lettuce</h4>
                                            <div class="product-price">49,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Vegetables and Fruits Products End -->
            <!-- New Products Start -->
            <div class="section145">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="main-title-tt">
                                <div class="main-title-left">
                                    <span>For You</span>
                                    <h2> New Products</h2>
                                </div>
                                <a href="shop" class="see-more-btn">See All</a>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="owl-carousel featured-slider owl-theme">
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=218" class="product-img">
                                            <img src="User/images/product/img-218.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">New</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>FMart Phone Holder</h4>
                                            <div class="product-price">199,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=205" class="product-img">
                                            <img src="User/images/product/img-205.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">New</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>FMart Wireless Mouse</h4>
                                            <div class="product-price">499,750  ₫</div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=171" class="product-img">
                                            <img src="User/images/product/img-171.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">5% off</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>FMart Pet Shampoo</h4>
                                            <div class="product-price">224.750  ₫</div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=110" class="product-img">
                                            <img src="User/images/product/img-110.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">New</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Unilever Cif Glass Cleaner</h4>
                                            <div class="product-price">124,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=73" class="product-img">
                                            <img src="User/images/product/img-73.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">New</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Coca-Cola Coke Zero </h4>
                                            <div class="product-price">74,750  ₫</div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=89" class="product-img">
                                            <img src="User/images/product/img-89.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">New</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>PepsiCo Lay’s Salt</h4>
                                            <div class="product-price">99.750  ₫</div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=119" class="product-img">	
                                            <img src="User/images/product/img-119.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">New</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Unilever Sunlight Dishwashing</h4>
                                            <div class="product-price">99,750  ₫</div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="product-item">
                                        <a href="http://localhost:8080/Supermarket_FMart/single_product?productId=166" class="product-img">
                                            <img src="User/images/product/img-166.jpg" alt="">
                                            <div class="product-absolute-options">
                                                <span class="offer-badge-1">New</span>
                                                <span class="like-icon" title="wishlist"></span>
                                            </div>
                                        </a>
                                        <div class="product-text-dt">
                                            <p>Available<span>(In Stock)</span></p>
                                            <h4>Mars Whiskas Cat Treats</h4>
                                            <div class="product-price">124,750  ₫ <span></span></div>
                                            <div class="qty-cart">
                                                <div class="quantity buttons_added">
                                                    <input type="button" value="-" class="minus minus-btn">
                                                    <input type="number" step="1" name="quantity" value="1" class="input-text qty text">
                                                    <input type="button" value="+" class="plus plus-btn">
                                                </div>
                                                <span class="cart-icon"><i class="uil uil-shopping-cart-alt"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- New Products End -->
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


    </body>

    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:00:03 GMT -->
</html>