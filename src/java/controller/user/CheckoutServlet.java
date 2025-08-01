package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.ProductImage;
import model.ShoppingCart;
import service.ProductService;
import service.ShoppingCartService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

// ===== COUPON MANAGEMENT IMPORTS - START =====
import model.Coupon;
import service.CouponService;
import util.CouponValidationUtil;
import util.CSRFTokenUtil;
import util.RateLimitUtil;
import java.util.logging.Logger;
import java.util.logging.Level;
// ===== COUPON MANAGEMENT IMPORTS - END =====

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    
    private ProductService productService;
    private ShoppingCartService cartService;

    // ===== COUPON MANAGEMENT SERVICES - START =====
    private CouponService couponService;
    private static final Logger logger = Logger.getLogger(CheckoutServlet.class.getName());
    // ===== COUPON MANAGEMENT SERVICES - END =====

    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
        cartService = new ShoppingCartService();

        // ===== COUPON MANAGEMENT INITIALIZATION - START =====
        couponService = new CouponService();
        // ===== COUPON MANAGEMENT INITIALIZATION - END =====
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
            System.out.println("CheckoutServlet: userId = " + userId);
            
            if (userId == null) {
                response.sendRedirect("login");
                return;
            }
            
            String productIdStr = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String quantityStr = request.getParameter("quantity");
            String unit = request.getParameter("unit");
            String sellingPriceStr = request.getParameter("sellingPrice");
            String totalPriceStr = request.getParameter("totalPrice");

            List<ShoppingCart> cartItems = new ArrayList<>();
            double cartTotal = 0.0;
            double totalSaving = 0.0;
            double deliveryCharge = 30000;
            if (productIdStr != null && quantityStr != null && sellingPriceStr != null) {
                int productId = Integer.parseInt(productIdStr);
                int quantity = Integer.parseInt(quantityStr);
                double sellingPrice = Double.parseDouble(sellingPriceStr);
                double totalPrice = Double.parseDouble(totalPriceStr);
                double costPrice = productService.getProductById(productId).getCostPrice();

                ShoppingCart orderItem = new ShoppingCart();
                orderItem.setUserID(userId);
                orderItem.setProductID(productId);
                orderItem.setQuantity(quantity);
                orderItem.setUnit(unit);
                orderItem.setAddedDate(new Date());
                orderItem.setProductName(productName);
                orderItem.setSellingPrice(sellingPrice);
                orderItem.setCostPrice(costPrice > 0 ? costPrice : sellingPrice);
                cartItems.add(orderItem);

                cartTotal = totalPrice;
                if (costPrice > sellingPrice) {
                    totalSaving = (costPrice - sellingPrice) * quantity;
                }
            } else {
                List<ShoppingCart> existingCartItems = cartService.getCartItemsByUserId(userId);
                if (existingCartItems != null && !existingCartItems.isEmpty()) {
                    cartItems.addAll(existingCartItems);
                    for (ShoppingCart item : existingCartItems) {
                        Product p = productService.getProductById(item.getProductID());
                        if (p != null) {
                            item.setProductName(p.getProductName());
                            item.setSellingPrice(p.getSellingPrice());
                            item.setCostPrice(p.getCostPrice());
                            cartTotal += p.getSellingPrice() * item.getQuantity();
                            if (p.getCostPrice() > p.getSellingPrice()) {
                                totalSaving += (p.getCostPrice() - p.getSellingPrice()) * item.getQuantity();
                            }
                        }
                    }
                }
            }
            String mainImageUrl = "images/product/default.jpg";
            if (productIdStr != null) {
                int productId = Integer.parseInt(productIdStr);
                List<ProductImage> productImages = productService.getProductImagesByProductId(productId);
                mainImageUrl = productImages.stream()
                        .filter(ProductImage::isIsMainImage)
                        .findFirst()
                        .map(ProductImage::getImageUrl)
                        .orElse(productImages.isEmpty() ? "images/product/default.jpg" : productImages.get(0).getImageUrl());
            }

            // ===== COUPON MANAGEMENT LOGIC - START =====
            double originalTotal = cartTotal;
            double couponDiscount = 0.0;
            String appliedCouponCode = null;
            String couponMessage = null;
            boolean couponApplied = false;

            String sessionCouponCode = (String) session.getAttribute("appliedCouponCode");
            Double sessionCouponDiscount = (Double) session.getAttribute("couponDiscount");

            if (sessionCouponCode != null && sessionCouponDiscount != null) {
                try {
                    Coupon coupon = couponService.getCouponByCode(sessionCouponCode);
                    if (coupon != null && CouponValidationUtil.isValidForOrder(coupon, userId, originalTotal)) {
                        appliedCouponCode = sessionCouponCode;
                        couponDiscount = CouponValidationUtil.calculateDiscount(coupon, originalTotal);
                        couponApplied = true;
                        couponMessage = "Coupon '" + sessionCouponCode + "' đã được áp dụng";
                        logger.info("Coupon reapplied from session: " + sessionCouponCode + ", discount: " + couponDiscount);
                    } else {
                        session.removeAttribute("appliedCouponCode");
                        session.removeAttribute("couponDiscount");
                        couponMessage = "Coupon đã hết hạn hoặc không còn khả dụng";
                    }
                } catch (Exception e) {
                    logger.log(Level.WARNING, "Error validating session coupon: " + e.getMessage(), e);
                    session.removeAttribute("appliedCouponCode");
                    session.removeAttribute("couponDiscount");
                }
            }

            double finalTotal = originalTotal - couponDiscount + deliveryCharge;

            List<Coupon> availableCoupons = new ArrayList<>();
            try {
                List<Coupon> allActiveCoupons = couponService.getActiveCoupons();
                for (Coupon coupon : allActiveCoupons) {
                    if (CouponValidationUtil.isValidForOrder(coupon, userId, originalTotal)) {
                        availableCoupons.add(coupon);
                    }
                }
            } catch (Exception e) {
                logger.log(Level.WARNING, "Error loading available coupons: " + e.getMessage(), e);
            }
            // ===== COUPON MANAGEMENT LOGIC - END =====

            request.setAttribute("product", productIdStr != null ? productService.getProductById(Integer.parseInt(productIdStr)) : null);
            request.setAttribute("mainImageUrl", mainImageUrl);
            request.setAttribute("quantity", quantityStr != null ? Integer.parseInt(quantityStr) : 1);
            request.setAttribute("unit", unit);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.setAttribute("totalSaving", totalSaving);
            request.setAttribute("deliveryCharge", deliveryCharge);
            request.setAttribute("productPrice", sellingPriceStr != null ? Double.parseDouble(sellingPriceStr) : 0.0);
            request.setAttribute("productOriginalPrice", productIdStr != null ? productService.getProductById(Integer.parseInt(productIdStr)).getCostPrice() : 0.0);

            // ===== COUPON MANAGEMENT ATTRIBUTES - START =====
            request.setAttribute("originalTotal", originalTotal);
            request.setAttribute("couponDiscount", couponDiscount);
            request.setAttribute("finalTotal", finalTotal);
            request.setAttribute("appliedCouponCode", appliedCouponCode);
            request.setAttribute("couponMessage", couponMessage);
            request.setAttribute("couponApplied", couponApplied);
            request.setAttribute("availableCoupons", availableCoupons);

            // Add CSRF token for coupon operations
            String csrfToken = CSRFTokenUtil.getToken(session);
            request.setAttribute("csrfToken", csrfToken);
            // ===== COUPON MANAGEMENT ATTRIBUTES - END =====

            request.getRequestDispatcher("/User/checkout.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in CheckoutServlet doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        }
    }

    // ===== COUPON MANAGEMENT POST METHOD - START =====
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (userId == null) {
            response.sendRedirect("login");
            return;
        }

        // Rate Limiting
        String clientId = RateLimitUtil.getClientId(request.getRemoteAddr(), userId);
        if (!RateLimitUtil.isAllowedCouponRequest(clientId)) {
            long resetTime = RateLimitUtil.getTimeUntilReset(clientId);
            session.setAttribute("couponError", "Too many requests. Please wait " + resetTime + " seconds before trying again.");
            response.sendRedirect("checkout");
            return;
        }

        // CSRF Protection
        String csrfToken = request.getParameter("csrfToken");
        if (!CSRFTokenUtil.validateToken(session, csrfToken)) {
            session.setAttribute("couponError", "Invalid security token. Please refresh the page and try again.");
            response.sendRedirect("checkout");
            return;
        }

        String action = request.getParameter("action");

        if ("applyCoupon".equals(action)) {
            handleApplyCoupon(request, response, session, userId);
        } else if ("removeCoupon".equals(action)) {
            handleRemoveCoupon(request, response, session);
        } else {
            session.setAttribute("couponError", "Invalid action");
            response.sendRedirect("checkout");
        }
    }

    // ===== COUPON MANAGEMENT HELPER METHODS - START =====
    private void handleApplyCoupon(HttpServletRequest request, HttpServletResponse response,
                                 HttpSession session, Integer userId) throws IOException {
        try {
            String couponCode = request.getParameter("couponCode");
            String orderTotalStr = request.getParameter("orderTotal");

            if (couponCode == null || couponCode.trim().isEmpty()) {
                session.setAttribute("couponError", "Vui lòng nhập mã coupon");
                response.sendRedirect("checkout");
                return;
            }

            if (orderTotalStr == null || orderTotalStr.trim().isEmpty()) {
                session.setAttribute("couponError", "Không thể xác định tổng tiền đơn hàng");
                response.sendRedirect("checkout");
                return;
            }

            double orderTotal = Double.parseDouble(orderTotalStr);
            couponCode = couponCode.trim().toUpperCase();

            Coupon coupon = couponService.getCouponByCode(couponCode);

            if (coupon == null) {
                session.setAttribute("couponError", "Mã coupon không tồn tại");
                response.sendRedirect("checkout");
                return;
            }

            if (!CouponValidationUtil.isValidForOrder(coupon, userId, orderTotal)) {
                String errorMessage = CouponValidationUtil.getValidationErrorMessage(coupon, userId, orderTotal);
                session.setAttribute("couponError", errorMessage);
                response.sendRedirect("checkout");
                return;
            }

            double discount = CouponValidationUtil.calculateDiscount(coupon, orderTotal);

            session.setAttribute("appliedCouponCode", couponCode);
            session.setAttribute("couponDiscount", discount);
            session.removeAttribute("couponError");
            session.setAttribute("couponSuccess", "Áp dụng coupon thành công! Tiết kiệm " +
                String.format("%,.0f", discount) + "đ");

            logger.info("Coupon applied successfully: " + couponCode + " for user: " + userId +
                       ", discount: " + discount);

        } catch (NumberFormatException e) {
            session.setAttribute("couponError", "Dữ liệu không hợp lệ");
            logger.log(Level.WARNING, "Invalid number format in apply coupon: " + e.getMessage(), e);
        } catch (Exception e) {
            session.setAttribute("couponError", "Lỗi hệ thống khi áp dụng coupon");
            logger.log(Level.SEVERE, "Error applying coupon: " + e.getMessage(), e);
        }

        response.sendRedirect("checkout");
    }

    private void handleRemoveCoupon(HttpServletRequest request, HttpServletResponse response,
                                  HttpSession session) throws IOException {
        try {
            session.removeAttribute("appliedCouponCode");
            session.removeAttribute("couponDiscount");
            session.removeAttribute("couponError");
            session.setAttribute("couponSuccess", "Đã hủy áp dụng coupon");

            logger.info("Coupon removed from session");

        } catch (Exception e) {
            logger.log(Level.WARNING, "Error removing coupon: " + e.getMessage(), e);
        }

        response.sendRedirect("checkout");
    }
    // ===== COUPON MANAGEMENT HELPER METHODS - END =====
    // ===== COUPON MANAGEMENT POST METHOD - END =====
}