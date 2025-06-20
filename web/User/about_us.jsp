<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
﻿<!DOCTYPE html>
<html lang="en">


    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/about_us.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:16 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <meta name="description" content="Gambolthemes">
        <meta name="author" content="Gambolthemes">		
        <title>FMart - About Us</title>

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
            <div class="default-dt">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="default_tabs">
                                <nav>
                                    <div class="nav nav-tabs tab_default  justify-content-center">
                                        <a class="nav-item nav-link active" href="about_us.jsp">About</a>
                                        <a class="nav-item nav-link" href="our_blog.jsp">Blog</a>
                                        <a class="nav-item nav-link" href="career.jsp">Careers</a>
                                        <a class="nav-item nav-link" href="press.jsp">Press</a>
                                    </div>
                                </nav>						
                            </div>
                            <div class="title129">	
                                <h2>About Us</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="life-gambo">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="default-title left-text">
                                <h2>About FMart</h2>
                                <p>Customers Deserve Better</p>
                                <img src="images/line.svg" alt="">
                            </div>
                            <div class="about-content">
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ac sodales sapien. Sed pellentesque, quam in ornare tincidunt, magna augue placerat nunc, ut facilisis nibh ipsum non ipsum. Cras ac eros non neque viverra consequat sed at est. Fusce efficitur, lacus nec dignissim tincidunt, diam sapien rhoncus neque, at tristique sapien nibh sed neque. Proin in neque in purus luctus facilisis. Donec viverra ligula quis lorem viverra consequat. Aliquam condimentum id enim volutpat rutrum. Donec semper iaculis convallis. Praesent quis elit eget ligula facilisis mattis. Praesent sed euismod dui. Suspendisse imperdiet vel quam nec venenatis. Suspendisse dictum blandit quam, vitae auctor enim gravida et. Sed id dictum nibh. Proin egestas massa sit amet tincidunt aliquet.</p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="about-img">
                                <img src="images/about.svg" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="about-steps-group white-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="about-step">
                                <div class="about-step-img">
                                    <img src="images/about/icon-1.svg" alt="">
                                </div>
                                <h4>400+</h4>
                                <p>People have joined the FMart team in the past six months</p>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="about-step">
                                <div class="about-step-img">
                                    <img src="images/about/icon-2.svg" alt="">
                                </div>
                                <h4>2x</h4>
                                <p>Rate of growth in our monthly user base</p>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="about-step">
                                <div class="about-step-img">
                                    <img src="images/about/icon-3.svg" alt="">
                                </div>
                                <h4>10 days</h4>
                                <p>Time taken to launch in 8 cities across India</p>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="about-step">
                                <div class="about-step-img">
                                    <img src="images/about/icon-4.svg" alt="">
                                </div>
                                <h4>95k</h4>
                                <p>App downloads on iOS and Android</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="life-gambo">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="default-title">
                                <h2>Our Team</h2>
                                <p>Teamwork Makes the Dream Work</p>
                                <img src="images/line.svg" alt="">
                            </div>
                            <div class="dd-content">
                                <div class="owl-carousel team-slider owl-theme">
                                    <div class="item">
                                        <div class="team-item">
                                            <div class="team-img">
                                                <img src="images/team/img-1.jpg" alt="">
                                            </div>
                                            <h4>Joginder Singh</h4>
                                            <span>CEO & Co-Founder</span>
                                            <ul class="team-social">
                                                <li><a href="https://www.facebook.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                                                <li><a href="https://www.linkedin.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-linkedin-in"></i></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="team-item">
                                            <div class="team-img">
                                                <img src="images/team/img-2.jpg" alt="">
                                            </div>
                                            <h4>John Doe</h4>
                                            <span>CTO & Senior Developer</span>
                                            <ul class="team-social">
                                                <li><a href="https://www.facebook.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                                                <li><a href="https://www.linkedin.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-linkedin-in"></i></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="team-item">
                                            <div class="team-img">
                                                <img src="images/team/img-3.jpg" alt="">
                                            </div>
                                            <h4>Jassica William</h4>
                                            <span>HR Manager</span>
                                            <ul class="team-social">
                                                <li><a href="https://www.facebook.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                                                <li><a href="https://www.linkedin.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-linkedin-in"></i></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="team-item">
                                            <div class="team-img">
                                                <img src="images/team/img-4.jpg" alt="">
                                            </div>
                                            <h4>Zoena Singh</h4>
                                            <span>Senior Sales Manager</span>
                                            <ul class="team-social">
                                                <li><a href="https://www.facebook.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                                                <li><a href="https://www.linkedin.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-linkedin-in"></i></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="how-order-gambo">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="default-title">
                                <h2>How Do I Order?</h2>
                                <p>How Do I order on FMart</p>
                                <img src="images/line.svg" alt="">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="how-order-steps">
                                <div class="how-order-icon">
                                    <i class="uil uil-search"></i>
                                </div>
                                <h4>Browse FMart.com for products or use the search feature</h4>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="how-order-steps">
                                <div class="how-order-icon">
                                    <i class="uil uil-shopping-basket"></i>
                                </div>
                                <h4>Add item to your shopping Basket</h4>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="how-order-steps">
                                <div class="how-order-icon">
                                    <i class="uil uil-stopwatch"></i>
                                </div>
                                <h4>Choose a convenient delivery time from our 5 Slots* a day</h4>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="how-order-steps">
                                <div class="how-order-icon">
                                    <i class="uil uil-money-bill"></i>
                                </div>
                                <h4>Select suitable payment option(Cash, Master, Credit Card, Discover)</h4>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="how-order-steps">
                                <div class="how-order-icon">
                                    <i class="uil uil-truck"></i>
                                </div>
                                <h4>Your products will be home-delivered as per your order.</h4>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="how-order-steps">
                                <div class="how-order-icon">
                                    <i class="uil uil-smile"></i>
                                </div>
                                <h4>Happy Curstomers</h4>
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

    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/about_us.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:19 GMT -->
</html>