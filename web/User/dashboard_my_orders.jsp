<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
﻿<!DOCTYPE html>
<html lang="en">


    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/dashboard_my_orders.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:13 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <meta name="description" content="Gambolthemes">
        <meta name="author" content="Gambolthemes">		
        <title>FMart - My Orders</title>

        <!-- Favicon Icon -->
        <link rel="icon" type="image/png" href="images/fav.png">

        <!-- Stylesheets -->
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet">
        <link href='User/vendor/unicons-2.0.1/css/unicons.css' rel='stylesheet'>
        <link href="User/css/style.css" rel="stylesheet">
        <link href="User/css/responsive.css" rel="stylesheet">
        <link href="User/css/night-mode.css" rel="stylesheet">
        <link href="User/css/step-wizard.css" rel="stylesheet">

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
                                    <li class="breadcrumb-item active" aria-current="page">My Orders</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <div class="dashboard-group">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="user-dt">
                                <div class="user-img">
                                    <img src="images/avatar/img-5.jpg" alt="">
                                    <div class="img-add">													
                                        <input type="file" id="file">
                                        <label for="file"><i class="uil uil-camera-plus"></i></label>
                                    </div>
                                </div>
                                <h4>Johe Doe</h4>
                                <p>+91999999999<a href="#"><i class="uil uil-edit"></i></a></p>
                                <div class="earn-points"><img src="images/Dollar.svg" alt="">Points : <span>20</span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>	
            <div class="">
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
                                            <h4><i class="uil uil-box"></i>My Orders</h4>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12">
                                        <div class="pdpt-bg">
                                            <div class="pdpt-title">
                                                <h6>Delivery Timing 10 May, 3.00PM - 6.00PM</h6>
                                            </div> 
                                            <div class="order-body10">
                                                <ul class="order-dtsll">
                                                    <li>
                                                        <div class="order-dt-img">
                                                            <img src="images/groceries.svg" alt="">
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="order-dt47">
                                                            <h4>FMart - Ludhiana</h4>
                                                            <p>Delivered - FMart</p>
                                                            <div class="order-title">2 Items <span data-bs-toggle="tooltip" data-bs-placement="top" title="2kg broccoli, 1kg Apple">?</span></div>
                                                        </div>
                                                    </li>
                                                </ul>
                                                <div class="total-dt">
                                                    <div class="total-checkout-group">
                                                        <div class="cart-total-dil">
                                                            <h4>Sub Total</h4>
                                                            <span>$25</span>
                                                        </div>
                                                        <div class="cart-total-dil pt-3">
                                                            <h4>Delivery Charges</h4>
                                                            <span>Free</span>
                                                        </div>
                                                    </div>
                                                    <div class="main-total-cart">
                                                        <h2>Total</h2>
                                                        <span>$25</span>
                                                    </div>
                                                </div>
                                                <div class="track-order">
                                                    <h4>Track Order</h4>
                                                    <div class="bs-wizard" style="border-bottom:0;">   
                                                        <div class="bs-wizard-step complete">
                                                            <div class="text-center bs-wizard-stepnum">Placed</div>
                                                            <div class="progress"><div class="progress-bar"></div></div>
                                                            <a href="#" class="bs-wizard-dot"></a>
                                                        </div>
                                                        <div class="bs-wizard-step complete"><!-- complete -->
                                                            <div class="text-center bs-wizard-stepnum">Packed</div>
                                                            <div class="progress"><div class="progress-bar"></div></div>
                                                            <a href="#" class="bs-wizard-dot"></a>
                                                        </div>
                                                        <div class="bs-wizard-step active"><!-- complete -->
                                                            <div class="text-center bs-wizard-stepnum">On the way</div>
                                                            <div class="progress"><div class="progress-bar"></div></div>
                                                            <a href="#" class="bs-wizard-dot"></a>
                                                        </div>
                                                        <div class="bs-wizard-step disabled"><!-- active -->
                                                            <div class="text-center bs-wizard-stepnum">Delivered</div>
                                                            <div class="progress"><div class="progress-bar"></div></div>
                                                            <a href="#" class="bs-wizard-dot"></a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="alert-offer">
                                                    <img src="images/ribbon.svg" alt="">
                                                    Cashback of $2 will be credit to FMart Super Market wallet 6-12 hours of delivery.
                                                </div>
                                                <div class="call-bill">
                                                    <div class="delivery-man">
                                                        Delivery Boy - <a href="#"><i class="uil uil-phone"></i> Call Us</a>
                                                    </div>
                                                    <div class="order-bill-slip">
                                                        <a href="bill.jsp" class="bill-btn5 hover-btn">View Bill</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="pdpt-bg">
                                            <div class="pdpt-title">
                                                <h6>Delivery Timing 10 May, 3.00PM - 6.00PM</h6>
                                            </div> 
                                            <div class="order-body10">
                                                <ul class="order-dtsll">
                                                    <li>
                                                        <div class="order-dt-img">
                                                            <img src="images/groceries.svg" alt="">
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="order-dt47">
                                                            <h4>FMart - Ludhiana</h4>
                                                            <p>Delivered - FMart</p>
                                                            <div class="order-title">2 Items <span data-bs-toggle="tooltip" data-bs-placement="top" title="2kg broccoli, 1kg Apple">?</span></div>
                                                        </div>
                                                    </li>
                                                </ul>
                                                <div class="total-dt">
                                                    <div class="total-checkout-group">
                                                        <div class="cart-total-dil">
                                                            <h4>Sub Total</h4>
                                                            <span>$25</span>
                                                        </div>
                                                        <div class="cart-total-dil pt-3">
                                                            <h4>Delivery Charges</h4>
                                                            <span>Free</span>
                                                        </div>
                                                    </div>
                                                    <div class="main-total-cart">
                                                        <h2>Total</h2>
                                                        <span>$25</span>
                                                    </div>
                                                </div>
                                                <div class="track-order">
                                                    <h4>Track Order</h4>
                                                    <div class="bs-wizard" style="border-bottom:0;">   
                                                        <div class="bs-wizard-step complete">
                                                            <div class="text-center bs-wizard-stepnum">Placed</div>
                                                            <div class="progress"><div class="progress-bar"></div></div>
                                                            <a href="#" class="bs-wizard-dot"></a>
                                                        </div>
                                                        <div class="bs-wizard-step complete"><!-- complete -->
                                                            <div class="text-center bs-wizard-stepnum">Packed</div>
                                                            <div class="progress"><div class="progress-bar"></div></div>
                                                            <a href="#" class="bs-wizard-dot"></a>
                                                        </div>
                                                        <div class="bs-wizard-step complete"><!-- complete -->
                                                            <div class="text-center bs-wizard-stepnum">Arrived</div>
                                                            <div class="progress"><div class="progress-bar"></div></div>
                                                            <a href="#" class="bs-wizard-dot"></a>
                                                        </div>
                                                        <div class="bs-wizard-step complete"><!-- complete -->
                                                            <div class="text-center bs-wizard-stepnum">Delivered</div>
                                                            <div class="progress"><div class="progress-bar"></div></div>
                                                            <a href="#" class="bs-wizard-dot"></a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="call-bill">
                                                    <div class="delivery-man">
                                                        <a href="#"><i class="uil uil-rss"></i>Feedback</a>
                                                    </div>
                                                    <div class="order-bill-slip">
                                                        <a href="bill.jsp" class="bill-btn5 hover-btn">View Bill</a>
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
        <script src="User/js/product.thumbnail.slider.js"></script>
        <script src="User/js/offset_overlay.js"></script>
        <script src="User/js/night-mode.js"></script>


    </body>

    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/dashboard_my_orders.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:13 GMT -->
</html>