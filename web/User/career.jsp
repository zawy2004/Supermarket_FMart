<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
﻿<!DOCTYPE html>
<html lang="en">


    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/career.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:20 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <meta name="description" content="Gambolthemes">
        <meta name="author" content="Gambolthemes">		
        <title>FMart - Career</title>

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
                        <h4>Gambo Super Market</h4>
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
                                        <a class="nav-item nav-link" href="about_us.jsp">About</a>
                                        <a class="nav-item nav-link" href="our_blog.jsp">Blog</a>
                                        <a class="nav-item nav-link active" href="career.jsp">Careers</a>
                                        <a class="nav-item nav-link" href="press.jsp">Press</a>
                                    </div>
                                </nav>						
                            </div>
                            <div class="title129">	
                                <h2>Join Inida's Largest Online Grocery Supermarket</h2>
                                <a href="#allJobs" class="position-link-btn hover-btn">Browse Positions</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="life-gambo">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="default-title">
                                <h2>Life of FMart</h2>
                                <p>Because great teams are built with passion, dedication and zeal for excellence!</p>
                                <img src="images/line.svg" alt="">
                            </div>
                            <div class="dd-content">
                                <div class="owl-carousel life-slider owl-theme">
                                    <div class="item">
                                        <div class="offer-item">		
                                            <div class="offer-item-img">
                                                <img src="../../../www.gambolthemes.net/html-items/gambo_supermarket_demo_new/images/career/img-1.jsp" alt="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="offer-item">		
                                            <div class="offer-item-img">
                                                <img src="../../../www.gambolthemes.net/html-items/gambo_supermarket_demo_new/images/career/img-2.jsp" alt="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="offer-item">		
                                            <div class="offer-item-img">
                                                <img src="../../../www.gambolthemes.net/html-items/gambo_supermarket_demo_new/images/career/img-3.jsp" alt="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="offer-item">		
                                            <div class="offer-item-img">
                                                <img src="../../../www.gambolthemes.net/html-items/gambo_supermarket_demo_new/images/career/img-4.jsp" alt="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="offer-item">		
                                            <div class="offer-item-img">
                                                <img src="../../../www.gambolthemes.net/html-items/gambo_supermarket_demo_new/images/career/img-5.jsp" alt="">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="life-gambo white-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="default-title">
                                <h2>The benefits of working at FMart</h2>
                                <p>We want you to feel like home when you're working at FMart and for that we've curated a great set of benefits for you.</p>
                                <img src="images/line.svg" alt="">
                            </div>
                        </div>
                    </div>
                    <div class="dd-content mt-50">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="benefits-step">
                                    <div class="benefit-icon">
                                        <i class="fas fa-trophy"></i>
                                    </div>
                                    <a href="#" class="benefit-link">Performance and Rewards</a>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="benefits-step">
                                    <div class="benefit-icon">
                                        <i class="fas fa-chart-line"></i>
                                    </div>
                                    <a href="#" class="benefit-link">Internal Growth Opportunity</a>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="benefits-step">
                                    <div class="benefit-icon">
                                        <i class="fas fa-hand-holding-heart"></i>
                                    </div>
                                    <a href="#" class="benefit-link">Employee Well Being</a>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="benefits-step">
                                    <div class="benefit-icon">
                                        <i class="fas fa-medkit"></i>
                                    </div>
                                    <a href="#" class="benefit-link">Insurance Coverage</a>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="benefits-step">
                                    <div class="benefit-icon">
                                        <i class="fas fa-suitcase-rolling"></i>
                                    </div>
                                    <a href="#" class="benefit-link">Domestic Travel and Relocation</a>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="benefits-step">
                                    <div class="benefit-icon">
                                        <i class="fas fa-donate"></i>
                                    </div>
                                    <a href="#" class="benefit-link">Compensation Benefits</a>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="benefits-step">
                                    <div class="benefit-icon">
                                        <i class="fas fa-book-reader"></i>
                                    </div>
                                    <a href="#" class="benefit-link">Learning and Development</a>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="benefits-step">
                                    <div class="benefit-icon">
                                        <i class="fas fa-coins"></i>
                                    </div>
                                    <a href="#" class="benefit-link">Stock Options</a>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="benefits-step">
                                    <div class="benefit-icon">
                                        <i class="fas fa-umbrella-beach"></i>
                                    </div>
                                    <a href="#" class="benefit-link">Time Off</a>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="know-more-link">
                                    <a href="#" class="kmore-btn hover-btn">Know More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="life-gambo">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="default-title">
                                <h2>Testimonials</h2>
                                <p>Our Team Says about us!</p>
                                <img src="images/line.svg" alt="">
                            </div>
                            <div class="dd-content">
                                <div class="owl-carousel testimonial-slider owl-theme">
                                    <div class="item">
                                        <div class="testi-item">		
                                            <div class="testi-text">
                                                <div class="qoute-icon"><i class="fas fa-quote-left"></i></div>
                                                <div class="testo-text">Sed ut mattis enim. Nunc id semper eros. Donec luctus venenatis quam at tincidunt. In tristique nibh eget porta cursus. Integer volutpat tincidunt nibh et mattis.</div>
                                            </div>
                                            <div class="team-dt">
                                                <div class="team-avatar">
                                                    <img src="images/avatar/img-1.jpg" alt="">
                                                </div>
                                                <div class="team-emp-dt">
                                                    <h4>Joginder Singh</h4>
                                                    <p>Senior UX Designer, Product</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="testi-item">		
                                            <div class="testi-text">
                                                <div class="qoute-icon"><i class="fas fa-quote-left"></i></div>
                                                <div class="testo-text">Sed ut mattis enim. Nunc id semper eros. Donec luctus venenatis quam at tincidunt. In tristique nibh eget porta cursus. Integer volutpat tincidunt nibh et mattis.</div>
                                            </div>
                                            <div class="team-dt">
                                                <div class="team-avatar">
                                                    <img src="images/avatar/img-2.jpg" alt="">
                                                </div>
                                                <div class="team-emp-dt">
                                                    <h4>Zoena Singh</h4>
                                                    <p>Senior Manager - Training, Corporate</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="testi-item">		
                                            <div class="testi-text">
                                                <div class="qoute-icon"><i class="fas fa-quote-left"></i></div>
                                                <div class="testo-text">Sed ut mattis enim. Nunc id semper eros. Donec luctus venenatis quam at tincidunt. In tristique nibh eget porta cursus. Integer volutpat tincidunt nibh et mattis.</div>
                                            </div>
                                            <div class="team-dt">
                                                <div class="team-avatar">
                                                    <img src="images/avatar/img-3.jpg" alt="">
                                                </div>
                                                <div class="team-emp-dt">
                                                    <h4>Rock William</h4>
                                                    <p>Senior Manager - Finance & Accounts, Corporate</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="testi-item">		
                                            <div class="testi-text">
                                                <div class="qoute-icon"><i class="fas fa-quote-left"></i></div>
                                                <div class="testo-text">Sed ut mattis enim. Nunc id semper eros. Donec luctus venenatis quam at tincidunt. In tristique nibh eget porta cursus. Integer volutpat tincidunt nibh et mattis.</div>
                                            </div>
                                            <div class="team-dt">
                                                <div class="team-avatar">
                                                    <img src="images/avatar/img-4.jpg" alt="">
                                                </div>
                                                <div class="team-emp-dt">
                                                    <h4>Ridhima William</h4>
                                                    <p>Head Customer Support</p>
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
            <div class="jobs-gambo" id="allJobs">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="default-title">
                                <h2>Work With Us</h2>
                                <p>Have the appetite to discover, learn and build with the team.</p>
                                <img src="images/line.svg" alt="">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="pdpt-bg">
                                <div class="pd-20">
                                    <div class="job-title-group">
                                        <h4>Location</h4>
                                        <a href="#" class="flter-clear-link">Clear Filter</a>
                                    </div>
                                    <div class="job-by-loc main-form">
                                        <div class="form-group">																	
                                            <select class="selectpicker">
                                                <option>All Location</option>
                                                <option>Gurgaon, India</option>
                                                <option>Ludhiana, India</option>
                                                <option>Delhi, India</option>
                                                <option>Bangluru, India</option>
                                                <option>Hyderabad, India</option>
                                                <option>Mumbai, India</option>
                                                <option>Kolkata, India</option>
                                                <option>Chandigrah, India</option>
                                            </select>	
                                        </div>
                                    </div>
                                    <div class="all-departments">
                                        <h4>Departments</h4>
                                        <div class="all-chckboxes mt-4">
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" value="" id="job1">
                                                <label class="form-check-label" for="job1">
                                                    Development
                                                </label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input mb-3" type="checkbox" value="" id="job2">
                                                <label class="form-check-label" for="job2">
                                                    Tech and Engineering
                                                </label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" value="" id="job3">
                                                <label class="form-check-label" for="job3">
                                                    Sales and Marketing
                                                </label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" value="" id="job4">
                                                <label class="form-check-label" for="job4">
                                                    UI/UX Designer
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="job5">
                                                <label class="form-check-label" for="job5">
                                                    Senior Manager
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <a href="job_detail_view.jsp" class="job-bg1">
                                <div class="job-item">
                                    <h4>Software Development Engineer</h4>
                                    <span><i class="uil uil-map-marker-alt"></i>Ludhiana, India</span>
                                </div>
                                <i class="uil uil-angle-right-b arrow-icon"></i>
                            </a>
                            <a href="job_detail_view.jsp" class="job-bg1">
                                <div class="job-item">
                                    <h4>Sales Associate</h4>
                                    <span><i class="uil uil-map-marker-alt"></i>Chandigrah, India</span>
                                </div>
                                <i class="uil uil-angle-right-b arrow-icon"></i>
                            </a>
                            <a href="job_detail_view.jsp" class="job-bg1">
                                <div class="job-item">
                                    <h4>Area Sales Manager</h4>
                                    <span><i class="uil uil-map-marker-alt"></i>Delhi, India</span>
                                </div>
                                <i class="uil uil-angle-right-b arrow-icon"></i>
                            </a>
                            <a href="job_detail_view.jsp" class="job-bg1">
                                <div class="job-item">
                                    <h4>UI/UX Designer</h4>
                                    <span><i class="uil uil-map-marker-alt"></i>Bangluru, India</span>
                                </div>
                                <i class="uil uil-angle-right-b arrow-icon"></i>
                            </a>
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

    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/career.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:42 GMT -->
</html>