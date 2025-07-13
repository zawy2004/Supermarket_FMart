package controller.user;

import model.Coupon;
import model.CouponUsage;
import model.User;
import service.CouponService;
import util.CouponValidationUtil.ValidationException;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/coupons")
public class CustomerCouponServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(CustomerCouponServlet.class.getName());
    private CouponService couponService = new CouponService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        User currentUser = getCurrentUser(request);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        try {
            switch (action != null ? action : "list") {
                case "list":
                    handleListAvailableCoupons(request, response, currentUser);
                    break;
                case "my-coupons":
                    handleListUserCoupons(request, response, currentUser);
                    break;
                case "history":
                    handleShowUsageHistory(request, response, currentUser);
                    break;
                case "validate":
                    handleValidateCoupon(request, response, currentUser);
                    break;
                case "available":
                    handleGetAvailableCoupons(request, response, currentUser);
                    break;
                default:
                    handleListAvailableCoupons(request, response, currentUser);
                    break;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error in CustomerCouponServlet", e);
            request.setAttribute("errorMessage", "Lỗi hệ thống. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        User currentUser = getCurrentUser(request);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        try {
            switch (action != null ? action : "") {
                case "apply":
                    handleApplyCouponToOrder(request, response, currentUser);
                    break;
                case "check":
                    handleCheckCouponAvailability(request, response, currentUser);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                    break;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error in CustomerCouponServlet POST", e);
            request.setAttribute("errorMessage", "Lỗi hệ thống. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        } catch (ValidationException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/User/coupons.jsp").forward(request, response);
        }
    }

    /**
     * Display all available coupons for customers
     */
    private void handleListAvailableCoupons(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        List<Coupon> activeCoupons = couponService.getActiveCoupons();
        request.setAttribute("coupons", activeCoupons);
        request.setAttribute("pageTitle", "Mã giảm giá có sẵn");
        request.getRequestDispatcher("/User/coupons.jsp").forward(request, response);
    }

    /**
     * Display user's coupon usage history
     */
    private void handleShowUsageHistory(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        List<CouponUsage> usageHistory = couponService.getUserCouponHistory(user.getUserId());
        request.setAttribute("usageHistory", usageHistory);
        request.setAttribute("pageTitle", "Lịch sử sử dụng coupon");
        request.getRequestDispatcher("/User/couponHistory.jsp").forward(request, response);
    }

    /**
     * Get available coupons for user based on order amount
     */
    private void handleGetAvailableCoupons(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String orderAmountStr = request.getParameter("orderAmount");
        double orderAmount = 0.0;
        
        try {
            if (orderAmountStr != null && !orderAmountStr.trim().isEmpty()) {
                orderAmount = Double.parseDouble(orderAmountStr);
            }
        } catch (NumberFormatException e) {
            logger.warning("Invalid order amount format: " + orderAmountStr);
        }
        
        List<Coupon> availableCoupons = couponService.getAvailableCouponsForUser(user.getUserId(), orderAmount);
        
        // Return as JSON for AJAX requests
        if ("json".equals(request.getParameter("format"))) {
            response.setContentType("application/json");
            StringBuilder json = new StringBuilder();
            json.append("{\"coupons\": [");
            
            for (int i = 0; i < availableCoupons.size(); i++) {
                Coupon coupon = availableCoupons.get(i);
                if (i > 0) json.append(",");
                
                json.append("{")
                    .append("\"code\": \"").append(escapeJson(coupon.getCouponCode())).append("\",")
                    .append("\"name\": \"").append(escapeJson(coupon.getCouponName())).append("\",")
                    .append("\"discountType\": \"").append(coupon.getDiscountType()).append("\",")
                    .append("\"discountValue\": ").append(coupon.getDiscountValue()).append(",")
                    .append("\"minOrderAmount\": ").append(coupon.getMinOrderAmount()).append(",")
                    .append("\"maxDiscountAmount\": ").append(coupon.getMaxDiscountAmount()).append(",")
                    .append("\"description\": \"").append(escapeJson(coupon.getDescription() != null ? coupon.getDescription() : "")).append("\"")
                    .append("}");
            }
            
            json.append("]}");
            response.getWriter().write(json.toString());
        } else {
            request.setAttribute("coupons", availableCoupons);
            request.setAttribute("orderAmount", orderAmount);
            request.setAttribute("pageTitle", "Coupon áp dụng được");
            request.getRequestDispatcher("/User/availableCoupons.jsp").forward(request, response);
        }
    }

    /**
     * Validate if coupon can be used
     */
    private void handleValidateCoupon(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String couponCode = request.getParameter("couponCode");
        String orderAmountStr = request.getParameter("orderAmount");
        
        if (couponCode == null || couponCode.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"valid\": false, \"message\": \"Mã coupon không được để trống\"}");
            return;
        }
        
        double orderAmount = 0.0;
        try {
            if (orderAmountStr != null && !orderAmountStr.trim().isEmpty()) {
                orderAmount = Double.parseDouble(orderAmountStr);
            }
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"valid\": false, \"message\": \"Số tiền đơn hàng không hợp lệ\"}");
            return;
        }
        
        try {
            couponService.validateCouponForUser(couponCode, user.getUserId(), orderAmount);
            double discount = couponService.calculateDiscount(couponCode, orderAmount);
            
            response.setContentType("application/json");
            response.getWriter().write("{\"valid\": true, \"discount\": " + discount + 
                                    ", \"message\": \"Coupon hợp lệ\"}");
            
        } catch (ValidationException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"valid\": false, \"message\": \"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    /**
     * Apply coupon to order (for checkout process)
     */
    private void handleApplyCouponToOrder(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException, ValidationException {
        
        String couponCode = request.getParameter("couponCode");
        String orderIdStr = request.getParameter("orderId");
        String orderAmountStr = request.getParameter("orderAmount");
        
        if (couponCode == null || orderIdStr == null || orderAmountStr == null) {
            throw new ValidationException("Thiếu thông tin cần thiết để áp dụng coupon");
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            double orderAmount = Double.parseDouble(orderAmountStr);
            
            double discount = couponService.applyCouponToOrder(orderId, couponCode, user.getUserId(), orderAmount);
            
            if (discount > 0) {
                request.setAttribute("successMessage", "Áp dụng coupon thành công! Bạn được giảm " + 
                                   String.format("%,.0f VND", discount));
                request.setAttribute("appliedDiscount", discount);
                request.setAttribute("couponCode", couponCode);
            } else {
                request.setAttribute("errorMessage", "Không thể áp dụng coupon");
            }
            
            // Return JSON for AJAX requests
            if ("json".equals(request.getParameter("format"))) {
                response.setContentType("application/json");
                if (discount > 0) {
                    response.getWriter().write("{\"success\": true, \"discount\": " + discount + 
                                            ", \"message\": \"Áp dụng coupon thành công\"}");
                } else {
                    response.getWriter().write("{\"success\": false, \"message\": \"Không thể áp dụng coupon\"}");
                }
            } else {
                request.getRequestDispatcher("/User/checkout.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            throw new ValidationException("Dữ liệu số không hợp lệ");
        }
    }

    /**
     * Check coupon availability for user
     */
    private void handleCheckCouponAvailability(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String couponCode = request.getParameter("couponCode");
        String orderAmountStr = request.getParameter("orderAmount");
        
        if (couponCode == null || couponCode.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"available\": false, \"message\": \"Mã coupon không được để trống\"}");
            return;
        }
        
        double orderAmount = 0.0;
        try {
            if (orderAmountStr != null && !orderAmountStr.trim().isEmpty()) {
                orderAmount = Double.parseDouble(orderAmountStr);
            }
        } catch (NumberFormatException e) {
            // Use default order amount of 0
        }
        
        boolean canUse = couponService.canUserUseCoupon(couponCode, user.getUserId(), orderAmount);
        
        response.setContentType("application/json");
        if (canUse) {
            try {
                double discount = couponService.calculateDiscount(couponCode, orderAmount);
                response.getWriter().write("{\"available\": true, \"discount\": " + discount + 
                                        ", \"message\": \"Coupon có thể sử dụng\"}");
            } catch (ValidationException e) {
                response.getWriter().write("{\"available\": false, \"message\": \"" + escapeJson(e.getMessage()) + "\"}");
            }
        } else {
            response.getWriter().write("{\"available\": false, \"message\": \"Coupon không thể sử dụng\"}");
        }
    }

    private User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (User) session.getAttribute("user") : null;
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"")
                  .replace("\\", "\\\\")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }

    @Override
    public String getServletInfo() {
        return "CustomerCouponServlet - Handles customer coupon operations";
    }

    private void handleListUserCoupons(HttpServletRequest request, HttpServletResponse response, User currentUser) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}