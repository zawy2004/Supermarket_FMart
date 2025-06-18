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
            // Set max date for date of birth to today
            var today = new Date().toISOString().split('T')[0];
            $('input[name="dob"]').attr('max', today);

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
                const re = /^[a-zA-ZÀ-Ỹà-ỹ\s]+$/;
                return re.test(name.trim()) && name.trim().length > 0;
            }

            function validateAddress(address) {
                const re = /^[a-zA-ZÀ-Ỹà-ỹ0-9\s]+$/;
                return re.test(address.trim()) && address.trim().length > 0;
            }

            function validatePassword(password) {
                return password.length >= 6 && /[A-Za-z]/.test(password) && /\d/.test(password);
            }

            function validateDateOfBirth(dob) {
                var today = new Date();
                var birthDate = new Date(dob);
                return birthDate <= today;
            }

            function showError(element, message) {
                element.addClass("is-invalid").removeClass("is-valid");
                element.next(".invalid-feedback").remove();
                element.after('<div class="invalid-feedback">' + message + '</div>');
            }

            function showSuccess(element) {
                element.removeClass("is-invalid").addClass("is-valid");
                element.next(".invalid-feedback").remove();
            }

            // Real-time validation
            $("#emailaddress").on("input", function() {
                if (!validateEmail($(this).val())) {
                    showError($(this), "Please enter a valid email address.");
                } else {
                    showSuccess($(this));
                }
            });

            $("#phone").on("input", function() {
                if (!validatePhone($(this).val())) {
                    showError($(this), "Phone must start with 0 and be 10 digits.");
                } else {
                    showSuccess($(this));
                }
            });

            $("#fullname").on("input", function() {
                if (!validateFullName($(this).val())) {
                    showError($(this), "Full name must contain only letters and spaces.");
                } else {
                    showSuccess($(this));
                }
            });

            $("#address").on("input", function() {
                if (!validateAddress($(this).val())) {
                    showError($(this), "Address must contain only letters, numbers, and spaces.");
                } else {
                    showSuccess($(this));
                }
            });

            $("#password").on("input", function() {
                if (!validatePassword($(this).val())) {
                    showError($(this), "Password must be at least 6 characters with letters and numbers.");
                } else {
                    showSuccess($(this));
                }
            });

            $('input[name="dob"]').on("change", function() {
                if (!validateDateOfBirth($(this).val())) {
                    showError($(this), "Date of birth cannot be in the future.");
                } else {
                    showSuccess($(this));
                }
            });

            // Auto move to next OTP input
            $('.otp-input').on('input', function() {
                if (this.value.length == this.maxLength) {
                    $(this).next('.otp-input').focus();
                }
            });

                // Send verification code
                $("#continueToOTP").click(function(e) {
                    e.preventDefault();
                    
                    // Validate all fields
                    var isValid = true;
                    var email = $("#emailaddress").val();
                    var phone = $("#phone").val();
                    var fullname = $("#fullname").val();
                    var address = $("#address").val();
                    var password = $("#password").val();
                    var dob = $('input[name="dob"]').val();
                    var gender = $('select[name="gender"]').val();

                    if (!validateEmail(email)) {
                        showError($("#emailaddress"), "Please enter a valid email address.");
                        isValid = false;
                    }

                    if (!validatePhone(phone)) {
                        showError($("#phone"), "Phone must start with 0 and be 10 digits.");
                        isValid = false;
                    }

                    if (!validateFullName(fullname)) {
                        showError($("#fullname"), "Full name must contain only letters and spaces.");
                        isValid = false;
                    }

                    if (!validateAddress(address)) {
                        showError($("#address"), "Address must contain only letters, numbers, and spaces.");
                        isValid = false;
                    }

                    if (!validatePassword(password)) {
                        showError($("#password"), "Password must be at least 6 characters with letters and numbers.");
                        isValid = false;
                    }

                    if (!validateDateOfBirth(dob)) {
                        showError($('input[name="dob"]'), "Date of birth cannot be in the future.");
                        isValid = false;
                    }

                    if (!gender) {
                        alert("Please select your gender.");
                        isValid = false;
                    }

                    if (!isValid) {
                        alert("Please fix all validation errors before continuing.");
                        return;
                    }

                    // Send OTP
                    $("#continueToOTP").prop('disabled', true).text('Sending...');
                    
                    $.ajax({
                        url: "${pageContext.request.contextPath}/SendVerificationCodeServlet",
                        type: "POST",
                        data: { emailaddress: email },
                        dataType: "json",
                        success: function(data) {
                            if (data.status === "success") {
                                // Hide user info form and show OTP form
                                $("#userInfoStep").hide();
                                $("#otpStep").show();
                                $("#stepTitle").text("Email Verification");
                                alert(data.message);
                            } else {
                                alert("Error: " + data.message);
                            }
                        },
                        error: function(xhr) {
                            try {
                                var response = JSON.parse(xhr.responseText);
                                alert("Error: " + response.message);
                                
                                // Nếu đạt giới hạn, hiện nút reset
                                if (response.message.includes("quá nhiều lần")) {
                                    showResetOption();
                                }
                            } catch (e) {
                                alert("Error sending verification code. Please try again.");
                            }
                        },
                        complete: function() {
                            $("#continueToOTP").prop('disabled', false).text('Sign Up Now');
                        }
                    });
                });

                // Function to show reset option
                function showResetOption() {
                    if ($("#resetCounterBtn").length === 0) {
                        $("#continueToOTP").after('<button type="button" id="resetCounterBtn" class="btn btn-warning mt-2 w-100">Reset Counter & Try Again</button>');
                    }
                }

                // Reset OTP counter
                $(document).on("click", "#resetCounterBtn", function(e) {
                    e.preventDefault();
                    
                    $(this).prop('disabled', true).text('Resetting...');
                    
                    $.ajax({
                        url: "${pageContext.request.contextPath}/ResetOTPCounterServlet",
                        type: "POST",
                        dataType: "json",
                        success: function(data) {
                            if (data.status === "success") {
                                alert(data.message);
                                $("#resetCounterBtn").remove();
                            } else {
                                alert("Error: " + data.message);
                            }
                        },
                        error: function(xhr) {
                            alert("Error resetting counter. Please try again.");
                        },
                        complete: function() {
                            $("#resetCounterBtn").prop('disabled', false).text('Reset Counter & Try Again');
                        }
                    });
                });

            // Resend verification code
            $("#resendCode").click(function(e) {
                e.preventDefault();
                var email = $("#emailaddress").val();
                
                $("#resendCode").prop('disabled', true).text('Sending...');
                
                $.ajax({
                    url: "${pageContext.request.contextPath}/SendVerificationCodeServlet",
                    type: "POST",
                    data: { emailaddress: email },
                    dataType: "json",
                    success: function(data) {
                        alert(data.message);
                    },
                    error: function(xhr) {
                        var response = JSON.parse(xhr.responseText);
                        alert("Error resending verification code: " + response.message);
                    },
                    complete: function() {
                        $("#resendCode").prop('disabled', false).text('Resend Code');
                    }
                });
            });

            // Go back to user info
            $("#backToUserInfo").click(function(e) {
                e.preventDefault();
                $("#otpStep").hide();
                $("#userInfoStep").show();
                $("#stepTitle").text("Sign Up");
                // Clear OTP inputs
                $(".otp-input").val("");
            });

            // Final registration with OTP
            $("#finalRegister").click(function(e) {
                e.preventDefault();
                
                var code = $("#code1").val() + $("#code2").val() + $("#code3").val() + $("#code4").val();
                
                if (code.length !== 4 || !/^\d{4}$/.test(code)) {
                    alert("Please enter a complete 4-digit verification code.");
                    return;
                }

                $("#finalRegister").prop('disabled', true).text('Registering...');

                $.ajax({
                    url: "${pageContext.request.contextPath}/register",
                    type: "POST",
                    data: $("#registerForm").serialize(),
                    success: function(response, status, xhr) {
                        var contentType = xhr.getResponseHeader("Content-Type") || "";
                        if (contentType.indexOf("application/json") >= 0) {
                            var data = typeof response === "string" ? JSON.parse(response) : response;
                            if (data.success) {
                                alert("Registration successful! Redirecting to home page...");
                                window.location.href = "${pageContext.request.contextPath}/home";
                            } else {
                                alert("Registration failed: " + data.message);
                            }
                        } else {
                            // Backend returned HTML (validation errors)
                            document.open();
                            document.write(response);
                            document.close();
                        }
                    },
                    error: function(xhr) {
                        alert("Registration failed: " + xhr.status + " - " + xhr.statusText);
                    },
                    complete: function() {
                        $("#finalRegister").prop('disabled', false).text('Complete Registration');
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
        .otp-input {
            width: 50px;
            height: 50px;
            text-align: center;
            font-size: 18px;
            margin: 0 5px;
        }
        .step-container {
            display: none;
        }
        #userInfoStep {
            display: block;
        }
        #otpStep {
            display: none;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
            margin-right: 10px;
        }
        .gap-2 {
            gap: 10px;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-back:hover {
            background-color: #5a6268;
            color: white;
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
                                    <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post">
                                        <div class="form-title"><h6 id="stepTitle">Sign Up</h6></div>

                                        <!-- Step 1: User Information -->
                                        <div id="userInfoStep" class="step-container">
                                            <div class="form-group pos_rel mb-3">
                                                <input type="text" id="fullname" name="fullname" placeholder="Full Name" class="form-control lgn_input" required>
                                                <i class="uil uil-user-circle lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="email" id="emailaddress" name="emailaddress" placeholder="Email Address" class="form-control lgn_input" required>
                                                <i class="uil uil-envelope lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="text" id="phone" name="phone" placeholder="Phone Number" class="form-control lgn_input" required>
                                                <i class="uil uil-mobile-android-alt lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="text" id="address" name="address" placeholder="Address" class="form-control lgn_input" required>
                                                <i class="uil uil-location-point lgn_icon"></i>
                                            </div>

                                            <div class="form-group pos_rel mb-3">
                                                <input type="date" name="dob" class="form-control lgn_input" required>
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
                                                <input type="password" id="password" name="password" placeholder="Password" class="form-control lgn_input" required>
                                                <i class="uil uil-padlock lgn_icon"></i>
                                            </div>

                                            <button type="button" id="continueToOTP" class="login-btn hover-btn">Sign Up Now</button>
                                        </div>

                                        <!-- Step 2: OTP Verification -->
                                        <div id="otpStep" class="step-container">
                                            <div class="text-center mb-4">
                                                <p>We've sent a verification code to your email address. Please enter it below:</p>
                                            </div>

                                            <div class="form-group pos_rel mb-4">
                                                <label class="control-label mb-3">Verification Code</label>
                                                <div class="d-flex justify-content-center mb-3">
                                                    <input type="text" id="code1" name="code1" class="form-control otp-input" maxlength="1" required>
                                                    <input type="text" id="code2" name="code2" class="form-control otp-input" maxlength="1" required>
                                                    <input type="text" id="code3" name="code3" class="form-control otp-input" maxlength="1" required>
                                                    <input type="text" id="code4" name="code4" class="form-control otp-input" maxlength="1" required>
                                                </div>
                                                
                                                <div class="text-center mb-3">
                                                    <a href="#" id="resendCode" class="text-primary">Resend Code</a>
                                                </div>
                                            </div>

                                            <div class="d-flex gap-2">
                                                <button type="button" id="backToUserInfo" class="btn btn-back flex-fill">Back</button>
                                                <button type="button" id="finalRegister" class="login-btn hover-btn flex-fill">Complete Registration</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="signup-link">
                                    <p>Already have an account? <a href="login">Sign In Now</a></p>
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

    <!-- Display error message if any -->
    <% if (request.getAttribute("error") != null) { %>
        <script>
            alert("<%= request.getAttribute("error") %>");
        </script>
    <% } %>

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