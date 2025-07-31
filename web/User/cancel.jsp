<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hủy thanh toán - FMart</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/fav.png">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Rajdhani', sans-serif;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            margin: 0;
        }
        .cancel-container {
            max-width: 600px;
            width: 100%;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            overflow: hidden;
            position: relative;
        }
        .cancel-header {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
            position: relative;
        }
        .cancel-icon {
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }
        .cancel-icon i {
            font-size: 2.5rem;
            animation: shake 0.6s ease-in-out;
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        .cancel-title {
            font-size: 2.2rem;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .cancel-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        .cancel-details {
            padding: 40px 30px;
        }
        .info-card {
            background: #fff5f5;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            border-left: 4px solid #ff6b6b;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding: 10px 0;
            border-bottom: 1px solid #fee;
        }
        .info-row:last-child {
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
        }
        .reason-message {
            background: linear-gradient(135deg, #fff5f5 0%, #ffeaea 100%);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            margin-bottom: 30px;
            border: 2px solid #ffd6cc;
        }
        .reason-message h4 {
            color: #dc3545;
            margin-bottom: 10px;
            font-weight: 600;
        }
        .reason-message p {
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
        .btn-primary {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
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
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
            color: white;
            text-decoration: none;
        }
        .btn-outline {
            background: transparent;
            border: 2px solid #6c757d;
            color: #6c757d;
            padding: 12px 30px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-outline:hover {
            background: #6c757d;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(108, 117, 125, 0.4);
            text-decoration: none;
        }
        @media (max-width: 768px) {
            .cancel-container {
                margin: 20px;
            }
            .cancel-header {
                padding: 30px 20px;
            }
            .cancel-title {
                font-size: 1.8rem;
            }
            .cancel-details {
                padding: 30px 20px;
            }
            .info-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            .btn-primary, .btn-outline {
                width: 100%;
                justify-content: center;
                max-width: 250px;
            }
        }
    </style>
</head>
<body>
    <div class='cancel-container'>
        <div class='cancel-header'>
            <div class='cancel-icon'>
                <i class='uil uil-times-circle'></i>
            </div>
            <h1 class='cancel-title'>Thanh toán bị hủy!</h1>
            <p class='cancel-subtitle'>Giao dịch của bạn đã bị hủy bỏ</p>
        </div>

        <div class='cancel-details'>
            <div class='info-card'>
                <div class='info-row'>
                    <span class='info-label'>
                        <i class='uil uil-receipt'></i>
                        Mã đơn hàng:
                    </span>
                    <span class='info-value'>${param.orderCode != null ? param.orderCode : "Không rõ"}</span>
                </div>
                <div class='info-row'>
                    <span class='info-label'>
                        <i class='uil uil-info-circle'></i>
                        Trạng thái:
                    </span>
                    <span class='info-value'>${param.status != null ? param.status : "Đã hủy"}</span>
                </div>
            </div>

            <div class='reason-message'>
                <h4><i class='uil uil-exclamation-triangle'></i> Lý do hủy</h4>
                <p>
                    Thanh toán có thể bị hủy do nhiều nguyên nhân:<br>
                    • Bạn đã chủ động hủy giao dịch<br>
                    • Phiên thanh toán đã hết hạn<br>
                    • Có lỗi xảy ra trong quá trình xử lý
                </p>
            </div>

            <div class='action-buttons'>
                <a href="${pageContext.request.contextPath}/checkout" class='btn-primary'>
                    <i class='uil uil-shop'></i>
                    Quay lại giỏ hàng
                </a>
                
                <a href="${pageContext.request.contextPath}/home" class='btn-primary'>
                    <i class='uil uil-shop'></i>
                    Tiếp tục mua sắm
                </a>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const container = document.querySelector('.cancel-container');
            container.style.opacity = '0';
            container.style.transform = 'translateY(30px)';

            setTimeout(() => {
                container.style.transition = 'all 0.6s ease';
                container.style.opacity = '1';
                container.style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>
