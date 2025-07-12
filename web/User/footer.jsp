<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<footer class="footer">
    <div class="footer-first-row">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <ul class="call-email-alt">
                        <li><a href="#" class="callemail"><i class="uil uil-dialpad-alt"></i>1800-000-000</a></li>
                        <li><a href="#" class="callemail"><i class="uil uil-envelope-alt"></i>info@FMartsupermarket.com</a></li>
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
                            <li><a href="#">Fruits and Vegetables</a></li>
                            <li><a href="#">Grocery & Staples</a></li>
                            <li><a href="#">Dairy & Eggs</a></li>
                            <li><a href="#">Beverages</a></li>
                            <li><a href="#">Snacks</a></li>
                            <li><a href="#">Home Care</a></li>
                            <li><a href="#">Noodles & Sauces</a></li>
                            <li><a href="shop_grid.jsp">More...</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-6">
                    <div class="second-row-item">
                        <h4>Useful Links</h4>
                        <ul>
                            <li><a href="User/about_us.jsp">About US</a></li>
                            <li><a href="User/shop_grid.jsp">Featured Products</a></li>
                            <li><a href="User/offers.jsp">Offers</a></li>
                            <li><a href="User/our_blog.jsp">Blog</a></li>
                            <li><a href="User/faq.jsp">Faq</a></li>
                            <li><a href="User/career.jsp">Careers</a></li>
                            <li><a href="User/contact_us.jsp">Contact Us</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-6">
                    <div class="second-row-item">
                        <h4>Top Cities</h4>
                        <ul>
                            <li><a href="#">Gurugram</a></li>
                            <li><a href="#">New Delhi</a></li>
                            <li><a href="#">Bangaluru</a></li>
                            <li><a href="#">Mumbai</a></li>
                            <li><a href="#">Hyderabad</a></li>
                            <li><a href="#">Kolkata</a></li>
                            <li><a href="#">Ludhiana</a></li>
                            <li><a href="#">Chandigrah</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-6">
                    <div class="second-row-item-app">
                        <h4>Download App</h4>
                        <ul>
                            <li><a href="#"><img class="download-btn mb-2" src="${pageContext.request.contextPath}/User/images/download-1.svg" alt=""></a></li>
                            <li><a href="#"><img class="download-btn mb-2" src="${pageContext.request.contextPath}/User/images/download-2.svg" alt=""></a></li>
                        </ul>
                    </div>
                    <div class="second-row-item-payment">
                        <h4>Payment Method</h4>
                        <div class="footer-payments">
                            <ul id="paypal-gateway" class="financial-institutes">
                                <li class="financial-institutes__logo">
                                    <img alt="Visa" title="Visa" src="${pageContext.request.contextPath}/User/images/footer-icons/pyicon-6.svg">
                                </li>
                                <li class="financial-institutes__logo">
                                    <img alt="Visa" title="Visa" src="${pageContext.request.contextPath}/User/images/footer-icons/pyicon-1.svg">
                                </li>
                                <li class="financial-institutes__logo">
                                    <img alt="MasterCard" title="MasterCard" src="${pageContext.request.contextPath}/User/images/footer-icons/pyicon-2.svg">
                                </li>
                                <li class="financial-institutes__logo">
                                    <img alt="American Express" title="American Express" src="${pageContext.request.contextPath}/User/images/footer-icons/pyicon-3.svg">
                                </li>
                                <li class="financial-institutes__logo">
                                    <img alt="Discover" title="Discover" src="${pageContext.request.contextPath}/User/images/footer-icons/pyicon-4.svg">
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="second-row-item-payment">
                        <h4>Newsletter</h4>
                        <div class="newsletter-input">
                            <input id="email" name="email" type="text" placeholder="Email Address" class="form-control input-md" required="">
                            <button class="newsletter-btn hover-btn" type="submit"><i class="uil uil-telegram-alt"></i></button>
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
                                <li><a href="about_us.jsp">About</a></li>
                                <li><a href="contact_us.jsp">Contact</a></li>
                                <li><a href="privacy_policy.jsp">Privacy Policy</a></li>
                                <li><a href="term_and_conditions.jsp">Term & Conditions</a></li>
                                <li><a href="refund_and_return_policy.jsp">Refund & Return Policy</a></li>
                            </ul>
                        </div>
                        <div class="copyright-text">
                            <i class="uil uil-copyright"></i>Copyright 2024 <b>FMartlthemes</b> . All rights reserved
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<script>
(function(){if(!window.chatbase||window.chatbase("getState")!=="initialized"){window.chatbase=(...arguments)=>{if(!window.chatbase.q){window.chatbase.q=[]}window.chatbase.q.push(arguments)};window.chatbase=new Proxy(window.chatbase,{get(target,prop){if(prop==="q"){return target.q}return(...args)=>target(prop,...args)}})}const onLoad=function(){const script=document.createElement("script");script.src="https://www.chatbase.co/embed.min.js";script.id="I1AbD7F-J8AQs_9cgNkRm";script.domain="www.chatbase.co";document.body.appendChild(script)};if(document.readyState==="complete"){onLoad()}else{window.addEventListener("load",onLoad)}})();
</script>
</body>