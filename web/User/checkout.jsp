<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, shrink-to-fit=9">
        <meta name="description" content="FMart Supermarket Checkout">
        <meta name="author" content="Your Team">
        <title>FMart - Thanh toán</title>

        <!-- Favicon Icon -->
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/User/images/fav.png">

        <!-- Stylesheets -->
        <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/User/vendor/unicons-2.0.1/css/unicons.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/User/css/style.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/User/css/responsive.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/User/css/night-mode.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/User/css/step-wizard.css" rel="stylesheet">

        <!-- Vendor Stylesheets -->
        <link href="${pageContext.request.contextPath}/User/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/User/vendor/OwlCarousel/assets/owl.carousel.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/User/vendor/OwlCarousel/assets/owl.theme.default.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/User/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/User/vendor/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">

        <style>
            .payment-method-radio {
                list-style: none;
                padding: 0;
                margin: 0;
                display: flex;
                gap: 100px; /* khoảng cách giữa các tùy chọn */
            }

            /* Từng mục chọn */
            .payment-method-radio li {
                position: relative;
            }

            /* Ẩn input radio */
            .payment-method-radio input[type="radio"] {
                display: none;
            }

            /* Style cho label để tạo hình nút */
            .payment-method-radio label {
                display: flex;
                flex-direction: column; /* xếp ảnh trên, chữ dưới nếu cần */
                align-items: center;
                justify-content: center;
                padding: 10px 15px;
                border: 2px solid #ccc;
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.3s ease;
                min-width: 100px;
                height: 40px;
            }

            /* Ảnh */
            .payment-method-radio label img {
                width: 50px;
                height: auto;
                margin-bottom: 5px;
            }

            /* Khi được chọn */
            .payment-method-radio input[type="radio"]:checked + label {
                border-color: #28a745;
                background-color: #e9f8ef;
                box-shadow: 0 0 5px rgba(0, 128, 0, 0.3);
            }

            .toast-notification {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 9999;
                min-width: 300px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            .payment-method-radio label {
                cursor: pointer;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                text-align: center;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .payment-method-radio input:checked + label {
                border-color: #007bff;
                background: #e7f1ff;
            }
            .payment-method-radio img {
                width: 24px;
                height: 24px;
                margin-right: 10px;
            }
            .phone-verified {
                color: #28a745;
                font-weight: 500;
            }
            .section-title {
                font-size: 1.25rem;
                margin-bottom: 1rem;
                border-bottom: 1px solid #eee;
                padding-bottom: 0.5rem;
            }
            .payment-description {
                display: none;
                margin-top: 10px;
                padding: 10px;
                background: #f8f9fa;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <!-- Category Model Start -->
        <div class="header-cate-model main-gambo-model modal fade" id="category_model" tabindex="-1" role="dialog" aria-modal="false">
            <div class="modal-dialog category-area" role="document">
                <div class="category-area-inner">
                    <div class="modal-header">
                        <button type="button" class="close btn-close" data-bs-dismiss="modal" aria-label="Close">
                            <i class="uil uil-multiply"></i>
                        </button>
                    </div>
                    <div class="category-model-content modal-content"> 
                        <div class="cate-header">
                            <h4>Chọn danh mục</h4>
                        </div>
                        <ul class="category-by-cat">
                            <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-1.svg" alt=""></div><div class="text"> Trái cây và Rau củ </div></a></li>
                            <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-2.svg" alt=""></div><div class="text"> Thực phẩm & Hàng khô </div></a></li>
                            <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-3.svg" alt=""></div><div class="text"> Sữa & Trứng </div></a></li>
                            <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-4.svg" alt=""></div><div class="text"> Đồ uống </div></a></li>
                            <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-5.svg" alt=""></div><div class="text"> Đồ ăn nhẹ </div></a></li>
                            <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-6.svg" alt=""></div><div class="text"> Chăm sóc nhà cửa </div></a></li>
                            <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-7.svg" alt=""></div><div class="text"> Mì & Nước chấm </div></a></li>
                            <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-8.svg" alt=""></div><div class="text"> Chăm sóc cá nhân </div></a></li>
                            <li><a href="#" class="single-cat-item"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-9.svg" alt=""></div><div class="text"> Chăm sóc thú cưng </div></a></li>
                        </ul>
                        <a href="#" class="morecate-btn"><i class="uil uil-apps"></i>Thêm danh mục</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Category Model End -->
        <!-- Search Model Start -->
        <div id="search_model" class="header-cate-model main-gambo-model modal fade" tabindex="-1" role="dialog" aria-modal="false">
            <div class="modal-dialog search-ground-area" role="document">
                <div class="category-area-inner">
                    <div class="modal-header">
                        <button type="button" class="close btn-close" data-bs-dismiss="modal" aria-label="Close">
                            <i class="uil uil-multiply"></i>
                        </button>
                    </div>
                    <div class="category-model-content modal-content"> 
                        <div class="search-header">
                            <form action="#">
                                <input type="search" placeholder="Tìm kiếm sản phẩm...">
                                <button type="submit"><i class="uil uil-search"></i></button>
                            </form>
                        </div>
                        <div class="search-by-cat">
                            <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-1.svg" alt=""></div><div class="text"> Trái cây và Rau củ </div></a>
                            <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-2.svg" alt=""></div><div class="text"> Thực phẩm & Hàng khô </div></a>
                            <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-3.svg" alt=""></div><div class="text"> Sữa & Trứng </div></a>
                            <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-4.svg" alt=""></div><div class="text"> Đồ uống </div></a>
                            <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-5.svg" alt=""></div><div class="text"> Đồ ăn nhẹ </div></a>
                            <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-6.svg" alt=""></div><div class="text"> Chăm sóc nhà cửa </div></a>
                            <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-7.svg" alt=""></div><div class="text"> Mì & Nước chấm </div></a>
                            <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-8.svg" alt=""></div><div class="text"> Chăm sóc cá nhân </div></a>
                            <a href="#" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/User/images/category/icon-9.svg" alt=""></div><div class="text"> Chăm sóc thú cưng </div></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Search Model End -->
        <!-- Cart Sidebar Offcanvas Start -->
        <jsp:include page="cart_sidebar.jsp"></jsp:include>
            <!-- Header Start -->
        <jsp:include page="search_model.jsp"></jsp:include>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Header End -->
            <!-- Body Start -->
            <div class="wrapper">
                <div class="gambo-Breadcrumb">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Thanh toán</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <div class="all-product-grid">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-md-7">
                            <form id="checkoutForm" action="${pageContext.request.contextPath}/processCheckout" method="post">
                                <div class="pdpt-bg">
                                    <div class="pdpt-title">
                                        <h4>Thông tin thanh toán</h4>
                                    </div>
                                    <div class="pdpt-body">
                                        <!-- Xác minh số điện thoại -->
                                        <div class="form-group mt-3">
                                            <label class="control-label">Số điện thoại*</label>
                                            <input id="phone" name="phone" type="text" placeholder="Số điện thoại" class="form-control" value="${sessionScope.userPhone}" required>
                                            <small class="form-text text-muted">Số điện thoại dùng để gửi thông báo đơn hàng.</small>
                                        </div>

                                        <!-- Họ và tên -->
                                        <div class="form-group mt-3">
                                            <label class="control-label">Họ và tên*</label>
                                            <input id="name" name="name" type="text" placeholder="Họ và tên" class="form-control" required>
                                        </div>

                                        <!-- Email -->
                                        <div class="form-group mt-3">
                                            <label class="control-label">Email*</label>
                                            <input id="email" name="email" type="email" placeholder="Email" class="form-control" required>
                                        </div>

                                        <!-- Địa chỉ -->
                                        <div class="form-group mt-3">
                                            <label class="control-label">Tỉnh/Thành phố*</label>
                                            <input id="province" name="province" type="text" placeholder="Tỉnh/Thành phố" class="form-control" required>
                                        </div>
                                        <div class="form-group mt-3">
                                            <label class="control-label">Quận/Huyện*</label>
                                            <input id="district" name="district" type="text" placeholder="Quận/Huyện" class="form-control" required>
                                        </div>
                                        <div class="form-group mt-3">
                                            <label class="control-label">Phường/Xã*</label>
                                            <input id="ward" name="ward" type="text" placeholder="Phường/Xã" class="form-control" required>
                                        </div>
                                        <div class="form-group mt-3">
                                            <label class="control-label">Số nhà và tên đường*</label>
                                            <input id="street" name="street" type="text" placeholder="Số nhà và tên đường" class="form-control" required>
                                        </div>
                                        <div class="form-group mt-3">
                                            <label class="control-label">Ghi chú</label>
                                            <textarea name="notes" class="form-control" placeholder="Ghi chú cho đơn hàng"></textarea>
                                        </div>

                                        <!-- Thời gian giao hàng -->
                                        <div class="form-group mt-3">
                                            <label class="control-label">Ngày giao hàng*</label>
                                            <select name="deliveryDate" class="form-control" required>
                                                <option value="">Chọn ngày</option>
                                                <option value="today">Hôm nay</option>
                                                <option value="tomorrow">Ngày mai</option>
                                                <c:forEach begin="2" end="7" var="i">
                                                    <option value="${i} days"><fmt:formatDate value="${java.time.LocalDate.now().plusDays(i)}" pattern="dd MMM yyyy"/></option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group mt-3">
                                            <label class="control-label">Giờ giao hàng*</label>
                                            <select name="deliveryTime" class="form-control" required>
                                                <option value="">Chọn giờ</option>
                                                <option value="08:00-10:00">8:00 - 10:00</option>
                                                <option value="10:00-12:00">10:00 - 12:00</option>
                                                <option value="12:00-14:00">12:00 - 14:00</option>
                                                <option value="14:00-16:00">14:00 - 16:00</option>
                                                <option value="16:00-18:00">16:00 - 18:00</option>
                                            </select>
                                        </div>

                                        <!-- Phương thức thanh toán -->
                                        <div class="form-group mt-3">
                                            <label class="control-label">Phương thức thanh toán*</label>
                                            <div class="product-radio">
                                                <ul class="product-now payment-method-radio">
                                                    <li>
                                                        <input type="radio" id="cod" name="paymentmethod" value="cod" checked>
                                                        <label for="cod"><img src="${pageContext.request.contextPath}/User/images/cod.png" alt=""></label>
                                                    </li>
                                                    <!--                                                <li>
                                                                                                        <input type="radio" id="vnpay" name="paymentmethod" value="vnpay">
                                                                                                        <label for="vnpay"><img src="${pageContext.request.contextPath}/User/images/icons/vnpay.png" alt=""> VNPay</label>
                                                                                                    </li>-->
                                                    <li>
                                                        <input type="radio" id="payos" name="paymentmethod" value="payos">
                                                        <label for="payos"><img src="${pageContext.request.contextPath}/User/images/payos.png" alt=""></label>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div id="payment-cod" class="payment-description">Thanh toán trực tiếp khi nhận hàng. Không phí thêm.</div>
                                            <div id="payment-vnpay" class="payment-description">Thanh toán qua VNPay. An toàn và nhanh chóng.</div>
                                            <div id="payment-payos" class="payment-description">Thanh toán qua PayOS. Hỗ trợ nhiều ngân hàng.</div>
                                        </div>

                                        <!-- Hidden fields for cart -->
                                        <c:forEach var="item" items="${cartItems}">
                                            <input type="hidden" name="productId" value="${item.productID}"/>
                                            <input type="hidden" name="productName" value="${item.productName}"/>
                                            <input type="hidden" name="unit" value="${item.unit}"/>
                                            <input type="hidden" name="quantity" value="${item.quantity}"/>
                                            <input type="hidden" name="price" value="${item.sellingPrice}"/>
                                        </c:forEach>
                                        <input type="hidden" name="cartTotal" value="${cartTotal}"/>

                                        <button type="button" class="next-btn16 hover-btn mt-4" onclick="showConfirmModal()">Đặt hàng</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="col-lg-4 col-md-5">
                            <div class="pdpt-bg mt-0" id="order-summary">
                                <div class="pdpt-title">
                                    <h4>Tóm tắt đơn hàng</h4>
                                </div>
                                <div class="right-cart-dt-body">
                                    <c:if test="${not empty cartItems}">
                                        <c:forEach var="cartItem" items="${cartItems}">
                                            <div class="cart-item border_radius">
                                                <div class="cart-product-img">
                                                    <img src="${pageContext.request.contextPath}/User/images/product/img-${cartItem.productID}.jpg" alt="${cartItem.productName}">
                                                </div>
                                                <div class="cart-text">
                                                    <h4>${cartItem.productName}</h4>
                                                    <div class="cart-item-price">
                                                        <fmt:formatNumber value="${cartItem.sellingPrice * cartItem.quantity}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                                                    </div>
                                                    <p>Số lượng: ${cartItem.quantity} ${cartItem.unit}</p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty cartItems}">
                                        <div class="text-center p-4">
                                            <p class="text-muted">Không có sản phẩm nào trong giỏ hàng.</p>
                                            <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">Mua sắm ngay</a>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="total-checkout-group">
                                    <div class="cart-total-dil">
                                        <h4>Tổng giỏ hàng</h4>
                                        <span><fmt:formatNumber value="${cartTotal != null ? cartTotal : 0}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                                    </div>
                                    <div class="cart-total-dil pt-3">
                                        <h4>Phí giao hàng</h4>
                                        <span><fmt:formatNumber value="${deliveryCharge != null ? deliveryCharge : 30000}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                                    </div>
                                </div>
                                <div class="cart-total-dil saving-total">
                                    <h4>Tổng tiết kiệm</h4>
                                    <span><fmt:formatNumber value="${totalSaving != null ? totalSaving : 0}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                                </div>
                                <div class="main-total-cart p-4">
                                    <h2>Tổng cộng</h2>
                                    <span id="total-amount"><fmt:formatNumber value="${cartTotal != null ? cartTotal + (deliveryCharge != null ? deliveryCharge : 30000) : 0}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                                </div>
                                <div class="payment-secure">
                                    <i class="uil uil-padlock"></i>Thanh toán an toàn
                                </div>
                            </div>
                            <a href="#" class="promo-link45" data-bs-toggle="modal" data-bs-target="#promoCodeModal">Có mã khuyến mãi?</a>
                            <div class="checkout-safety-alerts">
                                <p><i class="uil uil-sync"></i>Đảm bảo đổi trả 100%</p>
                                <p><i class="uil uil-check-square"></i>Sản phẩm chính hãng 100%</p>
                                <p><i class="uil uil-shield-check"></i>Thanh toán an toàn</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Promo Code Modal -->
            <div class="modal fade" id="promoCodeModal" tabindex="-1" aria-labelledby="promoCodeModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="promoCodeModalLabel">Áp dụng mã khuyến mãi</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="promoCodeInput">Mã khuyến mãi</label>
                                <input type="text" class="form-control" id="promoCodeInput" placeholder="Nhập mã khuyến mãi">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="button" class="btn btn-primary" onclick="applyPromoCode()">Áp dụng</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Confirm Payment Modal -->
            <div class="modal fade" id="confirmPaymentModal" tabindex="-1" aria-labelledby="confirmPaymentModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmPaymentModalLabel">Xác nhận thanh toán</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h5>Chi tiết đơn hàng</h5>
                            <div id="confirm-order-summary"></div> <!-- Sao chép từ order-summary -->
                            <hr>
                            <p><strong>Phương thức thanh toán:</strong> <span id="confirm-payment-method"></span></p>
                            <p><strong>Tổng cộng:</strong> <span id="confirm-total-amount"></span></p>
                            <p>Bạn chắc chắn muốn đặt hàng?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="button" class="btn btn-primary" onclick="submitCheckoutForm()">Xác nhận và thanh toán</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Body End -->
            <!-- Footer Start -->
            <jsp:include page="footer.jsp"></jsp:include>
                <!-- Footer End -->

                <!-- Javascripts -->
                <script src="${pageContext.request.contextPath}/User/js/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/User/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/User/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
            <script src="${pageContext.request.contextPath}/User/vendor/OwlCarousel/owl.carousel.js"></script>
            <script src="${pageContext.request.contextPath}/User/js/custom.js"></script>
            <script src="${pageContext.request.contextPath}/User/js/product.thumbnail.slider.js"></script>
            <script src="${pageContext.request.contextPath}/User/js/offset_overlay.js"></script>
            <script src="${pageContext.request.contextPath}/User/js/night-mode.js"></script>
            <script>
                                // Format price as VND
                                function formatVND(price) {
                                    return price.toLocaleString('vi-VN', {
                                        style: 'decimal',
                                        minimumFractionDigits: 0,
                                        maximumFractionDigits: 0
                                    }) + ' ₫';
                                }

                                // Show Notification
                                function showNotification(message, type) {
                                    const existingNotifications = document.querySelectorAll('.toast-notification');
                                    existingNotifications.forEach(notif => notif.remove());

                                    const notification = document.createElement('div');
                                    const alertType = type === 'success' ? 'success' : type === 'info' ? 'info' : 'danger';
                                    notification.className = 'alert alert-' + alertType + ' alert-dismissible fade show toast-notification';
                                    notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);';

                                    const icon = type === 'success' ? 'check-circle' : type === 'info' ? 'info-circle' : 'exclamation-circle';
                                    notification.innerHTML =
                                            '<i class="fas fa-' + icon + ' me-2"></i>' +
                                            message +
                                            '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';

                                    document.body.appendChild(notification);

                                    setTimeout(function () {
                                        if (notification.parentNode) {
                                            notification.remove();
                                        }
                                    }, 3000);
                                }

                                // Update Cart
                                function updateCart(cartId, quantity) {
                                    if (quantity < 1) {
                                        removeFromCart(cartId);
                                        return;
                                    }
                                    $.ajax({
                                        url: '${pageContext.request.contextPath}/cart',
                                        type: 'POST',
                                        data: {
                                            action: 'update',
                                            cartId: cartId,
                                            quantity: quantity
                                        },
                                        success: function (response) {
                                            showNotification('Cập nhật giỏ hàng thành công!', 'success');
                                            location.reload();
                                        },
                                        error: function (xhr) {
                                            showNotification('Lỗi khi cập nhật giỏ hàng: ' + xhr.responseText, 'error');
                                        }
                                    });
                                }

                                // Remove from Cart
                                function removeFromCart(cartId) {
                                    $.ajax({
                                        url: '${pageContext.request.contextPath}/cart',
                                        type: 'POST',
                                        data: {
                                            action: 'remove',
                                            cartId: cartId
                                        },
                                        success: function (response) {
                                            showNotification('Xóa sản phẩm khỏi giỏ hàng!', 'success');
                                            location.reload();
                                        },
                                        error: function (xhr) {
                                            showNotification('Lỗi khi xóa sản phẩm: ' + xhr.responseText, 'error');
                                        }
                                    });
                                }

                                // Apply Promo Code
                                function applyPromoCode() {
                                    const promoCode = document.getElementById('promoCodeInput').value;
                                    if (!promoCode) {
                                        showNotification('Vui lòng nhập mã khuyến mãi!', 'error');
                                        return;
                                    }
                                    $.ajax({
                                        url: '${pageContext.request.contextPath}/cart',
                                        type: 'POST',
                                        data: {
                                            action: 'applyPromo',
                                            promoCode: promoCode
                                        },
                                        success: function (response) {
                                            showNotification('Áp dụng mã khuyến mãi thành công!', 'success');
                                            $('#promoCodeModal').modal('hide');
                                            location.reload();
                                        },
                                        error: function (xhr) {
                                            showNotification('Lỗi khi áp dụng mã khuyến mãi: ' + xhr.responseText, 'error');
                                        }
                                    });
                                }

                                // Show Confirm Modal
                                function showConfirmModal() {
                                    // Sao chép tóm tắt đơn hàng vào modal
                                    const summary = document.getElementById('order-summary').innerHTML;
                                    document.getElementById('confirm-order-summary').innerHTML = summary;

                                    // Lấy phương thức thanh toán đã chọn
                                    const selectedPayment = document.querySelector('input[name="paymentmethod"]:checked').nextElementSibling.textContent;
                                    document.getElementById('confirm-payment-method').textContent = selectedPayment;

                                    // Lấy tổng giá
                                    const totalAmount = document.getElementById('total-amount').textContent;
                                    document.getElementById('confirm-total-amount').textContent = totalAmount;

                                    // Hiện modal
                                    $('#confirmPaymentModal').modal('show');
                                }

                                // Submit Form sau xác nhận
                                function submitCheckoutForm() {
                                    document.getElementById('checkoutForm').submit();
                                }

                                // Toggle Payment Method Description
                                $(document).ready(function () {
                                    $('input[name="paymentmethod"]').on('change', function () {
                                        const method = $(this).val();
                                        $('.payment-description').hide();
                                        $('#payment-' + method).show();
                                    });
                                    // Mặc định hiển thị cho COD
                                    $('#payment-cod').show();
                                });
            </script>
    </body>
</html>