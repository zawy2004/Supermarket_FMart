<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN" />



<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header bs-canvas-header side-cart-header p-3">
        <div class="d-inline-block main-cart-title" id="offcanvasRightLabel">
            My Cart <span id="cart-item-count">(<c:out value="${cartItems != null ? cartItems.size() : 0}"/> Items)</span>
        </div>
        <button type="button" class="close-btn" data-bs-dismiss="offcanvas" aria-label="Close">
            <i class="uil uil-multiply"></i>
        </button>
    </div>
    <div class="offcanvas-body p-0">
        <!-- Cart Summary Section -->
        <div class="cart-top-total p-4">
            <div class="cart-total-dil">
                <h4>Subtotal (Selected Items)</h4>
                <span id="selected-total">0 ₫</span>
            </div>
            <div class="cart-total-dil pt-2">
                <h4>Delivery Charges 
                    <small class="text-muted d-block">Free shipping over 500,000₫</small>
                </h4>
                <span id="delivery-charge">0 ₫</span>
            </div>
            <div class="cart-total-dil pt-2" id="promo-discount-section" style="display: none;">
                <h4>Promo Discount 
                    <span id="promo-code-display" class="badge bg-success ms-2"></span>
                    <button type="button" class="btn btn-sm btn-outline-danger ms-2" onclick="removePromoCode()">
                        <i class="fas fa-times"></i>
                    </button>
                </h4>
                <span id="promo-discount-amount" class="text-success">-0 ₫</span>
            </div>
        </div>
        
        <!-- Cart Items Section -->
        <div class="side-cart-items">
            <c:choose>
                <c:when test="${not empty cartItems}">
                    <c:forEach var="cartItem" items="${cartItems}" varStatus="loop">
                        <div class="cart-item" data-cart-id="${cartItem.cartID}">
                            <div class="cart-product-img">
                                <img src="User/images/product/img-${cartItem.productID}.jpg" 
                                     alt="${cartItem.productName}" 
                                     onerror="this.src='User/images/product/default.jpg'">
                                <c:if test="${cartItem.costPrice > 0 && cartItem.sellingPrice < cartItem.costPrice}">
                                    <c:set var="discount" value="${((cartItem.costPrice - cartItem.sellingPrice) / cartItem.costPrice) * 100}"/>
                                    <div class="offer-badge"><fmt:formatNumber value="${discount}" maxFractionDigits="0"/>% OFF</div>
                                </c:if>
                            </div>
                            <div class="cart-text">
                                <div class="form-check">
                                    <input class="form-check-input item-checkbox" 
                                           type="checkbox" 
                                           id="item-${cartItem.cartID}" 
                                           data-cart-id="${cartItem.cartID}"
                                           data-selling-price="${cartItem.sellingPrice}" 
                                           data-cost-price="${cartItem.costPrice > 0 ? cartItem.costPrice : cartItem.sellingPrice}"
                                           data-current-quantity="${cartItem.quantity}"
                                           onchange="updateCartTotals()">
                                    <label class="form-check-label" for="item-${cartItem.cartID}">
                                        ${cartItem.productName}
                                        <small class="text-muted d-block">${cartItem.unit}</small>
                                    </label>
                                </div>
                                <div class="qty-group">
                                    <div class="quantity buttons_added">
                                        <button type="button" class="minus minus-btn" 
                                                data-cart-id="${cartItem.cartID}"
                                                onclick="decreaseQuantity(${cartItem.cartID})"
                                                ${cartItem.quantity <= 1 ? 'disabled' : ''}>-</button>
                                        <input type="number" 
                                               class="input-text qty text qty-input" 
                                               value="${cartItem.quantity}" 
                                               min="1" max="999"
                                               data-cart-id="${cartItem.cartID}"
                                               id="qty-${cartItem.cartID}"
                                               onchange="handleQuantityChange(${cartItem.cartID}, this.value)"
                                               onblur="handleQuantityChange(${cartItem.cartID}, this.value)"
                                               onkeypress="handleQuantityKeyPress(event, ${cartItem.cartID})">
                                        <button type="button" class="plus plus-btn" 
                                                data-cart-id="${cartItem.cartID}"
                                                onclick="increaseQuantity(${cartItem.cartID})">+</button>
                                    </div>
                                    <div class="cart-item-price">
                                        <span class="current-price" data-cart-id="${cartItem.cartID}">
                                            <fmt:formatNumber value="${cartItem.sellingPrice * cartItem.quantity}" 
                                                            type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                                        </span>
                                        <c:if test="${cartItem.costPrice > 0 && cartItem.sellingPrice < cartItem.costPrice}">
                                            <span class="original-price" data-cart-id="${cartItem.cartID}">
                                                <fmt:formatNumber value="${cartItem.costPrice * cartItem.quantity}" 
                                                                type="number" groupingUsed="true" maxFractionDigits="0"/> ₫
                                            </span>
                                        </c:if>
                                    </div>
                                </div>
                                <button type="button" class="cart-close-btn" onclick="removeFromCart(${cartItem.cartID})">
                                    <i class="uil uil-multiply"></i>
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center p-4" id="empty-cart-message">
                        <i class="uil uil-shopping-cart-alt" style="font-size: 48px; color: #ddd;"></i>
                        <p class="text-muted mt-2">Your cart is empty</p>
                        <a href="shop" class="btn btn-primary">Shop Now</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Cart Footer -->
        <c:if test="${not empty cartItems}">
            <div class="offcanvas-footer">
                <div class="all-button-container d-flex justify-content-between p-3">
                    <button class="btn btn-custom-all btn-sm" onclick="selectAllItems()">
                        <i class="fas fa-check-double me-2"></i>Select All
                    </button>
                    <button class="btn btn-outline-secondary btn-sm" onclick="clearAllSelections()">
                        <i class="fas fa-times me-2"></i>Clear
                    </button>
                </div>
                
                <div class="cart-total-dil saving-total">
                    <h4><i class="fas fa-piggy-bank me-2"></i>Total Saving</h4>
                    <span id="total-savings" class="text-success">0 ₫</span>
                </div>
                
                <div class="main-total-cart">
                    <h2><i class="fas fa-calculator me-2"></i>Grand Total</h2>
                    <span id="grand-total" class="text-primary">0 ₫</span>
                </div>
                
                <div class="checkout-cart">
                    <a href="#" class="promo-code" data-bs-toggle="modal" data-bs-target="#promoCodeModal">
                        <i class="fas fa-tags me-1"></i>Have a promocode?
                    </a>
                    <button class="cart-checkout-btn hover-btn" id="checkout-btn" onclick="proceedToCheckout()" disabled>
                        <i class="fas fa-credit-card me-2"></i>Proceed to Checkout
                    </button>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- Promo Code Modal -->
