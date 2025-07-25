<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=9">
    <meta name="description" content="FMart - Press Releases for the Supermarket Management System at FPT University">
    <meta name="author" content="FMartlthemes">
    <title>FMart - Press</title>
    <link rel="icon" type="image/png" href="User/images/fav.png">
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
                            <div class="text"> Fruits and Vegetables </div>
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
                                    <a class="nav-item nav-link" href="our_blog">Blog</a>
                                    <a class="nav-item nav-link" href="career">Careers</a>
                                    <a class="nav-item nav-link active" href="press">Press</a>
                                </div>
                            </nav>						
                        </div>
                        <div class="title129">	
                            <h2>FMart Press at FPT University</h2>						
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="blog-gambo">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-12">
                        <div class="fcrse_3">
                            <ul class="blogleft12">
                                <li>
                                    <a href="#collapse2" class="category-topics cate-right" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapse2">Archive News</a>
                                    <div class="collapse show" id="collapse2" style="">
                                        <ul class="category-card">
                                            <li>
                                                <a href="#" class="category-item1">2025</a>																																																																																																																						
                                            </li>																												
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <div class="socl148">
                                        <button class="twiter158" data-href="#" onclick="sharingPopup(this);" id="twitter-share"><i class="uil uil-twitter ic45"></i>Follow</button>
                                        <button class="facebook158" data-href="#" onclick="sharingPopup(this);" id="facebook-share"><i class="uil uil-facebook ic45"></i>Follow</button>
                                    </div>
                                </li>
                                <li>
                                    <div class="help_link">
                                        <a href="faq.jsp">FAQ Help Center</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-12">
                        <div class="press-title">
                            <h2>FMart in the News at FPT University</h2>
                            <p>For media interviews and inquiries, please send an email to <a href="#">support@fmart.vn</a></p>
                        </div>
                        <a href="#" class="press-item">
                            <span>July 18, 2025</span>
                            <h4>FPT University Newsletter</h4>
                            <p>FMart System Successfully Launched at FPT University Campus</p>
                        </a>
                        <a href="#" class="press-item">
                            <span>July 15, 2025</span>
                            <h4>Vietnam Education Review</h4>
                            <p>FMart Project Wins Innovation Award at FPT University</p>
                        </a>
                        <a href="#" class="press-item">
                            <span>July 10, 2025</span>
                            <h4>Tech Vietnam</h4>
                            <p>FMart’s Student-Led System Enhances Campus Retail Experience</p>
                        </a>
                        <a href="#" class="press-item">
                            <span>July 5, 2025</span>
                            <h4>FPT News</h4>
                            <p>FMart System Recognized as a Model for Academic Projects at FPT</p>
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
