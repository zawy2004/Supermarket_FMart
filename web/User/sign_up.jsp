<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <title>FMart - Sign Up</title>

        <!-- Favicon Icon -->
        <link rel="icon" type="image/png" href="images/fav.png">

        <!-- Fonts & Styles -->
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href='vendor/unicons-2.0.1/css/unicons.css' rel='stylesheet'>
        <link href="css/style.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <link href="css/night-mode.css" rel="stylesheet">
        <link href="css/step-wizard.css" rel="stylesheet">
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
        <link href="vendor/OwlCarousel/assets/owl.theme.default.min.css" rel="stylesheet">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">
    </head>

    <body>
        <div class="sign-inup">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="sign-form">
                            <div class="sign-inner">
                                <div class="sign-logo" id="logo">
                                    <a href="index.jsp"><img src="images/logo.svg" alt=""></a>
                                    <a href="index.jsp"><img class="logo-inverse" src="images/dark-logo.svg" alt=""></a>
                                </div>
                                <div class="form-dt">
                                    <div class="form-inpts checout-address-step">
                                        <form action="register" method="post">
                                            <div class="form-title"><h6>Sign Up</h6></div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="text" name="username" placeholder="Username" class="form-control lgn_input" required>
                                                <i class="uil uil-user lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="text" name="fullname" placeholder="Full Name" class="form-control lgn_input" required>
                                                <i class="uil uil-user-circle lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="email" name="emailaddress" placeholder="Email Address" class="form-control lgn_input" required>
                                                <i class="uil uil-envelope lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="text" name="phone" placeholder="Phone Number" class="form-control lgn_input">
                                                <i class="uil uil-mobile-android-alt lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="text" name="address" placeholder="Address" class="form-control lgn_input">
                                                <i class="uil uil-location-point lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="date" name="dob" class="form-control lgn_input" placeholder="Date of Birth">
                                                <i class="uil uil-calendar-alt lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <select name="gender" class="form-control lgn_input" required>
                                                    <option value="">Select Gender</option>
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                    <option value="Other">Other</option>
                                                </select>
                                                <i class="uil uil-user lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <label class="control-label">Verification Code</label>
                                                <ul class="code-alrt-inputs signup-code-list">
                                                    <li><input name="code1" type="text" class="form-control input-md" maxlength="1" required></li>
                                                    <li><input name="code2" type="text" class="form-control input-md" maxlength="1" required></li>
                                                    <li><input name="code3" type="text" class="form-control input-md" maxlength="1" required></li>
                                                    <li><input name="code4" type="text" class="form-control input-md" maxlength="1" required></li>
                                                    <li><a class="chck-btn hover-btn code-btn145" href="#">Send</a></li>
                                                </ul>
                                                <a href="#" class="resend-link">Resend Code</a>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="password" name="password" placeholder="Password" class="form-control lgn_input" required>
                                                <i class="uil uil-padlock lgn_icon"></i>
                                            </div>

                                            <button class="login-btn hover-btn" type="submit">Sign Up Now</button>
                                        </form>
                                    </div>
                                    <div class="signup-link">
                                        <p>Already have an account? <a href="sign_in.jsp">Sign In Now</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="copyright-text text-center mt-4">
                            <i class="uil uil-copyright"></i>Copyright 2024 <b>FMart</b>. All rights reserved.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- JS scripts -->
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
