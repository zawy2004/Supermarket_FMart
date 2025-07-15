<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<header class="header clearfix" >
    <style>
        .header.clearfix {
            top: -2px;
        }

        /* Enhanced Autocomplete Styles */
        .header_search {
            position: relative;
            width: 100%;
        }

        .search-suggestions {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 0 0 12px 12px;
            max-height: 400px;
            overflow-y: auto;
            z-index: 9999;
            display: none;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            margin-top: 2px;
        }

        .suggestion-item {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            border-bottom: 1px solid #f5f5f5;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .suggestion-item:hover {
            background: #f8f9fa;
            transform: translateX(2px);
        }

        .suggestion-item:last-child {
            border-bottom: none;
        }

        .suggestion-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 12px;
            border: 2px solid #f0f0f0;
            flex-shrink: 0;
        }

        .suggestion-content {
            flex: 1;
            min-width: 0;
        }

        .suggestion-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 4px;
            font-size: 14px;
            line-height: 1.3;
            word-wrap: break-word;
        }

        .suggestion-price {
            color: #007bff;
            font-weight: 700;
            font-size: 14px;
        }

        .suggestion-brand {
            color: #666;
            font-size: 12px;
            margin-bottom: 2px;
        }

        .no-suggestions {
            padding: 20px;
            text-align: center;
            color: #666;
            font-style: italic;
        }

        .loading {
            padding: 20px;
            text-align: center;
            color: #666;
        }

        .loading::after {
            content: '';
            display: inline-block;
            width: 18px;
            height: 18px;
            border: 2px solid #f3f3f3;
            border-top: 2px solid #007bff;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-left: 8px;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }

        /* Search input enhanced */
        .prompt.srch10 {
            transition: all 0.3s ease;
            width: 350px !important;
        }

        .prompt.srch10:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
        }

        /* Highlight matched text */
        .highlight {
            background: #fff3cd;
            padding: 1px 3px;
            border-radius: 3px;
            font-weight: 700;
        }

        /* Mobile responsive */
        @media (max-width: 768px) {
            .suggestion-image {
                width: 40px;
                height: 40px;
                margin-right: 10px;
            }

            .suggestion-name {
                font-size: 13px;
            }

            .suggestion-price {
                font-size: 13px;
            }
        }
    </style>

    <div class="top-header-group">
        <div class="top-header">
            <div class="main_logo" id="logo">
                <a href="${pageContext.request.contextPath}/home">
                    <img src="${pageContext.request.contextPath}/User/images/logoFM.png" alt="FMart">
                </a>
                <a href="home"><img class="logo-inverse" src="User/images/dark-logo.svg" alt=""></a>
            </div>

            <!-- ENHANCED SEARCH BOX WITH AUTOCOMPLETE -->
            <div class="search120">
                <div class="header_search">
                    <form action="shop" method="get" style="position: relative; display: flex; align-items: center;" id="searchForm">
                        <input class="prompt srch10" 
                               type="text" 
                               name="search"
                               id="searchInput"
                               placeholder="Search for products..." 
                               value="${search}"
                               autocomplete="off"
                               style="width: 100%; padding-right: 50px;">
                        <button type="submit" 
                                style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer; z-index: 2;">
                            <i class="uil uil-search s-icon" style="font-size: 18px; color: #666;"></i>
                        </button>
                    </form>

                    <!-- AUTOCOMPLETE SUGGESTIONS -->
                    <div id="searchSuggestions" class="search-suggestions">
                        <!-- Dynamic content will be inserted here -->
                    </div>
                </div>
            </div>
            <!-- END ENHANCED SEARCH BOX -->

            <div class="header_right">
                <ul>
                    <li>
                        <a href="#" class="offer-link"><i class="uil uil-phone-alt"></i>1800-000-000</a>
                    </li>
                    <li>
                        <a href="User/offers.jsp" class="offer-link"><i class="uil uil-gift"></i>Offers</a>
                    </li>
                    <li>
                        <a href="User/faq.jsp" class="offer-link"><i class="uil uil-question-circle"></i>Help</a>
                    </li>
                    <li>
                        <a href="User/dashboard_my_wishlist.jsp" class="option_links" title="Wishlist"><i class='uil uil-heart icon_wishlist'></i><span class="noti_count1">3</span></a>
                    </li>	
                    <li class="dropdown account-dropdown">
                        <a href="#" class="opts_account" role="button" id="accountClick" data-bs-auto-close="outside" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="User/images/avatar/img-5.jpg" alt="">
                            <span class="user__name">
                                <% if (user != null) {%>
                                <%= user.getFullName()%>
                                <% } else { %>
                                <a href="login" style="color: #333; text-decoration: none;">Sign In</a>
                                <% } %>
                            </span>
                            <i class="uil uil-angle-down"></i>
                        </a>
                        <% if (user != null) { %>
                        <div class="dropdown-menu dropdown-menu-account dropdown-menu-end" aria-labelledby="accountClick" data-bs-popper="none">
                            <div class="night_mode_switch__btn">
                                <a href="#" id="night-mode" class="btn-night-mode">
                                    <i class="uil uil-moon"></i> Night mode
                                    <span class="btn-night-mode-switch">
                                        <span class="uk-switch-button"></span>
                                    </span>
                                </a>
                            </div>
                            <a href="profile?action=overview" class="channel_item">
                                <i class="uil uil-apps icon__1"></i>Dashboard
                            </a>

                            <a href="profile?action=orders"" class="channel_item"><i class="uil uil-box icon__1"></i>My Orders</a>
                            <a href="wishlist" class="channel_item"><i class="uil uil-heart icon__1"></i>My Wishlist</a>
                            <a href="profile?action=wallet" class="channel_item"><i class="uil uil-usd-circle icon__1"></i>My Wallet</a>
                            <a href="profile?action=addresses" class="channel_item"><i class="uil uil-location-point icon__1"></i>My Address</a>
                            <a href="User/offers.jsp" class="channel_item"><i class="uil uil-gift icon__1"></i>Offers</a>
                            <a href="User/faq.jsp" class="channel_item"><i class="uil uil-info-circle icon__1"></i>Faq</a>
                            <a href="logout" class="channel_item"><i class="uil uil-lock-alt icon__1"></i>Logout</a>
                        </div>
                        <% }%>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="sub-header-group">
        <div class="sub-header">
            <nav class="navbar navbar-expand-lg bg-gambo gambo-head navbar justify-content-lg-start pt-0 pb-0">
                <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
                    <span class="navbar-toggler-icon">
                        <i class="uil uil-bars"></i>
                    </span>
                </button>
                <a href="#" class="category_drop hover-btn" data-bs-toggle="modal" data-bs-target="#category_model" title="Categories"><i class="uil uil-apps"></i><span class="cate__icon">Select Category</span></a>
                <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
                    <div class="offcanvas-header">
                        <div class="offcanvas-logo" id="offcanvasNavbarLabel">
                            <img src="User/images/dark-logo-1.svg" alt="">
                        </div>
                        <button type="button" class="close-btn" data-bs-dismiss="offcanvas" aria-label="Close">
                            <i class="uil uil-multiply"></i>
                        </button>
                    </div>
                    <div class="offcanvas-body">
                        <div class="offcanvas-category mb-4 d-block d-lg-none">
                            <!-- MOBILE SEARCH WITH AUTOCOMPLETE -->
                            <div class="offcanvas-search position-relative">
                                <form action="shop" method="get" style="position: relative;" id="mobileSearchForm">
                                    <input class="canvas_search" 
                                           type="text" 
                                           name="search"
                                           id="mobileSearchInput"
                                           placeholder="Search for products..."
                                           value="${search}"
                                           autocomplete="off">
                                    <button type="submit" 
                                            style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer;">
                                        <i class="uil uil-search hover-btn canvas-icon"></i>
                                    </button>
                                </form>

                                <!-- Mobile suggestions -->
                                <div id="mobileSuggestions" class="search-suggestions" style="position: absolute; top: 100%; left: 0; right: 0;">
                                    <!-- Dynamic content for mobile -->
                                </div>
                            </div>
                            <!-- END MOBILE SEARCH -->
                            <button class="category_drop_canvas hover-btn mt-4" data-bs-toggle="modal" data-bs-target="#category_model" title="Categories"><i class="uil uil-apps"></i><span class="cate__icon">Select Category</span></button>
                        </div>
                        <ul class="navbar-nav justify-content-start flex-grow-1 pe_5">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="home">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="shop?sortBy=newest">New Products</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="shop?sortBy=discount">Featured Products</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Blog
                                </a>
                                <ul class="dropdown-menu dropdown-submenu">
                                    <li><a class="dropdown-item" href="User/our_blog.jsp">Our Blog</a></li>
                                    <li><a class="dropdown-item" href="User/blog_no_sidebar.jsp">Our Blog Two No Sidebar</a></li>
                                    <li><a class="dropdown-item" href="User/blog_left_sidebar.jsp">Our Blog with Left Sidebar</a></li>
                                    <li><a class="dropdown-item" href="User/blog_right_sidebar.jsp">Our Blog with Right Sidebar</a></li>
                                    <li><a class="dropdown-item" href="User/blog_detail_view.jsp">Blog Detail View</a></li>
                                    <li><a class="dropdown-item" href="User/blog_left_sidebar_single_view.jsp">Blog Detail View with Sidebar</a></li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Pages
                                </a>
                                <ul class="dropdown-menu dropdown-submenu">
                                    <li><a class="dropdown-item" href="User/dashboard_overview.jsp">Account</a></li>
                                    <li><a class="dropdown-item" href="User/about_us.jsp">About Us</a></li>
                                    <li><a class="dropdown-item" href="shop">Online Shop</a></li>
                                    <li><a class="dropdown-item" href="User/single_product_view.jsp">Single Product View</a></li>
                                    <li><a class="dropdown-item" href="User/checkout.jsp">Checkout</a></li>
                                    <li><a class="dropdown-item" href="User/request_product.jsp">Product Request</a></li>
                                    <li><a class="dropdown-item" href="User/order_placed.jsp">Order Placed</a></li>
                                    <li><a class="dropdown-item" href="User/bill.jsp">Bill Slip</a></li>
                                    <li><a class="dropdown-item" href="User/job_detail_view.jsp">Job Detail View</a></li>
                                    <li><a class="dropdown-item" href="login">Sign In</a></li>
                                    <li><a class="dropdown-item" href="register">Sign Up</a></li>
                                    <li><a class="dropdown-item" href="User/forgot_password.jsp">Forgot Password</a></li>
                                </ul>
                            </li>
                            <!-- Fix trong header.jsp - dòng cuối cùng -->
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact Us</a>
                            </li>

                        </ul>
                        <div class="d-block d-lg-none">
                            <ul class="offcanvas-help-links">
                                <li><a href="#" class="offer-link"><i class="uil uil-phone-alt"></i>1800-000-000</a></li>
                                <li><a href="User/offers.jsp" class="offer-link"><i class="uil uil-gift"></i>Offers</a></li>
                                <li><a href="User/faq.jsp" class="offer-link"><i class="uil uil-question-circle"></i>Help</a></li>
                            </ul>
                            <div class="offcanvas-copyright">
                                <i class="uil uil-copyright"></i>Copyright 2022 <b>FMartlthemes</b> . All rights reserved
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sub_header_right">
                    <div class="header_cart">
                        <a href="#" class="cart__btn hover-btn" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight"><i class="uil uil-shopping-cart-alt"></i><span>Cart</span><ins>2</ins><i class="uil uil-angle-down"></i></a>
                    </div>
                </div>
            </nav>
        </div>
    </div>
