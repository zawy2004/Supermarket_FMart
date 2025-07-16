<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header bs-canvas-header side-cart-header p-3">
        <div class="d-inline-block main-cart-title" id="offcanvasRightLabel">
            My Cart <span>(<c:out value="${cartItems != null ? cartItems.size() : 0}"/> Items)</span>
        </div>
        <button type="button" class="close-btn" data-bs-dismiss="offcanvas" aria-label="Close">
            <i class="uil uil-multiply"></i>
        </button>
    </div>
    <div class="offcanvas-body p-0">
        <div class="cart-top-total p-4">
            <div class="cart-total-dil">
                <h4>FMart Super Market</h4>
                <span id="selected-total"><fmt:formatNumber value="0" pattern="#,##0"/>₫</span>
            </div>
            <div class="cart-total-dil pt-2">
                <h4>Delivery Charges</h4>
                <span id="delivery-charge"><fmt:formatNumber value="${deliveryCharge != null ? deliveryCharge : 30000}" pattern="#,##0"/>₫</span>
            </div>
        </div>
        <div class="side-cart-items">
            <c:forEach var="cartItem" items="${cartItems}" varStatus="loop">
                <div class="cart-item">
                    <div class="cart-product-img">
                        <img src="User/images/product/img-${cartItem.productID}.jpg" alt="${cartItem.productName}">
                        <c:if test="${cartItem.costPrice > 0 && cartItem.sellingPrice < cartItem.costPrice}">
                            <c:set var="discount" value="${((cartItem.costPrice - cartItem.sellingPrice) / cartItem.costPrice) * 100}"/>
                            <div class="offer-badge"><fmt:formatNumber value="${discount}" maxFractionDigits="0"/>% OFF</div>
                        </c:if>
                    </div>
                    <div class="cart-text">
                        <div class="form-check">
                            <input class="form-check-input item-checkbox" type="checkbox" id="item-${cartItem.cartID}" data-price="${cartItem.sellingPrice * cartItem.quantity}" onchange="updateTotal()">
                            <label class="form-check-label" for="item-${cartItem.cartID}">${cartItem.productName}</label>
                        </div>
                        <div class="qty-group">
                            <div class="quantity buttons_added">
                                <input type="button" value="-" class="minus minus-btn" onclick="updateCart(${cartItem.cartID}, ${cartItem.quantity - 1})">
                                <input type="number" step="1" name="quantity" value="${cartItem.quantity}" class="input-text qty text" min="1" onchange="updatePrice(${cartItem.cartID}, this.value)">
                                <input type="button" value="+" class="plus plus-btn" onclick="updateCart(${cartItem.cartID}, ${cartItem.quantity + 1})">
                            </div>
                            <div class="cart-item-price">
                                <fmt:formatNumber value="${cartItem.sellingPrice * cartItem.quantity}" pattern="#,##0"/>₫
                                <c:if test="${cartItem.costPrice > 0 && cartItem.sellingPrice < cartItem.costPrice}">
                                    <span><fmt:formatNumber value="${cartItem.costPrice * cartItem.quantity}" pattern="#,##0"/>₫</span>
                                </c:if>
                            </div>
                        </div>
                        <button type="button" class="cart-close-btn" onclick="removeFromCart(${cartItem.cartID})">
                            <i class="uil uil-multiply"></i>
                        </button>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty cartItems}">
                <div class="text-center p-4">
                    <p class="text-muted">Your cart is empty</p>
                    <a href="shop" class="btn btn-primary">Shop Now</a>
                </div>
            </c:if>
        </div>
        <div class="offcanvas-footer">
            <div class="all-button-container d-flex justify-content-start p-3">
                <button class="btn btn-custom-all btn-sm" onclick="selectAllItems()">
                    <i class="fas fa-check-double me-2"></i>All
                </button>
            </div>
            <div class="cart-total-dil saving-total">
                <h4>Total Saving</h4>
                <span id="selected-saving"><fmt:formatNumber value="0" pattern="#,##0"/>₫</span>
            </div>
            <div class="main-total-cart">
                <h2>Total</h2>
                <span id="grand-total"><fmt:formatNumber value="0" pattern="#,##0"/>₫</span>
            </div>
            <div class="checkout-cart">
                <a href="#" class="promo-code" data-bs-toggle="modal" data-bs-target="#promoCodeModal">Have a promocode?</a>
                <a href="checkout" class="cart-checkout-btn hover-btn">Proceed to Checkout</a>
            </div>
        </div>
    </div>
