<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <title>FMart - Sign In</title>
        <link rel="icon" type="image/png" href="images/fav.png">
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <link href="css/night-mode.css" rel="stylesheet">
        <link href="css/step-wizard.css" rel="stylesheet">
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
        <link href="vendor/OwlCarousel/assets/owl.theme.default.min.css" rel="stylesheet">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">

        <style>
            .checkbox-container { display: flex; align-items: center; gap: 15px; }
            .checkbox-container input[type="checkbox"] { margin: 0; vertical-align: middle; }
            .checkbox-container label { margin: 0; vertical-align: middle; }
            .social-login { display: flex; justify-content: center; gap: 15px; margin-top: 10px; }
            .social-btn { display: flex; align-items: center; background-color: #f9f9f9; border: 1px solid #ddd; padding: 8px 16px; border-radius: 6px; text-decoration: none; color: #000; font-weight: 500; font-family: 'Rajdhani', sans-serif; transition: background 0.3s; }
            .social-btn:hover { background-color: #f0f0f0; }
            .social-btn .icon { width: 28px; height: 28px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-right: 10px; color: #fff; font-size: 16px; font-weight: bold; }
            .facebook-btn .icon { background-color: #3b5998; }
            .google-btn .icon { background-color: #db4437; }
            .linkedin-btn .icon { background-color: #0077b5; }
            .or-text { text-align: center; font-weight: 500; margin-top: 20px; margin-bottom: 10px; }
            .error-message { color: red; text-align: center; margin-top: 10px; }
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
                                        <form action="${pageContext.request.contextPath}/User/login" method="post">
                                            <div class="form-title"><h6>Sign In</h6></div>
                                            <div class="form-group pos_rel mb-3">
                                                <input id="phone[number]" name="phone" type="text" placeholder="Enter Phone Number" class="form-control lgn_input" required>
                                                <i class="uil uil-mobile-android-alt lgn_icon"></i>
                                            </div>
                                            <div class="form-group pos_rel mb-3">
                                                <input id="email[address]" name="email" type="email" placeholder="Enter Email Address" class="form-control lgn_input" required>
                                                <i class="uil uil-envelope lgn_icon"></i>
                                            </div>
                                            <div class="form-group pos_rel mb-3">
                                                <input id="password1" name="password" type="password" placeholder="Enter Password" class="form-control lgn_input" required>
                                                <i class="uil uil-padlock lgn_icon"></i>
                                            </div>
                                            <div class="form-group mb-3 checkbox-container">
                                                <input type="checkbox" name="remember_me" id="remember_me">
                                                <label for="remember_me">Remember Me</label>
                                            </div>
                                            <button class="login-btn hover-btn h_50" type="submit">Sign In Now</button>
                                        </form>

                                        <!-- Hiển thị thông báo lỗi nếu có -->
                                        <% if (request.getAttribute("errorMessage") != null) { %>
                                            <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
                                        <% } %>

                                        <!-- Social login section -->
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
                                    </div>
                                    <div class="password-forgor">
                                        <a href="forgot_password.jsp">Forgot Password?</a>
                                    </div>
                                    <div class="signup-link">
                                        <p>Don't have an account? - <a href="sign_up.jsp">Sign Up Now</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="copyright-text text-center mt-4">
                            <i class="uil uil-copyright"></i>Copyright 2024 <b>FMartlthemes</b>. All rights reserved
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
        <script src="vendor/OwlCarousel/owl.carousel.js"></script>
        <script src="js/jquery.countdown.min.js"></script>
        <script src="js/custom.js"></script>
        <script src="js/product.thumbnail.slider.js"></script>
        <script src="js/offset_overlay.js"></script>
        <script src="js/night-mode.js"></script>
    </body>
</html>