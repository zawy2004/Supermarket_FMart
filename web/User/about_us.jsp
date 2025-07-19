<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=9">
    <meta name="description" content="FMart - Building the Supermarket Management System at FPT University">
    <meta name="author" content="FMartlthemes">
    <title>FMart - About Us</title>
    <link rel="icon" type="image/png" href="images/fav.png">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
    <link href="User/css/style.css" rel="stylesheet">
    <link href="User/css/responsive.css" rel="stylesheet">
    <link href="User/css/night-mode.css" rel="stylesheet">
    <link href="User/css/step-wizard.css" rel="stylesheet">
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
                            <div class="text"> Fruits and Vegetables </div>
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
                                    <a class="nav-item nav-link active" href="about_us">About</a>
                                    <a class="nav-item nav-link" href="our_blog">Blog</a>
                                    <a class="nav-item nav-link" href="career">Careers</a>
                                    <a class="nav-item nav-link" href="press">Press</a>
                                </div>
                            </nav>						
                        </div>
                        <div class="title129">	
                            <h2>Building the FMart Supermarket Management System at FPT University</h2>
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
                            <h2>About FMart at FPT</h2>
                            <p>Innovating Supermarket Management in an Academic Environment</p>
                            <img src="images/line.svg" alt="">
                        </div>
                        <div class="about-content">
                            <p>The FMart Supermarket Management System at FPT University is an innovative project developed by students and lecturers to optimize retail processes, inventory management, and delivery services within the campus. Integrating cutting-edge technology with a focus on practical learning, FMart provides a seamless shopping experience for the FPT community. This initiative not only addresses real-world needs but also serves as a platform for students to enhance their programming and project management skills.</p>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="about-img">
                            <img src="User/images/about.svg" alt="FMart at FPT University">
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
                                <img src="User/images/about/icon-1.svg" alt="">
                            </div>
                            <h4>150+</h4>
                            <p>Students involved in FMart development over the past 6 months</p>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="about-step">
                            <div class="about-step-img">
                                <img src="User/images/about/icon-2.svg" alt="">
                            </div>
                            <h4>3x</h4>
                            <p>Growth rate of users within the FPT campus</p>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="about-step">
                            <div class="about-step-img">
                                <img src="User/images/about/icon-3.svg" alt="">
                            </div>
                            <h4>7 days</h4>
                            <p>Time taken to deploy across FPT University areas</p>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="about-step">
                            <div class="about-step-img">
                                <img src="User/images/about/icon-4.svg" alt="">
                            </div>
                            <h4>500+</h4>
                            <p>Internal app downloads at FPT University</p>
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
                            <p>Collaboration for a Future-Ready FMart</p>
                            <img src="User/images/line.svg" alt="">
                        </div>
                        <div class="dd-content">
                            <div class="owl-carousel team-slider owl-theme">
                                <div class="item">
                                    <div class="team-item">
                                        <div class="team-img">
                                            <img src="User/images/team/img-1.jpg" alt="Nguyen Van A">
                                        </div>
                                        <h4>Nguyen Van A</h4>
                                        <span>Project Leader & Student Developer</span>
                                        <ul class="team-social">
                                            <li><a href="https://www.facebook.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                                            <li><a href="https://www.linkedin.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-linkedin-in"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="team-item">
                                        <div class="team-img">
                                            <img src="User/images/team/img-2.jpg" alt="Tran Thi B">
                                        </div>
                                        <h4>Tran Thi B</h4>
                                        <span>Lead Developer & FPT Student</span>
                                        <ul class="team-social">
                                            <li><a href="https://www.facebook.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                                            <li><a href="https://www.linkedin.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-linkedin-in"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="team-item">
                                        <div class="team-img">
                                            <img src="User/images/team/img-3.jpg" alt="Le Van C">
                                        </div>
                                        <h4>Le Van C</h4>
                                        <span>UI/UX Designer & Student</span>
                                        <ul class="team-social">
                                            <li><a href="https://www.facebook.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                                            <li><a href="https://www.linkedin.com/" class="scl-btn hover-btn" target="_blank"><i class="fab fa-linkedin-in"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="team-item">
                                        <div class="team-img">
                                            <img src="User/images/team/img-4.jpg" alt="Pham Thi D">
                                        </div>
                                        <h4>Pham Thi D</h4>
                                        <span>Quality Assurance & FPT Student</span>
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
                            <p>How to Order on FMart at FPT University</p>
                            <img src="images/line.svg" alt="">
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="how-order-steps">
                            <div class="how-order-icon">
                                <i class="uil uil-search"></i>
                            </div>
                            <h4>Browse FMart System for Products</h4>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="how-order-steps">
                            <div class="how-order-icon">
                                <i class="uil uil-shopping-basket"></i>
                            </div>
                            <h4>Add Items to Your Campus Cart</h4>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="how-order-steps">
                            <div class="how-order-icon">
                                <i class="uil uil-stopwatch"></i>
                            </div>
                            <h4>Select a Delivery Slot within Campus</h4>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="how-order-steps">
                            <div class="how-order-icon">
                                <i class="uil uil-money-bill"></i>
                            </div>
                            <h4>Choose Payment Method (Cash or Card)</h4>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="how-order-steps">
                            <div class="how-order-icon">
                                <i class="uil uil-truck"></i>
                            </div>
                            <h4>Get Products Delivered to Your Location on Campus</h4>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="how-order-steps">
                            <div class="how-order-icon">
                                <i class="uil uil-smile"></i>
                            </div>
                            <h4>Happy FPT Community</h4>
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
</html>