</div>

<!-- Promo Code Modal -->
<div class="modal fade" id="promoCodeModal" tabindex="-1" aria-labelledby="promoCodeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="promoCodeModalLabel">Apply Promo Code</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="promoCodeForm">
                    <div class="mb-3">
                        <label for="promoCodeInput" class="form-label">Promo Code</label>
                        <input type="text" class="form-control" id="promoCodeInput" placeholder="Enter promo code">
                    </div>
                    <button type="button" class="btn btn-primary w-100" onclick="applyPromoCode()">Apply</button>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    /* CSS tùy chỉnh cho nút "All" */
    .btn-custom-all {
        background-color: #FF5722; /* Màu cam tươi đẹp */
        border-color: #FF5722;
        color: #ffffff;
        font-weight: 600;
        padding: 8px 20px;
        border-radius: 20px; /* Bo góc tròn mềm mại */
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(255, 87, 34, 0.3); /* Hiệu ứng bóng cam */
    }

    .btn-custom-all:hover {
        background-color: #E64A19; /* Màu cam đậm hơn khi hover */
        border-color: #E64A19;
        color: #ffffff;
        transform: translateY(-2px); /* Nâng nút lên khi hover */
        box-shadow: 0 6px 15px rgba(255, 87, 34, 0.4);
    }

    .btn-custom-all:active {
        transform: translateY(0); /* Quay về vị trí ban đầu khi click */
        box-shadow: 0 2px 6px rgba(255, 87, 34, 0.2);
    }

    .all-button-container {
        padding: 10px 20px; /* Tăng khoảng cách cho cân đối */
    }
</style>

<script>
    function formatVND(number) {
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND', minimumFractionDigits: 0 }).format(number);
    }

    function updatePrice(cartId, quantity) {
        $.ajax({
            url: 'cart',
            type: 'POST',
            data: {
                action: 'update',
                cartId: cartId,
                quantity: quantity
            },
            success: function(response) {
                showNotification('Cart updated successfully!', 'success');
                location.reload();
            },
            error: function(xhr) {
                showNotification('Error updating cart: ' + xhr.responseText, 'error');
            }
        });
    }

    function updateCart(cartId, quantity) {
        if (quantity < 1) {
            removeFromCart(cartId);
            return;
        }
        updatePrice(cartId, quantity);
    }

    function removeFromCart(cartId) {
        $.ajax({
            url: 'cart',
            type: 'POST',
            data: {
                action: 'remove',
                cartId: cartId
            },
            success: function(response) {
                showNotification('Item removed from cart!', 'success');
                location.reload();
            },
            error: function(xhr) {
                showNotification('Error removing item: ' + xhr.responseText, 'error');
            }
        });
    }

    function applyPromoCode() {
        const promoCode = document.getElementById('promoCodeInput').value;
        $.ajax({
            url: 'cart',
            type: 'POST',
            data: {
                action: 'applyPromo',
                promoCode: promoCode
            },
            success: function(response) {
                showNotification('Promo code applied successfully!', 'success');
                $('#promoCodeModal').modal('hide');
                location.reload();
            },
            error: function(xhr) {
                showNotification('Error applying promo code: ' + xhr.responseText, 'error');
            }
        });
    }

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

        setTimeout(function() {
            if (notification.parentNode) {
                notification.remove();
            }
        }, 3000);
    }

    function updateTotal() {
        let total = 0;
        let saving = 0;
        const checkboxes = document.querySelectorAll('.item-checkbox:checked');
        
        checkboxes.forEach(checkbox => {
            const price = parseFloat(checkbox.getAttribute('data-price'));
            total += price;
            const costPrice = price * 1.2; // Giả định costPrice cao hơn sellingPrice 20%
            saving += (costPrice - price);
        });

        const deliveryChargeText = document.getElementById('delivery-charge').textContent.replace(/[^0-9]/g, '');
        const deliveryCharge = parseFloat(deliveryChargeText);
        const grandTotal = total + deliveryCharge;

        document.getElementById('selected-total').textContent = formatVND(total);
        document.getElementById('selected-saving').textContent = formatVND(saving);
        document.getElementById('grand-total').textContent = formatVND(grandTotal);
    }

    function selectAllItems() {
        const checkboxes = document.querySelectorAll('.item-checkbox');
        checkboxes.forEach(checkbox => {
            checkbox.checked = true;
        });
        updateTotal();
    }

    document.addEventListener('DOMContentLoaded', function() {
        updateTotal();
    });
</script>