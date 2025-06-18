<!DOCTYPE html>
<html lang="en">
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>

	
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
	<header class="header clearfix">
		<div class="top-header-group">
			<div class="top-header">
				<div class="main_logo" id="logo">
					<a href="index.jsp"><img src="User/images/logoFM.png" alt=""></a>
					<a href="index.jsp"><img class="logo-inverse" src="User/images/dark-logo.svg" alt=""></a>
				</div>
				<div class="search120">
					<div class="header_search position-relative">
						<input class="prompt srch10" type="text" placeholder="Search for products..">
						<i class="uil uil-search s-icon"></i>
					</div>
				</div>
				<div class="header_right">
					<ul>
						<li>
							<a href="#" class="offer-link"><i class="uil uil-phone-alt"></i>1800-000-000</a>
						</li>
						<li>
							<a href="offers.jsp" class="offer-link"><i class="uil uil-gift"></i>Offers</a>
						</li>
						<li>
							<a href="faq.jsp" class="offer-link"><i class="uil uil-question-circle"></i>Help</a>
						</li>
						<li>
							<a href="dashboard_my_wishlist.jsp" class="option_links" title="Wishlist"><i class='uil uil-heart icon_wishlist'></i><span class="noti_count1">3</span></a>
						</li>	
						<li class="dropdown account-dropdown">
    <a href="#" class="opts_account" role="button" id="accountClick" data-bs-auto-close="outside" data-bs-toggle="dropdown" aria-expanded="false">
        <img src="User/images/avatar/img-5.jpg" alt="">
        <span class="user__name">
            <% if (user != null) { %>
                <%= user.getFullName() %>
            <% } else { %>
                <a href="login" style="color: #333; text-decoration: none;">Sign In</a>
            <% } %>
        </span>
        <i class="uil uil-angle-down"></i>
    </a>
    <% if (user != null) { %>
        <div class="dropdown-menu dropdown-menu-account dropdown-menu-end" aria-labelledby="accountClick" data-bs-popper="none">
            <div class="night_mode_switch__btn">
                <a href="#" id="night-mode" class="btn-night-mode">
                    <i class="uil uil-moon"></i> Night mode
                    <span class="btn-night-mode-switch">
                        <span class="uk-switch-button"></span>
                    </span>
                </a>
            </div>
            <a href="User/dashboard_overview.jsp" class="channel_item"><i class="uil uil-apps icon__1"></i>Dashboard</a>
            <a href="User/dashboard_my_orders.jsp" class="channel_item"><i class="uil uil-box icon__1"></i>My Orders</a>
            <a href="User/dashboard_my_wishlist.jsp" class="channel_item"><i class="uil uil-heart icon__1"></i>My Wishlist</a>
            <a href="User/dashboard_my_wallet.jsp" class="channel_item"><i class="uil uil-usd-circle icon__1"></i>My Wallet</a>
            <a href="User/dashboard_my_addresses.jsp" class="channel_item"><i class="uil uil-location-point icon__1"></i>My Address</a>
            <a href="User/offers.jsp" class="channel_item"><i class="uil uil-gift icon__1"></i>Offers</a>
            <a href="User/faq.jsp" class="channel_item"><i class="uil uil-info-circle icon__1"></i>Faq</a>
            <a href="User/sign_in.jsp" class="channel_item"><i class="uil uil-lock-alt icon__1"></i>Logout</a>
        </div>
    <% } %>
