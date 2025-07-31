<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt hàng thành công - FMart</title>
        <link rel="icon" type="image/png" href="images/fav.png">
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
        <link href="User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Rajdhani', sans-serif;
                background: linear-gradient(135deg, #ff9a56 0%, #ff6b35 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }
            
            .success-container {
                max-width: 650px;
                width: 100%;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(0,0,0,0.15);
                overflow: hidden;
                position: relative;
            }
            
            .success-header {
                background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
                color: white;
                padding: 40px 30px;
                text-align: center;
                position: relative;
            }
            
            .success-header::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="1" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
                animation: float 20s infinite linear;
                pointer-events: none;
            }
            
            @keyframes float {
                0% { transform: translate(-50%, -50%) rotate(0deg); }
                100% { transform: translate(-50%, -50%) rotate(360deg); }
            }
            
            .success-icon {
                width: 80px;
                height: 80px;
                background: rgba(255,255,255,0.2);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                position: relative;
                z-index: 1;
            }
            
            .success-icon i {
                font-size: 2.5rem;
                animation: checkmark 0.6s ease-in-out;
            }
            
            @keyframes checkmark {
                0% { transform: scale(0) rotate(-45deg); }
                50% { transform: scale(1.2) rotate(-45deg); }
                100% { transform: scale(1) rotate(0deg); }
            }
            
            .success-title {
                font-size: 2.2rem;
                font-weight: 600;
                margin-bottom: 10px;
                position: relative;
                z-index: 1;
            }
            
            .success-subtitle {
                font-size: 1.1rem;
                opacity: 0.9;
                position: relative;
                z-index: 1;
            }
            
            .order-details {
                padding: 40px 30px;
            }
            
            .order-info-card {
                background: #fff8f5;
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 25px;
                border-left: 4px solid #ff6b35;
            }
            
            .order-info-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
                padding: 10px 0;
                border-bottom: 1px solid #e9ecef;
            }
            
            .order-info-row:last-child {
                border-bottom: none;
                margin-bottom: 0;
            }
            
            .info-label {
                font-weight: 500;
                color: #6c757d;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            
            .info-value {
                font-weight: 600;
                color: #495057;
                text-align: right;
            }
            
            .total-amount {
                font-size: 1.3rem;
                color: #ff6b35;
                font-weight: 700;
            }
            
            .order-number {
                font-size: 1.2rem;
                color: #ff6b35;
                font-weight: 600;
                font-family: 'Courier New', monospace;
            }
            
            .thank-you-message {
                background: linear-gradient(135deg, #fff8f5 0%, #ffeee6 100%);
                border-radius: 15px;
                padding: 25px;
                text-align: center;
                margin-bottom: 30px;
                border: 2px solid #ffe0d1;
            }
            
            .thank-you-message h4 {
                color: #ff6b35;
                margin-bottom: 10px;
                font-weight: 600;
            }
            
            .thank-you-message p {
                color: #666;
                margin-bottom: 0;
                line-height: 1.6;
            }
            
            .action-buttons {
                display: flex;
                gap: 15px;
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .btn-primary-custom {
                background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
                border: none;
                padding: 12px 30px;
                border-radius: 25px;
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            
            .btn-primary-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(255, 107, 53, 0.4);
                color: white;
                text-decoration: none;
            }
            
            .btn-outline-custom {
                background: transparent;
                border: 2px solid #ff6b35;
                color: #ff6b35;
                padding: 12px 30px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            
            .btn-outline-custom:hover {
                background: #ff6b35;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(255, 107, 53, 0.4);
                text-decoration: none;
            }
            
            .confetti {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                overflow: hidden;
            }
            
            .confetti-piece {
                position: absolute;
                width: 10px;
                height: 10px;
                background: #ff6b35;
                animation: confetti-fall 3s linear infinite;
            }
            
            .confetti-piece:nth-child(2) { background: #f7931e; animation-delay: 0.5s; left: 20%; }
            .confetti-piece:nth-child(3) { background: #ff9a56; animation-delay: 1s; left: 40%; }
            .confetti-piece:nth-child(4) { background: #ffc09f; animation-delay: 1.5s; left: 60%; }
            .confetti-piece:nth-child(5) { background: #ffe0d1; animation-delay: 2s; left: 80%; }
            
            @keyframes confetti-fall {
                0% {
                    transform: translateY(-100vh) rotate(0deg);
                    opacity: 1;
                }
                100% {
                    transform: translateY(100vh) rotate(720deg);
                    opacity: 0;
                }
            }
            
            @media (max-width: 768px) {
                .success-container {
                    margin: 20px;
                }
                
                .success-header {
                    padding: 30px 20px;
                }
                
                .success-title {
                    font-size: 1.8rem;
                }
                
                .order-details {
                    padding: 30px 20px;
                }
                
                .order-info-row {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 5px;
                }
                
                .info-value {
                    text-align: left;
                }
                
                .action-buttons {
                    flex-direction: column;
                    align-items: center;
                }
                
                .btn-primary-custom,
                .btn-outline-custom {
                    width: 100%;
                    justify-content: center;
                    max-width: 250px;
                }
            }
        </style>
    </head>
    <body>
        <div class="success-container">
            <!-- Confetti Animation -->
            <div class="confetti">
                <div class="confetti-piece"></div>
                <div class="confetti-piece"></div>
                <div class="confetti-piece"></div>
                <div class="confetti-piece"></div>
                <div class="confetti-piece"></div>
            </div>
            
            <!-- Success Header -->
            <div class="success-header">
                <div class="success-icon">
                    <i class="uil uil-check"></i>
                </div>
                <h1 class="success-title">Đặt hàng thành công!</h1>
                <p class="success-subtitle">Đơn hàng của bạn đã được xác nhận và đang được xử lý</p>
            </div>
            
            <!-- Order Details -->
            <div class="order-details">
                <!-- Order Information Card -->
                <div class="order-info-card">
                    <div class="order-info-row">
                        <span class="info-label">
                            <i class="uil uil-receipt"></i>
                            Mã đơn hàng:
                        </span>
                        <span class="info-value order-number">${order.orderNumber}</span>
                    </div>
                    <div class="order-info-row">
                        <span class="info-label">
                            <i class="uil uil-user"></i>
                            Khách hàng:
                        </span>
                        <span class="info-value">${name}</span>
                    </div>
                    <div class="order-info-row">
                        <span class="info-label">
                            <i class="uil uil-phone"></i>
                            Số điện thoại:
                        </span>
                        <span class="info-value">${phone}</span>
                    </div>
                    <div class="order-info-row">
                        <span class="info-label">
                            <i class="uil uil-map-marker"></i>
                            Địa chỉ giao hàng:
                        </span>
                        <span class="info-value">${order.deliveryAddress}</span>
                    </div>
                    <div class="order-info-row">
                        <span class="info-label">
                            <i class="uil uil-credit-card"></i>
                            Phương thức thanh toán:
                        </span>
                        <span class="info-value">
                            ${order.paymentMethod == 'cod' ? 'Thanh toán khi nhận hàng' : 'VNPAY'}
                        </span>
                    </div>
                    <div class="order-info-row">
                        <span class="info-label">
                            <i class="uil uil-money-bill"></i>
                            Tổng tiền:
                        </span>
                        <span class="info-value total-amount">
                            <fmt:formatNumber value="${finalAmount}" type="number"/> ₫
                        </span>
                    </div>
                </div>
                
                <!-- Thank You Message -->
                <div class="thank-you-message">
                    <h4><i class="uil uil-heart"></i> Cảm ơn bạn đã tin tưởng FMart!</h4>
                    <p>
                        Chúng tôi sẽ liên hệ và giao hàng sớm nhất có thể.<br>
                        Bạn có thể theo dõi trạng thái đơn hàng trong trang "Đơn hàng của tôi".
                    </p>
                </div>
                
                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="orders" class="btn-outline-custom">
                        <i class="uil uil-package"></i>
                        Theo dõi đơn hàng
                    </a>
                    <a href="home" class="btn-primary-custom">
                        <i class="uil uil-shop"></i>
                        Tiếp tục mua sắm
                    </a>
                </div>
            </div>
        </div>
        
        <script>
            // Add smooth entrance animation
            document.addEventListener('DOMContentLoaded', function() {
                const container = document.querySelector('.success-container');
                container.style.opacity = '0';
                container.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    container.style.transition = 'all 0.6s ease';
                    container.style.opacity = '1';
                    container.style.transform = 'translateY(0)';
                }, 100);
                
                // Auto redirect after 30 seconds
                setTimeout(() => {
                    if (confirm('Bạn có muốn chuyển về trang chủ không?')) {
                        window.location.href = 'home';
                    }
                }, 30000);
            });
        </script>
    </body>
</html>