</header>

<!-- AUTOCOMPLETE JAVASCRIPT -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        console.log('🔍 Autocomplete system initializing...');

        // Elements
        const searchInput = document.getElementById('searchInput');
        const searchSuggestions = document.getElementById('searchSuggestions');
        const searchForm = document.getElementById('searchForm');
        const mobileSearchInput = document.getElementById('mobileSearchInput');
        const mobileSuggestions = document.getElementById('mobileSuggestions');
        const mobileSearchForm = document.getElementById('mobileSearchForm');

        let searchTimeout;
        let currentRequest;

        // Initialize both desktop and mobile search
        if (searchInput && searchSuggestions) {
            initializeAutocomplete(searchInput, searchSuggestions, searchForm, 'desktop');
        }

        if (mobileSearchInput && mobileSuggestions) {
            initializeAutocomplete(mobileSearchInput, mobileSuggestions, mobileSearchForm, 'mobile');
        }

        function initializeAutocomplete(inputElement, suggestionsElement, formElement, type) {
            console.log('🔍 Initializing ' + type + ' autocomplete');

            // Input event
            inputElement.addEventListener('input', function () {
                const keyword = this.value.trim();

                clearTimeout(searchTimeout);

                if (keyword.length < 2) {
                    hideSuggestions(suggestionsElement);
                    return;
                }

                showLoading(suggestionsElement);

                searchTimeout = setTimeout(() => {
                    fetchSuggestions(keyword, suggestionsElement);
                }, 300);
            });

            // Form submit
            formElement.addEventListener('submit', function (e) {
                hideSuggestions(suggestionsElement);
            });

            // Focus event
            inputElement.addEventListener('focus', function () {
                const keyword = this.value.trim();
                if (keyword.length >= 2) {
                    fetchSuggestions(keyword, suggestionsElement);
                }
            });

            // Keyboard navigation
            inputElement.addEventListener('keydown', function (e) {
                const items = suggestionsElement.querySelectorAll('.suggestion-item');
                let activeIndex = -1;

                // Find currently active item
                for (let i = 0; i < items.length; i++) {
                    if (items[i].classList.contains('active')) {
                        activeIndex = i;
                        break;
                    }
                }

                if (e.key === 'ArrowDown') {
                    e.preventDefault();
                    // Remove current active
                    if (activeIndex >= 0)
                        items[activeIndex].classList.remove('active');
                    // Set next active
                    activeIndex = (activeIndex + 1) % items.length;
                    if (items[activeIndex]) {
                        items[activeIndex].classList.add('active');
                        items[activeIndex].scrollIntoView({block: 'nearest'});
                    }
                } else if (e.key === 'ArrowUp') {
                    e.preventDefault();
                    // Remove current active
                    if (activeIndex >= 0)
                        items[activeIndex].classList.remove('active');
                    // Set previous active
                    activeIndex = activeIndex <= 0 ? items.length - 1 : activeIndex - 1;
                    if (items[activeIndex]) {
                        items[activeIndex].classList.add('active');
                        items[activeIndex].scrollIntoView({block: 'nearest'});
                    }
                } else if (e.key === 'Enter' && activeIndex >= 0) {
                    e.preventDefault();
                    items[activeIndex].click();
                } else if (e.key === 'Escape') {
                    hideSuggestions(suggestionsElement);
                }
            });
        }

        function fetchSuggestions(keyword, suggestionsElement) {
            if (currentRequest) {
                currentRequest.abort();
            }

            console.log('🔍 Fetching suggestions for: "' + keyword + '"');

            currentRequest = new XMLHttpRequest();
            currentRequest.open('GET', 'AutocompleteServlet?keyword=' + encodeURIComponent(keyword), true);

            currentRequest.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    try {
                        const suggestions = JSON.parse(this.responseText);
                        console.log('🔍 Received ' + suggestions.length + ' suggestions');
                        displaySuggestions(suggestions, suggestionsElement, keyword);
                    } catch (e) {
                        console.error('🔍 Error parsing suggestions:', e);
                        showNoSuggestions(suggestionsElement);
                    }
                }
            };

            currentRequest.onerror = function () {
                console.error('🔍 Request failed');
                showNoSuggestions(suggestionsElement);
            };

            currentRequest.send();
        }

        function displaySuggestions(suggestions, suggestionsElement, keyword) {
            suggestionsElement.innerHTML = '';

            if (suggestions.length === 0) {
                showNoSuggestions(suggestionsElement);
                return;
            }

            suggestions.forEach(product => {
                const item = createSuggestionItem(product, keyword);
                suggestionsElement.appendChild(item);
            });

            showSuggestions(suggestionsElement);
        }

        function createSuggestionItem(product, keyword) {
            const item = document.createElement('div');
            item.className = 'suggestion-item';

            // Format price
            const formattedPrice = '$' + parseFloat(product.sellingPrice).toFixed(2);

            // Get image URL
            let imageSrc = product.imageUrl;
            if (!imageSrc || imageSrc === 'null' || imageSrc === '') {
                imageSrc = 'User/images/product/img-' + product.productId + '.jpg';
            }

            // Highlight matching text
            const highlightedName = highlightKeyword(product.productName, keyword);

            // Build HTML string with traditional concatenation
            var htmlContent = '<img src="' + imageSrc + '" ' +
                    'alt="' + product.productName + '" ' +
                    'class="suggestion-image" ' +
                    'onerror="this.src=\'User/images/product/no-image.jpg\'"> ' +
                    '<div class="suggestion-content"> ' +
                    '<div class="suggestion-name">' + highlightedName + '</div>';

            // Add brand if exists
            if (product.brand && product.brand.trim() !== '') {
                htmlContent += '<div class="suggestion-brand">' + product.brand + '</div>';
            }

            htmlContent += '<div class="suggestion-price">' + formattedPrice + '</div> ' +
                    '</div>';

            item.innerHTML = htmlContent;

            // Click event
            item.addEventListener('click', function () {
                selectProduct(product);
            });

            // Hover events for keyboard navigation
            item.addEventListener('mouseenter', function () {
                // Remove active from all items
                const allItems = suggestionsElement.querySelectorAll('.suggestion-item');
                allItems.forEach(i => i.classList.remove('active'));
                // Add active to this item
                this.classList.add('active');
            });

            return item;
        }

        function highlightKeyword(text, keyword) {
            if (!keyword || keyword.length < 2)
                return text;

            // Tìm keyword trong text (case-insensitive)
            var parts = text.split(new RegExp('(' + keyword + ')', 'gi'));
            var result = '';

            for (var i = 0; i < parts.length; i++) {
                if (parts[i].toLowerCase() === keyword.toLowerCase()) {
                    result += '<span class="highlight">' + parts[i] + '</span>';
                } else {
                    result += parts[i];
                }
            }

            return result;
        }

        function selectProduct(product) {
            console.log('🔍 Selected product: ' + product.productName + ' (ID: ' + product.productId + ')');

            // Fill search input
            if (searchInput)
                searchInput.value = product.productName;
            if (mobileSearchInput)
                mobileSearchInput.value = product.productName;

            // Hide suggestions
            hideSuggestions(searchSuggestions);
            hideSuggestions(mobileSuggestions);

            // Redirect to product detail page
            window.location.href = 'single_product?productId=' + product.productId;
        }

        function showLoading(suggestionsElement) {
            suggestionsElement.innerHTML = '<div class="loading">Đang tìm kiếm...</div>';
            showSuggestions(suggestionsElement);
        }

        function showNoSuggestions(suggestionsElement) {
            suggestionsElement.innerHTML = '<div class="no-suggestions">Không tìm thấy sản phẩm nào</div>';
            showSuggestions(suggestionsElement);
        }

        function showSuggestions(suggestionsElement) {
            suggestionsElement.style.display = 'block';
        }

        function hideSuggestions(suggestionsElement) {
            if (suggestionsElement) {
                suggestionsElement.style.display = 'none';
            }
        }

        // Hide suggestions when clicking outside
        document.addEventListener('click', function (e) {
            if (!e.target.closest('.header_search') && !e.target.closest('.offcanvas-search')) {
                hideSuggestions(searchSuggestions);
                hideSuggestions(mobileSuggestions);
            }
        });

        console.log('🔍 Autocomplete system ready!');
    });
</script>