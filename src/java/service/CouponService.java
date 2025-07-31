package service;

import dao.CouponDAO;
import dao.CouponUsageDAO;
import model.Coupon;
import model.CouponUsage;
import util.CouponValidationUtil;
import util.CouponValidationUtil.ValidationException;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class CouponService {
    
    private static final Logger logger = Logger.getLogger(CouponService.class.getName());
    private CouponDAO couponDAO = new CouponDAO();
    private CouponUsageDAO couponUsageDAO = new CouponUsageDAO();

    public int createCoupon(Coupon coupon) throws SQLException, ValidationException {
        // Validate coupon data
        CouponValidationUtil.validateCoupon(coupon);
        
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


    public List<Coupon> getAllCoupons() throws SQLException {
        return couponDAO.getAllCoupons();
    }


    public List<Coupon> getActiveCoupons() throws SQLException {
        return couponDAO.getActiveCoupons();
    }

    public Coupon getCouponByCode(String couponCode) throws SQLException {
        if (couponCode == null || couponCode.trim().isEmpty()) {
            return null;
        }
        return couponDAO.getCouponByCode(couponCode.trim().toUpperCase());
    }


    public Coupon getCouponById(int couponId) throws SQLException {
        return couponDAO.getCouponById(couponId);
    }

    public void validateCouponForUser(String couponCode, int userId, double orderAmount) 
            throws SQLException, ValidationException {
        
        Coupon coupon = getCouponByCode(couponCode);
        if (coupon == null) {
            throw new ValidationException("Mã coupon không tồn tại");
        }

        // Get user's usage count for this coupon
        int userUsageCount = couponUsageDAO.getUserCouponUsageCount(userId, coupon.getCouponId());
        
        // Validate coupon usage
        CouponValidationUtil.validateCouponUsage(coupon, orderAmount, userUsageCount);
    }

    public double calculateDiscount(String couponCode, double orderAmount) throws SQLException, ValidationException {
        Coupon coupon = getCouponByCode(couponCode);
        if (coupon == null) {
            throw new ValidationException("Mã coupon không tồn tại");
        }

        return coupon.calculateDiscount(orderAmount);
    }

    public double applyCouponToOrder(int orderId, String couponCode, int userId, double orderAmount)
            throws SQLException, ValidationException {

        // Step 1: Validate coupon for user
        validateCouponForUser(couponCode, userId, orderAmount);

        // Step 2: Apply coupon using stored procedure
        // Stored procedure handles all validation and logging internally
        try {
            double appliedDiscount = couponDAO.applyCouponToOrder(orderId, couponCode, userId);

            if (appliedDiscount > 0) {
                logger.info("Successfully applied coupon " + couponCode + " to order " + orderId +
                          " for user " + userId + ", discount: " + appliedDiscount);
            }

            return appliedDiscount;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error applying coupon to order", e);
            throw e;
        }
    }

    public double applyCouponManually(int orderId, String couponCode, int userId, double orderAmount)
            throws SQLException, ValidationException {

        // Use stored procedure for manual application as well
        // This ensures consistency with automatic application
        return applyCouponToOrder(orderId, couponCode, userId, orderAmount);
    }

    /**
     * Get user's coupon usage history
     */
    public List<CouponUsage> getUserCouponHistory(int userId) throws SQLException {
        return couponUsageDAO.getCouponUsageByUser(userId);
    }

    /**
     * Get user's coupon usage history by orders (compatible with database schema)
     */
    public List<CouponUsage> getUserCouponHistoryByOrders(int userId) throws SQLException {
        return couponUsageDAO.getCouponUsageByUserOrders(userId);
    }

 
    public List<CouponUsage> getOrderCouponUsage(int orderId) throws SQLException {
        return couponUsageDAO.getCouponUsageByOrder(orderId);
    }

  
    public boolean canUserUseCoupon(String couponCode, int userId, double orderAmount) {
        try {
            validateCouponForUser(couponCode, userId, orderAmount);
            return true;
        } catch (SQLException | ValidationException e) {
            logger.warning("User " + userId + " cannot use coupon " + couponCode + ": " + e.getMessage());
            return false;
        }
    }

   
    public boolean updateCouponStatus(int couponId, boolean isActive) throws SQLException {
        return couponDAO.updateCouponStatus(couponId, isActive);
    }

    public List<CouponUsageDAO.CouponUsageStats> getCouponUsageStatistics() throws SQLException {
        return couponUsageDAO.getCouponUsageStats();
    }

    public List<Coupon> getAvailableCouponsForUser(int userId, double orderAmount) throws SQLException {
        List<Coupon> activeCoupons = getActiveCoupons();
        List<Coupon> availableCoupons = new ArrayList<>();
        
        for (Coupon coupon : activeCoupons) {
            if (canUserUseCoupon(coupon.getCouponCode(), userId, orderAmount)) {
                availableCoupons.add(coupon);
            }
        }
        
        return availableCoupons;
    }

    public boolean isCouponCodeAvailable(String couponCode) throws SQLException {
        return !couponDAO.couponCodeExists(couponCode);
    }

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
     * Tìm kiếm coupon với phân trang
     */
    public List<Coupon> searchCoupons(String keyword, String statusFilter, String typeFilter, int offset, int limit) throws SQLException {
        return couponDAO.searchCoupons(keyword, statusFilter, typeFilter, offset, limit);
    }

    /**
     * Đếm số lượng coupon theo điều kiện tìm kiếm
     */
    public int countSearchCoupons(String keyword, String statusFilter, String typeFilter) throws SQLException {
        return couponDAO.countSearchCoupons(keyword, statusFilter, typeFilter);
    }

    /**
     * Cập nhật thông tin coupon
     */
    public boolean updateCoupon(Coupon coupon) throws SQLException, ValidationException {
        // Validate coupon data
        CouponValidationUtil.validateCoupon(coupon);

        // Check if coupon code exists for other coupons
        Coupon existingCoupon = getCouponByCode(coupon.getCouponCode());
        if (existingCoupon != null && existingCoupon.getCouponId() != coupon.getCouponId()) {
            throw new ValidationException("Mã coupon đã tồn tại: " + coupon.getCouponCode());
        }

        return couponDAO.updateCoupon(coupon);
    }

    /**
     * Xóa coupon (soft delete)
     */
    public boolean deleteCoupon(int couponId) throws SQLException {
        return couponDAO.deleteCoupon(couponId);
    }

    /**
     * Xóa coupon vĩnh viễn
     */
    public boolean hardDeleteCoupon(int couponId) throws SQLException {
        return couponDAO.hardDeleteCoupon(couponId);
    }

    /**
     * Lấy thống kê tổng quan về coupon
     */
    public CouponStatistics getCouponStatistics() throws SQLException {
        List<Coupon> allCoupons = getAllCoupons();

        int totalCoupons = allCoupons.size();
        int activeCoupons = 0;
        int expiredCoupons = 0;
        int usedCoupons = 0;
        double totalDiscountGiven = 0.0;

        Date now = new Date();

        for (Coupon coupon : allCoupons) {
            if (coupon.isActive()) {
                if (coupon.getEndDate().before(now)) {
                    expiredCoupons++;
                } else {
                    activeCoupons++;
                }
            }

            if (coupon.getUsageCount() > 0) {
                usedCoupons++;
                // Tính tổng discount đã áp dụng (cần thêm logic tính toán chi tiết)
            }
        }

        return new CouponStatistics(totalCoupons, activeCoupons, expiredCoupons, usedCoupons, totalDiscountGiven);
    }

    /**
     * Inner class để lưu thống kê coupon
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