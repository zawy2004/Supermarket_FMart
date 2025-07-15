<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=9">
    <meta name="description" content="FMart Supermarket Checkout">
    <meta name="author" content="Your Team">
    <title>FMart - Thanh toán</title>

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

    <style>
        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .payment-method-radio label {
            cursor: pointer;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .payment-method-radio input:checked + label {
            border-color: #007bff;
            background: #e7f1ff;
        }
        .payment-method-radio img {
            width: 24px;
            height: 24px;
            margin-right: 10px;
        }
        .phone-verified {
            color: #28a745;
            font-weight: 500;
        }
    </style>
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
                        <h4>Chọn danh mục</h4>
                    </div>
                    <ul class="category-by-cat">
                        <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-1.svg" alt=""></div><div class="text"> Trái cây và Rau củ </div></a></li>
                        <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-2.svg" alt=""></div><div class="text"> Thực phẩm & Hàng khô </div></a></li>
                        <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-3.svg" alt=""></div><div class="text"> Sữa & Trứng </div></a></li>
                        <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-4.svg" alt=""></div><div class="text"> Đồ uống </div></a></li>
                        <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-5.svg" alt=""></div><div class="text"> Đồ ăn nhẹ </div></a></li>
                        <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-6.svg" alt=""></div><div class="text"> Chăm sóc nhà cửa </div></a></li>
                        <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-7.svg" alt=""></div><div class="text"> Mì & Nước chấm </div></a></li>
                        <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-8.svg" alt=""></div><div class="text"> Chăm sóc cá nhân </div></a></li>
                        <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-9.svg" alt=""></div><div class="text"> Chăm sóc thú cưng </div></a></li>
                    </ul>
                    <a href="#" class="morecate-btn"><i class="uil uil-apps"></i>Thêm danh mục</a>
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
                            <input type="search" placeholder="Tìm kiếm sản phẩm...">
                            <button type="submit"><i class="uil uil-search"></i></button>
                        </form>
                    </div>
                    <div class="search-by-cat">
                        <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-1.svg" alt=""></div><div class="text"> Trái cây và Rau củ </div></a>
                        <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-2.svg" alt=""></div><div class="text"> Thực phẩm & Hàng khô </div></a>
                        <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-3.svg" alt=""></div><div class="text"> Sữa & Trứng </div></a>
                        <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-4.svg" alt=""></div><div class="text"> Đồ uống </div></a>
                        <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-5.svg" alt=""></div><div class="text"> Đồ ăn nhẹ </div></a>
                        <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-6.svg" alt=""></div><div class="text"> Chăm sóc nhà cửa </div></a>
                        <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-7.svg" alt=""></div><div class="text"> Mì & Nước chấm </div></a>
                        <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-8.svg" alt=""></div><div class="text"> Chăm sóc cá nhân </div></a>
                        <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-9.svg" alt=""></div><div class="text"> Chăm sóc thú cưng </div></a>
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
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Thanh toán</li>
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
                                        <button class="wizard-btn" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">Xác minh số điện thoại</button>
                                    </h4>
                                </div>
                                <div id="collapseOne" class="collapse show" data-bs-parent="#checkout_wizard">
                                    <div class="checkout-step-body">
                                        <p>Số điện thoại của bạn được sử dụng để gửi thông báo đơn hàng và liên kết với ví ZaloPay (nếu chọn thanh toán ZaloPay).</p>
                                        <c:if test="${not empty sessionScope.userPhone}">
                                            <p class="phone-verified">Số điện thoại: <span id="phoneDisplay">${sessionScope.userPhone}</span> <i class="fas fa-check-circle"></i> <a class="edit-no-btn hover-btn" data-bs-toggle="collapse" href="#edit-number">Chỉnh sửa</a></p>
                                        </c:if>
                                        <c:if test="${empty sessionScope.userPhone}">
                                            <p class="text-muted">Chưa có số điện thoại được xác minh. Vui lòng nhập số điện thoại.</p>
                                        </c:if>
                                        <div class="collapse ${empty sessionScope.userPhone ? 'show' : ''}" id="edit-number">
                                            <div class="row">
                                                <div class="col-lg-8">
                                                    <div class="checkout-login">
                                                        <form id="phoneForm">
                                                            <div class="login-phone">
                                                                <input type="text" id="phoneInput" class="form-control" placeholder="Số điện thoại" value="${sessionScope.userPhone}">
                                                            </div>
                                                            <button type="button" class="chck-btn hover-btn" onclick="sendVerificationCode()">Gửi mã xác minh</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="otp-verifaction" style="display: none;" id="otpSection">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="form-group mb-0">
                                                        <label class="control-label">Nhập mã xác minh (4 chữ số)</label>
                                                        <ul class="code-alrt-inputs">
                                                            <li><input id="code1" name="code" type="text" maxlength="1" class="form-control input-md" required=""></li>
                                                            <li><input id="code2" name="code" type="text" maxlength="1" class="form-control input-md" required=""></li>
                                                            <li><input id="code3" name="code" type="text" maxlength="1" class="form-control input-md" required=""></li>
                                                            <li><input id="code4" name="code" type="text" maxlength="1" class="form-control input-md" required=""></li>
                                                            <li>
                                                                <button type="button" class="chck-btn hover-btn" onclick="verifyCode()">Xác minh</button>
                                                            </li>
                                                        </ul>
                                                        <a href="#" class="resend-link" onclick="sendVerificationCode()">Gửi lại mã</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <c:if test="${not empty sessionScope.userPhone}">
                                            <button class="next-btn16 hover-btn" data-bs-toggle="collapse" data-bs-target="#collapseTwo">Tiếp tục</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="checkout-step">
                                <div class="checkout-card" id="headingTwo">
                                    <span class="checkout-step-number">2</span>
                                    <h4 class="checkout-step-title">
                                        <button class="wizard-btn collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">Địa chỉ giao hàng</button>
                                    </h4>
                                </div>
                                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-bs-parent="#checkout_wizard">
                                    <div class="checkout-step-body">
                                        <div class="checout-address-step">
                                            <div class="row">
                                                <div class="col-lg-12">                                                
                                                    <form id="addressForm">
                                                        <div class="form-group">
                                                            <div class="product-radio">
                                                                <ul class="product-now">
                                                                    <li>
                                                                        <input type="radio" id="ad1" name="addressType" value="home" checked>
                                                                        <label for="ad1">Nhà riêng</label>
                                                                    </li>
                                                                    <li>
                                                                        <input type="radio" id="ad2" name="addressType" value="office">
                                                                        <label for="ad2">Văn phòng</label>
                                                                    </li>
                                                                    <li>
                                                                        <input type="radio" id="ad3" name="addressType" value="other">
                                                                        <label for="ad3">Khác</label>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="address-fieldset">
                                                            <div class="row">
                                                                <div class="col-lg-6 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Họ và tên*</label>
                                                                        <input id="name" name="name" type="text" placeholder="Họ và tên" class="form-control input-md" required="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Email*</label>
                                                                        <input id="email" name="email" type="email" placeholder="Địa chỉ email" class="form-control input-md" required="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-12 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Số nhà / Tòa nhà / Văn phòng*</label>
                                                                        <input id="flat" name="flat" type="text" placeholder="Địa chỉ" class="form-control input-md" required="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-12 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Tên đường / Khu vực / Tên văn phòng*</label>
                                                                        <input id="street" name="street" type="text" placeholder="Địa chỉ đường" class="form-control input-md">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Mã bưu điện*</label>
                                                                        <input id="pincode" name="pincode" type="text" placeholder="Mã bưu điện" class="form-control input-md" required="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <label class="control-label">Khu vực*</label>
                                                                        <input id="locality" name="locality" type="text" placeholder="Thành phố" class="form-control input-md" required="">
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-12 col-md-12">
                                                                    <div class="form-group mt-30">
                                                                        <div class="address-btns">
                                                                            <button type="button" class="save-btn14 hover-btn" onclick="saveAddress()">Lưu</button>
                                                                            <a class="collapsed ms-auto next-btn16 hover-btn" role="button" data-bs-toggle="collapse" data-bs-parent="#checkout_wizard" href="#collapseThree">Tiếp tục</a>
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
                            </div>
                            <div class="checkout-step">
                                <div class="checkout-card" id="headingThree"> 
                                    <span class="checkout-step-number">3</span>
                                    <h4 class="checkout-step-title">
                                        <button class="wizard-btn collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">Thời gian & Ngày giao hàng</button>
                                    </h4>
                                </div>
                                <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-bs-parent="#checkout_wizard">
                                    <div class="checkout-step-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label class="control-label">Chọn ngày và giờ*</label>
                                                    <div class="date-slider-group">
                                                        <div class="owl-carousel date-slider owl-theme">
                                                            <div class="item">
                                                                <div class="date-now">
                                                                    <input type="radio" id="dd1" name="deliveryDate" value="today" checked>
                                                                    <label for="dd1">Hôm nay</label>
                                                                </div>
                                                            </div>
                                                            <div class="item">
                                                                <div class="date-now">
                                                                    <input type="radio" id="dd2" name="deliveryDate" value="tomorrow">
                                                                    <label for="dd2">Ngày mai</label>
                                                                </div>
                                                            </div>
                                                            <c:forEach begin="2" end="7" var="i">
                                                                <div class="item">
                                                                    <div class="date-now">
                                                                        <input type="radio" id="dd${i+1}" name="deliveryDate" value="${i} days">
                                                                        <label for="dd${i+1}"><fmt:formatDate value="${java.time.LocalDate.now().plusDays(i)}" pattern="dd MMM yyyy"/></label>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                    <div class="time-radio mt-4">
                                                        <div class="grouped fields">
                                                            <div class="form-check mb-3">
                                                                <input class="form-check-input" type="radio" name="deliveryTime" id="time1" value="08:00-10:00" checked>
                                                                <label class="form-check-label ms-1" for="time1">8:00 - 10:00</label>
                                                            </div>
                                                            <div class="form-check mb-3">
                                                                <input class="form-check-input" type="radio" name="deliveryTime" id="time2" value="10:00-12:00">
                                                                <label class="form-check-label ms-1" for="time2">10:00 - 12:00</label>
                                                            </div>
                                                            <div class="form-check mb-3">
                                                                <input class="form-check-input" type="radio" name="deliveryTime" id="time3" value="12:00-14:00">
                                                                <label class="form-check-label ms-1" for="time3">12:00 - 14:00</label>
                                                            </div>
                                                            <div class="form-check mb-3">
                                                                <input class="form-check-input" type="radio" name="deliveryTime" id="time4" value="14:00-16:00">
                                                                <label class="form-check-label ms-1" for="time4">14:00 - 16:00</label>
                                                            </div>
                                                            <div class="form-check mb-3">
                                                                <input class="form-check-input" type="radio" name="deliveryTime" id="time5" value="16:00-18:00">
                                                                <label class="form-check-label ms-1" for="time5">16:00 - 18:00</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <a class="collapsed next-btn16 mt-4 hover-btn" role="button" data-bs-toggle="collapse" href="#collapseFour">Tiến hành thanh toán</a>
                                    </div>
                                </div>
                            </div>
                            <div class="checkout-step">
                                <div class="checkout-card" id="headingFour">
                                    <span class="checkout-step-number">4</span>
                                    <h4 class="checkout-step-title"> 
                                        <button class="wizard-btn collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">Thanh toán</button>
                                    </h4>
                                </div>
                                <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-bs-parent="#checkout_wizard">
                                    <div class="checkout-step-body">
                                        <div class="payment_method-checkout">    
                                            <div class="row">    
                                                <div class="col-md-12">
                                                    <div class="rpt100">                                                    
                                                        <ul class="radio--group-inline-container_1 payment-method-radio">
                                                            <li>
                                                                <div class="radio-item_1">
                                                                    <input id="cashondelivery" value="cod" name="paymentmethod" type="radio" checked>
                                                                    <label for="cashondelivery" class="radio-label_1">
                                                                        <img src="${pageContext.request.contextPath}/User/images/icons/cod.png" alt="COD"> Thanh toán khi nhận hàng
                                                                    </label>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="radio-item_1">
                                                                    <input id="zalopay" value="zalopay" name="paymentmethod" type="radio">
                                                                    <label for="zalopay" class="radio-label_1">
                                                                        <img src="${pageContext.request.contextPath}/User/images/icons/zalopay.png" alt="ZaloPay"> Thanh toán qua ZaloPay
                                                                    </label>
                                                                </div>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                    <div class="form-group return-departure-dts" data-method="cod" style="display: block;">                                                            
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="pymnt_title">
                                                                    <h4>Thanh toán khi nhận hàng</h4>
                                                                    <p>Thanh toán khi nhận hàng không áp dụng cho đơn hàng trên 10 triệu đồng.</p>
                                                                </div>
                                                            </div>                                                        
                                                        </div>
                                                    </div>
                                                    <div class="form-group return-departure-dts main-form" data-method="zalopay" style="display: none;">                                                            
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="pymnt_title mb-0">
                                                                    <h4 class="mb-0">Thanh toán qua ZaloPay</h4>
                                                                    <p>Thanh toán an toàn và nhanh chóng qua ví ZaloPay hoặc các phương thức khác.</p>
                                                                </div>
                                                            </div>                                                        
                                                        </div>
                                                    </div>
                                                    <button type="button" class="next-btn16 hover-btn" onclick="placeOrder()">Đặt hàng</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-5">
                        <div class="pdpt-bg mt-0">
                            <div class="pdpt-title">
                                <h4>Tóm tắt đơn hàng</h4>
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
                                                    <fmt:formatNumber value="${cartItem.sellingPrice * cartItem.quantity}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                                                </div>
                                                <p>Số lượng: ${cartItem.quantity} ${cartItem.unit}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty cartItems}">
                                    <div class="text-center p-4">
                                        <p class="text-muted">Không có sản phẩm nào trong giỏ hàng.</p>
                                        <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">Mua sắm ngay</a>
                                    </div>
                                </c:if>
                            </div>
                            <div class="total-checkout-group">
                                <div class="cart-total-dil">
                                    <h4>Tổng giỏ hàng</h4>
                                    <span><fmt:formatNumber value="${cartTotal != null ? cartTotal : 0}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                                </div>
                                <div class="cart-total-dil pt-3">
                                    <h4>Phí giao hàng</h4>
                                    <span><fmt:formatNumber value="${deliveryCharge != null ? deliveryCharge : 30000}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                                </div>
                            </div>
                            <div class="cart-total-dil saving-total">
                                <h4>Tổng tiết kiệm</h4>
                                <span><fmt:formatNumber value="${totalSaving != null ? totalSaving : 0}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                            </div>
                            <div class="main-total-cart p-4">
                                <h2>Tổng cộng</h2>
                                <span><fmt:formatNumber value="${cartTotal != null ? cartTotal + (deliveryCharge != null ? deliveryCharge : 30000) : 0}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                            </div>
                            <div class="payment-secure">
                                <i class="uil uil-padlock"></i>Thanh toán an toàn
                            </div>
                        </div>
                        <a href="#" class="promo-link45" data-bs-toggle="modal" data-bs-target="#promoCodeModal">Có mã khuyến mãi?</a>
                        <div class="checkout-safety-alerts">
                            <p><i class="uil uil-sync"></i>Đảm bảo đổi trả 100%</p>
                            <p><i class="uil uil-check-square"></i>Sản phẩm chính hãng 100%</p>
                            <p><i class="uil uil-shield-check"></i>Thanh toán an toàn</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Promo Code Modal -->
    <div class="modal fade" id="promoCodeModal" tabindex="-1" aria-labelledby="promoCodeModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="promoCodeModalLabel">Áp dụng mã khuyến mãi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="promoCodeInput">Mã khuyến mãi</label>
                        <input type="text" class="form-control" id="promoCodeInput" placeholder="Nhập mã khuyến mãi">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary" onclick="applyPromoCode()">Áp dụng</button>
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
        // Format price as VND
        function formatVND(price) {
            return price.toLocaleString('vi-VN', { 
                style: 'decimal', 
                minimumFractionDigits: 0, 
                maximumFractionDigits: 0 
            }) + ' ₫';
        }

        // Show Notification
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

        // Update Cart
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
                    showNotification('Cập nhật giỏ hàng thành công!', 'success');
                    location.reload();
                },
                error: function(xhr) {
                    showNotification('Lỗi khi cập nhật giỏ hàng: ' + xhr.responseText, 'error');
                }
            });
        }

        // Remove from Cart
        function removeFromCart(cartId) {
            $.ajax({
                url: '${pageContext.request.contextPath}/cart',
                type: 'POST',
                data: {
                    action: 'remove',
                    cartId: cartId
                },
                success: function(response) {
                    showNotification('Xóa sản phẩm khỏi giỏ hàng!', 'success');
                    location.reload();
                },
                error: function(xhr) {
                    showNotification('Lỗi khi xóa sản phẩm: ' + xhr.responseText, 'error');
                }
            });
        }

        // Apply Promo Code
        function applyPromoCode() {
            const promoCode = document.getElementById('promoCodeInput').value;
            if (!promoCode) {
                showNotification('Vui lòng nhập mã khuyến mãi!', 'error');
                return;
            }
            $.ajax({
                url: '${pageContext.request.contextPath}/cart',
                type: 'POST',
                data: {
                    action: 'applyPromo',
                    promoCode: promoCode
                },
                success: function(response) {
                    showNotification('Áp dụng mã khuyến mãi thành công!', 'success');
                    $('#promoCodeModal').modal('hide');
                    location.reload();
                },
                error: function(xhr) {
                    showNotification('Lỗi khi áp dụng mã khuyến mãi: ' + xhr.responseText, 'error');
                }
            });
        }

        // Send Verification Code
        function sendVerificationCode() {
            const phone = document.getElementById('phoneInput').value;
            if (!phone || !/^\+?\d{10,12}$/.test(phone)) {
                showNotification('Vui lòng nhập số điện thoại hợp lệ!', 'error');
                return;
            }
            $.ajax({
                url: '${pageContext.request.contextPath}/sendVerificationCode',
                type: 'POST',
                data: { phone: phone },
                success: function(response) {
                    showNotification('Mã xác minh đã được gửi!', 'success');
                    document.getElementById('phoneDisplay').textContent = phone;
                    $('#edit-number').collapse('hide');
                    document.getElementById('otpSection').style.display = 'block';
                },
                error: function(xhr) {
                    showNotification('Lỗi khi gửi mã xác minh: ' + xhr.responseText, 'error');
                }
            });
        }

        // Verify Code
        function verifyCode() {
            const code = document.getElementById('code1').value + 
                         document.getElementById('code2').value + 
                         document.getElementById('code3').value + 
                         document.getElementById('code4').value;
            if (code.length !== 4) {
                showNotification('Vui lòng nhập mã xác minh 4 chữ số!', 'error');
                return;
            }
            $.ajax({
                url: '${pageContext.request.contextPath}/verifyCode',
                type: 'POST',
                data: { 
                    code: code,
                    phone: document.getElementById('phoneDisplay').textContent
                },
                success: function(response) {
                    showNotification('Xác minh thành công!', 'success');
                    $('#collapseOne').collapse('hide');
                    $('#collapseTwo').collapse('show');
                    document.getElementById('otpSection').style.display = 'none';
                    // Update phone display with verified status
                    document.getElementById('phoneDisplay').parentElement.classList.add('phone-verified');
                },
                error: function(xhr) {
                    showNotification('Mã xác minh không đúng: ' + xhr.responseText, 'error');
                }
            });
        }

        // Save Address
        function saveAddress() {
            const addressData = {
                name: document.getElementById('name').value,
                email: document.getElementById('email').value,
                flat: document.getElementById('flat').value,
                street: document.getElementById('street').value,
                pincode: document.getElementById('pincode').value,
                locality: document.getElementById('locality').value,
                addressType: document.querySelector('input[name="addressType"]:checked').value
            };
            if (!addressData.name || !addressData.email || !addressData.flat || !addressData.pincode || !addressData.locality) {
                showNotification('Vui lòng điền đầy đủ thông tin địa chỉ!', 'error');
                return;
            }
            $.ajax({
                url: '${pageContext.request.contextPath}/saveAddress',
                type: 'POST',
                data: addressData,
                success: function(response) {
                    showNotification('Lưu địa chỉ thành công!', 'success');
                    $('#collapseTwo').collapse('hide');
                    $('#collapseThree').collapse('show');
                },
                error: function(xhr) {
                    showNotification('Lỗi khi lưu địa chỉ: ' + xhr.responseText, 'error');
                }
            });
        }

        // Place Order
        function placeOrder() {
            if (!${not empty cartItems}) {
                showNotification('Giỏ hàng trống! Vui lòng thêm sản phẩm.', 'error');
                return;
            }
            if (!document.getElementById('phoneDisplay').parentElement.classList.contains('phone-verified')) {
                showNotification('Vui lòng xác minh số điện thoại trước khi đặt hàng!', 'error');
                return;
            }

            const paymentMethod = document.querySelector('input[name="paymentmethod"]:checked').value;
            const orderData = {
                paymentMethod: paymentMethod,
                deliveryDate: document.querySelector('input[name="deliveryDate"]:checked').value,
                deliveryTime: document.querySelector('input[name="deliveryTime"]:checked').value,
                phone: document.getElementById('phoneDisplay').textContent,
                cartItems: [
                    <c:forEach var="cartItem" items="${cartItems}" varStatus="status">
                        {
                            productId: '${cartItem.productID}',
                            productName: '${cartItem.productName}',
                            quantity: ${cartItem.quantity},
                            unit: '${cartItem.unit}',
                            sellingPrice: ${cartItem.sellingPrice}
                        }<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                cartTotal: ${cartTotal != null ? cartTotal : 0},
                deliveryCharge: ${deliveryCharge != null ? deliveryCharge : 30000},
                total: ${cartTotal != null ? cartTotal + (deliveryCharge != null ? deliveryCharge : 30000) : 0},
                appTransId: 'FMART_' + Date.now()
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/processCheckout',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(orderData),
                success: function(response) {
                    if (paymentMethod === 'zalopay' && response.orderUrl) {
                        showNotification('Đang chuyển hướng đến cổng thanh toán ZaloPay...', 'info');
                        setTimeout(() => {
                            window.location.href = response.orderUrl;
                        }, 1000);
                    } else if (paymentMethod === 'cod') {
                        showNotification('Đặt hàng thành công!', 'success');
                        setTimeout(() => {
                            window.location.href = '${pageContext.request.contextPath}/order_confirmation?orderId=' + response.orderId;
                        }, 2000);
                    } else {
                        showNotification('Lỗi: Không nhận được URL thanh toán từ ZaloPay.', 'error');
                    }
                },
                error: function(xhr) {
                    showNotification('Lỗi khi đặt hàng: ' + xhr.responseText, 'error');
                }
            });
        }

        // Toggle Payment Method Form
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

            $('input[name="paymentmethod"]').on('change', function() {
                const method = $(this).val();
                $('.return-departure-dts').hide();
                $(`.return-departure-dts[data-method="${method}"]`).show();
            });

            // Auto-focus OTP inputs
            $('.code-alrt-inputs input').on('input', function() {
                if (this.value.length === 1) {
                    $(this).next('input').focus();
                }
            });
        });
    </script>
</body>
</html>