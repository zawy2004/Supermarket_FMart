<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
﻿<!DOCTYPE html>
<html lang="en">


    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/faq.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:12 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <meta name="description" content="Gambolthemes">
        <meta name="author" content="Gambolthemes">		
        <title>FMart - Frequently Asked Questions</title>

        <!-- Favicon Icon -->
        <link rel="icon" type="image/png" href="images/fav.png">

        <!-- Stylesheets -->
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet">
        <link href='vendor/unicons-2.0.1/css/unicons.css' rel='stylesheet'>
        <link href="css/style.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <link href="css/night-mode.css" rel="stylesheet">
        <link href="css/step-wizard.css" rel="stylesheet">

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
                                    <li class="breadcrumb-item active" aria-current="page">Frequently Asked Questions</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <div class="all-product-grid">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="default-title">
                                <h2>Frequently Asked Questions</h2>
                                <img src="images/line.svg" alt="">
                            </div>
                            <div class="panel-group accordion pt-1" id="accordion0">
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingOne">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapseOne" href="#" aria-expanded="false" aria-controls="collapseOne">
                                                Registration
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne" data-bs-parent="#accordion0" style="">
                                        <div class="panel-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam semper faucibus erat a efficitur. Praesent vulputate mauris eget augue semper, at eleifend enim aliquam. Vivamus suscipit lacinia neque eget suscipit. Morbi vitae nisl ac justo placerat vulputate ac quis lectus. Vestibulum pellentesque, orci eu ultrices molestie, nisi libero hendrerit eros, vel interdum augue tortor vel urna. Nullam enim dolor, pulvinar in metus vitae, tincidunt dignissim neque. Pellentesque tempor nulla eu neque hendrerit fringilla. Suspendisse ultricies venenatis maximus. Suspendisse erat elit, ultricies eu porta nec, luctus sit amet dui. Fusce feugiat odio semper, hendrerit lectus vitae, convallis nisl. Ut a justo diam. Donec vitae leo lorem. Cras pharetra libero ut urna condimentum, non imperdiet leo posuere.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingTwo">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapseTwo" href="#" aria-expanded="false" aria-controls="collapseTwo">
                                                Account Related
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam semper faucibus erat a efficitur. Praesent vulputate mauris eget augue semper, at eleifend enim aliquam. Vivamus suscipit lacinia neque eget suscipit. Morbi vitae nisl ac justo placerat vulputate ac quis lectus. Vestibulum pellentesque, orci eu ultrices molestie, nisi libero hendrerit eros, vel interdum augue tortor vel urna. Nullam enim dolor, pulvinar in metus vitae, tincidunt dignissim neque. Pellentesque tempor nulla eu neque hendrerit fringilla. Suspendisse ultricies venenatis maximus. Suspendisse erat elit, ultricies eu porta nec, luctus sit amet dui. Fusce feugiat odio semper, hendrerit lectus vitae, convallis nisl. Ut a justo diam. Donec vitae leo lorem. Cras pharetra libero ut urna condimentum, non imperdiet leo posuere.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingThree">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapseThree" href="#" aria-expanded="false" aria-controls="collapseThree">
                                                Payment
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam semper faucibus erat a efficitur. Praesent vulputate mauris eget augue semper, at eleifend enim aliquam. Vivamus suscipit lacinia neque eget suscipit. Morbi vitae nisl ac justo placerat vulputate ac quis lectus. Vestibulum pellentesque, orci eu ultrices molestie, nisi libero hendrerit eros, vel interdum augue tortor vel urna. Nullam enim dolor, pulvinar in metus vitae, tincidunt dignissim neque. Pellentesque tempor nulla eu neque hendrerit fringilla. Suspendisse ultricies venenatis maximus. Suspendisse erat elit, ultricies eu porta nec, luctus sit amet dui. Fusce feugiat odio semper, hendrerit lectus vitae, convallis nisl. Ut a justo diam. Donec vitae leo lorem. Cras pharetra libero ut urna condimentum, non imperdiet leo posuere.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingfour">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapsefour" href="#" aria-expanded="false" aria-controls="collapsefour">
                                                Delivery Related
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapsefour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingfour" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam semper faucibus erat a efficitur. Praesent vulputate mauris eget augue semper, at eleifend enim aliquam. Vivamus suscipit lacinia neque eget suscipit. Morbi vitae nisl ac justo placerat vulputate ac quis lectus. Vestibulum pellentesque, orci eu ultrices molestie, nisi libero hendrerit eros, vel interdum augue tortor vel urna. Nullam enim dolor, pulvinar in metus vitae, tincidunt dignissim neque. Pellentesque tempor nulla eu neque hendrerit fringilla. Suspendisse ultricies venenatis maximus. Suspendisse erat elit, ultricies eu porta nec, luctus sit amet dui. Fusce feugiat odio semper, hendrerit lectus vitae, convallis nisl. Ut a justo diam. Donec vitae leo lorem. Cras pharetra libero ut urna condimentum, non imperdiet leo posuere.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingfive">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapsefive" href="#" aria-expanded="false" aria-controls="collapsefive">
                                                Order Related
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapsefive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingfive" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam semper faucibus erat a efficitur. Praesent vulputate mauris eget augue semper, at eleifend enim aliquam. Vivamus suscipit lacinia neque eget suscipit. Morbi vitae nisl ac justo placerat vulputate ac quis lectus. Vestibulum pellentesque, orci eu ultrices molestie, nisi libero hendrerit eros, vel interdum augue tortor vel urna. Nullam enim dolor, pulvinar in metus vitae, tincidunt dignissim neque. Pellentesque tempor nulla eu neque hendrerit fringilla. Suspendisse ultricies venenatis maximus. Suspendisse erat elit, ultricies eu porta nec, luctus sit amet dui. Fusce feugiat odio semper, hendrerit lectus vitae, convallis nisl. Ut a justo diam. Donec vitae leo lorem. Cras pharetra libero ut urna condimentum, non imperdiet leo posuere.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingsix">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapsesix" href="#" aria-expanded="false" aria-controls="collapsesix">
                                                Customer Related
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapsesix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingsix" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam semper faucibus erat a efficitur. Praesent vulputate mauris eget augue semper, at eleifend enim aliquam. Vivamus suscipit lacinia neque eget suscipit. Morbi vitae nisl ac justo placerat vulputate ac quis lectus. Vestibulum pellentesque, orci eu ultrices molestie, nisi libero hendrerit eros, vel interdum augue tortor vel urna. Nullam enim dolor, pulvinar in metus vitae, tincidunt dignissim neque. Pellentesque tempor nulla eu neque hendrerit fringilla. Suspendisse ultricies venenatis maximus. Suspendisse erat elit, ultricies eu porta nec, luctus sit amet dui. Fusce feugiat odio semper, hendrerit lectus vitae, convallis nisl. Ut a justo diam. Donec vitae leo lorem. Cras pharetra libero ut urna condimentum, non imperdiet leo posuere.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingseven">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapseseven" href="#" aria-expanded="false" aria-controls="collapseseven">
                                                Return & Refund
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapseseven" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingseven" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam semper faucibus erat a efficitur. Praesent vulputate mauris eget augue semper, at eleifend enim aliquam. Vivamus suscipit lacinia neque eget suscipit. Morbi vitae nisl ac justo placerat vulputate ac quis lectus. Vestibulum pellentesque, orci eu ultrices molestie, nisi libero hendrerit eros, vel interdum augue tortor vel urna. Nullam enim dolor, pulvinar in metus vitae, tincidunt dignissim neque. Pellentesque tempor nulla eu neque hendrerit fringilla. Suspendisse ultricies venenatis maximus. Suspendisse erat elit, ultricies eu porta nec, luctus sit amet dui. Fusce feugiat odio semper, hendrerit lectus vitae, convallis nisl. Ut a justo diam. Donec vitae leo lorem. Cras pharetra libero ut urna condimentum, non imperdiet leo posuere.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" id="headingeight">
                                        <div class="panel-title">
                                            <a class="collapsed" data-bs-toggle="collapse" data-bs-target="#collapseeight" href="#" aria-expanded="false" aria-controls="collapseeight">
                                                How Does it Work
                                            </a>
                                        </div>
                                    </div>
                                    <div id="collapseeight" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingeight" data-bs-parent="#accordion0">
                                        <div class="panel-body">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam semper faucibus erat a efficitur. Praesent vulputate mauris eget augue semper, at eleifend enim aliquam. Vivamus suscipit lacinia neque eget suscipit. Morbi vitae nisl ac justo placerat vulputate ac quis lectus. Vestibulum pellentesque, orci eu ultrices molestie, nisi libero hendrerit eros, vel interdum augue tortor vel urna. Nullam enim dolor, pulvinar in metus vitae, tincidunt dignissim neque. Pellentesque tempor nulla eu neque hendrerit fringilla. Suspendisse ultricies venenatis maximus. Suspendisse erat elit, ultricies eu porta nec, luctus sit amet dui. Fusce feugiat odio semper, hendrerit lectus vitae, convallis nisl. Ut a justo diam. Donec vitae leo lorem. Cras pharetra libero ut urna condimentum, non imperdiet leo posuere.</p>
                                        </div>
                                    </div>
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
        <script src="js/product.thumbnail.slider.js"></script>
        <script src="js/offset_overlay.js"></script>
        <script src="js/night-mode.js"></script>


    </body>

    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/faq.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:12 GMT -->
</html>