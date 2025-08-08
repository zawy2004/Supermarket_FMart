package service;

import dao.CouponDAO;
import dao.CouponUsageDAO;
import dao.UserDAO;
import model.Coupon;
import model.CouponUsage;
import model.User;
import config.CouponConfig;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Enhanced CouponService with full functionality
 * Handles both personal and global coupons with proper validation
 */
public class CouponService {

    private static final Logger logger = Logger.getLogger(CouponService.class.getName());
    private CouponDAO couponDAO = new CouponDAO();
    private CouponUsageDAO couponUsageDAO = new CouponUsageDAO();
    private UserDAO userDAO = new UserDAO();
    
    /**
     * Custom exception for validation errors
     */
    public static class ValidationException extends Exception {
        public ValidationException(String message) {
            super(message);
        }
    }
    
    /**
     * Apply coupon to order - MAIN METHOD
     * Uses integrated CouponDAO logic (personal + global)
     */
    public double applyCouponToOrder(int orderId, String couponCode, int userId, double orderAmount) throws SQLException, ValidationException {
        try {
            logger.info("Applying coupon " + couponCode + " to order " + orderId + " for user " + userId);
            double discount = couponDAO.applyCouponToOrder(orderId, couponCode, userId);
            logger.info("Successfully applied coupon. Discount: " + discount);
            return discount;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error applying coupon: " + e.getMessage(), e);
            // Convert SQL errors to ValidationException for consistent error handling
            String errorMessage = e.getMessage();
            if (errorMessage.contains("Mã giảm giá không hợp lệ") ||
                errorMessage.contains("đã hết hạn") ||
                errorMessage.contains("đã hết số lần sử dụng") ||
                errorMessage.contains("đạt giới hạn") ||
                errorMessage.contains("không đủ để áp dụng")) {
                throw new ValidationException(errorMessage);
            }
            throw e;
        }
    }
    
    /**
     * Get coupon by code
     */
    public Coupon getCouponByCode(String couponCode) throws SQLException {
        if (couponCode == null || couponCode.trim().isEmpty()) {
            return null;
        }
        return couponDAO.getCouponByCode(couponCode.trim().toUpperCase());
    }
    
    /**
     * Simple validation - just check if coupon exists and is active
     */
    public boolean validateCoupon(String couponCode, int userId, double orderTotal) {
        try {
            Coupon coupon = getCouponByCode(couponCode);
            if (coupon == null || !coupon.isActive()) {
                return false;
            }
            
            // Check minimum order amount
            if (coupon.getMinOrderAmount() > 0 && orderTotal < coupon.getMinOrderAmount()) {
                return false;
            }
            
            return true;
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Error validating coupon: " + e.getMessage(), e);
            return false;
        }
    }
    
    /**
     * Calculate discount for display purposes
     */
    public double calculateDiscount(String couponCode, double orderAmount) throws SQLException, ValidationException {
        Coupon coupon = getCouponByCode(couponCode);
        if (coupon == null) {
            throw new ValidationException("Mã coupon không tồn tại");
        }

        return coupon.calculateDiscount(orderAmount);
    }

    /**
     * Get all coupons (for admin)
     */
    public List<Coupon> getAllCoupons() throws SQLException {
        return couponDAO.getAllCoupons();
    }

    /**
     * Get active coupons
     */
    public List<Coupon> getActiveCoupons() throws SQLException {
        return couponDAO.getActiveCoupons();
    }

    /**
     * Get coupon by ID
     */
    public Coupon getCouponById(int couponId) throws SQLException {
        return couponDAO.getCouponById(couponId);
    }

    /**
     * Create new coupon
     */
    public int createCoupon(Coupon coupon) throws SQLException, ValidationException {
        // Basic validation
        if (coupon.getCouponCode() == null || coupon.getCouponCode().trim().isEmpty()) {
            throw new ValidationException("Mã coupon không được để trống");
        }

        if (coupon.getDiscountValue() <= 0) {
            throw new ValidationException("Giá trị giảm giá phải lớn hơn 0");
        }

        // Check if coupon code already exists
        if (couponDAO.couponCodeExists(coupon.getCouponCode())) {
            throw new ValidationException("Mã coupon đã tồn tại: " + coupon.getCouponCode());
        }

        // Set default values
        coupon.setUsageCount(0);
        coupon.setActive(true);
        coupon.setCreatedDate(new java.sql.Date(System.currentTimeMillis()));

        return couponDAO.addCoupon(coupon);
    }

    /**
     * Update coupon
     */
    public boolean updateCoupon(Coupon coupon) throws SQLException, ValidationException {
        // Basic validation
        if (coupon.getCouponCode() == null || coupon.getCouponCode().trim().isEmpty()) {
            throw new ValidationException("Mã coupon không được để trống");
        }

        if (coupon.getDiscountValue() <= 0) {
            throw new ValidationException("Giá trị giảm giá phải lớn hơn 0");
        }

        // Check if coupon code exists for other coupons
        Coupon existingCoupon = getCouponByCode(coupon.getCouponCode());
        if (existingCoupon != null && existingCoupon.getCouponId() != coupon.getCouponId()) {
            throw new ValidationException("Mã coupon đã tồn tại: " + coupon.getCouponCode());
        }

        return couponDAO.updateCoupon(coupon);
    }

    /**
     * Delete coupon (soft delete)
     */
    public boolean deleteCoupon(int couponId) throws SQLException {
        return couponDAO.deleteCoupon(couponId);
    }

