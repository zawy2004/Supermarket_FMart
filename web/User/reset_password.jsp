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
    <title>FMart - Reset Password</title>
    
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
        
        .password-strength {
            margin-top: 5px;
            font-size: 12px;
        }
        
        .strength-weak { color: #dc3545; }
        .strength-medium { color: #ffc107; }
        .strength-strong { color: #28a745; }
        
        .password-requirements {
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 2px;
        }
        
        .requirement i {
            margin-right: 5px;
            font-size: 10px;
        }
        
        .requirement.valid {
            color: #28a745;
        }
        
        .requirement.invalid {
            color: #dc3545;
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
        
        .verification-info {
            background: #e7f3ff;
            border: 1px solid #b8daff;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .verification-info i {
            color: #007bff;
            font-size: 24px;
            margin-bottom: 10px;
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
                                    
                                    <!-- Verification Info -->
                                    <div class="verification-info">
                                        <i class="uil uil-check-circle"></i>
                                        <h6>Code Verified Successfully!</h6>
                                        <p class="mb-0">
                                            Now you can set a new password for your account<br>
                                            <strong>${sessionScope.resetEmail}</strong>
                                        </p>
                                    </div>
                                    
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
                                    
                                    <form id="resetPasswordForm" action="${pageContext.request.contextPath}/forgot-password" method="post">
                                        <input type="hidden" name="action" value="reset-password">
                                        
                                        <div class="form-title">
                                            <h6>Set New Password</h6>
                                        </div>
                                        
                                        <div class="form-group pos_rel mb-3">
                                            <input id="passwordnew" 
                                                   name="passwordnew" 
                                                   type="password" 
                                                   placeholder="Enter New Password" 
                                                   class="form-control lgn_input" 
                                                   required="">
                                            <i class="uil uil-padlock lgn_icon"></i>
                                            <div class="password-strength" id="passwordStrength"></div>
                                            <div class="password-requirements" id="passwordRequirements">
                                                <div class="requirement" id="req-length">
                                                    <i class="uil uil-times"></i>
                                                    At least 6 characters
                                                </div>
                                                <div class="requirement" id="req-letter">
                                                    <i class="uil uil-times"></i>
                                                    Contains letters
                                                </div>
                                                <div class="requirement" id="req-number">
                                                    <i class="uil uil-times"></i>
                                                    Contains numbers
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group pos_rel mb-3">
                                            <input id="passwordconfirm" 
                                                   name="passwordconfirm" 
                                                   type="password" 
                                                   placeholder="Re-enter New Password" 
                                                   class="form-control lgn_input" 
                                                   required="">
                                            <i class="uil uil-padlock lgn_icon"></i>
                                            <div class="password-match" id="passwordMatch"></div>
                                        </div>
                                        
                                        <button class="login-btn hover-btn h_50 btn-loading" type="submit" id="submitBtn">
                                            <span class="loading">
                                                <i class="uil uil-spinner-alt fa-spin"></i>
                                            </span>
                                            <span class="btn-text">Reset Password</span>
                                        </button>
                                    </form>
                                </div>
                                <div class="signup-link">
                                    <p>Go Back - <a href="${pageContext.request.contextPath}/forgot-password?action=verify">Enter Code Again</a></p>
                                    <p><a href="sign_in.jsp">Back to Sign In</a></p>
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
            const form = $('#resetPasswordForm');
            const submitBtn = $('#submitBtn');
            const loading = submitBtn.find('.loading');
            const btnText = submitBtn.find('.btn-text');
            const newPasswordInput = $('#passwordnew');
            const confirmPasswordInput = $('#passwordconfirm');
            
            // Password strength checking
            newPasswordInput.on('input', function() {
                const password = $(this).val();
                checkPasswordStrength(password);
                checkPasswordMatch();
            });
            
            // Password match checking
            confirmPasswordInput.on('input', function() {
                checkPasswordMatch();
            });
            
            function checkPasswordStrength(password) {
                const requirements = {
                    length: password.length >= 6,
                    letter: /[A-Za-z]/.test(password),
                    number: /[0-9]/.test(password)
                };
                
                // Update requirement indicators
                updateRequirement('req-length', requirements.length);
                updateRequirement('req-letter', requirements.letter);
                updateRequirement('req-number', requirements.number);
                
                // Calculate strength
                const score = Object.values(requirements).filter(Boolean).length;
                const strengthElement = $('#passwordStrength');
                
                if (password.length === 0) {
                    strengthElement.text('');
                } else if (score === 1) {
                    strengthElement.text('Weak').removeClass().addClass('password-strength strength-weak');
                } else if (score === 2) {
                    strengthElement.text('Medium').removeClass().addClass('password-strength strength-medium');
                } else if (score === 3) {
                    strengthElement.text('Strong').removeClass().addClass('password-strength strength-strong');
                }
                
                return score === 3;
            }
            
            function updateRequirement(id, isValid) {
                const element = $('#' + id);
                if (isValid) {
                    element.removeClass('invalid').addClass('valid');
                    element.find('i').removeClass('uil-times').addClass('uil-check');
                } else {
                    element.removeClass('valid').addClass('invalid');
                    element.find('i').removeClass('uil-check').addClass('uil-times');
                }
            }
            
            function checkPasswordMatch() {
                const newPassword = newPasswordInput.val();
                const confirmPassword = confirmPasswordInput.val();
                const matchElement = $('#passwordMatch');
                
                if (confirmPassword.length === 0) {
                    matchElement.text('');
                    return false;
                }
                
                if (newPassword === confirmPassword) {
                    matchElement.text('Passwords match').removeClass().addClass('password-strength strength-strong');
                    return true;
                } else {
                    matchElement.text('Passwords do not match').removeClass().addClass('password-strength strength-weak');
                    return false;
                }
            }
            
            // Form submission
            form.on('submit', function(e) {
                e.preventDefault();
                
                const newPassword = newPasswordInput.val();
                const confirmPassword = confirmPasswordInput.val();
                
                // Validate password strength
                if (!checkPasswordStrength(newPassword)) {
                    showError('Password must be at least 6 characters and contain both letters and numbers.');
                    return;
                }
                
                // Validate password match
                if (!checkPasswordMatch()) {
                    showError('Passwords do not match.');
                    return;
                }
                
                // Show loading state
                loading.addClass('show');
                btnText.hide();
                submitBtn.prop('disabled', true);
                
                // Submit form
                this.submit();
            });
            
            function showError(message) {
                // Remove existing alerts
                $('.alert-danger').remove();
                
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
            
            // Focus on new password input
            newPasswordInput.focus();
            
            // Check if user accessed this page without verification
            <c:if test="${sessionScope.codeVerified == null || !sessionScope.codeVerified}">
                window.location.href = '${pageContext.request.contextPath}/forgot-password?action=verify';
            </c:if>
        });
    </script>
</body>

</html>