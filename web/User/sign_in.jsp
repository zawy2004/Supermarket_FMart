<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <title>FMart - Sign In</title>
        <link rel="icon" type="image/png" href="User/images/logoFM.png">
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

        <style>
            .checkbox-container { display: flex; align-items: center; gap: 15px; }
            .checkbox-container input[type="checkbox"] { margin: 0; vertical-align: middle; }
            .checkbox-container label { margin: 0; vertical-align: middle; cursor: pointer; }
            .social-login { display: flex; justify-content: center; gap: 15px; margin-top: 10px; }
            .social-btn { display: flex; align-items: center; background-color: #f9f9f9; border: 1px solid #ddd; padding: 8px 16px; border-radius: 6px; text-decoration: none; color: #000; font-weight: 500; font-family: 'Rajdhani', sans-serif; transition: background 0.3s; }
            .social-btn:hover { background-color: #f0f0f0; text-decoration: none; color: #000; }
            .social-btn .icon { width: 28px; height: 28px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 10px; color: #fff; font-size: 16px; font-weight: bold; }
            .facebook-btn .icon { background-color: #3b5998; }
            .google-btn .icon { background-color: #db4437; }
            .linkedin-btn .icon { background-color: #0077b5; }
            .or-text { text-align: center; font-weight: 500; margin-top: 20px; margin-bottom: 10px; }
            
            /* Thêm styles cho validation và error handling */
            .alert {
                margin-bottom: 20px;
                padding: 12px 15px;
                border-radius: 5px;
                font-size: 14px;
            }
            .alert-danger {
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                color: #721c24;
            }
            .alert-success {
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
                color: #155724;
            }
            .is-invalid {
                border-color: #dc3545 !important;
            }
            .is-valid {
                border-color: #28a745 !important;
            }
            .invalid-feedback {
                color: #dc3545;
                font-size: 0.875em;
                margin-top: 0.25rem;
                display: block;
            }
            .me-2 {
                margin-right: 0.5rem;
            }
        </style>

        <!-- Thêm jQuery và validation JavaScript -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function() {
                // Validation functions
                function validateEmail(email) {
                    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    return re.test(email);
                }

                function validatePhone(phone) {
                    const re = /^0\d{9}$/;
                    return re.test(phone);
                }

                // Real-time validation
                $("#phoneInput").on("input", function() {
                    var phone = $(this).val().trim();
                    if (phone && !validatePhone(phone)) {
                        $(this).addClass("is-invalid");
                    } else {
                        $(this).removeClass("is-invalid");
                    }
                });

                $("#emailInput").on("input", function() {
                    var email = $(this).val().trim();
                    if (email && !validateEmail(email)) {
                        $(this).addClass("is-invalid");
                    } else {
                        $(this).removeClass("is-invalid");
                    }
                });

                // Form submission validation
                $("#loginForm").on("submit", function(e) {
                    const email = $("#emailInput").val().trim();
                    const phone = $("#phoneInput").val().trim();
                    const password = $("#passwordInput").val().trim();
                    
                    // Remove existing error classes
                    $(".form-control").removeClass("is-invalid");
                    
                    let hasError = false;
                    
                    // Check if at least email or phone is provided
                    if (!email && !phone) {
                        $("#emailInput").addClass("is-invalid");
                        $("#phoneInput").addClass("is-invalid");
                        alert("Please enter either email or phone number");
                        hasError = true;
                    }
                    
                    // Validate email if provided
                    if (email && !validateEmail(email)) {
                        $("#emailInput").addClass("is-invalid");
                        alert("Please enter a valid email address");
                        hasError = true;
                    }
                    
                    // Validate phone if provided
                    if (phone && !validatePhone(phone)) {
                        $("#phoneInput").addClass("is-invalid");
                        alert("Please enter a valid phone number (10 digits starting with 0)");
                        hasError = true;
                    }
                    
                    // Check password
                    if (!password) {
                        $("#passwordInput").addClass("is-invalid");
                        alert("Please enter your password");
                        hasError = true;
                    }
                    
                    if (hasError) {
                        e.preventDefault();
                        return false;
                    }
                    
                    // Allow form to submit normally if validation passes
                    return true;
                });

                // Auto-focus on first empty field
                if (!$("#emailInput").val()) {
                    $("#emailInput").focus();
                } else if (!$("#passwordInput").val()) {
                    $("#passwordInput").focus();
                }
            });
        </script>
    </head>
    <body>
        <div class="sign-inup">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="sign-form">
                            <div class="sign-inner">
                                <div class="sign-logo" id="logo">
                                    <a href="index.jsp"><img src="User/images/logoFM.png" alt="FMart Logo"></a>
                                    <a href="index.jsp"><img class="logo-inverse" src="images/dark-logoFM.png" alt="FMart Dark Logo"></a>
                                </div>
                                <div class="form-dt">
                                    <!-- Thêm error/success message handling từ backend -->
                                    <% if (request.getAttribute("errorMessage") != null) { %>
                                        <div class="alert alert-danger">
                                            <i class="fas fa-exclamation-circle me-2"></i>
                                            <%= request.getAttribute("errorMessage") %>
                                        </div>
                                    <% } %>
                                    
                                    <% if (request.getAttribute("successMessage") != null) { %>
                                        <div class="alert alert-success">
                                            <i class="fas fa-check-circle me-2"></i>
                                            <%= request.getAttribute("successMessage") %>
                                        </div>
                                    <% } %>

                                    <div class="form-inpts checout-address-step">
                                        <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
                                            <div class="form-title"><h6>Sign In</h6></div>
                                            
                                            <div class="form-group pos_rel mb-3">
                                                <input id="phoneInput" name="phone" type="text" placeholder="Enter Phone Number (Optional)" class="form-control lgn_input" pattern="0[0-9]{9}" title="Phone number must be 10 digits starting with 0">
                                                <i class="uil uil-mobile-android-alt lgn_icon"></i>
                                            </div>
                                            
                                            <div class="form-group pos_rel mb-3">
                                                <input id="emailInput" name="email" type="email" placeholder="Enter Email Address" class="form-control lgn_input" required>
                                                <i class="uil uil-envelope lgn_icon"></i>
                                            </div>
                                            
                                            <div class="form-group pos_rel mb-3">
                                                <input id="passwordInput" name="password" type="password" placeholder="Enter Password" class="form-control lgn_input" required>
                                                <i class="uil uil-padlock lgn_icon"></i>
                                            </div>
                                            
                                            <div class="form-group mb-3 checkbox-container">
                                                <input type="checkbox" name="remember_me" id="rememberMe">
                                                <label for="rememberMe">Remember Me</label>
                                            </div>
                                            
                                            <button class="login-btn hover-btn h_50" type="submit">Sign In Now</button>

                                            <!-- Social login section với backend URLs -->
                                            <div class="form-group text-center">
                                                <div class="or-text">Or login with</div>
                                                <div class="social-login">
                                                    <a href="${pageContext.request.contextPath}/User/login-google" class="social-btn google-btn">
                                                        <div class="icon"><i class="fab fa-google"></i></div>
                                                        <span>Google</span>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/User/login-facebook" class="social-btn facebook-btn">
                                                        <div class="icon"><i class="fab fa-facebook-f"></i></div>
                                                        <span>Facebook</span>
                                                    </a>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <div class="password-forgor">
                                        <a href="${pageContext.request.contextPath}/forgot-password">Forgot Password?</a>
                                    </div>
                                    
                                    <div class="signup-link">
                                        <p>Don't have an account? - <a href="${pageContext.request.contextPath}/register">Sign Up Now</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="copyright-text text-center mt-4">
                            <i class="uil uil-copyright"></i>Copyright 2024 <b>FMart</b>. All rights reserved
                        </div>
                    </div>
                </div>
            </div>
        </div>

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