<div class="modal fade" id="promoCodeModal" tabindex="-1" aria-labelledby="promoCodeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="promoCodeModalLabel">
                    <i class="fas fa-tags me-2 text-primary"></i>Apply Promo Code
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="available-promos mb-4">
                    <h6 class="text-muted mb-3">Available Offers:</h6>
                    <div class="promo-suggestions">
                        <div class="promo-card" onclick="usePromoCode('SAVE10')">
                            <div class="promo-info">
                                <strong>SAVE10</strong>
                                <span class="promo-desc">10% off entire order</span>
                            </div>
                            <div class="promo-value">10% OFF</div>
                        </div>
                        <div class="promo-card" onclick="usePromoCode('WELCOME20')">
                            <div class="promo-info">
                                <strong>WELCOME20</strong>
                                <span class="promo-desc">20% off (max 100,000₫)</span>
                            </div>
                            <div class="promo-value">20% OFF</div>
                        </div>
                        <div class="promo-card" onclick="usePromoCode('FMART50')">
                            <div class="promo-info">
                                <strong>FMART50</strong>
                                <span class="promo-desc">50% off (max 100,000₫)</span>
                            </div>
                            <div class="promo-value">50% OFF</div>
                        </div>
                    </div>
                </div>
                
                <div class="manual-promo">
                    <label for="promoCodeInput" class="form-label">Enter Promo Code Manually</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="promoCodeInput" 
                               placeholder="Enter code (e.g., SAVE10)" 
                               style="text-transform: uppercase;"
                               onkeypress="handlePromoKeyPress(event)">
                        <button type="button" class="btn btn-outline-secondary" onclick="clearPromoInput()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="d-grid mt-3">
                        <button type="button" class="btn btn-primary" onclick="applyPromoCode()">
                            <i class="fas fa-check me-2"></i>Apply Code
                        </button>
                    </div>
                </div>
                
                <div id="promo-result" class="mt-3" style="display: none;"></div>
            </div>
        </div>
    </div>
</div>

