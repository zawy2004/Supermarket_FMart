<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

            function validateFullName(name) {
                const re = /^[a-zA-Z\s]+$/;
                return re.test(name.trim());
            }

            function validateAddress(address) {
                const re = /^[a-zA-Z0-9\s]+$/;
                return re.test(address.trim());
            }

            function validatePassword(password) {
                return password.length >= 6 && /[A-Za-z]/.test(password) && /\d/.test(password);
            }

            // Real-time validation
            $("#emailaddress").on("input", function() {
                if (!validateEmail($(this).val())) {
                    $(this).addClass("is-invalid").removeClass("is-valid");
                    $(this).next(".invalid-feedback").remove();
                    $(this).after('<div class="invalid-feedback">Please enter a valid email address.</div>');
                } else {
                    $(this).removeClass("is-invalid").addClass("is-valid");
                    $(this).next(".invalid-feedback").remove();
                }
            });

            $("#phone").on("input", function() {
                if (!validatePhone($(this).val())) {
                    $(this).addClass("is-invalid").removeClass("is-valid");
                    $(this).next(".invalid-feedback").remove();
                    $(this).after('<div class="invalid-feedback">Phone must start with 0 and be 10 digits.</div>');
                } else {
                    $(this).removeClass("is-invalid").addClass("is-valid");
                    $(this).next(".invalid-feedback").remove();
                }
            });

            $("#fullname").on("input", function() {
                if (!validateFullName($(this).val())) {
                    $(this).addClass("is-invalid").removeClass("is-valid");
                    $(this).next(".invalid-feedback").remove();
                    $(this).after('<div class="invalid-feedback">Full name must contain only letters and spaces.</div>');
                } else {
                    $(this).removeClass("is-invalid").addClass("is-valid");
                    $(this).next(".invalid-feedback").remove();
                }
            });

            $("#address").on("input", function() {
                if (!validateAddress($(this).val())) {
                    $(this).addClass("is-invalid").removeClass("is-valid");
                    $(this).next(".invalid-feedback").remove();
                    $(this).after('<div class="invalid-feedback">Address must contain only letters, numbers, and spaces.</div>');
                } else {
                    $(this).removeClass("is-invalid").addClass("is-valid");
                    $(this).next(".invalid-feedback").remove();
                }
            });

            $("#password").on("input", function() {
                if (!validatePassword($(this).val())) {
                    $(this).addClass("is-invalid").removeClass("is-valid");
                    $(this).next(".invalid-feedback").remove();
                    $(this).after('<div class="invalid-feedback">Password must be at least 6 characters with letters and numbers.</div>');
                } else {
                    $(this).removeClass("is-invalid").addClass("is-valid");
                    $(this).next(".invalid-feedback").remove();
                }
            });

            // Send verification code
            $("#sendCode").click(function(e) {
                e.preventDefault();
                var email = $("#emailaddress").val();
                if (!validateEmail(email)) {
                    alert("Please enter a valid email address before sending code.");
                    return;
                }
                $.ajax({
                    url: "${pageContext.request.contextPath}/SendVerificationCodeServlet",
                    type: "POST",
                    data: { emailaddress: email },
                    success: function(response) {
                        var data = JSON.parse(response);
                        alert(data.message);
                    },
                    error: function(xhr, status, error) {
                        alert("Error sending verification code: " + error + "\nStatus: " + status + "\nResponse: " + xhr.responseText);
                    }
                });
            });

            // Resend verification code
            $("#resendCode").click(function(e) {
                e.preventDefault();
                var email = $("#emailaddress").val();
                if (!validateEmail(email)) {
                    alert("Please enter a valid email address before resending code.");
                    return;
                }
                $.ajax({
                    url: "${pageContext.request.contextPath}/SendVerificationCodeServlet",
                    type: "POST",
                    data: { emailaddress: email },
                    success: function(response) {
                        var data = JSON.parse(response);
                        alert(data.message);
                    },
                    error: function(xhr, status, error) {
                        alert("Error resending verification code: " + error + "\nStatus: " + status + "\nResponse: " + xhr.responseText);
                    }
                });
            });      

    $(document).on("submit", "#registerForm", function(e) {
        e.preventDefault();
        var code = $("#code1").val() + $("#code2").val() + $("#code3").val() + $("#code4").val();
        var formData = $(this).serialize() + "&verificationCode=" + code;

        $.ajax({
            url: "${pageContext.request.contextPath}/register",
            type: "POST",
            data: formData,
            success: function(response, status, xhr) {
                var contentType = xhr.getResponseHeader("Content-Type") || "";
                if (contentType.indexOf("application/json") >= 0) {
                    // Backend trả về JSON (đăng ký thành công)
                    var data = typeof response === "string" ? JSON.parse(response) : response;
                    if (data.success) {
                        window.location.href = "${pageContext.request.contextPath}/home";
                    } else {
                        alert("Registration failed!");
                    }
                } else {
                    // Backend trả về HTML (có lỗi validate/OTP) → render lại trang lỗi
                    document.open();
                    document.write(response);
                    document.close();
                }
            },
            error: function(xhr) {
                alert("Registration failed: " + xhr.status + " - " + xhr.statusText);
            }
        });
    });
    });

    </script>
    <style>
        .is-invalid {
            border-color: #dc3545;
        }
        .is-valid {
            border-color: #28a745;
        }
        .invalid-feedback {
            color: #dc3545;
            font-size: 0.875em;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>
    <div class="sign-inup">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="sign-form">
                        <div class="sign-inner">
                            <div class="sign-logo" id="logo">
                                <a href="index.jsp"><img src="User/images/logoFM.png" alt="FMart Logo"></a>
                                <a href="index.jsp"><img class="logo-inverse" src="images/dark-logo.svg" alt="FMart Dark Logo"></a>
                            </div>
                            <div class="form-dt">
                                <div class="form-inpts checout-address-step">
                                    <form action="${pageContext.request.contextPath}/home" method="post"
                                        <div class="form-title"><h6>Sign Up</h6></div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="text" id="fullname" name="fullname" placeholder="Full Name" class="form-control lgn_input" value="David My" required>
                                            <i class="uil uil-user-circle lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="email" id="emailaddress" name="emailaddress" placeholder="Email Address" class="form-control lgn_input" value="ewi042650@gmail.com" required>
                                            <i class="uil uil-envelope lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="text" id="phone" name="phone" placeholder="Phone Number" class="form-control lgn_input" value="0774454307" required>
                                            <i class="uil uil-mobile-android-alt lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="text" id="address" name="address" placeholder="Address" class="form-control lgn_input" value="da nang" required>
                                            <i class="uil uil-location-point lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="date" name="dob" class="form-control lgn_input" value="2004-06-26" required>
                                            <i class="uil uil-calendar-alt lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <select name="gender" class="form-control lgn_input" required>
                                                <option value="">Select Gender</option>
                                                <option value="Male" selected>Male</option>
                                                <option value="Female">Female</option>
                                                <option value="Other">Other</option>
                                            </select>
                                            <i class="uil uil-user lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <label class="control-label">Verification Code</label>
                                            <ul class="code-alrt-inputs signup-code-list">
                                                <li><input type="text" id="code1" name="code1" class="form-control input-md" maxlength="1" required></li>
                                                <li><input type="text" id="code2" name="code2" class="form-control input-md" maxlength="1" required></li>
                                                <li><input type="text" id="code3" name="code3" class="form-control input-md" maxlength="1" required></li>
                                                <li><input type="text" id="code4" name="code4" class="form-control input-md" maxlength="1" required></li>
                                                <li><a class="chck-btn hover-btn code-btn145" id="sendCode" href="#">Send</a></li>
                                                <li><a class="chck-btn hover-btn code-btn145" id="resendCode" href="#">Resend Code</a></li>
                                            </ul>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="password" id="password" name="password" placeholder="Password" class="form-control lgn_input" value="Password123" required>
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
                        <div class="copyright-text text-center mt-4">
                            <i class="uil uil-copyright"></i>Copyright 2024 <b>FMart</b>. All rights reserved.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JS scripts -->
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