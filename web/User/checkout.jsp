<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=9">
    <meta name="description" content="FMart Supermarket Checkout">
    <meta name="author" content="Your Team">
    <title>FMart - Checkout</title>

    <!-- Favicon Icon -->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/User/images/fav.png">

    <!-- Stylesheets -->
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/night-mode.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/css/step-wizard.css" rel="stylesheet">

    <!-- Vendor Stylesheets -->
    <link href="${pageContext.request.contextPath}/User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/OwlCarousel/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">
</head>
<body>
    <!-- Category Model Start -->
    <div class="header-cate-model main-gambo-model modal fade" id="category_model" tabindex="-1" role="dialog" aria-modal="false">
        <div class="modal-dialog category-area" role="document">
            <div class="category-area-inner">
                <div class="modal-header">
                    <button type="button" class="close btn-close" data-bs-dismiss="modal" aria-label="Close">
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
                                    <img src="${pageContext.request.contextPath}/User/images/category/icon-1.svg" alt="">
                                </div>
                                <div class="text"> Fruits and Vegetables </div>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="single-cat-item">
                                <div class="icon">
                                    <img src="${pageContext.request.contextPath}/User/images/category/icon-2.svg" alt="">
                                </div>
                                <div class="text"> Grocery & Staples </div>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="single-cat-item">
                                <div class="icon">
                                    <img src="${pageContext.request.contextPath}/User/images/category/icon-3.svg" alt="">
                                </div>
                                <div class="text"> Dairy & Eggs </div>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="single-cat-item">
                                <div class="icon">
                                    <img src="${pageContext.request.contextPath}/User/images/category/icon-4.svg" alt="">
                                </div>
                                <div class="text"> Beverages </div>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="single-cat-item">
                                <div class="icon">
                                    <img src="${pageContext.request.contextPath}/User/images/category/icon-5.svg" alt="">
                                </div>
                                <div class="text"> Snacks </div>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="single-cat-item">
                                <div class="icon">
                                    <img src="${pageContext.request.contextPath}/User/images/category/icon-6.svg" alt="">
                                </div>
                                <div class="text"> Home Care </div>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="single-cat-item">
                                <div class="icon">
                                    <img src="${pageContext.request.contextPath}/User/images/category/icon-7.svg" alt="">
                                </div>
                                <div class="text"> Noodles & Sauces </div>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="single-cat-item">
                                <div class="icon">
                                    <img src="${pageContext.request.contextPath}/User/images/category/icon-8.svg" alt="">
                                </div>
                                <div class="text"> Personal Care </div>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="single-cat-item">
                                <div class="icon">
                                    <img src="${pageContext.request.contextPath}/User/images/category/icon-9.svg" alt="">
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
    <!-- Category Model End -->
    <!-- Search Model Start -->
    <div id="search_model" class="header-cate-model main-gambo-model modal fade" tabindex="-1" role="dialog" aria-modal="false">
        <div class="modal-dialog search-ground-area" role="document">
            <div class="category-area-inner">
                <div class="modal-header">
                    <button type="button" class="close btn-close" data-bs-dismiss="modal" aria-label="Close">
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
                                <img src="${pageContext.request.contextPath}/User/images/category/icon-1.svg" alt="">
                            </div>
                            <div class="text">
                                Fruits and Vegetables
                            </div>
                        </a>
                        <a href="#" class="single-cat">
                            <div class="icon">
                                <img src="${pageContext.request.contextPath}/User/images/category/icon-2.svg" alt="">
                            </div>
                            <div class="text"> Grocery & Staples </div>
                        </a>
                        <a href="#" class="single-cat">
                            <div class="icon">
                                <img src="${pageContext.request.contextPath}/User/images/category/icon-3.svg" alt="">
                            </div>
                            <div class="text"> Dairy & Eggs </div>
                        </a>
                        <a href="#" class="single-cat">
                            <div class="icon">
                                <img src="${pageContext.request.contextPath}/User/images/category/icon-4.svg" alt="">
                            </div>
                            <div class="text"> Beverages </div>
                        </a>
                        <a href="#" class="single-cat">
                            <div class="icon">
                                <img src="${pageContext.request.contextPath}/User/images/category/icon-5.svg" alt="">
                            </div>
                            <div class="text"> Snacks </div>
                        </a>
                        <a href="#" class="single-cat">
                            <div class="icon">
                                <img src="${pageContext.request.contextPath}/User/images/category/icon-6.svg" alt="">
                            </div>
                            <div class="text"> Home Care </div>
                        </a>
                        <a href="#" class="single-cat">
                            <div class="icon">
                                <img src="${pageContext.request.contextPath}/User/images/category/icon-7.svg" alt="">
                            </div>
                            <div class="text"> Noodles & Sauces </div>
                        </a>
                        <a href="#" class="single-cat">
                            <div class="icon">
                                <img src="${pageContext.request.contextPath}/User/images/category/icon-8.svg" alt="">
                            </div>
                            <div class="text"> Personal Care </div>
                        </a>
                        <a href="#" class="single-cat">
                            <div class="icon">
                                <img src="${pageContext.request.contextPath}/User/images/category/icon-9.svg" alt="">
                            </div>
                            <div class="text"> Pet Care </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Search Model End -->
    <!-- Cart Sidebar Offcanvas Start -->
    <jsp:include page="cart_sidebar.jsp"></jsp:include>
    <!-- Header Start -->
    <jsp:include page="search_model.jsp"></jsp:include>
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
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Checkout</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <div class="all-product-grid">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-md-7">
                        <div id="checkout_wizard" class="checkout accordion left-chck145">
                            <div class="checkout-step">
                                <div class="checkout-card" id="headingOne"> 
                                    <span class="checkout-step-number">1</span>
                                    <h4 class="checkout-step-title"> 
                                        <button class="wizard-btn" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne"> Phone Number Verification</button>
                                    </h4>
                                </div>
                                <div id="collapseOne" class="collapse show" data-bs-parent="#checkout_wizard">
                                    <div class="checkout-step-body">
                                        <p>We need your phone number so we can inform you about any delay or problem.</p>	
                                        <p class="phn145">4 digits code send your phone <span>+910000000000</span><a class="edit-no-btn hover-btn" data-bs-toggle="collapse" href="#edit-number">Edit</a></p>
                                        <div class="collapse" id="edit-number">
                                            <div class="row">
                                                <div class="col-lg-8">
                                                    <div class="checkout-login">
                                                        <form>
                                                            <div class="login-phone">
                                                                <input type="text" class="form-control" placeholder="Phone Number">
                                                            </div>
                                                            <a class="chck-btn hover-btn" role="button" data-bs-toggle="collapse" href="#otp-verifaction" >Send Code</a>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="otp-verifaction">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="form-group mb-0">
                                                        <label class="control-label">Enter Code</label>
                                                        <ul class="code-alrt-inputs">
                                                            <li>
                                                                <input id="code[1]" name="number" type="text" placeholder="" class="form-control input-md" required="">
                                                            </li>
                                                            <li>
                                                                <input id="code[2]" name="number" type="text" placeholder="" class="form-control input-md" required="">
                                                            </li>
                                                            <li>
                                                                <input id="code[3]" name="number" type="text" placeholder="" class="form-control input-md" required="">
                                                            </li>
                                                            <li>
                                                                <input id="code[4]" name="number" type="text" placeholder="" class="form-control input-md" required="">
                                                            </li>
                                                            <li>
                                                                <a class="collapsed chck-btn hover-btn" role="button" data-bs-toggle="collapse" data-bs-parent="#checkout_wizard" href="#collapseTwo">Next</a>
                                                            </li>
                                                        </ul>
                                                        <a href="#" class="resend-link">Resend Code</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="checkout-step">
                                <div class="checkout-card" id="headingTwo">
                                    <span class="checkout-step-number">2</span>
                                    <h4 class="checkout-step-title">
                                        <button class="wizard-btn collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"> Delivery Address</button>
                                    </h4>
                                </div>
                                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-bs-parent="#checkout_wizard">
                                    <div class="checkout-step-body">
                                        <div class="checout-address-step">
                                            <div class="row">
                                                <div class="col-lg-12">												
                                                    <form class="">
                                                        <!-- Multiple Radios (inline) -->
                                                        <div class="form-group">
                                                            <div class="product-radio">
                                                                <ul class="product-now">
                                                                    <li>
                                                                        <input type="radio" id="ad1" name="address1" checked>
                                                                        <label for="ad1">Home</label>
                                                                    </li>
                                                                    <li>
                                                                        <input type="radio" id="ad2" name="address1">
                                                                        <label for="ad2">Office</label>
                                                                    </li>
                                                                    <li>
                                                                        <input type="radio" id="ad3" name="address1">
                                                                        <label for="ad3">Other</label>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="address-fieldset">
                                                            <div class="row">
                                                                <div class="col-lg-6 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Name*</label>
                                                                        <input id="name" name="name" type="text" placeholder="Name" class="form-control input-md" required="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Email Address*</label>
                                                                        <input id="email1" name="email1" type="text" placeholder="Email Address" class="form-control input-md" required="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-12 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Flat / House / Office No.*</label>
                                                                        <input id="flat" name="flat" type="text" placeholder="Address" class="form-control input-md" required="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-12 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Street / Society / Office Name*</label>
                                                                        <input id="street" name="street" type="text" placeholder="Street Address" class="form-control input-md">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Pincode*</label>
                                                                        <input id="pincode" name="pincode" type="text" placeholder="Pincode" class="form-control input-md" required="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Locality*</label>
                                                                        <input id="Locality" name="locality" type="text" placeholder="Enter City" class="form-control input-md" required="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-12 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <div class="address-btns">
                                                                            <button class="save-btn14 hover-btn">Save</button>
                                                                            <a class="collapsed ms-auto next-btn16 hover-btn" role="button" data-bs-toggle="collapse" data-bs-parent="#checkout_wizard" href="#collapseThree"> Next </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="checkout-step">
                                    <div class="checkout-card" id="headingThree"> 
                                        <span class="checkout-step-number">3</span>
                                        <h4 class="checkout-step-title">
                                            <button class="wizard-btn collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree"> Delivery Time & Date </button>
                                        </h4>
                                    </div>
                                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-bs-parent="#checkout_wizard">
                                        <div class="checkout-step-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Select Date and Time*</label>
                                                        <div class="date-slider-group">
                                                            <div class="owl-carousel date-slider owl-theme">
                                                                <div class="item">
                                                                    <div class="date-now">
                                                                        <input type="radio" id="dd1" name="address1" checked="">
                                                                        <label for="dd1">Today</label>
                                                                    </div>
                                                                </div>
                                                                <div class="item">
                                                                    <div class="date-now">
                                                                        <input type="radio" id="dd2" name="address1">
                                                                        <label for="dd2">Tomorrow</label>
                                                                    </div>
                                                                </div>
                                                                <div class="item">
                                                                    <div class="date-now">
                                                                        <input type="radio" id="dd3" name="address1">
                                                                        <label for="dd3">10 May 2020</label>
                                                                    </div>
                                                                </div>
                                                                <div class="item">
                                                                    <div class="date-now">
                                                                        <input type="radio" id="dd4" name="address1">
                                                                        <label for="dd4">11 May 2020</label>
                                                                    </div>
                                                                </div>
                                                                <div class="item">
                                                                    <div class="date-now">
                                                                        <input type="radio" id="dd5" name="address1">
                                                                        <label for="dd5">12 May 2020</label>
                                                                    </div>
                                                                </div>
                                                                <div class="item">
                                                                    <div class="date-now">
                                                                        <input type="radio" id="dd6" name="address1">
                                                                        <label for="dd6">13 May 2020</label>
                                                                    </div>
                                                                </div>
                                                                <div class="item">
                                                                    <div class="date-now">
                                                                        <input type="radio" id="dd7" name="address1">
                                                                        <label for="dd7">14 May 2020</label>
                                                                    </div>
                                                                </div>
                                                                <div class="item">
                                                                    <div class="date-now">
                                                                        <input type="radio" id="dd8" name="address1">
                                                                        <label for="dd8">15 May 2020</label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="time-radio mt-4">
                                                            <div class="grouped fields">
                                                                <div class="form-check mb-3">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
                                                                    <label class="form-check-label ms-1" for="flexRadioDefault1">
                                                                        8.00AM - 10.00AM
                                                                    </label>
                                                                </div>
                                                                <div class="form-check mb-3">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2">
                                                                    <label class="form-check-label ms-1" for="flexRadioDefault2">
                                                                        10.00AM - 12.00PM
                                                                    </label>
                                                                </div>
                                                                <div class="form-check mb-3">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault3">
                                                                    <label class="form-check-label ms-1" for="flexRadioDefault3">
                                                                        12.00PM - 2.00PM
                                                                    </label>
                                                                </div>
                                                                <div class="form-check mb-3">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault4">
                                                                    <label class="form-check-label ms-1" for="flexRadioDefault4">
                                                                        2.00PM - 4.00PM
                                                                    </label>
                                                                </div>
                                                                <div class="form-check mb-3">
                                                                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault5">
                                                                    <label class="form-check-label ms-1" for="flexRadioDefault5">
                                                                        4.00PM - 6.00PM
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <a class="collapsed next-btn16 mt-4 hover-btn" role="button" data-bs-toggle="collapse" href="#collapseFour"> Proccess to payment </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="checkout-step">
                                    <div class="checkout-card" id="headingFour">
                                        <span class="checkout-step-number">4</span>
                                        <h4 class="checkout-step-title"> 
                                            <button class="wizard-btn collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">Payment</button>
                                        </h4>
                                    </div>
                                    <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-bs-parent="#checkout_wizard">
                                        <div class="checkout-step-body">
                                            <div class="payment_method-checkout">	
                                                <div class="row">	
                                                    <div class="col-md-12">
                                                        <div class="rpt100">													
                                                            <ul class="radio--group-inline-container_1">
                                                                <li>
                                                                    <div class="radio-item_1">
                                                                        <input id="cashondelivery1" value="cashondelivery" name="paymentmethod" type="radio" data-minimum="50.0" checked>
                                                                        <label for="cashondelivery1" class="radio-label_1">Cash on Delivery</label>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="radio-item_1">
                                                                        <input id="card1" value="card" name="paymentmethod" type="radio" data-minimum="50.0">
                                                                        <label for="card1" class="radio-label_1">Credit / Debit Card</label>
                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="form-group return-departure-dts" data-method="cashondelivery" style="display: block;">															
                                                            <div class="row">
                                                                <div class="col-lg-12">
                                                                    <div class="pymnt_title">
                                                                        <h4>Cash on Delivery</h4>
                                                                        <p>Cash on Delivery will not be available if your order value exceeds $10.</p>
                                                                    </div>
                                                                </div>														
                                                            </div>
                                                        </div>
                                                        <div class="form-group return-departure-dts main-form" data-method="card">															
                                                            <div class="row">
                                                                <div class="col-lg-12">
                                                                    <div class="pymnt_title mb-0">
                                                                        <h4 class="mb-0">Credit / Debit Card</h4>
                                                                    </div>
                                                                </div>														
                                                                <div class="col-lg-6">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Holder Name*</label>
                                                                        <div class="ui search focus">
                                                                            <div class="ui left icon input swdh11 swdh19">
                                                                                <input class="prompt srch_explore" type="text" name="holdername" value="" id="holder[name]" required="" maxlength="64" placeholder="Holder Name">															
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Card Number*</label>
                                                                        <div class="ui search focus">
                                                                            <div class="ui left icon input swdh11 swdh19">
                                                                                <input class="prompt srch_explore" type="text" name="cardnumber" value="" id="card[number]" required="" maxlength="64" placeholder="Card Number">															
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4">
                                                                    <div class="form-group mt-30">																	
                                                                        <label class="control-label">Expiration Month*</label>
                                                                        <select class="selectpicker" title="Select Month" data-size="5">
                                                                            <option value="">Month</option>
                                                                            <option value="1">January</option>
                                                                            <option value="2">February</option>
                                                                            <option value="3">March</option>
                                                                            <option value="4">April</option>
                                                                            <option value="5">May</option>
                                                                            <option value="6">June</option>
                                                                            <option value="7">July</option>
                                                                            <option value="8">August</option>
                                                                            <option value="9">September</option>
                                                                            <option value="10">October</option>
                                                                            <option value="11">November</option>
                                                                            <option value="12">December</option>
                                                                        </select>	
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Expiration Year*</label>
                                                                        <div class="ui search focus">
                                                                            <div class="ui left icon input swdh11 swdh19">
                                                                                <input class="prompt srch_explore" type="text" name="card[expire-year]" maxlength="4" placeholder="Year">															
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">CVV*</label>
                                                                        <div class="ui search focus">
                                                                            <div class="ui left icon input swdh11 swdh19">
                                                                                <input class="prompt srch_explore" name="card[cvc]" maxlength="3" placeholder="CVV">															
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <a href="#" class="next-btn16 hover-btn">Place Order</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Order Summary (bên ph?i) -->
                    </div>
                    <div class="col-lg-4 col-md-5">
                        <div class="pdpt-bg mt-0">
                            <div class="pdpt-title">
                                <h4>Order Summary</h4>
                            </div>
                            <div class="right-cart-dt-body">
                                <c:if test="${not empty cartItems}">
                                    <c:forEach var="cartItem" items="${cartItems}">
                                        <div class="cart-item border_radius">
                                            <div class="cart-product-img">
                                                <img src="${pageContext.request.contextPath}/User/images/product/img-${cartItem.productID}.jpg" alt="${cartItem.productName}">
                                            </div>
                                            <div class="cart-text">
                                                <h4>${cartItem.productName}</h4>
                                                <div class="cart-item-price">
                                                    $<fmt:formatNumber value="${cartItem.sellingPrice * cartItem.quantity}" maxFractionDigits="2"/>
                                                </div>
                                                <p>Quantity: ${cartItem.quantity} ${cartItem.unit}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty cartItems}">
                                    <div class="text-center p-4">
                                        <p class="text-muted">No items selected for checkout.</p>
                                        <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">Shop Now</a>
                                    </div>
                                </c:if>
                            </div>
                            <div class="total-checkout-group">
                                <div class="cart-total-dil">
                                    <h4>FMart Super Market</h4>
                                    <span>$<fmt:formatNumber value="${cartTotal != null ? cartTotal : 0}" maxFractionDigits="2"/></span>
                                </div>
                                <div class="cart-total-dil pt-3">
                                    <h4>Delivery Charges</h4>
                                    <span>$<fmt:formatNumber value="${deliveryCharge != null ? deliveryCharge : 1}" maxFractionDigits="2"/></span>
                                </div>
                            </div>
                            <div class="cart-total-dil saving-total">
                                <h4>Total Saving</h4>
                                <span>$<fmt:formatNumber value="${totalSaving != null ? totalSaving : 0}" maxFractionDigits="2"/></span>
                            </div>
                            <div class="main-total-cart p-4">
                                <h2>Total</h2>
                                <span>$<fmt:formatNumber value="${cartTotal != null ? cartTotal + (deliveryCharge != null ? deliveryCharge : 1) : 0}" maxFractionDigits="2"/></span>
                            </div>
                            <div class="payment-secure">
                                <i class="uil uil-padlock"></i>Secure checkout
                            </div>
                        </div>
                        <a href="#" class="promo-link45">Have a promocode?</a>
                        <div class="checkout-safety-alerts">
                            <p><i class="uil uil-sync"></i>100% Replacement Guarantee</p>
                            <p><i class="uil uil-check-square"></i>100% Genuine Products</p>
                            <p><i class="uil uil-shield-check"></i>Secure Payments</p>
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
    <script src="${pageContext.request.contextPath}/User/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/User/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/User/vendor/OwlCarousel/owl.carousel.js"></script>
    <script src="${pageContext.request.contextPath}/User/js/custom.js"></script>
    <script src="${pageContext.request.contextPath}/User/js/product.thumbnail.slider.js"></script>
    <script src="${pageContext.request.contextPath}/User/js/offset_overlay.js"></script>
    <script src="${pageContext.request.contextPath}/User/js/night-mode.js"></script>
    <script>
        // Include các hàm từ cart_sidebar.jsp nếu cần
        function updateCart(cartId, quantity) {
            if (quantity < 1) {
                removeFromCart(cartId);
                return;
            }
            $.ajax({
                url: '${pageContext.request.contextPath}/cart',
                type: 'POST',
                data: {
                    action: 'update',
                    cartId: cartId,
                    quantity: quantity
                },
                success: function(response) {
                    showNotification('Cart updated successfully!', 'success');
                    location.reload(); // Tải lại trang để cập nhật giỏ hàng
                },
                error: function(xhr) {
                    showNotification('Error updating cart: ' + xhr.responseText, 'error');
                }
            });
        }

        function removeFromCart(cartId) {
            $.ajax({
                url: '${pageContext.request.contextPath}/cart',
                type: 'POST',
                data: {
                    action: 'remove',
                    cartId: cartId
                },
                success: function(response) {
                    showNotification('Item removed from cart!', 'success');
                    location.reload(); // Tải lại trang để cập nhật giỏ hàng
                },
                error: function(xhr) {
                    showNotification('Error removing item: ' + xhr.responseText, 'error');
                }
            });
        }

        function applyPromoCode() {
            const promoCode = document.getElementById('promoCodeInput').value;
            $.ajax({
                url: '${pageContext.request.contextPath}/cart',
                type: 'POST',
                data: {
                    action: 'applyPromo',
                    promoCode: promoCode
                },
                success: function(response) {
                    showNotification('Promo code applied successfully!', 'success');
                    $('#promoCodeModal').modal('hide');
                    location.reload();
                },
                error: function(xhr) {
                    showNotification('Error applying promo code: ' + xhr.responseText, 'error');
                }
            });
        }

        function showNotification(message, type) {
            const existingNotifications = document.querySelectorAll('.toast-notification');
            existingNotifications.forEach(notif => notif.remove());

            const notification = document.createElement('div');
            const alertType = type === 'success' ? 'success' : type === 'info' ? 'info' : 'danger';
            notification.className = 'alert alert-' + alertType + ' alert-dismissible fade show toast-notification';
            notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);';

            const icon = type === 'success' ? 'check-circle' : type === 'info' ? 'info-circle' : 'exclamation-circle';
            notification.innerHTML = 
                '<i class="fas fa-' + icon + ' me-2"></i>' + 
                message + 
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';

            document.body.appendChild(notification);

            setTimeout(function() {
                if (notification.parentNode) {
                    notification.remove();
                }
            }, 3000);
        }

        $(document).ready(function() {
            $('.date-slider').owlCarousel({
                loop: false,
                margin: 10,
                nav: false,
                dots: false,
                responsive: {
                    0: { items: 3 },
                    600: { items: 4 },
                    1000: { items: 5 },
                    1200: { items: 6 },
                    1400: { items: 7 }
                }
            });
        });
    </script>
</body>
</html>