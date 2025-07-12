<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<footer class="footer">
    <div class="footer-first-row">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <ul class="call-email-alt">
                        <li><a href="#" class="callemail"><i class="uil uil-dialpad-alt"></i>1800-000-000</a></li>
                        <li><a href="#" class="callemail"><i class="uil uil-envelope-alt"></i>support@fmart.vn</a></li>
                    </ul>
                </div>
                <div class="col-md-6 col-sm-6">
                    <div class="social-links-footer">
                        <ul>
                            <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                            <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fab fa-google-plus-g"></i></a></li>
                            <li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
                            <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                            <li><a href="#"><i class="fab fa-pinterest-p"></i></a></li>
                        </ul>
                    </div>
                </div>				
            </div>
        </div>
    </div>
    <div class="footer-second-row">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-6">
                    <div class="second-row-item">
                        <h4>Categories</h4>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/shop?category=fruits">Fruits and Vegetables</a></li>
                            <li><a href="${pageContext.request.contextPath}/shop?category=grocery">Grocery & Staples</a></li>
                            <li><a href="${pageContext.request.contextPath}/shop?category=dairy">Dairy & Eggs</a></li>
                            <li><a href="${pageContext.request.contextPath}/shop?category=beverages">Beverages</a></li>
                            <li><a href="${pageContext.request.contextPath}/shop?category=snacks">Snacks</a></li>
                            <li><a href="${pageContext.request.contextPath}/shop?category=homecare">Home Care</a></li>
                            <li><a href="${pageContext.request.contextPath}/shop?category=noodles">Noodles & Sauces</a></li>
                            <li><a href="${pageContext.request.contextPath}/shop">More...</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-6">
                    <div class="second-row-item">
                        <h4>Useful Links</h4>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/User/about_us.jsp">About US</a></li>
                            <li><a href="${pageContext.request.contextPath}/shop?sortBy=discount">Featured Products</a></li>
                            <li><a href="${pageContext.request.contextPath}/User/offers.jsp">Offers</a></li>
                            <li><a href="${pageContext.request.contextPath}/User/our_blog.jsp">Blog</a></li>
                            <li><a href="${pageContext.request.contextPath}/User/faq.jsp">Faq</a></li>
                            <li><a href="${pageContext.request.contextPath}/User/career.jsp">Careers</a></li>
                            <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-6">
                    <div class="second-row-item">
                        <h4>Thành Phố Phục Vụ</h4>
                        <ul>
                            <li><a href="#">TP. Hồ Chí Minh</a></li>
                            <li><a href="#">Hà Nội</a></li>
                            <li><a href="#">Đà Nẵng</a></li>
                            <li><a href="#">Nha Trang</a></li>
                            <li><a href="#">Cần Thơ</a></li>
                            <li><a href="#">Hải Phòng</a></li>
                            <li><a href="#">Huế</a></li>
                            <li><a href="#">Vũng Tàu</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-6">
                    <div class="second-row-item-app">
                        <h4>Download App</h4>
                        <ul>
                            <li><a href="#"><img class="download-btn mb-2" src="${pageContext.request.contextPath}/User/images/download-1.svg" alt="Download on App Store"></a></li>
                            <li><a href="#"><img class="download-btn mb-2" src="${pageContext.request.contextPath}/User/images/download-2.svg" alt="Get it on Google Play"></a></li>
                        </ul>
                    </div>
                    <div class="second-row-item-payment">
                        <h4>Payment Methods</h4>
                        <div class="footer-payments">
                            <ul id="paypal-gateway" class="financial-institutes">
                                <li class="financial-institutes__logo">
                                    <i class="fab fa-cc-visa fa-2x text-primary" title="Visa"></i>
                                </li>
                                <li class="financial-institutes__logo">
                                    <i class="fab fa-cc-mastercard fa-2x text-warning" title="MasterCard"></i>
                                </li>
                                <li class="financial-institutes__logo">
                                    <i class="fab fa-cc-paypal fa-2x text-info" title="PayPal"></i>
                                </li>
                                <li class="financial-institutes__logo">
                                    <i class="fas fa-university fa-2x text-success" title="Banking"></i>
                                </li>
                                <li class="financial-institutes__logo">
                                    <i class="fas fa-money-bill-wave fa-2x text-secondary" title="Cash on Delivery"></i>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="second-row-item-payment">
                        <h4>Newsletter</h4>
                        <div class="newsletter-input">
                            <form action="${pageContext.request.contextPath}/newsletter" method="post">
                                <input id="email" name="email" type="email" placeholder="Email Address" class="form-control input-md" required="">
                                <button class="newsletter-btn hover-btn" type="submit"><i class="uil uil-telegram-alt"></i></button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-last-row">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="footer-bottom-group">
                        <div class="footer-bottom-links">
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/User/about_us.jsp">About</a></li>
                                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                                <li><a href="${pageContext.request.contextPath}/User/privacy_policy.jsp">Privacy Policy</a></li>
                                <li><a href="${pageContext.request.contextPath}/User/term_and_conditions.jsp">Term & Conditions</a></li>
                                <li><a href="${pageContext.request.contextPath}/User/refund_and_return_policy.jsp">Refund & Return Policy</a></li>
                            </ul>
                        </div>
                        <div class="copyright-text">
                            <i class="uil uil-copyright"></i>Copyright 2024 <b>FMart</b> . All rights reserved
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Custom CSS for payment icons -->
<style>
.financial-institutes {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    list-style: none;
    padding: 0;
    margin: 0;
}

