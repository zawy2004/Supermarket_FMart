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
    <title>FMart - Verify Reset Code</title>
    
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
        /* Custom styles for OTP verification */
        .otp-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }
        
        .otp-input {
            width: 50px;
            height: 50px;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            border: 2px solid #ddd;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .otp-input:focus {
            border-color: #ff6a00;
            box-shadow: 0 0 5px rgba(255, 106, 0, 0.3);
            outline: none;
        }
        
        .otp-input.filled {
            border-color: #28a745;
            background-color: #f8f9fa;
        }
        
        .timer-container {
            text-align: center;
            margin: 15px 0;
        }
        
        .timer {
            font-weight: bold;
            color: #ff6a00;
        }
        
        .resend-link {
            color: #007bff;
            cursor: pointer;
            text-decoration: underline;
        }
        
        .resend-link:hover {
            color: #0056b3;
        }
        
        .resend-link.disabled {
            color: #6c757d;
            cursor: not-allowed;
            text-decoration: none;
        }
        
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
        
        .loading-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }
        
        .loading-spinner {
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
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
                                        <i class="uil uil-envelope-check"></i>
                                        <h6>Verify Reset Code</h6>
                                        <p class="mb-0">
                                            We've sent a 4-digit verification code to<br>
                                            <strong>${sessionScope.resetEmail != null ? sessionScope.resetEmail : param.email}</strong>
                                        </p>
                                    </div>
                                    
                                    <!-- Error/Success Messages -->
                                    <c:if test="${not empty errorMessage}">
                                        <div class="alert alert-danger">
                                            <i class="uil uil-exclamation-triangle"></i>
                                            ${errorMessage}
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${not empty successMessage}">
                                        <div class="alert alert-success">
                                            <i class="uil uil-check-circle"></i>
                                            ${successMessage}
                                        </div>
                                    </c:if>
                                    
                                    <form id="verifyCodeForm" action="${pageContext.request.contextPath}/forgot-password" method="post">
                                        <input type="hidden" name="action" value="verify-reset-code">
                                        
                                        <div class="form-title">
                                            <h6>Enter Verification Code</h6>
                                        </div>
                                        
                                        <!-- OTP Input Fields - 4 digits only -->
                                        <div class="otp-container">
                                            <input type="text" class="otp-input" id="code1" name="code1" maxlength="1" required>
                                            <input type="text" class="otp-input" id="code2" name="code2" maxlength="1" required>
                                            <input type="text" class="otp-input" id="code3" name="code3" maxlength="1" required>
                                            <input type="text" class="otp-input" id="code4" name="code4" maxlength="1" required>
                                        </div>
                                        
                                        <!-- Timer and Resend -->
                                        <div class="timer-container">
                                            <p class="mb-2">Code expires in: <span class="timer" id="timer">15:00</span></p>
                                            <p class="mb-0">
                                                Didn't receive the code? 
                                                <span class="resend-link" id="resendLink">Resend Code</span>
                                            </p>
                                        </div>
                                        
                                        <button class="login-btn hover-btn h_50" type="submit" id="verifyBtn">
                                            <i class="uil uil-check-circle"></i> Verify Code
                                        </button>
                                    </form>
                                </div>
                                <div class="signup-link">
                                    <p>Go Back - <a href="${pageContext.request.contextPath}/forgot-password">Try Another Email</a></p>
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

    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner">
            <i class="uil uil-spinner-alt fa-spin" style="font-size: 24px;"></i>
            <p class="mt-2 mb-0">Verifying code...</p>
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
            // OTP Input Handling - 4 digits
            const otpInputs = $('.otp-input');
            
            // Auto-focus next input and handle backspace
            otpInputs.on('input', function(e) {
                const current = $(this);
                const value = current.val();
                
                // Only allow numbers
                if (!/^\d$/.test(value)) {
                    current.val('');
                    return;
                }
                
                current.addClass('filled');
                
                // Move to next input
                const nextInput = current.next('.otp-input');
                if (nextInput.length) {
                    nextInput.focus();
                } else {
                    // All inputs filled, auto-submit
                    $('#verifyBtn').focus();
                }
                
                updateVerifyButton();
            });
            
            // Handle backspace
            otpInputs.on('keydown', function(e) {
                const current = $(this);
                
                if (e.key === 'Backspace') {
                    if (current.val() === '') {
                        // Move to previous input
                        const prevInput = current.prev('.otp-input');
                        if (prevInput.length) {
                            prevInput.focus();
                            prevInput.val('');
                            prevInput.removeClass('filled');
                        }
                    } else {
                        current.val('');
                        current.removeClass('filled');
                    }
                    updateVerifyButton();
                }
            });
            
            // Paste handling - 4 digits
            otpInputs.on('paste', function(e) {
                e.preventDefault();
                const pastedData = e.originalEvent.clipboardData.getData('text');
                const digits = pastedData.replace(/\D/g, '').slice(0, 4); // Only 4 digits
                
                for (let i = 0; i < digits.length && i < otpInputs.length; i++) {
                    $(otpInputs[i]).val(digits[i]).addClass('filled');
                }
                
                updateVerifyButton();
            });
            
            function updateVerifyButton() {
                const allFilled = otpInputs.toArray().every(input => $(input).val() !== '');
                $('#verifyBtn').prop('disabled', !allFilled);
            }
            
            // Countdown Timer
            let timeLeft = 15 * 60; // 15 minutes in seconds
            const timerDisplay = $('#timer');
            const resendLink = $('#resendLink');
            
            function updateTimer() {
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;
                const display = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
                timerDisplay.text(display);
                
                if (timeLeft <= 0) {
                    timerDisplay.text('00:00');
                    timerDisplay.parent().html('<span style="color: red;">Code has expired!</span>');
                    resendLink.removeClass('disabled').text('Send New Code');
                    otpInputs.prop('disabled', true);
                    $('#verifyBtn').prop('disabled', true).text('Code Expired');
                    return;
                }
                
                timeLeft--;
            }
            
            // Update timer every second
            const timerInterval = setInterval(updateTimer, 1000);
            updateTimer(); // Initial call
            
            // Resend Code
            let resendCooldown = false;
            resendLink.on('click', function() {
                if (resendCooldown || $(this).hasClass('disabled')) return;
                
                resendCooldown = true;
                $(this).addClass('disabled').text('Sending...');
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/forgot-password',
                    method: 'POST',
                    data: {
                        action: 'resend-reset-code',
                        email: '${sessionScope.resetEmail}'
                    },
                    success: function(response) {
                        if (response.status === 'success') {
                            // Reset timer
                            timeLeft = 15 * 60;
                            
                            // Show success message
                            $('.alert').remove();
                            $('.verification-info').after(
                                '<div class="alert alert-success">' +
                                '<i class="uil uil-check-circle"></i> ' +
                                response.message +
                                '</div>'
                            );
                            
                            // Clear inputs
                            otpInputs.val('').removeClass('filled').prop('disabled', false);
                            $('#code1').focus();
                            $('#verifyBtn').prop('disabled', true).text('Verify Code');
                            
                        } else {
                            $('.alert').remove();
                            $('.verification-info').after(
                                '<div class="alert alert-danger">' +
                                '<i class="uil uil-exclamation-triangle"></i> ' +
                                response.message +
                                '</div>'
                            );
                        }
                    },
                    error: function() {
                        $('.alert').remove();
                        $('.verification-info').after(
                            '<div class="alert alert-danger">' +
                            '<i class="uil uil-exclamation-triangle"></i> ' +
                            'Network error. Please try again.' +
                            '</div>'
                        );
                    },
                    complete: function() {
                        setTimeout(() => {
                            resendLink.removeClass('disabled').text('Resend Code');
                            resendCooldown = false;
                        }, 30000); // 30 seconds cooldown
                    }
                });
            });
            
            // Form submission
            $('#verifyCodeForm').on('submit', function(e) {
                e.preventDefault();
                
                const code = otpInputs.map(function() { return $(this).val(); }).get().join('');
                
                if (code.length !== 4) {
                    alert('Please enter the complete 4-digit code.');
                    return;
                }
                
                $('#loadingOverlay').show();
                
                // Submit form
                this.submit();
            });
            
            // Auto-focus first input
            $('#code1').focus();
            
            // Initial button state
            updateVerifyButton();
            
            // Auto-hide alerts after 10 seconds
            setTimeout(() => {
                $('.alert').fadeOut(500, function() {
                    $(this).remove();
                });
            }, 10000);
        });
    </script>
</body>

</html>