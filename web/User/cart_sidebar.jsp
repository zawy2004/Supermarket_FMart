
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
                <span>$<fmt:formatNumber value="${cartTotal != null ? cartTotal : 0}" maxFractionDigits="2"/></span>
            </div>
            <div class="cart-total-dil pt-2">
                <h4>Delivery Charges</h4>
                <span>$<fmt:formatNumber value="${deliveryCharge != null ? deliveryCharge : 1}" maxFractionDigits="2"/></span>
            </div>
        </div>
        <div class="side-cart-items">
            <c:forEach var="cartItem" items="${cartItems}">
                <div class="cart-item">
                    <div class="cart-product-img">
                        <img src="User/images/product/img-${cartItem.productID}.jpg" alt="${cartItem.productName}">
                        <c:if test="${cartItem.costPrice > 0 && cartItem.sellingPrice < cartItem.costPrice}">
                            <c:set var="discount" value="${((cartItem.costPrice - cartItem.sellingPrice) / cartItem.costPrice) * 100}"/>
                            <div class="offer-badge"><fmt:formatNumber value="${discount}" maxFractionDigits="0"/>% OFF</div>
                        </c:if>
                    </div>
                    <div class="cart-text">
                        <h4>${cartItem.productName}</h4>
                        <div class="qty-group">
                            <div class="quantity buttons_added">
                                <input type="button" value="-" class="minus minus-btn" onclick="updateCart(${cartItem.cartID}, ${cartItem.quantity - 1})">
                                <input type="number" step="1" name="quantity" value="${cartItem.quantity}" class="input-text qty text" min="1">
                                <input type="button" value="+" class="plus plus-btn" onclick="updateCart(${cartItem.cartID}, ${cartItem.quantity + 1})">
                            </div>
                            <div class="cart-item-price">
                                $<fmt:formatNumber value="${cartItem.sellingPrice * cartItem.quantity}" maxFractionDigits="2"/>
                                <c:if test="${cartItem.costPrice > 0 && cartItem.sellingPrice < cartItem.costPrice}">
                                    <span>$<fmt:formatNumber value="${cartItem.costPrice * cartItem.quantity}" maxFractionDigits="2"/></span>
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
    </div>
    <div class="offcanvas-footer">
        <div class="cart-total-dil saving-total">
            <h4>Total Saving</h4>
            <span>$<fmt:formatNumber value="${totalSaving != null ? totalSaving : 0}" maxFractionDigits="2"/></span>
        </div>
        <div class="main-total-cart">
            <h2>Total</h2>
            <span>$<fmt:formatNumber value="${cartTotal != null ? cartTotal + (deliveryCharge != null ? deliveryCharge : 1) : 0}" maxFractionDigits="2"/></span>
        </div>
        <div class="checkout-cart">
            <a href="#" class="promo-code" data-bs-toggle="modal" data-bs-target="#promoCodeModal">Have a promocode?</a>
            <a href="checkout" class="cart-checkout-btn hover-btn">Proceed to Checkout</a>
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

<script>
    function updateCart(cartId, quantity) {
        if (quantity < 1) {
            removeFromCart(cartId);
            return;
        }
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
                location.reload(); // Tải lại trang để cập nhật giỏ hàng
            },
            error: function(xhr) {
                showNotification('Error updating cart: ' + xhr.responseText, 'error');
            }
        });
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
                location.reload(); // Tải lại trang để cập nhật giỏ hàng
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
</script>
