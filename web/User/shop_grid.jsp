<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
﻿<!DOCTYPE html>
<html lang="en">


    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/shop_grid.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:14 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <meta name="description" content="Gambolthemes">
        <meta name="author" content="Gambolthemes">		
        <title>FMart - Shop Grid</title>

        <!-- Favicon Icon -->
        <link rel="icon" type="image/png" href="images/fav.png">

        <!-- Stylesheets -->
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet">
        <link href='vendor/unicons-2.0.1/css/unicons.css' rel='stylesheet'>
        <link href="css/style.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <link href="css/night-mode.css" rel="stylesheet">

        <!-- Vendor Stylesheets -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
        <link href="vendor/OwlCarousel/assets/owl.theme.default.min.css" rel="stylesheet">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">

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
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="images/category/icon-1.svg" alt="">
                                    </div>
                                    <div class="text"> Fruits and Vegetables </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="images/category/icon-2.svg" alt="">
                                    </div>
                                    <div class="text"> Grocery & Staples </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="images/category/icon-3.svg" alt="">
                                    </div>
                                    <div class="text"> Dairy & Eggs </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="images/category/icon-4.svg" alt="">
                                    </div>
                                    <div class="text"> Beverages </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="images/category/icon-5.svg" alt="">
                                    </div>
                                    <div class="text"> Snacks </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="images/category/icon-6.svg" alt="">
                                    </div>
                                    <div class="text"> Home Care </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="images/category/icon-7.svg" alt="">
                                    </div>
                                    <div class="text"> Noodles & Sauces </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="images/category/icon-8.svg" alt="">
                                    </div>
                                    <div class="text"> Personal Care </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="images/category/icon-9.svg" alt="">
                                    </div>
                                    <div class="text"> Pet Care </div>
                                </a>
                            </li>
                        </ul>
                        <a href="#" class="morecate-btn"><i class="uil uil-apps"></i>More Categories</a>
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
                            <form action="#">
                                <input type="search" placeholder="Search for products...">
                                <button type="submit"><i class="uil uil-search"></i></button>
                            </form>
                        </div>
                        <div class="search-by-cat">
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="images/category/icon-1.svg" alt="">
                                </div>
                                <div class="text">
                                    Fruits and Vegetables
                                </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="images/category/icon-2.svg" alt="">
                                </div>
                                <div class="text"> Grocery & Staples </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="images/category/icon-3.svg" alt="">
                                </div>
                                <div class="text"> Dairy & Eggs </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="images/category/icon-4.svg" alt="">
                                </div>
                                <div class="text"> Beverages </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="images/category/icon-5.svg" alt="">
                                </div>
                                <div class="text"> Snacks </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="images/category/icon-6.svg" alt="">
                                </div>
                                <div class="text"> Home Care </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="images/category/icon-7.svg" alt="">
                                </div>
                                <div class="text"> Noodles & Sauces </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="images/category/icon-8.svg" alt="">
                                </div>
                                <div class="text"> Personal Care </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="images/category/icon-9.svg" alt="">
                                </div>
                                <div class="text"> Pet Care </div>
                            </a>
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
                            <img src="images/product/img-1.jpg" alt="">
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
                            <img src="images/product/img-2.jpg" alt="">
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
        <!-- Filter Sidebar Offcanvas Start-->
        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasFilter" aria-labelledby="offcanvasFilterLabel">
            <div class="offcanvas-header bs-canvas-header side-cart-header p-3">
                <div class="d-inline-block main-cart-title" id="offcanvasFilterLabel">Filter</div>
                <button type="button" class="close-btn" data-bs-dismiss="offcanvas" aria-label="Close">
                    <i class="uil uil-multiply"></i>
                </button>
            </div>
            <div class="offcanvas-body p-0">
                <div class="filter-items">
                    <div class="filtr-cate-title">
                        <h4>Categories</h4>
                    </div>
                    <div class="filter-item-body scrollstyle_4">
                        <div class="cart-radio">
                            <ul class="cte-select">
                                <li>
                                    <input type="radio" id="c1" name="category1">
                                    <label for="c1">All</label>
                                </li>
                                <li>
                                    <input type="radio" id="c2" name="category1" checked>
                                    <label for="c2">Vegetables & Fruits</label>
                                </li>
                                <li>
                                    <input type="radio" id="c3" name="category1">
                                    <label for="c3">Grocery & Staples</label>
                                </li>
                                <li>
                                    <input type="radio" id="c4" name="category1">
                                    <label for="c4">Dairy & Eggs</label>
                                </li>
                                <li>
                                    <input type="radio" id="c5" name="category1">
                                    <label for="c5">Beverages</label>
                                </li>
                                <li>
                                    <input type="radio" id="c6" name="category1">
                                    <label for="c6">Snacks</label>
                                </li>
                                <li>
                                    <input type="radio" id="c7" name="category1">
                                    <label for="c7">Home Care</label>
                                </li>
                                <li>
                                    <input type="radio" id="c8" name="category1">
                                    <label for="c8">Noodles & Sauces</label>
                                </li>
                                <li>
                                    <input type="radio" id="c9" name="category1">
                                    <label for="c9">Personal Care</label>
                                </li>
                                <li>
                                    <input type="radio" id="c10" name="category1">
                                    <label for="c10">Pat Care</label>
                                </li>
                                <li>
                                    <input type="radio" id="c11" name="category1">
                                    <label for="c11">Mea & Seafood</label>
                                </li>
                                <li>
                                    <input type="radio" id="c12" name="category1">
                                    <label for="c12">Electronics</label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="filter-items">
                    <div class="filtr-cate-title">
                        <h4>Brand</h4>
                    </div>
                    <div class="other-item-body scrollstyle_4">
                        <div class="brand-list">
                            <div class="search-by-catgory">
                                <div class="ui search">
                                    <div class="ui left icon input swdh10 position-relative">
                                        <input class="prompt srch10" type="text" placeholder="Search by brand..">
                                        <i class="uil uil-search icon icon1"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="Brand1">
                                <label class="form-check-label" for="Brand1">
                                    Brand Name
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="Brand2">
                                <label class="form-check-label" for="Brand2">
                                    Brand Name
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="Brand3">
                                <label class="form-check-label" for="Brand3">
                                    Brand Name
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="Brand4">
                                <label class="form-check-label" for="Brand4">
                                    Brand Name
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="Brand5">
                                <label class="form-check-label" for="Brand5">
                                    Brand Name
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="Brand6">
                                <label class="form-check-label" for="Brand6">
                                    Brand Name
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="filter-items">
                    <div class="filtr-cate-title">
                        <h4>Price</h4>
                    </div>
                    <div class="price-pack-item-body scrollstyle_4">
                        <div class="brand-list">
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="price1">
                                <label class="form-check-label" for="price1">
                                    Less than $2 <span class="webproduct">(9)</span>
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="price2">
                                <label class="form-check-label" for="price2">
                                    $2 to $5 <span class="webproduct">(8)</span>
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="price3">
                                <label class="form-check-label" for="price3">
                                    $6 to $10 <span class="webproduct">(12)</span>
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="price4">
                                <label class="form-check-label" for="price4">
                                    $11 to $15 <span class="webproduct">(4)</span>
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="price5">
                                <label class="form-check-label" for="price5">
                                    $15 to $20 <span class="webproduct">(16)</span>
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="price6">
                                <label class="form-check-label" for="price6">
                                    $21 to $25 <span class="webproduct">(18)</span>
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="price7">
                                <label class="form-check-label" for="price7">
                                    More than $25 <span class="webproduct">(25)</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="filter-items">
                    <div class="filtr-cate-title">
                        <h4>Discount</h4>
                    </div>
                    <div class="offer-item-body scrollstyle_4">
                        <div class="brand-list">
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="discount1">
                                <label class="form-check-label" for="discount1">
                                    2% - 5% <span class="webproduct">(9)</span>
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="discount2">
                                <label class="form-check-label" for="discount2">
                                    6% - 10% <span class="webproduct">(5)</span>
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="discount3">
                                <label class="form-check-label" for="discount3">
                                    11% - 15% <span class="webproduct">(11)</span>
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="discount4">
                                <label class="form-check-label" for="discount4">
                                    16% - 25% <span class="webproduct">(27)</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="filter-items">
                    <div class="filtr-cate-title">
                        <h4>Pack Size</h4>
                    </div>
                    <div class="price-pack-item-body scrollstyle_4">
                        <div class="brand-list">
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size1">
                                <label class="form-check-label" for="size1">
                                    1 pc
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size2">
                                <label class="form-check-label" for="size2">
                                    1 pc approx. 400 to 600 gm
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size3">
                                <label class="form-check-label" for="size3">
                                    1 pc approx. 500 to 800 gm
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size4">
                                <label class="form-check-label" for="size4">
                                    Combo 3 Items
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size5">
                                <label class="form-check-label" for="size5">
                                    Combo 4 Items
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size6">
                                <label class="form-check-label" for="size6">
                                    Combo 5 Items
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size7">
                                <label class="form-check-label" for="size7">
                                    100 g
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size8">
                                <label class="form-check-label" for="size8">
                                    200 g
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size9">
                                <label class="form-check-label" for="size9">
                                    250 g
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size10">
                                <label class="form-check-label" for="size10">
                                    500 g
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size11">
                                <label class="form-check-label" for="size11">
                                    1kg
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size12">
                                <label class="form-check-label" for="size12">
                                    2kg
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" value="" id="size13">
                                <label class="form-check-label" for="size13">
                                    3kg
                                </label>
                            </div>						
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Filter Sidebar Offcanvas End-->
        <!-- Header Start -->
       <jsp:include page="header.jsp"></jsp:include>
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
                                    <li class="breadcrumb-item active" aria-current="page">Vegetables & Fruits</li>
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
                                    <h2>Vegetables & Fruits</h2>
                                </div>
                                <a href="#" class="filter-btn" data-bs-toggle="offcanvas" data-bs-target="#offcanvasFilter" aria-controls="offcanvasFilter">Filters</a>
                                <div class="product-sort main-form">
                                    <select class="selectpicker" data-width="25%">
                                        <option value="0">Popularity</option>
                                        <option value="1">Price - Low to High</option>
                                        <option value="2">Price - High to Low</option>
                                        <option value="3">Alphabetical</option>
                                        <option value="4">Saving - High to Low</option>
                                        <option value="5">Saving - Low to High</option>
                                        <option value="6">% Off - High to Low</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="product-list-view">
                        <div class="row">
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-1.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">6% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$12 <span>$15</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-2.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">2% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$10 <span>$13</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-3.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">5% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$5 <span>$8</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-4.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">3% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$15 <span>$20</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-5.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">2% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$9 <span>$10</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-6.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">2% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$7 <span>$8</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-7.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">1% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$6.95 <span>$7</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-11.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">6% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$12 <span>$15</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-12.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">2% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$10 <span>$13</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-13.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">5% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$5 <span>$8</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-14.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">1% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$6.95 <span>$7</span></div>
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
                            <div class="col-lg-3 col-md-6">
                                <div class="product-item mb-30">
                                    <a href="single_product_view.jsp" class="product-img">
                                        <img src="images/product/img-8.jpg" alt="">
                                        <div class="product-absolute-options">
                                            <span class="offer-badge-1">3% off</span>
                                            <span class="like-icon" title="wishlist"></span>
                                        </div>
                                    </a>
                                    <div class="product-text-dt">
                                        <p>Available<span>(In Stock)</span></p>
                                        <h4>Product Title Here</h4>
                                        <div class="product-price">$8 <span>$10</span></div>
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
                            <div class="col-md-12">
                                <div class="more-product-btn">
                                    <button class="show-more-btn hover-btn" onclick="window.location.href = '#';">Show More</button>
                                </div>
                            </div>
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
        <script src="js/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
        <script src="vendor/OwlCarousel/owl.carousel.js"></script>
        <script src="js/jquery.countdown.min.js"></script>
        <script src="js/custom.js"></script>
        <script src="js/offset_overlay.js"></script>
        <script src="js/night-mode.js"></script>


    </body>

    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/shop_grid.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:14 GMT -->
</html>