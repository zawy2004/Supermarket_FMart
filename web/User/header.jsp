<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<header class="header clearfix" >

    <div class="top-header-group">
        <div class="top-header">
            <div class="main_logo" id="logo">
                <a href="home"><img src="User/images/logoFM.png" alt=""></a>
                <a href="home"><img class="logo-inverse" src="User/images/dark-logo.svg" alt=""></a>
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
                                <% if (user != null) {%>
                                <%= user.getFullName()%>
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
                            <a href="profile?action=overview" class="channel_item">
                                <i class="uil uil-apps icon__1"></i>Dashboard
                            </a>

                            <a href="profile?action=orders"" class="channel_item"><i class="uil uil-box icon__1"></i>My Orders</a>
                            <a href="profile?action=wishlist" class="channel_item"><i class="uil uil-heart icon__1"></i>My Wishlist</a>
                            <a href="profile?action=wallet" class="channel_item"><i class="uil uil-usd-circle icon__1"></i>My Wallet</a>
                            <a href="profile?action=addresses" class="channel_item"><i class="uil uil-location-point icon__1"></i>My Address</a>
                            <a href="User/offers.jsp" class="channel_item"><i class="uil uil-gift icon__1"></i>Offers</a>
                            <a href="User/faq.jsp" class="channel_item"><i class="uil uil-info-circle icon__1"></i>Faq</a>
                            <a href="login" class="channel_item"><i class="uil uil-lock-alt icon__1"></i>Logout</a>
                        </div>
                        <% }%>
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