<style>
    /* Button Styles */
    .btn-custom-all {
        background: linear-gradient(135deg, #FF5722, #E64A19);
        border: none;
        color: #ffffff;
        font-weight: 600;
        padding: 8px 20px;
        border-radius: 20px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(255, 87, 34, 0.3);
    }
    
    .btn-custom-all:hover {
        background: linear-gradient(135deg, #E64A19, #D84315);
        color: #ffffff;
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(255, 87, 34, 0.4);
    }
    
    /* Cart Styles */
    .offcanvas.offcanvas-end {
        width: 520px !important;
    }
    
    .cart-item {
        border-bottom: 1px solid #f0f0f0;
        padding: 15px;
        transition: all 0.3s ease;
        position: relative;
    }
    
    .cart-item:hover {
        background-color: #fafafa;
        transform: translateX(-2px);
    }
    
    .cart-item:last-child {
        border-bottom: none;
    }
    
    /* Quantity Controls */
    .quantity.buttons_added {
        display: flex;
        align-items: center;
        border: 2px solid #e9ecef;
        border-radius: 8px;
        overflow: hidden;
        background: white;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        max-width: 130px;
    }
    
    .quantity.buttons_added button {
        background: #f8f9fa;
        border: none;
        width: 35px;
        height: 35px;
        cursor: pointer;
        font-weight: bold;
        font-size: 16px;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }
    
    .quantity.buttons_added button:hover:not(:disabled) {
        background: #007bff;
        color: white;
        transform: scale(1.05);
    }
    
    .quantity.buttons_added button:active:not(:disabled) {
        background: #0056b3;
        transform: scale(0.95);
    }
    
    .quantity.buttons_added button:disabled {
        background: #e9ecef;
        color: #6c757d;
        cursor: not-allowed;
        transform: none;
        opacity: 0.6;
    }
    
    .qty-input {
        width: 60px;
        text-align: center;
        border: none;
        background: transparent;
        font-weight: 600;
        font-size: 14px;
        padding: 8px 4px;
        flex-shrink: 0;
    }
    
    .qty-input:focus {
        outline: none;
        background: #f8f9fa;
    }
    
    .qty-input:disabled {
        background: #f8f9fa;
        color: #6c757d;
        cursor: not-allowed;
    }
    
    /* Price Styles */
    .current-price {
        text-decoration: none !important;
        font-weight: 600;
        color: #28a745 !important;
        font-size: 15px;
    }
    
    .original-price {
        text-decoration: none !important;
        color: #6c757d;
        font-size: 13px;
        margin-left: 8px;
    }
    
    /* Checkout Button */
    .cart-checkout-btn {
        background: linear-gradient(135deg, #28a745, #20c997);
        color: white;
        border: none;
        padding: 12px 24px;
        border-radius: 8px;
        font-weight: 600;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s;
        width: 100%;
        text-align: center;
        cursor: pointer;
    }
    
    .cart-checkout-btn:hover:not(:disabled) {
        background: linear-gradient(135deg, #218838, #1ea080);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
        color: white;
        text-decoration: none;
    }
    
    .cart-checkout-btn:disabled {
        background: #6c757d;
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
        opacity: 0.6;
    }
    
    /* Promo Code Styles */
    .promo-code {
        color: #007bff;
        text-decoration: none;
        font-size: 14px;
        margin-bottom: 12px;
        display: block;
        text-align: center;
        padding: 8px;
        border: 1px dashed #007bff;
        border-radius: 6px;
        transition: all 0.3s;
        margin-top: 15px;
    }
    
    .promo-code:hover {
        background: #e7f1ff;
        color: #0056b3;
        text-decoration: none;
    }
    
    .promo-card {
        border: 1px solid #e9ecef;
        border-radius: 8px;
        padding: 12px;
        margin-bottom: 10px;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .promo-card:hover {
        border-color: #007bff;
        background: #f8f9fa;
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    
    .promo-info strong {
        color: #495057;
        font-size: 14px;
    }
    
    .promo-desc {
        color: #6c757d;
        font-size: 12px;
        display: block;
    }
    
    .promo-value {
        background: linear-gradient(135deg, #28a745, #20c997);
        color: white;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 600;
    }
    
    /* Summary Styles */
    .saving-total {
        background: linear-gradient(135deg, #e8f5e8, #f0f9f0);
        margin: 15px;
        padding: 15px;
        border-radius: 10px;
        border-left: 4px solid #28a745;
    }
    
    .main-total-cart {
        background: linear-gradient(135deg, #e3f2fd, #f1f8ff);
        margin: 15px;
        padding: 20px;
        border-radius: 10px;
        border-left: 4px solid #2196f3;
        text-align: center;
    }
    
    /* Animations */
    @keyframes slideInRight {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOutRight {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
    
    .toast-notification {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 10000;
        min-width: 300px;
        max-width: 400px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.12);
        border-radius: 8px;
        animation: slideInRight 0.4s ease;
    }
    
    .offer-badge {
        position: absolute;
        top: 5px;
        right: 5px;
        background: linear-gradient(135deg, #ff6b35, #f7931e);
        color: white;
        font-size: 10px;
        padding: 2px 6px;
        border-radius: 10px;
        font-weight: 600;
    }
    
    /* Responsive */
    @media (max-width: 576px) {
        .offcanvas.offcanvas-end {
            width: 100% !important;
        }
        
        .promo-card {
            flex-direction: column;
            text-align: center;
        }
        
        .promo-value {
            margin-top: 8px;
        }
    }
</style>

<script>
    // Global variables for cart management
    let currentPromoCode = '';
    let currentPromoDiscount = 0;
    let currentPromoType = 'percentage';
    let currentPromoMax = 0;
    let isUpdatingQuantity = false;
    
    // Available promo codes with their details
    const availablePromoCodes = {
        'SAVE10': { type: 'percentage', value: 10, max: 0, description: '10% off entire order' },
        'WELCOME20': { type: 'percentage', value: 20, max: 100000, description: '20% off (max 100,000₫)' },
        'FMART50': { type: 'percentage', value: 50, max: 100000, description: '50% off (max 100,000₫)' },
        'FLAT50K': { type: 'fixed', value: 50000, max: 0, description: 'Flat 50,000₫ off' },
        'NEWUSER': { type: 'percentage', value: 15, max: 75000, description: '15% off for new users (max 75,000₫)' },
        'ILOVEFMART': { type: 'percentage', value: 20, max: 0, description: '20% off entire order' }
    };

    // Format Vietnamese currency
    function formatVND(number) {
        return new Intl.NumberFormat('vi-VN', { 
            style: 'decimal', 
            minimumFractionDigits: 0, 
            maximumFractionDigits: 0 
        }).format(Math.round(number)) + ' ₫';
    }

    // Calculate delivery charges based on subtotal and quantity
    function calculateDeliveryCharge(subtotal, totalQuantity) {
        // Free delivery for orders over 500,000 VND
        if (subtotal >= 500000) {
            return 0;
        }
        
        // Base delivery charge: 30,000 VND + 5,000 per item (max 100,000)
        const baseCharge = 30000;
        const perItemCharge = 5000;
        const maxCharge = 100000;
        
        const calculatedCharge = baseCharge + (totalQuantity * perItemCharge);
        return Math.min(calculatedCharge, maxCharge);
    }

    // Calculate promo discount
    function calculatePromoDiscount(subtotal) {
        if (!currentPromoCode || currentPromoDiscount === 0) {
            return 0;
        }
        
        const promo = availablePromoCodes[currentPromoCode];
        if (!promo) return 0;
        
        let discount = 0;
        if (promo.type === 'percentage') {
            discount = subtotal * (promo.value / 100);
            if (promo.max > 0) {
                discount = Math.min(discount, promo.max);
            }
        } else if (promo.type === 'fixed') {
            discount = Math.min(promo.value, subtotal);
        }
        
        return discount;
    }

    // Update all cart totals
    function updateCartTotals() {
        let subtotal = 0;
        let totalSaving = 0;
        let totalQuantity = 0;
        
        const checkboxes = document.querySelectorAll('.item-checkbox:checked');
        
        checkboxes.forEach(checkbox => {
            const sellingPrice = parseFloat(checkbox.getAttribute('data-selling-price')) || 0;
            const costPrice = parseFloat(checkbox.getAttribute('data-cost-price')) || sellingPrice;
            const quantity = parseInt(checkbox.getAttribute('data-current-quantity')) || 0;
            
            const itemSubtotal = sellingPrice * quantity;
            subtotal += itemSubtotal;
            totalQuantity += quantity;
            
            // Calculate savings (difference between cost price and selling price)
            if (costPrice > sellingPrice) {
                totalSaving += (costPrice - sellingPrice) * quantity;
            }
        });

        // Calculate promo discount
        const promoDiscount = calculatePromoDiscount(subtotal);
        const subtotalAfterPromo = subtotal - promoDiscount;
        
        // Calculate delivery charge
        const deliveryCharge = calculateDeliveryCharge(subtotalAfterPromo, totalQuantity);
        
        // Calculate grand total
        const grandTotal = subtotalAfterPromo + deliveryCharge;
        
        // Total savings includes both discount savings and promo discount
        const totalSavingsWithPromo = totalSaving + promoDiscount;

        // Update UI elements
        document.getElementById('selected-total').textContent = formatVND(subtotal);
        document.getElementById('delivery-charge').textContent = formatVND(deliveryCharge);
        document.getElementById('total-savings').textContent = formatVND(totalSavingsWithPromo);
        document.getElementById('grand-total').textContent = formatVND(grandTotal);
        
        // Show/hide promo discount section
        const promoSection = document.getElementById('promo-discount-section');
        if (promoDiscount > 0) {
            promoSection.style.display = 'block';
            document.getElementById('promo-discount-amount').textContent = '-' + formatVND(promoDiscount);
            document.getElementById('promo-code-display').textContent = currentPromoCode;
        } else {
            promoSection.style.display = 'none';
        }
        
        // Enable/disable checkout button
        const checkoutBtn = document.getElementById('checkout-btn');
        if (checkboxes.length > 0 && grandTotal > 0) {
            checkoutBtn.disabled = false;
            checkoutBtn.style.opacity = '1';
        } else {
            checkoutBtn.disabled = true;
            checkoutBtn.style.opacity = '0.6';
        }
    }

    // Increase quantity
    function increaseQuantity(cartId) {
    console.log('Increasing quantity for cart ID:', cartId);
    
    if (isUpdatingQuantity) {
        console.log('Already updating, skipping...');
        return;
    }
    
    const qtyInput = document.getElementById('qty-' + cartId);
    const checkbox = document.querySelector(`input[data-cart-id="${cartId}"].item-checkbox`);
    
    if (!qtyInput || !checkbox) {
        console.error('Elements not found for cart ID:', cartId);
        return;
    }
    
    let currentQuantity = parseInt(qtyInput.value) || 1;
    let newQuantity = currentQuantity + 1;
    
    if (newQuantity > 999) {
        showNotification('Maximum quantity is 999', 'warning');
        return;
    }
    
    // Visual feedback
    qtyInput.style.transform = 'scale(1.05)';
    setTimeout(() => {
        qtyInput.style.transform = 'scale(1)';
    }, 150);
    
    updateQuantity(cartId, newQuantity);
}


    // Decrease quantity
    function decreaseQuantity(cartId) {
    console.log('Decreasing quantity for cart ID:', cartId);
    
    if (isUpdatingQuantity) {
        console.log('Already updating, skipping...');
        return;
    }
    
    const qtyInput = document.getElementById('qty-' + cartId);
    const checkbox = document.querySelector(`input[data-cart-id="${cartId}"].item-checkbox`);
    
    if (!qtyInput || !checkbox) {
        console.error('Elements not found for cart ID:', cartId);
        return;
    }
    
    let currentQuantity = parseInt(qtyInput.value) || 1;
    let newQuantity = currentQuantity - 1;
    
    if (newQuantity < 1) {
        if (confirm('Remove this item from cart?')) {
            removeFromCart(cartId);
        }
        return;
    }
    
    // Visual feedback
    qtyInput.style.transform = 'scale(1.05)';
    setTimeout(() => {
        qtyInput.style.transform = 'scale(1)';
    }, 150);
    
    updateQuantity(cartId, newQuantity);
}

    // Handle quantity change from input field
    function handleQuantityChange(cartId, value) {
        console.log('Handling quantity change for cart ID:', cartId, 'Value:', value);
        
        if (isUpdatingQuantity) {
            console.log('Already updating, skipping...');
            return;
        }
        
        const newQuantity = parseInt(value) || 1;
        const qtyInput = document.getElementById('qty-' + cartId);
        
        if (newQuantity < 1) {
            if (confirm('Remove this item from cart?')) {
                removeFromCart(cartId);
            } else {
                qtyInput.value = 1;
                updateQuantity(cartId, 1);
            }
            return;
        }
        
        if (newQuantity > 999) {
            showNotification('Maximum quantity is 999', 'warning');
            qtyInput.value = 999;
            updateQuantity(cartId, 999);
            return;
        }
        
        if (newQuantity !== parseInt(qtyInput.value)) {
            updateQuantity(cartId, newQuantity);
        }
    }

    // Handle keypress in quantity input
    function handleQuantityKeyPress(event, cartId) {
        // Allow: backspace, delete, tab, escape, enter
        if ([8, 9, 27, 13, 46].indexOf(event.keyCode) !== -1 ||
            // Allow: Ctrl+A, Ctrl+C, Ctrl+V, Ctrl+X
            (event.keyCode === 65 && event.ctrlKey === true) ||
            (event.keyCode === 67 && event.ctrlKey === true) ||
            (event.keyCode === 86 && event.ctrlKey === true) ||
            (event.keyCode === 88 && event.ctrlKey === true)) {
            return;
        }
        
        // Ensure that it is a number and stop the keypress
        if ((event.shiftKey || (event.keyCode < 48 || event.keyCode > 57)) && (event.keyCode < 96 || event.keyCode > 105)) {
            event.preventDefault();
        }
        
        // Handle enter key
        if (event.keyCode === 13) {
            event.preventDefault();
            handleQuantityChange(cartId, event.target.value);
        }
    }

    // Update quantity (common function)
    function updateQuantity(cartId, newQuantity) {
    console.log('Updating quantity for cart ID:', cartId, 'to quantity:', newQuantity);
    
    isUpdatingQuantity = true;
    
    const qtyInput = document.getElementById('qty-' + cartId);
    const checkbox = document.querySelector(`input[data-cart-id="${cartId}"].item-checkbox`);
    const minusBtn = document.querySelector(`button[data-cart-id="${cartId}"].minus-btn`);
    const plusBtn = document.querySelector(`button[data-cart-id="${cartId}"].plus-btn`);
    
    if (!qtyInput || !checkbox) {
        console.error('Required elements not found for cart ID:', cartId);
        isUpdatingQuantity = false;
        return;
    }
    
    // Lưu số lượng cũ để rollback nếu cần
    const oldQuantity = parseInt(qtyInput.value) || 1;
    
    // Disable buttons và add visual feedback
    if (minusBtn) {
        minusBtn.disabled = true;
        minusBtn.style.opacity = '0.5';
    }
    if (plusBtn) {
        plusBtn.disabled = true;
        plusBtn.style.opacity = '0.5';
    }
    qtyInput.disabled = true;
    qtyInput.style.backgroundColor = '#f8f9fa';
    
    // CẬP NHẬT UI NGAY LẬP TỨC
    qtyInput.value = newQuantity;
    checkbox.setAttribute('data-current-quantity', newQuantity);
    
    // Cập nhật giá tiền ngay lập tức
    updateItemPriceDisplay(cartId, newQuantity);
    
    // Cập nhật tổng tiền ngay lập tức
    updateCartTotals();
    
    // Cập nhật trạng thái buttons
    updateButtonStates();
    
    // Gửi request lên server
    updateCartOnServer(cartId, newQuantity, oldQuantity);
}


    // Update item price display
    function updateItemPriceDisplay(cartId, quantity) {
    console.log('Updating item price display for cart ID:', cartId, 'quantity:', quantity);
    
    const checkbox = document.querySelector(`input[data-cart-id="${cartId}"].item-checkbox`);
    if (!checkbox) {
        console.error('Checkbox not found for cart ID:', cartId);
        return;
    }
    
    const sellingPrice = parseFloat(checkbox.getAttribute('data-selling-price')) || 0;
    const costPrice = parseFloat(checkbox.getAttribute('data-cost-price')) || sellingPrice;
    
    const newCurrentTotal = sellingPrice * quantity;
    const newOriginalTotal = costPrice * quantity;
    
    console.log('Calculating new prices:', {
        cartId,
        sellingPrice,
        costPrice,
        quantity,
        newCurrentTotal,
        newOriginalTotal
    });
    
    // TÌM KIẾM ELEMENT GIÁ TIỀN TRONG CART ITEM
    const cartItem = document.querySelector(`.cart-item[data-cart-id="${cartId}"]`);
    if (!cartItem) {
        console.error('Cart item not found for cart ID:', cartId);
        return;
    }
    
    // Tìm và cập nhật giá bán hiện tại
    const currentPriceSpan = cartItem.querySelector('.current-price');
    if (currentPriceSpan) {
        currentPriceSpan.textContent = formatVND(newCurrentTotal);
        console.log('Updated current price to:', formatVND(newCurrentTotal));
    } else {
        console.warn('Current price span not found in cart item');
    }
    
    // Tìm và cập nhật giá gốc (nếu có discount)
    const originalPriceSpan = cartItem.querySelector('.original-price');
    if (originalPriceSpan && costPrice > sellingPrice) {
        originalPriceSpan.textContent = formatVND(newOriginalTotal);
        console.log('Updated original price to:', formatVND(newOriginalTotal));
    }
    
    // Cập nhật tất cả các element có thể chứa giá trong cart item
    const priceElements = cartItem.querySelectorAll('.cart-item-price span');
    priceElements.forEach(element => {
        if (element.classList.contains('current-price')) {
            element.textContent = formatVND(newCurrentTotal);
        } else if (element.classList.contains('original-price') && costPrice > sellingPrice) {
            element.textContent = formatVND(newOriginalTotal);
        }
    });
}



    // Update cart on server
    function updateCartOnServer(cartId, quantity, oldQuantity) {
    console.log('Sending update to server for cart ID:', cartId, 'quantity:', quantity);
    
    $.ajax({
        url: 'cart',
        type: 'POST',
        data: {
            action: 'update',
            cartId: cartId,
            quantity: quantity
        },
        dataType: 'json',
        timeout: 10000,
        success: function(response) {
            console.log('Server response:', response);
            
            if (response.success) {
                console.log('Cart updated successfully on server');
                showNotification('Cart updated successfully!', 'success');
                
                // Nếu server trả về quantity khác, cập nhật lại
                if (response.newQuantity && response.newQuantity !== quantity) {
                    updateQuantityFromServer(cartId, response.newQuantity);
                }
            } else {
                console.error('Server returned error:', response.error);
                showNotification('Error: ' + (response.error || 'Unknown error'), 'error');
                // Rollback về quantity cũ
                rollbackQuantity(cartId, oldQuantity);
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX error:', status, error);
            
            let errorMessage = 'Error updating cart';
            if (xhr.status === 401) {
                errorMessage = 'Please log in again';
            } else if (xhr.status === 403) {
                errorMessage = 'Access denied';
            } else if (xhr.status === 0) {
                errorMessage = 'Network error';
            }
            
            showNotification(errorMessage, 'error');
            
            // Rollback về quantity cũ
            rollbackQuantity(cartId, oldQuantity);
        },
        complete: function() {
            // Re-enable controls
            enableQuantityControls(cartId, quantity);
            isUpdatingQuantity = false;
        }
    });
}

function updateQuantityFromServer(cartId, serverQuantity) {
    const qtyInput = document.getElementById('qty-' + cartId);
    const checkbox = document.querySelector(`input[data-cart-id="${cartId}"].item-checkbox`);
    
    if (qtyInput && checkbox) {
        qtyInput.value = serverQuantity;
        checkbox.setAttribute('data-current-quantity', serverQuantity);
        updateItemPriceDisplay(cartId, serverQuantity);
        updateCartTotals();
        updateButtonStates();
    }
}

function rollbackQuantity(cartId, oldQuantity) {
    console.log('Rolling back quantity for cart ID:', cartId, 'to:', oldQuantity);
    
    const qtyInput = document.getElementById('qty-' + cartId);
    const checkbox = document.querySelector(`input[data-cart-id="${cartId}"].item-checkbox`);
    
    if (qtyInput && checkbox) {
        qtyInput.value = oldQuantity;
        checkbox.setAttribute('data-current-quantity', oldQuantity);
        
        // Cập nhật lại giá tiền
        updateItemPriceDisplay(cartId, oldQuantity);
        
        // Cập nhật lại tổng tiền
        updateCartTotals();
        
        // Cập nhật trạng thái buttons
        updateButtonStates();
    }
}

    // Enable quantity controls
    function enableQuantityControls(cartId, quantity) {
    const qtyInput = document.getElementById('qty-' + cartId);
    const minusBtn = document.querySelector(`button[data-cart-id="${cartId}"].minus-btn`);
    const plusBtn = document.querySelector(`button[data-cart-id="${cartId}"].plus-btn`);
    
    if (qtyInput) {
        qtyInput.disabled = false;
        qtyInput.style.backgroundColor = '';
    }
    
    if (plusBtn) {
        plusBtn.disabled = false;
        plusBtn.style.opacity = '1';
    }
    
    if (minusBtn) {
        const currentQty = quantity || parseInt(qtyInput?.value) || 1;
        minusBtn.disabled = currentQty <= 1;
        minusBtn.style.opacity = currentQty <= 1 ? '0.5' : '1';
    }
}


    // Revert quantity on error
    function revertQuantity(cartId) {
        const qtyInput = document.getElementById('qty-' + cartId);
        const checkbox = document.querySelector(`input[data-cart-id="${cartId}"].item-checkbox`);
        
        if (qtyInput && checkbox) {
            const originalQuantity = parseInt(checkbox.getAttribute('data-current-quantity')) || 1;
            qtyInput.value = originalQuantity;
            updateItemPriceDisplay(cartId, originalQuantity);
            updateCartTotals();
        }
    }

    // Remove item from cart
    function removeFromCart(cartId) {
    if (!confirm('Are you sure you want to remove this item from your cart?')) {
        return;
    }
    
    const cartItem = document.querySelector(`.cart-item[data-cart-id="${cartId}"]`);
    if (!cartItem) {
        console.error('Cart item not found for cart ID:', cartId);
        return;
    }
    
    // Visual feedback ngay lập tức
    cartItem.style.opacity = '0.6';
    cartItem.style.pointerEvents = 'none';
    cartItem.style.transform = 'scale(0.98)';
    
    // Thay đổi nút remove thành loading
    const removeBtn = cartItem.querySelector('.cart-close-btn');
    if (removeBtn) {
        removeBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
        removeBtn.disabled = true;
    }
    
    $.ajax({
        url: 'cart',
        type: 'POST',
        data: {
            action: 'remove',
            cartId: cartId
        },
        dataType: 'json',
        success: function(response) {
            console.log('Item removed successfully');
            showNotification('Item removed from cart!', 'success');
            
            // Animation trượt ra ngoài
            cartItem.style.transition = 'all 0.3s ease-out';
            cartItem.style.transform = 'translateX(100%)';
            cartItem.style.opacity = '0';
            
            setTimeout(() => {
                // Xóa item khỏi DOM
                cartItem.remove();
                
                // Cập nhật tổng tiền và số lượng
                updateCartTotals();
                updateCartCount();
                
                // Kiểm tra xem có còn item nào không
                const remainingItems = document.querySelectorAll('.cart-item');
                if (remainingItems.length === 0) {
                    showEmptyCartMessage();
                }
            }, 300);
        },
        error: function(xhr, status, error) {
            console.error('Error removing item:', error);
            showNotification('Error removing item', 'error');
            
            // Khôi phục trạng thái ban đầu
            cartItem.style.opacity = '1';
            cartItem.style.pointerEvents = 'auto';
            cartItem.style.transform = 'scale(1)';
            
            if (removeBtn) {
                removeBtn.innerHTML = '<i class="uil uil-multiply"></i>';
                removeBtn.disabled = false;
            }
        }
    });
}

function showEmptyCartMessage() {
    const sideCartItems = document.querySelector('.side-cart-items');
    const offcanvasFooter = document.querySelector('.offcanvas-footer');
    
    if (sideCartItems) {
        sideCartItems.innerHTML = `
            <div class="text-center p-4" id="empty-cart-message">
                <i class="uil uil-shopping-cart-alt" style="font-size: 48px; color: #ddd;"></i>
                <p class="text-muted mt-2">Your cart is empty</p>
                <a href="shop" class="btn btn-primary">Shop Now</a>
            </div>
        `;
    }
    
    // Ẩn footer khi giỏ hàng trống
    if (offcanvasFooter) {
        offcanvasFooter.style.display = 'none';
    }
    
    // Cập nhật cart count về 0
    updateCartCountDisplay(0);
}

function updateCartCountDisplay(count) {
    // Cập nhật số lượng trong cart sidebar
    const cartCountSpan = document.getElementById('cart-item-count');
    if (cartCountSpan) {
        cartCountSpan.textContent = `(${count} Items)`;
    }
    
    // Cập nhật tất cả cart count trong header
    const headerCartCounts = document.querySelectorAll('.cart-count, .header-cart-count, .cart-badge');
    headerCartCounts.forEach(element => {
        element.textContent = count;
        element.style.display = count === 0 ? 'none' : 'inline-block';
    });
}


    // Select all items
    function selectAllItems() {
        const checkboxes = document.querySelectorAll('.item-checkbox');
        let selectedCount = 0;
        
        checkboxes.forEach(checkbox => {
            if (!checkbox.checked) {
                checkbox.checked = true;
                selectedCount++;
            }
        });
        
        if (selectedCount > 0) {
            showNotification(`Selected ${checkboxes.length} items`, 'success');
        } else {
            showNotification('All items are already selected', 'info');
        }
        
        updateCartTotals();
    }

    // Clear all selections
    function clearAllSelections() {
        const checkboxes = document.querySelectorAll('.item-checkbox:checked');
        
        if (checkboxes.length === 0) {
            showNotification('No items are selected', 'info');
            return;
        }
        
        checkboxes.forEach(checkbox => {
            checkbox.checked = false;
        });
        
        showNotification('All selections cleared', 'info');
        updateCartTotals();
    }

    // Use promo code from suggestions
    function usePromoCode(code) {
        document.getElementById('promoCodeInput').value = code;
        applyPromoCode();
    }

    // Apply promo code
    function applyPromoCode() {
        const promoCodeInput = document.getElementById('promoCodeInput');
        const code = promoCodeInput.value.trim().toUpperCase();
        
        if (!code) {
            showNotification('Please enter a promo code!', 'warning');
            promoCodeInput.focus();
            return;
        }

        // Check if same code is already applied
        if (currentPromoCode === code) {
            showNotification('This promo code is already applied!', 'info');
            $('#promoCodeModal').modal('hide');
            return;
        }

        if (availablePromoCodes[code]) {
            const promo = availablePromoCodes[code];
            
            // Store current promo details
            currentPromoCode = code;
            currentPromoDiscount = promo.value;
            currentPromoType = promo.type;
            currentPromoMax = promo.max;
            
            showNotification(`Promo code ${code} applied successfully! ${promo.description}`, 'success');
            $('#promoCodeModal').modal('hide');
            promoCodeInput.value = '';
            
            // Hide result div
            document.getElementById('promo-result').style.display = 'none';
            
            updateCartTotals();
            
            // Update server session
            $.ajax({
                url: 'cart',
                type: 'POST',
                data: {
                    action: 'applyPromo',
                    promoCode: code
                },
                success: function(response) {
                    console.log('Promo code saved to session');
                },
                error: function(xhr) {
                    console.error('Error saving promo code:', xhr.responseText);
                }
            });
        } else {
            showNotification('Invalid promo code!', 'error');
            
            // Show available codes in modal
            const resultDiv = document.getElementById('promo-result');
            resultDiv.style.display = 'block';
            resultDiv.innerHTML = `
                <div class="alert alert-warning">
                    <strong><i class="fas fa-exclamation-triangle me-2"></i>Invalid Code!</strong>
                    <br><small class="text-muted">Try these available codes: SAVE10, WELCOME20, FMART50, FLAT50K, NEWUSER, ILOVEFMART</small>
                </div>
            `;
        }
    }

    // Remove applied promo code
    function removePromoCode() {
        if (!currentPromoCode) return;
        
        const oldCode = currentPromoCode;
        
        // Clear promo variables
        currentPromoCode = '';
        currentPromoDiscount = 0;
        currentPromoType = 'percentage';
        currentPromoMax = 0;
        
        showNotification(`Promo code ${oldCode} removed`, 'info');
        updateCartTotals();
        
        // Clear from server session
        $.ajax({
            url: 'cart',
            type: 'POST',
            data: {
                action: 'clearPromo'
            },
            success: function(response) {
                console.log('Promo code cleared from session');
            }
        });
    }

    // Clear promo input
    function clearPromoInput() {
        document.getElementById('promoCodeInput').value = '';
        document.getElementById('promo-result').style.display = 'none';
    }

    // Handle enter key press in promo input
    function handlePromoKeyPress(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
            applyPromoCode();
        }
    }

    // Proceed to checkout
    function proceedToCheckout() {
        const selectedItems = document.querySelectorAll('.item-checkbox:checked');
        
        if (selectedItems.length === 0) {
            showNotification('Please select items to checkout', 'warning');
            return;
        }
        
        // Get selected item details for checkout
        const selectedItemIds = Array.from(selectedItems).map(cb => cb.getAttribute('data-cart-id'));
        
        showNotification('Redirecting to checkout...', 'info');
        
        // Add selected items to session or URL parameter
        const params = new URLSearchParams();
        params.append('selectedItems', selectedItemIds.join(','));
        
        setTimeout(() => {
            window.location.href = 'checkout?' + params.toString();
        }, 500);
    }

    // Update cart count in header
    function updateCartCount() {
    const cartItems = document.querySelectorAll('.cart-item');
    const count = cartItems.length;
    updateCartCountDisplay(count);
}

    // Show notification with improved styling
    function showNotification(message, type = 'info') {
        // Remove existing notifications
        const existingNotifications = document.querySelectorAll('.toast-notification');
        existingNotifications.forEach(notif => notif.remove());

        const notification = document.createElement('div');
        const alertType = type === 'success' ? 'success' : 
                         type === 'info' ? 'info' : 
                         type === 'warning' ? 'warning' : 'danger';
        
        notification.className = 'alert alert-' + alertType + ' alert-dismissible fade show toast-notification';

        const icon = type === 'success' ? 'check-circle' : 
                    type === 'info' ? 'info-circle' : 
                    type === 'warning' ? 'exclamation-triangle' : 'exclamation-circle';
        
        notification.innerHTML = 
            '<div class="d-flex align-items-center">' +
                '<i class="fas fa-' + icon + ' me-2 flex-shrink-0"></i>' + 
                '<div class="flex-grow-1">' + message + '</div>' +
                '<button type="button" class="btn-close ms-2" data-bs-dismiss="alert"></button>' +
            '</div>';

        document.body.appendChild(notification);

        // Auto-remove notification after 4 seconds
        setTimeout(function() {
            if (notification.parentNode) {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => {
                    if (notification.parentNode) {
                        notification.remove();
                    }
                }, 300);
            }
        }, 4000);
    }

    // Initialize cart when page loads
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Initializing cart...');
        
        // Initialize checkbox change events
        const checkboxes = document.querySelectorAll('.item-checkbox');
        console.log('Found', checkboxes.length, 'checkboxes');
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', updateCartTotals);
        });
        
        // Initialize quantity input events with better selectors
        const qtyInputs = document.querySelectorAll('.qty-input');
        console.log('Found', qtyInputs.length, 'quantity inputs');
        qtyInputs.forEach(input => {
            const cartId = input.getAttribute('data-cart-id');
            console.log('Setting up quantity input for cart ID:', cartId);
            
            // Remove existing event listeners to avoid duplicates
            input.removeEventListener('keypress', handleQuantityKeyPress);
            input.removeEventListener('change', handleQuantityChange);
            input.removeEventListener('blur', handleQuantityChange);
            
            // Add event listeners
            input.addEventListener('keypress', function(e) {
                handleQuantityKeyPress(e, cartId);
            });
            
            input.addEventListener('change', function() {
                handleQuantityChange(cartId, this.value);
            });
            
            input.addEventListener('blur', function() {
                handleQuantityChange(cartId, this.value);
            });
        });
        
        // Initialize buttons
        const minusButtons = document.querySelectorAll('.minus-btn');
        const plusButtons = document.querySelectorAll('.plus-btn');
        console.log('Found', minusButtons.length, 'minus buttons and', plusButtons.length, 'plus buttons');
        
        // Auto-uppercase and handle enter key in promo code input
        const promoInput = document.getElementById('promoCodeInput');
        if (promoInput) {
            promoInput.addEventListener('input', function() {
                this.value = this.value.toUpperCase().replace(/[^A-Z0-9]/g, '');
            });
        }
        
        // Check for existing promo code from session
        const sessionPromoCode = '${sessionScope.promoCode}';
        if (sessionPromoCode && sessionPromoCode !== '' && sessionPromoCode !== 'null') {
            if (availablePromoCodes[sessionPromoCode]) {
                currentPromoCode = sessionPromoCode;
                const promo = availablePromoCodes[sessionPromoCode];
                currentPromoDiscount = promo.value;
                currentPromoType = promo.type;
                currentPromoMax = promo.max;
                console.log('Loaded existing promo code:', sessionPromoCode);
            }
        }
        
        // Set initial button states
        updateButtonStates();
        
        // Initial calculations
        updateCartTotals();
        updateCartCount();
        
        console.log('Cart initialized successfully');
    });

    // Update button states based on quantities
    function updateButtonStates() {
    const cartItems = document.querySelectorAll('.cart-item');
    cartItems.forEach(item => {
        const cartId = item.getAttribute('data-cart-id');
        const qtyInput = document.getElementById('qty-' + cartId);
        const minusBtn = document.querySelector(`button[data-cart-id="${cartId}"].minus-btn`);
        const plusBtn = document.querySelector(`button[data-cart-id="${cartId}"].plus-btn`);
        
        if (qtyInput) {
            const quantity = parseInt(qtyInput.value) || 1;
            
            if (minusBtn) {
                minusBtn.disabled = quantity <= 1;
                minusBtn.style.opacity = quantity <= 1 ? '0.5' : '1';
                minusBtn.style.cursor = quantity <= 1 ? 'not-allowed' : 'pointer';
            }
            
            if (plusBtn) {
                plusBtn.disabled = quantity >= 999;
                plusBtn.style.opacity = quantity >= 999 ? '0.5' : '1';
                plusBtn.style.cursor = quantity >= 999 ? 'not-allowed' : 'pointer';
            }
        }
    });
}
</script>