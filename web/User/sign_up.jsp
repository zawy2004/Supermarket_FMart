<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FMart - Sign Up</title>

    <link rel="icon" type="image/png" href="images/fav.png">
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

    <style>
        .is-invalid {
            border: 1px solid red !important;
        }

        .text-danger {
            font-size: 0.85rem;
            margin-top: 4px;
            color: red;
            display: none;
        }

        .text-danger.active {
            display: block;
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
                                <a href="index.jsp"><img src="images/logo.svg" alt=""></a>
                                <a href="index.jsp"><img class="logo-inverse" src="images/dark-logo.svg" alt=""></a>
                            </div>
                            <div class="form-dt">
                                <div class="form-inpts checout-address-step">
                                    <form action="register" method="post">
                                        <div class="form-title">
                                            <h6>Sign Up</h6>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="text" name="username" placeholder="Username" class="form-control lgn_input" required>
                                            <small class="text-danger" id="username-error"></small>
                                            <i class="uil uil-user lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="text" name="fullname" placeholder="Full Name" class="form-control lgn_input" required>
                                            <small class="text-danger" id="fullname-error"></small>
                                            <i class="uil uil-user-circle lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="email" name="emailaddress" placeholder="Email Address" class="form-control lgn_input" required>
                                            <small class="text-danger" id="emailaddress-error"></small>
                                            <i class="uil uil-envelope lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="text" name="phone" placeholder="Phone Number" class="form-control lgn_input" required>
                                            <small class="text-danger" id="phone-error">Invalid phone</small>
                                            <i class="uil uil-mobile-android-alt lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="text" name="address" placeholder="Address" class="form-control lgn_input" required>
                                            <small class="text-danger" id="address-error"></small>
                                            <i class="uil uil-location-point lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="date" name="dob" class="form-control lgn_input" placeholder="Date of Birth" required>
                                            <small class="text-danger" id="dob-error"></small>
                                            <i class="uil uil-calendar-alt lgn_icon"></i>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <select name="gender" class="form-control lgn_input" required>
                                                <option value="">Select Gender</option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                                <option value="Other">Other</option>
                                            </select>
                                            <small class="text-danger" id="gender-error"></small>
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
                                            <small class="text-danger" id="verification-error"></small>
                                        </div>

                                        <div class="form-group pos_rel mb-3">
                                            <input type="password" name="password" placeholder="Password" class="form-control lgn_input" required>
                                            <small class="text-danger" id="password-error"></small>
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

    <script>
        // Đảm bảo jQuery đã tải trước khi chạy script
        $(document).ready(function() {
            console.log("jQuery loaded successfully"); // Debug: Kiểm tra jQuery

            if (typeof jQuery === 'undefined') {
                console.error("jQuery not loaded! Check path: /Supermarket_FMart/js/jquery.min.js");
            }

            // Định nghĩa các validator
            const validators = {
                username: {
                    el: $("input[name='username']"),
                    rule: v => /^[a-zA-Z0-9_]{1,10}$/.test(v),
                    message: "Invalid username (1-10 alphanumeric characters or _)."
                },
                fullname: {
                    el: $("input[name='fullname']"),
                    rule: v => /^[A-Za-zÀ-Ỹà-ỹ\s]+$/.test(v),
                    message: "Invalid full name (only letters and spaces)."
                },
                emailaddress: {
                    el: $("input[name='emailaddress']"),
                    rule: v => /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/.test(v),
                    message: "Invalid email (must contain @ and be in format like example@domain.com)."
                },
                phone: {
                    el: $("input[name='phone']"),
                    rule: v => /^0\d{9}$/.test(v),
                    message: "Invalid phone (must start with 0 and be 10 digits)."
                },
                address: {
                    el: $("input[name='address']"),
                    rule: v => /^[A-Za-zÀ-Ỹà-ỹ0-9\s]+$/.test(v),
                    message: "Invalid address (only letters, numbers, and spaces)."
                },
                dob: {
                    el: $("input[name='dob']"),
                    rule: v => {
                        if (!v) return false;
                        const date = new Date(v);
                        const today = new Date();
                        today.setHours(0, 0, 0, 0);
                        return date <= today && !isNaN(date.getTime());
                    },
                    message: "Invalid date of birth."
                },
                gender: {
                    el: $("select[name='gender']"),
                    rule: v => v.trim() !== "" && ["Male", "Female", "Other"].includes(v),
                    message: "Invalid gender."
                },
                password: {
                    el: $("input[name='password']"),
                    rule: v => /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/.test(v),
                    message: "Invalid password (must be at least 6 characters with letters and numbers)."
                }
            };

            // Hàm tạo phần tử lỗi
            function createErrorEl(msg) {
                const small = $("<small>").addClass("text-danger active").text(msg);
                return small[0];
            }

            // Hàm validate một trường
            function validateField({ el, rule, message }) {
                const parent = el.closest(".form-group");
                const errorEl = parent.find("small.text-danger");
                const isValid = rule(el.val().trim());

                // Xóa lỗi cũ nếu có
                if (errorEl.length) {
                    errorEl.remove();
                    el.removeClass("is-invalid");
                }

                // Hiển thị lỗi nếu không hợp lệ và có giá trị nhập
                if (!isValid && el.val().trim() !== "") {
                    el.addClass("is-invalid");
                    if (!parent.find("small.text-danger").length) {
                        parent.append(createErrorEl(message));
                    }
                } else if (isValid && el.hasClass("is-invalid")) {
                    el.removeClass("is-invalid");
                }
            }

            // Validate mã xác minh
            const codeInputs = [
                $("input[name='code1']"),
                $("input[name='code2']"),
                $("input[name='code3']"),
                $("input[name='code4']")
            ];
            let verificationValid = false;

            function validateVerificationCode() {
                const code = codeInputs.map(input => input.val().trim()).join('');
                const parent = $(".form-group .code-alrt-inputs");
                const errorEl = parent.find("small#verification-error");

                if (errorEl.length) errorEl.remove();

                if (code.length > 0 && (code.length !== 4 || !/^\d+$/.test(code))) {
                    const newErrorEl = createErrorEl("Invalid verification code (must be 4 digits).");
                    newErrorEl.id = "verification-error";
                    parent.append(newErrorEl);
                    verificationValid = false;
                } else {
                    verificationValid = code.length === 4;
                }
            }

            // Xử lý sự kiện cho mã xác minh
            codeInputs.forEach((input, index) => {
                input.on("input", function() {
                    if (this.value.length >= this.maxLength) {
                        const next = codeInputs[index + 1];
                        if (next) next.focus();
                    }
                    validateVerificationCode();
                });
                input.on("blur", validateVerificationCode);
            });

            // Xử lý gửi mã xác minh
            $(".code-btn145").on("click", function(e) {
                e.preventDefault();
                const email = $("input[name='emailaddress']").val();
                if (validators.emailaddress.rule(email)) {
                    $.ajax({
                        url: "/Supermarket_FMart/SendVerificationCodeServlet", // Đường dẫn đầy đủ
                        type: "POST",
                        data: { emailaddress: email },
                        success: function(response) {
                            const result = JSON.parse(response);
                            if (result.status === "success") {
                                alert(result.message);
                            } else {
                                const errorEl = createErrorEl(result.message);
                                $(".form-group .code-alrt-inputs").append(errorEl);
                            }
                        },
                        error: function(xhr) {
                            const errorEl = createErrorEl("Failed to send verification code: " + xhr.statusText);
                            $(".form-group .code-alrt-inputs").append(errorEl);
                        }
                    });
                } else {
                    validateField(validators.emailaddress);
                }
            });

            // Xử lý resend code
            $(".resend-link").on("click", function(e) {
                e.preventDefault();
                $(".code-btn145").click();
            });

            // Áp dụng validate realtime cho tất cả trường
            Object.values(validators).forEach(({ el, rule, message }) => {
                el.on("input", function() {
                    console.log("Validating: " + el.attr("name") + " = " + el.val()); // Debug
                    validateField({ el: $(this), rule, message });
                });
                el.on("blur", function() {
                    console.log("Blur validating: " + el.attr("name") + " = " + el.val()); // Debug
                    validateField({ el: $(this), rule, message });
                });
            });

            // Kiểm tra toàn bộ form trước khi submit
            $("form").on("submit", function(e) {
                let isValid = true;
                Object.values(validators).forEach(({ el, rule, message }) => {
                    validateField({ el, rule, message });
                    if (el.hasClass("is-invalid")) isValid = false;
                });
                validateVerificationCode();
                if (!verificationValid) {
                    const parent = $(".form-group .code-alrt-inputs");
                    const errorEl = parent.find("small#verification-error");
                    if (!errorEl.length) {
                        const newErrorEl = createErrorEl("Verification code is required.");
                        newErrorEl.id = "verification-error";
                        parent.append(newErrorEl);
                    }
                    isValid = false;
                }
                if (!isValid) e.preventDefault();
            });
        });
    </script>
</body>
</html>