</li>

					</ul>
				</div>
			</div>
		</div>
		<div class="sub-header-group">
			<div class="sub-header">
				<nav class="navbar navbar-expand-lg bg-gambo gambo-head navbar justify-content-lg-start pt-0 pb-0">
					<button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
						<span class="navbar-toggler-icon">
							<i class="uil uil-bars"></i>
						</span>
					</button>
					<a href="#" class="category_drop hover-btn" data-bs-toggle="modal" data-bs-target="#category_model" title="Categories"><i class="uil uil-apps"></i><span class="cate__icon">Select Category</span></a>
					<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
						<div class="offcanvas-header">
							<div class="offcanvas-logo" id="offcanvasNavbarLabel">
								<img src="User/images/dark-logo-1.svg" alt="">
							</div>
							<button type="button" class="close-btn" data-bs-dismiss="offcanvas" aria-label="Close">
								<i class="uil uil-multiply"></i>
							</button>
						</div>
						<div class="offcanvas-body">
							<div class="offcanvas-category mb-4 d-block d-lg-none">
								<div class="offcanvas-search position-relative">
									<input class="canvas_search" type="text" placeholder="Search for products..">
									<i class="uil uil-search hover-btn canvas-icon"></i>
								</div>
								<button class="category_drop_canvas hover-btn mt-4" data-bs-toggle="modal" data-bs-target="#category_model" title="Categories"><i class="uil uil-apps"></i><span class="cate__icon">Select Category</span></button>
							</div>
							<ul class="navbar-nav justify-content-start flex-grow-1 pe_5">
								<li class="nav-item">
									<a class="nav-link active" aria-current="page" href="home">Home</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" href="shop_grid.jsp">New Products</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" href="shop_grid.jsp">Featured Products</a>
								</li>
								<li class="nav-item dropdown">
									<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
										Blog
									</a>
									<ul class="dropdown-menu dropdown-submenu">
										<li><a class="dropdown-item" href="User/our_blog.jsp">Our Blog</a></li>
										<li><a class="dropdown-item" href="User/blog_no_sidebar.jsp">Our Blog Two No Sidebar</a></li>
										<li><a class="dropdown-item" href="User/blog_left_sidebar.jsp">Our Blog with Left Sidebar</a></li>
										<li><a class="dropdown-item" href="User/blog_right_sidebar.jsp">Our Blog with Right Sidebar</a></li>
										<li><a class="dropdown-item" href="User/blog_detail_view.jsp">Blog Detail View</a></li>
										<li><a class="dropdown-item" href="User/blog_left_sidebar_single_view.jsp">Blog Detail View with Sidebar</a></li>
									</ul>
								</li>
								<li class="nav-item dropdown">
									<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
										Pages
									</a>
									<ul class="dropdown-menu dropdown-submenu">
										<li><a class="dropdown-item" href="dashboard_overview.jsp">Account</a></li>
										<li><a class="dropdown-item" href="about_us.jsp">About Us</a></li>
										<li><a class="dropdown-item" href="shop_grid.jsp">Online Shop</a></li>
										<li><a class="dropdown-item" href="single_product_view.jsp">Single Product View</a></li>
										<li><a class="dropdown-item" href="checkout.jsp">Checkout</a></li>
										<li><a class="dropdown-item" href="request_product.jsp">Product Request</a></li>
										<li><a class="dropdown-item" href="order_placed.jsp">Order Placed</a></li>
										<li><a class="dropdown-item" href="bill.jsp">Bill Slip</a></li>
										<li><a class="dropdown-item" href="job_detail_view.jsp">Job Detail View</a></li>
										<li><a class="dropdown-item" href="login">Sign In</a></li>
										<li><a class="dropdown-item" href="register">Sign Up</a></li>
										<li><a class="dropdown-item" href="forgot_password.jsp">Forgot Password</a></li>
									</ul>
								</li>
								<li class="nav-item">
									<a class="nav-link" href="contact_us.jsp">Contact Us</a>
								</li>
							</ul>
							<div class="d-block d-lg-none">
								<ul class="offcanvas-help-links">
									<li><a href="#" class="offer-link"><i class="uil uil-phone-alt"></i>1800-000-000</a></li>
									<li><a href="offers.jsp" class="offer-link"><i class="uil uil-gift"></i>Offers</a></li>
									<li><a href="faq.jsp" class="offer-link"><i class="uil uil-question-circle"></i>Help</a></li>
								</ul>
								<div class="offcanvas-copyright">
									<i class="uil uil-copyright"></i>Copyright 2022 <b>FMartlthemes</b> . All rights reserved
								</div>
							</div>
						</div>
					</div>
					<div class="sub_header_right">
						<div class="header_cart">
							<a href="#" class="cart__btn hover-btn" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight"><i class="uil uil-shopping-cart-alt"></i><span>Cart</span><ins>2</ins><i class="uil uil-angle-down"></i></a>
						</div>
					</div>
				</nav>
			</div>
		</div>
	</header>
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
										<a href="shop_grid.jsp" class="Offer-shop-btn hover-btn">Shop Now</a>
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
										<a href="shop_grid.jsp" class="Offer-shop-btn hover-btn">Shop Now</a>
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
										<a href="shop_grid.jsp" class="Offer-shop-btn hover-btn">Shop Now</a>
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
										<a href="shop_grid.jsp" class="Offer-shop-btn hover-btn">Shop Now</a>
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
										<a href="shop_grid.jsp" class="Offer-shop-btn hover-btn">Shop Now</a>
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
								<a href="shop_grid.jsp" class="category-item">
									<div class="cate-img">
										<img src="User/images/category/icon-1.svg" alt="">
									</div>
									<h4>Vegetables & Fruits</h4>
								</a>
							</div>
							<div class="item">
								<a href="shop_grid.jsp" class="category-item">
									<div class="cate-img">
										<img src="User/images/category/icon-2.svg" alt="">
									</div>
									<h4> Grocery & Staples </h4>
								</a>
							</div>
							<div class="item">
								<a href="shop_grid.jsp" class="category-item">
									<div class="cate-img">
										<img src="User/images/category/icon-3.svg" alt="">
									</div>
									<h4> Dairy & Eggs </h4>
								</a>
							</div>
							<div class="item">
								<a href="shop_grid.jsp" class="category-item">
									<div class="cate-img">
										<img src="User/images/category/icon-4.svg" alt="">
									</div>
									<h4> Beverages </h4>
								</a>
							</div>
							<div class="item">
								<a href="shop_grid.jsp" class="category-item">
									<div class="cate-img">
										<img src="User/images/category/icon-5.svg" alt="">
									</div>
									<h4> Snacks </h4>
								</a>
							</div>
							<div class="item">
								<a href="shop_grid.jsp" class="category-item">
									<div class="cate-img">
										<img src="User/images/category/icon-6.svg" alt="">
									</div>
									<h4> Home Care </h4>
								</a>
							</div>
							<div class="item">
								<a href="shop_grid.jsp" class="category-item">
									<div class="cate-img">
										<img src="User/images/category/icon-7.svg" alt="">
									</div>
									<h4> Noodles & Sauces </h4>
								</a>
							</div>
							<div class="item">
								<a href="shop_grid.jsp" class="category-item">
									<div class="cate-img">
										<img src="User/images/category/icon-8.svg" alt="">
									</div>
									<h4> Personal Care </h4>
								</a>
							</div>
							<div class="item">
								<a href="shop_grid.jsp" class="category-item">
									<div class="cate-img">
										<img src="User/images/category/icon-9.svg" alt="">
									</div>
									<h4> Pet Care </h4>
								</a>
							</div>
							<div class="item">
								<a href="shop_grid.jsp" class="category-item">
									<div class="cate-img">
										<img src="User/images/category/icon-10.svg" alt="">
									</div>
									<h4> Meat & Seafood </h4>
								</a>
							</div>
							<div class="item">
								<a href="shop_grid.jsp" class="category-item">
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
							<a href="shop_grid.jsp" class="see-more-btn">See All</a>
						</div>
					</div>
					<div class="col-md-12">
						<div class="owl-carousel featured-slider owl-theme">
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-1.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-2.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-3.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-4.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-5.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-6.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-7.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-8.jpg" alt="">
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
							<a href="shop_grid.jsp" class="see-more-btn">See All</a>
						</div>
					</div>
					<div class="col-md-12">
						<div class="owl-carousel featured-slider owl-theme">
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-11.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-12.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-13.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-1.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-5.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-6.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-14.jpg" alt="">
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-3.jpg" alt="">
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
								<h2>Added New Products</h2>
							</div>
							<a href="shop_grid.jsp" class="see-more-btn">See All</a>
						</div>
					</div>
					<div class="col-md-12">
						<div class="owl-carousel featured-slider owl-theme">
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-10.jpg" alt="">
										<div class="product-absolute-options">
											<span class="offer-badge-1">New</span>
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
							<div class="item">
								<div class="product-item">
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-9.jpg" alt="">
										<div class="product-absolute-options">
											<span class="offer-badge-1">New</span>
											<span class="like-icon" title="wishlist"></span>
										</div>
									</a>
									<div class="product-text-dt">
										<p>Available<span>(In Stock)</span></p>
										<h4>Product Title Here</h4>
										<div class="product-price">$10</div>
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
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-15.jpg" alt="">
										<div class="product-absolute-options">
											<span class="offer-badge-1">5% off</span>
											<span class="like-icon" title="wishlist"></span>
										</div>
									</a>
									<div class="product-text-dt">
										<p>Available<span>(In Stock)</span></p>
										<h4>Product Title Here</h4>
										<div class="product-price">$5</div>
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
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-11.jpg" alt="">
										<div class="product-absolute-options">
											<span class="offer-badge-1">New</span>
											<span class="like-icon" title="wishlist"></span>
										</div>
									</a>
									<div class="product-text-dt">
										<p>Available<span>(In Stock)</span></p>
										<h4>Product Title Here</h4>
										<div class="product-price">$15 <span>$16</span></div>
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
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-14.jpg" alt="">
										<div class="product-absolute-options">
											<span class="offer-badge-1">New</span>
											<span class="like-icon" title="wishlist"></span>
										</div>
									</a>
									<div class="product-text-dt">
										<p>Available<span>(In Stock)</span></p>
										<h4>Product Title Here</h4>
										<div class="product-price">$9</div>
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
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-2.jpg" alt="">
										<div class="product-absolute-options">
											<span class="offer-badge-1">New</span>
											<span class="like-icon" title="wishlist"></span>
										</div>
									</a>
									<div class="product-text-dt">
										<p>Available<span>(In Stock)</span></p>
										<h4>Product Title Here</h4>
										<div class="product-price">$7</div>
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
									<a href="single_product_view.jsp" class="product-img">	
										<img src="User/images/product/img-5.jpg" alt="">
										<div class="product-absolute-options">
											<span class="offer-badge-1">New</span>
											<span class="like-icon" title="wishlist"></span>
										</div>
									</a>
									<div class="product-text-dt">
										<p>Available<span>(In Stock)</span></p>
										<h4>Product Title Here</h4>
										<div class="product-price">$6.95</div>
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
									<a href="single_product_view.jsp" class="product-img">
										<img src="User/images/product/img-6.jpg" alt="">
										<div class="product-absolute-options">
											<span class="offer-badge-1">New</span>
											<span class="like-icon" title="wishlist"></span>
										</div>
									</a>
									<div class="product-text-dt">
										<p>Available<span>(In Stock)</span></p>
										<h4>Product Title Here</h4>
										<div class="product-price">$8 <span>8.75</span></div>
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
	<footer class="footer">
		<div class="footer-first-row">
			<div class="container">
				<div class="row">
					<div class="col-md-6 col-sm-6">
						<ul class="call-email-alt">
							<li><a href="#" class="callemail"><i class="uil uil-dialpad-alt"></i>1800-000-000</a></li>
							<li><a href="#" class="callemail"><i class="uil uil-envelope-alt"></i>info@FMartsupermarket.com</a></li>
						</ul>
					</div>
					<div class="col-md-6 col-sm-6">
						<div class="social-links-footer">
							<ul>
								<li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
								<li><a href="#"><i class="fab fa-twitter"></i></a></li>
								<li><a href="#"><i class="fab fa-google-plus-g"></i></a></li>
								<li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
								<li><a href="#"><i class="fab fa-instagram"></i></a></li>
								<li><a href="#"><i class="fab fa-pinterest-p"></i></a></li>
							</ul>
						</div>
					</div>				
				</div>
			</div>
		</div>
		<div class="footer-second-row">
			<div class="container">
				<div class="row">
					<div class="col-lg-3 col-md-6 col-6">
						<div class="second-row-item">
							<h4>Categories</h4>
							<ul>
								<li><a href="#">Fruits and Vegetables</a></li>
								<li><a href="#">Grocery & Staples</a></li>
								<li><a href="#">Dairy & Eggs</a></li>
								<li><a href="#">Beverages</a></li>
								<li><a href="#">Snacks</a></li>
								<li><a href="#">Home Care</a></li>
								<li><a href="#">Noodles & Sauces</a></li>
								<li><a href="shop_grid.jsp">More...</a></li>
							</ul>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 col-6">
						<div class="second-row-item">
							<h4>Useful Links</h4>
							<ul>
								<li><a href="User/about_us.jsp">About US</a></li>
								<li><a href="User/shop_grid.jsp">Featured Products</a></li>
								<li><a href="User/offers.jsp">Offers</a></li>
								<li><a href="User/our_blog.jsp">Blog</a></li>
								<li><a href="User/faq.jsp">Faq</a></li>
								<li><a href="User/career.jsp">Careers</a></li>
								<li><a href="User/contact_us.jsp">Contact Us</a></li>
							</ul>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 col-6">
						<div class="second-row-item">
							<h4>Top Cities</h4>
							<ul>
								<li><a href="#">Gurugram</a></li>
								<li><a href="#">New Delhi</a></li>
								<li><a href="#">Bangaluru</a></li>
								<li><a href="#">Mumbai</a></li>
								<li><a href="#">Hyderabad</a></li>
								<li><a href="#">Kolkata</a></li>
								<li><a href="#">Ludhiana</a></li>
								<li><a href="#">Chandigrah</a></li>
							</ul>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 col-6">
						<div class="second-row-item-app">
							<h4>Download App</h4>
							<ul>
								<li><a href="#"><img class="download-btn mb-2" src="User/images/download-1.svg" alt=""></a></li>
								<li><a href="#"><img class="download-btn mb-2" src="User/images/download-2.svg" alt=""></a></li>
							</ul>
						</div>
						<div class="second-row-item-payment">
							<h4>Payment Method</h4>
							<div class="footer-payments">
								<ul id="paypal-gateway" class="financial-institutes">
									<li class="financial-institutes__logo">
									  <img alt="Visa" title="Visa" src="User/images/footer-icons/pyicon-6.svg">
									</li>
									<li class="financial-institutes__logo">
									  <img alt="Visa" title="Visa" src="User/images/footer-icons/pyicon-1.svg">
									</li>
									<li class="financial-institutes__logo">
									  <img alt="MasterCard" title="MasterCard" src="User/images/footer-icons/pyicon-2.svg">
									</li>
									<li class="financial-institutes__logo">
									  <img alt="American Express" title="American Express" src="User/images/footer-icons/pyicon-3.svg">
									</li>
									<li class="financial-institutes__logo">
									  <img alt="Discover" title="Discover" src="User/images/footer-icons/pyicon-4.svg">
									</li>
								</ul>
							</div>
						</div>
						<div class="second-row-item-payment">
							<h4>Newsletter</h4>
							<div class="newsletter-input">
								<input id="email" name="email" type="text" placeholder="Email Address" class="form-control input-md" required="">
								<button class="newsletter-btn hover-btn" type="submit"><i class="uil uil-telegram-alt"></i></button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="footer-last-row">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="footer-bottom-group">
							<div class="footer-bottom-links">
								<ul>
									<li><a href="about_us.jsp">About</a></li>
									<li><a href="contact_us.jsp">Contact</a></li>
									<li><a href="privacy_policy.jsp">Privacy Policy</a></li>
									<li><a href="term_and_conditions.jsp">Term & Conditions</a></li>
									<li><a href="refund_and_return_policy.jsp">Refund & Return Policy</a></li>
								</ul>
							</div>
							<div class="copyright-text">
								<i class="uil uil-copyright"></i>Copyright 2024 <b>FMartlthemes</b> . All rights reserved
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
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