    /**
     * Update coupon status
     */
    public boolean updateCouponStatus(int couponId, boolean isActive) throws SQLException {
        return couponDAO.updateCouponStatus(couponId, isActive);
    }

    /**
     * Search coupons with pagination
     */
    public List<Coupon> searchCoupons(String keyword, String statusFilter, String typeFilter, int offset, int limit) throws SQLException {
        return couponDAO.searchCoupons(keyword, statusFilter, typeFilter, offset, limit);
    }

    /**
     * Count search results
     */
    public int countSearchCoupons(String keyword, String statusFilter, String typeFilter) throws SQLException {
        return couponDAO.countSearchCoupons(keyword, statusFilter, typeFilter);
    }

    /**
     * Get user's coupon usage history
     */
    public List<CouponUsage> getUserCouponHistoryByOrders(int userId) throws SQLException {
        return couponUsageDAO.getCouponUsageByUserOrders(userId);
    }

    /**
     * Get order coupon usage
     */
    public List<CouponUsage> getOrderCouponUsage(int orderId) throws SQLException {
        return couponUsageDAO.getCouponUsageByOrder(orderId);
    }

    /**
     * Get coupon usage statistics
     */
    public List<CouponUsageDAO.CouponUsageStats> getCouponUsageStatistics() throws SQLException {
        return couponUsageDAO.getCouponUsageStats();
    }

    /**
     * Get available coupons for user
     */
    public List<Coupon> getAvailableCouponsForUser(int userId, double orderAmount) throws SQLException {
        List<Coupon> activeCoupons = getActiveCoupons();
        List<Coupon> availableCoupons = new ArrayList<>();

        for (Coupon coupon : activeCoupons) {
            if (validateCoupon(coupon.getCouponCode(), userId, orderAmount)) {
                availableCoupons.add(coupon);
            }
        }

        return availableCoupons;
    }

    /**
     * Check if coupon code is available
     */
    public boolean isCouponCodeAvailable(String couponCode) throws SQLException {
        return !couponDAO.couponCodeExists(couponCode);
    }

    /**
     * Generate coupon code suggestion
     */
    public String generateCouponCodeSuggestion(String baseName) {
        if (baseName == null || baseName.trim().isEmpty()) {
            baseName = "COUPON";
        }

        String cleanName = baseName.replaceAll("[^A-Za-z0-9]", "").toUpperCase();
        if (cleanName.length() > 10) {
            cleanName = cleanName.substring(0, 10);
        }

        long timestamp = System.currentTimeMillis() % 10000;
        return cleanName + timestamp;
    }

    /**
     * Get optimized coupon statistics using single SQL query
     */
    public CouponStatistics getCouponStatistics() throws SQLException {
        return couponDAO.getCouponStatistics();
    }

    /**
     * Validate coupon for user with detailed error messages
     */
    public void validateCouponForUser(String couponCode, int userId, double orderAmount) throws SQLException, ValidationException {
        Coupon coupon = getCouponByCode(couponCode);
        if (coupon == null) {
            throw new ValidationException("Mã coupon không tồn tại");
        }

        if (!coupon.isActive()) {
            throw new ValidationException("Mã coupon đã bị vô hiệu hóa");
        }

        // Check validity period
        Date now = new Date();
        if (coupon.getStartDate() != null && now.before(coupon.getStartDate())) {
            throw new ValidationException("Mã coupon chưa có hiệu lực");
        }

        if (coupon.getEndDate() != null && now.after(coupon.getEndDate())) {
            throw new ValidationException("Mã coupon đã hết hạn sử dụng");
        }

        // Check minimum order amount
        if (coupon.getMinOrderAmount() > 0 && orderAmount < coupon.getMinOrderAmount()) {
            throw new ValidationException("Đơn hàng tối thiểu " + String.format("%,.0f", coupon.getMinOrderAmount()) + " VND để sử dụng coupon này");
        }

        // Check usage limits
        if (coupon.getOrderLimit() > 0) {
            int userUsageCount = couponUsageDAO.getUserCouponUsageCount(userId, coupon.getCouponId());
            if (userUsageCount >= coupon.getOrderLimit()) {
                throw new ValidationException("Bạn đã sử dụng hết số lần cho phép của mã coupon này");
            }
        }

        if (coupon.getUsageLimit() > 0 && coupon.getUsageCount() >= coupon.getUsageLimit()) {
            throw new ValidationException("Mã coupon đã hết số lần sử dụng");
        }
    }

    /**
     * Inner class for coupon statistics
     */
    public static class CouponStatistics {
        private int totalCoupons;
        private int activeCoupons;
        private int expiredCoupons;
        private int usedCoupons;
        private double totalDiscountGiven;

        public CouponStatistics(int totalCoupons, int activeCoupons, int expiredCoupons, int usedCoupons, double totalDiscountGiven) {
            this.totalCoupons = totalCoupons;
            this.activeCoupons = activeCoupons;
            this.expiredCoupons = expiredCoupons;
            this.usedCoupons = usedCoupons;
            this.totalDiscountGiven = totalDiscountGiven;
        }

        // Getters
        public int getTotalCoupons() { return totalCoupons; }
        public int getActiveCoupons() { return activeCoupons; }
        public int getExpiredCoupons() { return expiredCoupons; }
        public int getUsedCoupons() { return usedCoupons; }
        public double getTotalDiscountGiven() { return totalDiscountGiven; }
    }
}
