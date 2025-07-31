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
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            :root {
                --primary-gradient: linear-gradient(135deg, #ff9a56 0%, #ff6b35 100%);
                --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                --glass-bg: rgba(255, 255, 255, 0.1);
                --glass-border: rgba(255, 255, 255, 0.2);
                --shadow-soft: 0 8px 32px rgba(0, 0, 0, 0.1);
                --shadow-hover: 0 12px 40px rgba(0, 0, 0, 0.15);
                --border-radius: 16px;
                --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            /* Enhanced Form Container */
            .checkout-form-container {
                background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
                border-radius: var(--border-radius);
                box-shadow: var(--shadow-soft);
                overflow: hidden;
                position: relative;
                margin-bottom: 2rem;
            }

            .checkout-form-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: var(--primary-gradient);
            }

            /* Form Header */
            .form-header {
                background: linear-gradient(135deg, #ff9a56 0%, #ff6b35 100%);
                padding: 2rem;
                color: white;
                position: relative;
                overflow: hidden;
            }

            .form-header::before {
                content: '';
                position: absolute;
                top: -50%;
                right: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
                animation: shimmer 3s ease-in-out infinite;
            }

            @keyframes shimmer {
                0%, 100% { transform: translateX(-100%); }
                50% { transform: translateX(0%); }
            }

            .form-header h4 {
                margin: 0;
                font-size: 1.75rem;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                position: relative;
                z-index: 1;
            }

            .form-header .header-icon {
                width: 40px;
                height: 40px;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                backdrop-filter: blur(10px);
            }

            /* Form Body */
            .form-body {
                padding: 2.5rem;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(20px);
            }

            /* Section Groups */
            .form-section {
                margin-bottom: 2.5rem;
                background: white;
                border-radius: 12px;
                padding: 2rem;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                border: 1px solid rgba(0, 0, 0, 0.05);
                transition: var(--transition);
                position: relative;
                overflow: hidden;
            }

            .form-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: var(--primary-gradient);
                transform: scaleX(0);
                transition: var(--transition);
            }

            .form-section:hover::before {
                transform: scaleX(1);
            }

            .form-section:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-hover);
            }

            .section-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                padding-bottom: 0.75rem;
                border-bottom: 2px solid #e2e8f0;
                position: relative;
            }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 50px;
                height: 2px;
                background: var(--primary-gradient);
            }

            .section-icon {
                width: 32px;
                height: 32px;
                background: var(--primary-gradient);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1rem;
            }

            /* Enhanced Form Groups */
            .enhanced-form-group {
                margin-bottom: 1.5rem;
                position: relative;
            }

            .enhanced-form-group label {
                font-weight: 600;
                color: #4a5568;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 0.95rem;
            }

            .enhanced-form-group label i {
                color: #ff9a56;
                font-size: 1rem;
            }

            .enhanced-form-control {
                width: 100%;
                padding: 0.875rem 1rem;
                border: 2px solid #e2e8f0;
                border-radius: 10px;
                font-size: 1rem;
                transition: var(--transition);
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                position: relative;
            }

            .enhanced-form-control:focus {
                outline: none;
                border-color: #ff9a56;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
                transform: translateY(-1px);
                background: white;
            }

            .enhanced-form-control::placeholder {
                color: #a0aec0;
                font-weight: 400;
            }

            /* Two Column Layout */
            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1.5rem;
                margin-bottom: 1.5rem;
            }

            @media (max-width: 768px) {
                .form-row {
                    grid-template-columns: 1fr;
                    gap: 1rem;
                }
            }

            /* Enhanced Payment Methods */
            .payment-methods-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 1rem;
                margin-top: 1rem;
            }

            .payment-method-card {
                position: relative;
                background: white;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                padding: 1.5rem 1rem;
                text-align: center;
                cursor: pointer;
                transition: var(--transition);
                overflow: hidden;
            }

            .payment-method-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: var(--primary-gradient);
                opacity: 0;
                transition: var(--transition);
            }

            .payment-method-card:hover {
                transform: translateY(-4px);
                box-shadow: var(--shadow-hover);
                border-color: #ff9a56;
            }

            .payment-method-card input[type="radio"] {
                display: none;
            }

            .payment-method-card input[type="radio"]:checked + .payment-card-content::before {
                opacity: 0.1;
            }

            .payment-method-card input[type="radio"]:checked + .payment-card-content {
                color: #ff9a56;
            }

            .payment-method-card.selected {
                border-color: #ff9a56;
                background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.15);
            }

            .payment-card-content {
                position: relative;
                z-index: 1;
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 0.75rem;
            }

            .payment-card-content img {
                width: 50px;
                height: 50px;
                object-fit: contain;
                filter: grayscale(0.3);
                transition: var(--transition);
            }

            .payment-method-card:hover .payment-card-content img,
            .payment-method-card.selected .payment-card-content img {
                filter: grayscale(0);
                transform: scale(1.1);
            }

            .payment-card-title {
                font-weight: 600;
                color: #4a5568;
                font-size: 0.9rem;
                margin: 0;
            }

            /* Enhanced Submit Button */
            .enhanced-submit-btn {
                background: var(--primary-gradient);
                border: none;
                border-radius: 12px;
                padding: 1rem 3rem;
                font-size: 1.1rem;
                font-weight: 600;
                color: white;
                cursor: pointer;
                transition: var(--transition);
                position: relative;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.75rem;
                width: 100%;
                margin-top: 2rem;
            }

            .enhanced-submit-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                transition: var(--transition);
            }

            .enhanced-submit-btn:hover::before {
                left: 100%;
            }

            .enhanced-submit-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }

            .enhanced-submit-btn:active {
                transform: translateY(0);
            }

            /* Form Helper Text */
            .form-helper {
                font-size: 0.875rem;
                color: #718096;
                margin-top: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .form-helper i {
                color: #ff9a56;
            }

            /* Required Field Indicator */
            .required-indicator {
                color: #e53e3e;
                margin-left: 2px;
            }

            /* Enhanced Select Dropdown */
            .enhanced-select {
                position: relative;
            }

            .enhanced-select select {
                appearance: none;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 0.75rem center;
                background-repeat: no-repeat;
                background-size: 1.5em 1.5em;
                padding-right: 2.5rem;
            }

            /* Payment Description Enhanced */
            .payment-description {
                display: none;
                margin-top: 1rem;
                padding: 1rem;
                background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
                border-radius: 8px;
                border-left: 4px solid #ff9a56;
                font-size: 0.9rem;
                color: #4a5568;
            }

            .payment-description.active {
                display: block;
                animation: fadeInUp 0.3s ease-out;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Toast Notification Enhanced */
            .toast-notification {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 9999;
                min-width: 300px;
                box-shadow: var(--shadow-soft);
                border-radius: 12px;
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            /* Loading States */
            .loading {
                opacity: 0.7;
                pointer-events: none;
                position: relative;
            }

            .loading::after {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 20px;
                height: 20px;
                margin: -10px 0 0 -10px;
                border: 2px solid #ff9a56;
                border-radius: 50%;
                border-top-color: transparent;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                to { transform: rotate(360deg); }
            }

            /* Mobile Responsive Enhancements */
            @media (max-width: 768px) {
                .form-header,
                .form-body {
                    padding: 1.5rem;
                }
                
                .form-section {
                    padding: 1.5rem;
                    margin-bottom: 1.5rem;
                }
                
                .payment-methods-grid {
                    grid-template-columns: 1fr;
                    gap: 0.75rem;
                }
                
                .enhanced-submit-btn {
                    padding: 0.875rem 2rem;
                    font-size: 1rem;
                }
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
                                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
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
                            <div class="checkout-form-container">
                                <div class="form-header">
                                    <h4>
                                        <div class="header-icon">
                                            <i class="fas fa-credit-card"></i>
                                        </div>
                                        Thông tin thanh toán
                                    </h4>
                                </div>
                                
                                <div class="form-body">
                                    <form id="checkoutForm" action="${pageContext.request.contextPath}/processCheckout" method="post">
                                        <!-- Contact Information Section -->
                                        <div class="form-section">
                                            <div class="section-title">
                                                <div class="section-icon">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                                Thông tin liên hệ
                                            </div>
                                            
                                            <div class="enhanced-form-group">
                                                <label for="phone">
                                                    <i class="fas fa-phone"></i>
                                                    Số điện thoại<span class="required-indicator">*</span>
                                                </label>
                                                <input id="phone" name="phone" type="text" placeholder="Nhập số điện thoại" 
                                                       class="enhanced-form-control" value="${sessionScope.userPhone}" required>
                                                <div class="form-helper">
                                                    <i class="fas fa-info-circle"></i>
                                                    Số điện thoại dùng để gửi thông báo đơn hàng
                                                </div>
                                            </div>

                                            <div class="form-row">
                                                <div class="enhanced-form-group">
                                                    <label for="name">
                                                        <i class="fas fa-user-circle"></i>
                                                        Họ và tên<span class="required-indicator">*</span>
                                                    </label>
                                                    <input id="name" name="name" type="text" placeholder="Nhập họ và tên" 
                                                           class="enhanced-form-control" required>
                                                </div>

                                                <div class="enhanced-form-group">
                                                    <label for="email">
                                                        <i class="fas fa-envelope"></i>
                                                        Email<span class="required-indicator">*</span>
                                                    </label>
                                                    <input id="email" name="email" type="email" placeholder="Nhập địa chỉ email" 
                                                           class="enhanced-form-control" required>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Delivery Address Section -->
                                        <div class="form-section">
                                            <div class="section-title">
                                                <div class="section-icon">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                </div>
                                                Địa chỉ giao hàng
                                            </div>
                                            
                                            <div class="form-row">
                                                <div class="enhanced-form-group">
                                                    <label for="province">
                                                        <i class="fas fa-city"></i>
                                                        Tỉnh/Thành phố<span class="required-indicator">*</span>
                                                    </label>
                                                    <input id="province" name="province" type="text" placeholder="Chọn tỉnh/thành phố" 
                                                           class="enhanced-form-control" required>
                                                </div>

                                                <div class="enhanced-form-group">
                                                    <label for="district">
                                                        <i class="fas fa-building"></i>
                                                        Quận/Huyện<span class="required-indicator">*</span>
                                                    </label>
                                                    <input id="district" name="district" type="text" placeholder="Chọn quận/huyện" 
                                                           class="enhanced-form-control" required>
                                                </div>
                                            </div>

                                            <div class="form-row">
                                                <div class="enhanced-form-group">
                                                    <label for="ward">
                                                        <i class="fas fa-map-pin"></i>
                                                        Phường/Xã<span class="required-indicator">*</span>
                                                    </label>
                                                    <input id="ward" name="ward" type="text" placeholder="Chọn phường/xã" 
                                                           class="enhanced-form-control" required>
                                                </div>

                                                <div class="enhanced-form-group">
                                                    <label for="street">
                                                        <i class="fas fa-home"></i>
                                                        Số nhà và tên đường<span class="required-indicator">*</span>
                                                    </label>
                                                    <input id="street" name="street" type="text" placeholder="Nhập số nhà và tên đường" 
                                                           class="enhanced-form-control" required>
                                                </div>
                                            </div>

                                            <div class="enhanced-form-group">
                                                <label for="notes">
                                                    <i class="fas fa-sticky-note"></i>
                                                    Ghi chú
                                                </label>
                                                <textarea name="notes" class="enhanced-form-control" placeholder="Ghi chú cho đơn hàng (tùy chọn)" 
                                                          rows="3" style="resize: vertical;"></textarea>
                                                <div class="form-helper">
                                                    <i class="fas fa-lightbulb"></i>
                                                    Ví dụ: Giao hàng tại cổng sau, gọi trước khi giao...
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Delivery Schedule Section -->
                                        <div class="form-section">
                                            <div class="section-title">
                                                <div class="section-icon">
                                                    <i class="fas fa-clock"></i>
                                                </div>
                                                Thời gian giao hàng
                                            </div>
                                            
                                            <div class="form-row">
                                                <div class="enhanced-form-group">
                                                    <label for="deliveryDate">
                                                        <i class="fas fa-calendar-alt"></i>
                                                        Ngày giao hàng<span class="required-indicator">*</span>
                                                    </label>
                                                    <div class="enhanced-select">
                                                        <select name="deliveryDate" class="enhanced-form-control" required>
                                                            <option value="">Chọn ngày giao hàng</option>
                                                            <option value="today">Hôm nay</option>
                                                            <option value="tomorrow">Ngày mai</option>
                                                            <c:forEach begin="2" end="7" var="i">
                                                                <option value="${i} days"><fmt:formatDate value="${java.time.LocalDate.now().plusDays(i)}" pattern="dd MMM yyyy"/></option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="enhanced-form-group">
                                                    <label for="deliveryTime">
                                                        <i class="fas fa-clock"></i>
                                                        Giờ giao hàng<span class="required-indicator">*</span>
                                                    </label>
                                                    <div class="enhanced-select">
                                                        <select name="deliveryTime" class="enhanced-form-control" required>
                                                            <option value="">Chọn khung giờ</option>
                                                            <option value="08:00-10:00">8:00 - 10:00 (Sáng sớm)</option>
                                                            <option value="10:00-12:00">10:00 - 12:00 (Buổi sáng)</option>
                                                            <option value="12:00-14:00">12:00 - 14:00 (Buổi trưa)</option>
                                                            <option value="14:00-16:00">14:00 - 16:00 (Buổi chiều)</option>
                                                            <option value="16:00-18:00">16:00 - 18:00 (Chiều tối)</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Payment Method Section -->
                                        <div class="form-section">
                                            <div class="section-title">
                                                <div class="section-icon">
                                                    <i class="fas fa-credit-card"></i>
                                                </div>
                                                Phương thức thanh toán
                                            </div>
                                            
                                            <div class="payment-methods-grid">
                                                <div class="payment-method-card selected">
                                                    <input type="radio" id="cod" name="paymentmethod" value="cod" checked>
                                                    <div class="payment-card-content">
                                                        <img src="${pageContext.request.contextPath}/User/images/cod.png" alt="Thanh toán khi nhận hàng">
                                                        <h5 class="payment-card-title">Thanh toán khi nhận hàng</h5>
                                                    </div>
                                                </div>

                                                <div class="payment-method-card">
                                                    <input type="radio" id="payos" name="paymentmethod" value="payos">
                                                    <div class="payment-card-content">
                                                        <img src="${pageContext.request.contextPath}/User/images/payos.png" alt="PayOS">
                                                        <h5 class="payment-card-title">PayOS</h5>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div id="payment-cod" class="payment-description active">
                                                <i class="fas fa-hand-holding-usd"></i>
                                                <strong>Thanh toán trực tiếp khi nhận hàng.</strong> Không phí thêm. Bạn có thể kiểm tra hàng trước khi thanh toán.
                                            </div>
                                            <div id="payment-payos" class="payment-description">
                                                <i class="fas fa-shield-alt"></i>
                                                <strong>Thanh toán qua PayOS.</strong> An toàn và nhanh chóng. Hỗ trợ nhiều ngân hàng và ví điện tử.
                                            </div>
                                        </div>

                                        <!-- Hidden fields for cart -->
                                        <c:forEach var="item" items="${cartItems}">
                                            <input type="hidden" name="productId" value="${item.productID}"/>
                                            <input type="hidden" name="productName" value="${item.productName}"/>
                                            <input type="hidden" name="unit" value="${item.unit}"/>
                                            <input type="hidden" name="quantity" value="${item.quantity}"/>
                                            <input type="hidden" name="price" value="${item.sellingPrice}"/>
                                        </c:forEach>
                                        <input type="hidden" name="cartTotal" value="${cartTotal}"/>

                                        <button type="button" class="enhanced-submit-btn" onclick="showConfirmModal()">
                                            <i class="fas fa-shopping-bag"></i>
                                            Xác nhận đặt hàng
                                            <div class="btn-shimmer"></div>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-5">
                            <div class="pdpt-bg mt-0" id="order-summary">
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
                                    <span id="total-amount"><fmt:formatNumber value="${cartTotal != null ? cartTotal + (deliveryCharge != null ? deliveryCharge : 30000) : 0}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
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

            <!-- Confirm Payment Modal -->
            <div class="modal fade" id="confirmPaymentModal" tabindex="-1" aria-labelledby="confirmPaymentModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmPaymentModalLabel">Xác nhận thanh toán</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h5>Chi tiết đơn hàng</h5>
                            <div id="confirm-order-summary"></div>
                            <hr>
                            <p><strong>Phương thức thanh toán:</strong> <span id="confirm-payment-method"></span></p>
                            <p><strong>Tổng cộng:</strong> <span id="confirm-total-amount"></span></p>
                            <p>Bạn chắc chắn muốn đặt hàng?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="button" class="btn btn-primary" onclick="submitCheckoutForm()">Xác nhận và thanh toán</button>
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

                                    setTimeout(function () {
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
                                        success: function (response) {
                                            showNotification('Cập nhật giỏ hàng thành công!', 'success');
                                            location.reload();
                                        },
                                        error: function (xhr) {
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
                                        success: function (response) {
                                            showNotification('Xóa sản phẩm khỏi giỏ hàng!', 'success');
                                            location.reload();
                                        },
                                        error: function (xhr) {
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
                                        success: function (response) {
                                            showNotification('Áp dụng mã khuyến mãi thành công!', 'success');
                                            $('#promoCodeModal').modal('hide');
                                            location.reload();
                                        },
                                        error: function (xhr) {
                                            showNotification('Lỗi khi áp dụng mã khuyến mãi: ' + xhr.responseText, 'error');
                                        }
                                    });
                                }

                                // Show Confirm Modal
                                function showConfirmModal() {
                                    // Sao chép tóm tắt đơn hàng vào modal
                                    const summary = document.getElementById('order-summary').innerHTML;
                                    document.getElementById('confirm-order-summary').innerHTML = summary;

                                    // Lấy phương thức thanh toán đã chọn
                                    const selectedPayment = document.querySelector('input[name="paymentmethod"]:checked').nextElementSibling.querySelector('.payment-card-title').textContent;
                                    document.getElementById('confirm-payment-method').textContent = selectedPayment;

                                    // Lấy tổng giá
                                    const totalAmount = document.getElementById('total-amount').textContent;
                                    document.getElementById('confirm-total-amount').textContent = totalAmount;

                                    // Hiện modal
                                    $('#confirmPaymentModal').modal('show');
                                }

                                // Submit Form sau xác nhận
                                function submitCheckoutForm() {
                                    document.getElementById('checkoutForm').submit();
                                }

                                // Enhanced Payment Method Selection
                                $(document).ready(function () {
                                    // Payment method selection
                                    $('.payment-method-card').on('click', function() {
                                        // Remove selected class from all cards
                                        $('.payment-method-card').removeClass('selected');
                                        
                                        // Add selected class to clicked card
                                        $(this).addClass('selected');
                                        
                                        // Check the radio button
                                        $(this).find('input[type="radio"]').prop('checked', true);
                                        
                                        // Hide all payment descriptions
                                        $('.payment-description').removeClass('active');
                                        
                                        // Show selected payment description
                                        const method = $(this).find('input[type="radio"]').val();
                                        $('#payment-' + method).addClass('active');
                                    });

                                    // Form validation enhancements
                                    $('.enhanced-form-control').on('focus', function() {
                                        $(this).closest('.enhanced-form-group').addClass('focused');
                                    });

                                    $('.enhanced-form-control').on('blur', function() {
                                        $(this).closest('.enhanced-form-group').removeClass('focused');
                                        
                                        // Add validation feedback
                                        if ($(this).prop('required') && !$(this).val()) {
                                            $(this).addClass('is-invalid');
                                        } else {
                                            $(this).removeClass('is-invalid').addClass('is-valid');
                                        }
                                    });

                                    // Form submission with loading state
                                    $('#checkoutForm').on('submit', function() {
                                        $('.enhanced-submit-btn').addClass('loading').prop('disabled', true);
                                    });

                                    // Initialize payment method
                                    const defaultMethod = $('input[name="paymentmethod"]:checked').val();
                                    $('#payment-' + defaultMethod).addClass('active');
                                });
            </script>
    </body>
</html>