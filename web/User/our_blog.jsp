<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
﻿<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/our_blog.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:14 GMT -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <meta name="description" content="Gambolthemes">
        <meta name="author" content="Gambolthemes">		
        <title>FMart - Our Blog</title>

        <!-- Favicon Icon -->
        <link rel="icon" type="image/png" href="images/fav.png">

        <!-- Stylesheets -->
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
                                        <img src="User/images/category/icon-1.svg" alt="">
                                    </div>
                                    <div class="text"> Fruits and Vegetables </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-2.svg" alt="">
                                    </div>
                                    <div class="text"> Grocery & Staples </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-3.svg" alt="">
                                    </div>
                                    <div class="text"> Dairy & Eggs </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-4.svg" alt="">
                                    </div>
                                    <div class="text"> Beverages </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-5.svg" alt="">
                                    </div>
                                    <div class="text"> Snacks </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-6.svg" alt="">
                                    </div>
                                    <div class="text"> Home Care </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-7.svg" alt="">
                                    </div>
                                    <div class="text"> Noodles & Sauces </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-8.svg" alt="">
                                    </div>
                                    <div class="text"> Personal Care </div>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="single-cat-item">
                                    <div class="icon">
                                        <img src="User/images/category/icon-9.svg" alt="">
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
                                    <img src="User/images/category/icon-1.svg" alt="">
                                </div>
                                <div class="text">
                                    Fruits and Vegetables
                                </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="User/images/category/icon-2.svg" alt="">
                                </div>
                                <div class="text"> Grocery & Staples </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="User/images/category/icon-3.svg" alt="">
                                </div>
                                <div class="text"> Dairy & Eggs </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="User/images/category/icon-4.svg" alt="">
                                </div>
                                <div class="text"> Beverages </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="User/images/category/icon-5.svg" alt="">
                                </div>
                                <div class="text"> Snacks </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="User/images/category/icon-6.svg" alt="">
                                </div>
                                <div class="text"> Home Care </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="User/images/category/icon-7.svg" alt="">
                                </div>
                                <div class="text"> Noodles & Sauces </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="User/images/category/icon-8.svg" alt="">
                                </div>
                                <div class="text"> Personal Care </div>
                            </a>
                            <a href="#" class="single-cat">
                                <div class="icon">
                                    <img src="User/images/category/icon-9.svg" alt="">
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
                <div class="default-dt">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 col-md-12">
                                <div class="default_tabs">
                                    <nav>
                                        <div class="nav nav-tabs tab_default  justify-content-center">
                                            <a class="nav-item nav-link" href="about_us">About</a>
                                            <a class="nav-item nav-link active" href="our_blog">Blog</a>
                                            <a class="nav-item nav-link" href="career">Careers</a>
                                            <a class="nav-item nav-link" href="press">Press</a>
                                        </div>
                                    </nav>						
                                </div>
                                <div class="title129">	
                                    <h2>Insights, ideas, and stories</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="blog-gambo">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-4 col-md-5">
                                <div class="pdpt-bg-left mt-0">
                                    <div class="pdpt-title">
                                        <h4>Most Viewed Posts</h4>
                                    </div>
                                    <ul class="top-posts">
                                        <li>
                                            <div class="blog-top-item">
                                                <a href="blog_detail_view.jsp" class="top-post-link">Optimizing Inventory at FMart</a>
                                                <span class="blog-time">July 10, 2025</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="blog-top-item">
                                                <a href="blog_detail_view.jsp" class="top-post-link">Student Projects in FMart System</a>
                                                <span class="blog-time">July 5, 2025</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="blog-top-item">
                                                <a href="blog_detail_view.jsp" class="top-post-link">Enhancing Delivery at FPT Campus</a>
                                                <span class="blog-time">June 28, 2025</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="blog-top-item">
                                                <a href="blog_detail_view.jsp" class="top-post-link">FMart Payment Innovations</a>
                                                <span class="blog-time">June 20, 2025</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="blog-top-item">
                                                <a href="blog_detail_view.jsp" class="top-post-link">Sustainability in FMart Operations</a>
                                                <span class="blog-time">June 15, 2025</span>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="pdpt-bg-left mb-30">
                                    <div class="pdpt-title">
                                        <h4>Contact With Us</h4>
                                    </div>
                                    <div class="cntct-social">
                                        <ul class="team-social">
                                            <li><a href="#" class="scl-btn hover-btn"><i class="fab fa-facebook-f"></i></a></li>
                                            <li><a href="#" class="scl-btn hover-btn"><i class="fab fa-twitter"></i></a></li>
                                            <li><a href="#" class="scl-btn hover-btn"><i class="fab fa-instagram"></i></a></li>
                                            <li><a href="#" class="scl-btn hover-btn"><i class="fab fa-linkedin-in"></i></a></li>
                                            <li><a href="#" class="scl-btn hover-btn"><i class="fab fa-youtube"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-8 col-md-7">
                                <div class="blog-item">
                                    <a href="blog_detail_view.jsp" class="blog-img">
                                        <img src="User/images/blog/img-1.jpg" alt="">
                                        <div class="blog-cate-badge">FMart Operations</div>
                                    </a>
                                    <div class="date-icons-group">
                                        <div class="blog-time sz-14">July 18, 2025</div>
                                        <ul class="like-share-icons">
                                            <li>
                                                <a href="#" class="like-share"><i class="uil uil-thumbs-up"></i><span>15</span></a>
                                            </li>
                                            <li>
                                                <a href="#" class="like-share"><i class="uil uil-share-alt"></i></a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="blog-detail">
                                        <h4>Optimizing Inventory Management at FMart</h4>
                                        <p>Learn how the FMart team at FPT University is using advanced inventory techniques to ensure product availability. This blog explores real-time tracking and student-led innovations in managing stock levels efficiently.</p>
                                        <a href="blog_detail_view.jsp">Read More</a>
                                    </div>
                                </div>
                                <div class="blog-item">
                                    <a href="blog_detail_view.jsp" class="blog-img">
                                        <img src="User/images/blog/img-2.jpg" alt="">
                                        <div class="blog-cate-badge">Student Projects</div>
                                    </a>
                                    <div class="date-icons-group">
                                        <div class="blog-time sz-14">July 12, 2025</div>
                                        <ul class="like-share-icons">
                                            <li>
                                                <a href="#" class="like-share"><i class="uil uil-thumbs-up"></i><span>22</span></a>
                                            </li>
                                            <li>
                                                <a href="#" class="like-share"><i class="uil uil-share-alt"></i></a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="blog-detail">
                                        <h4>Student Contributions to FMart Development</h4>
                                        <p>Discover how FPT University students are contributing to the FMart system through projects in software development, focusing on enhancing user experience and operational efficiency.</p>
                                        <a href="blog_detail_view.jsp">Read More</a>
                                    </div>
                                </div>
                                <div class="blog-item">
                                    <a href="blog_detail_view.jsp" class="blog-img">
                                        <img src="User/images/blog/img-3.jpg" alt="">
                                        <div class="blog-cate-badge">Delivery Solutions</div>
                                    </a>
                                    <div class="date-icons-group">
                                        <div class="blog-time sz-14">July 5, 2025</div>
                                        <ul class="like-share-icons">
                                            <li>
                                                <a href="#" class="like-share"><i class="uil uil-thumbs-up"></i><span>30</span></a>
                                            </li>
                                            <li>
                                                <a href="#" class="like-share"><i class="uil uil-share-alt"></i></a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="blog-detail">
                                        <h4>Improving Delivery Services at FMart</h4>
                                        <p>Explore the latest updates in FMart's delivery system at FPT University, including faster campus-wide delivery and student feedback integration for better service.</p>
                                        <a href="blog_detail_view.jsp">Read More</a>
                                    </div>
                                </div>
                                <div class="blog-more-btn">
                                    <a href="#" class="blog-btn hover-btn">More View</a>
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

    <!-- Mirrored from gambolthemes.net/html-items/gambo_supermarket_demo_new/our_blog.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 11 Jun 2025 12:01:15 GMT -->
</html>