.financial-institutes__logo {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 45px;
    height: 35px;
    background: #f8f9fa;
    border-radius: 6px;
    transition: all 0.3s ease;
}

.financial-institutes__logo:hover {
    background: #e9ecef;
    transform: translateY(-2px);
}

.financial-institutes__logo i {
    font-size: 20px !important;
}

.newsletter-input {
    position: relative;
}

.newsletter-input form {
    display: flex;
    border-radius: 25px;
    overflow: hidden;
}

.newsletter-input input {
    flex: 1;
    border: none;
    padding: 12px 15px;
    border-radius: 25px 0 0 25px;
}

.newsletter-btn {
    border: none;
    background: #FF5722;
    color: white;
    padding: 12px 15px;
    border-radius: 0 25px 25px 0;
    cursor: pointer;
    transition: background 0.3s ease;
}

.newsletter-btn:hover {
    background: #e64a19;
}

.footer-bottom-links ul {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer-bottom-links a {
    color: #bdc3c7;
    text-decoration: none;
    transition: color 0.3s ease;
}

.footer-bottom-links a:hover {
    color: #FF5722;
}

@media (max-width: 768px) {
    .footer-bottom-links ul {
        justify-content: center;
        margin-bottom: 15px;
    }
    
    .financial-institutes {
        justify-content: center;
    }
}
</style>

<script>
// Newsletter subscription
document.addEventListener('DOMContentLoaded', function() {
    const newsletterForm = document.querySelector('.newsletter-input form');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = this.querySelector('input[name="email"]').value;
            if (email) {
                // Show success message
                alert('Cảm ơn bạn đã đăng ký nhận bản tin từ FMart!');
                this.reset();
            }
        });
    }
});

// Chatbase script (optional)
(function(){if(!window.chatbase||window.chatbase("getState")!=="initialized"){window.chatbase=(...arguments)=>{if(!window.chatbase.q){window.chatbase.q=[]}window.chatbase.q.push(arguments)};window.chatbase=new Proxy(window.chatbase,{get(target,prop){if(prop==="q"){return target.q}return(...args)=>target(prop,...args)}})}const onLoad=function(){const script=document.createElement("script");script.src="https://www.chatbase.co/embed.min.js";script.id="I1AbD7F-J8AQs_9cgNkRm";script.domain="www.chatbase.co";document.body.appendChild(script)};if(document.readyState==="complete"){onLoad()}else{window.addEventListener("load",onLoad)}})();
</script>
</body>