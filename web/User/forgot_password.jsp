<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=9">
    <meta name="description" content="Fmart">
    <meta name="author" content="Fmart">		
    <title>FMart - Forgot Password</title>
    
    <!-- Favicon Icon -->
    <link rel="icon" type="image/png" href="images/fav.png">
    
    <!-- Stylesheets -->
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet">
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
    
    <style>
        .alert {
            margin-bottom: 20px;
            padding: 15px;
            border-radius: 8px;
            display: flex;
            align-items: center;
        }
        
        .alert-success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        
        .alert i {
            margin-right: 10px;
            font-size: 18px;
        }
        
        .loading {
            display: none;
        }
        
        .loading.show {
            display: inline-block;
        }
        
        .btn-loading {
            position: relative;
        }
        
        .btn-loading:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }
    </style>
</head>

<body>
    <div class="sign-inup">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="sign-form">
                        <div class="sign-inner">
                            <div class="sign-logo" id="logo">
                                <a href="index.jsp"><img src="images/logo.svg" alt=""></a>
                                <a href="index.jsp"><img class="logo-inverse" src="images/dark-logo.svg" alt=""></a>
                            </div>
                            <div class="form-dt">
                                <div class="form-inpts checout-address-step">
                                    
                                    <!-- Success Message -->
                                    <c:if test="${not empty successMessage}">
                                        <div class="alert alert-success">
                                            <i class="uil uil-check-circle"></i>
                                            ${successMessage}
                                        </div>
                                    </c:if>
                                    
                                    <!-- Error Message -->
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger">
                                            <i class="uil uil-exclamation-triangle"></i>
                                            ${error}
                                        </div>
                                    </c:if>
                                    
                                    <form id="forgotPasswordForm" action="${pageContext.request.contextPath}/forgot-password" method="post">
                                        <input type="hidden" name="action" value="send-reset-code">
                                        
                                        <div class="form-title">
                                            <h6>Request a Password Reset</h6>
                                            <p>Enter your email address and we'll send you a verification code to reset your password.</p>
                                        </div>
                                        
                                        <div class="form-group pos_rel mb-3">
                                            <input id="emailaddress" 
                                                   name="emailaddress" 
                                                   type="email" 
                                                   placeholder="Your Email Address" 
                                                   class="form-control lgn_input" 
                                                   value="${param.emailaddress}"
                                                   required="">
                                            <i class="uil uil-envelope lgn_icon"></i>
                                        </div>
                                        
                                        <button class="login-btn hover-btn h_50 btn-loading" type="submit" id="submitBtn">
                                            <span class="loading">
                                                <i class="uil uil-spinner-alt fa-spin"></i>
                                            </span>
                                            <span class="btn-text">Send Reset Code</span>
                                        </button>
                                    </form>
                                </div>
                                <div class="signup-link">
                                    <p>Go Back - <a href="sign_in.jsp">Sign In Now</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="copyright-text text-center mt-4">
                        <i class="uil uil-copyright"></i>Copyright 2024 <b>FMart</b> . All rights reserved
                    </div>
                </div>
            </div>
        </div>
    </div>

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
    
    <script>
        $(document).ready(function() {
            const form = $('#forgotPasswordForm');
            const submitBtn = $('#submitBtn');
            const loading = submitBtn.find('.loading');
            const btnText = submitBtn.find('.btn-text');
            
            form.on('submit', function(e) {
                // Show loading state
                loading.addClass('show');
                btnText.hide();
                submitBtn.prop('disabled', true);
                
                // Validate email
                const email = $('#emailaddress').val().trim();
                if (!email) {
                    e.preventDefault();
                    showError('Vui lòng nhập email.');
                    resetButton();
                    return;
                }
                
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    e.preventDefault();
                    showError('Email không hợp lệ.');
                    resetButton();
                    return;
                }
            });
            
            function resetButton() {
                loading.removeClass('show');
                btnText.show();
                submitBtn.prop('disabled', false);
            }
            
            function showError(message) {
                // Remove existing alerts
                $('.alert').remove();
                
                // Create new error alert
                const alert = $('<div class="alert alert-danger">' +
                              '<i class="uil uil-exclamation-triangle"></i>' +
                              message + '</div>');
                
                // Insert before form
                $('.form-inpts').prepend(alert);
                
                // Auto remove after 5 seconds
                setTimeout(() => {
                    alert.fadeOut(500, function() {
                        $(this).remove();
                    });
                }, 5000);
            }
            
            // Auto-hide alerts after 10 seconds
            setTimeout(() => {
                $('.alert').fadeOut(500, function() {
                    $(this).remove();
                });
            }, 10000);
            
            // Focus on email input
            $('#emailaddress').focus();
        });
    </script>
</body>

</html>