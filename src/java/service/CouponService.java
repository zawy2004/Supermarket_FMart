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
        
        // Step 2: Get coupon details
        Coupon coupon = getCouponByCode(couponCode);
        
        // Step 3: Calculate discount
        double discountAmount = coupon.calculateDiscount(orderAmount);
        
        if (discountAmount <= 0) {
            throw new ValidationException("Không thể áp dụng coupon cho đơn hàng này");
        }

        try {
            // Step 4: Apply coupon using stored procedure (if exists)
            double appliedDiscount = couponDAO.applyCouponToOrder(orderId, couponCode, userId);
            
            // Step 5: Log coupon usage
            if (appliedDiscount > 0) {
                CouponUsage usage = new CouponUsage();
                usage.setCouponID(coupon.getCouponId());
                usage.setUserID(userId);
                usage.setOrderID(orderId);
                usage.setUsedDate(new Date());
                usage.setDiscountAmount(appliedDiscount);
                
                couponUsageDAO.logCouponUsage(usage);
                
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
        
        // Validate and get coupon
        validateCouponForUser(couponCode, userId, orderAmount);
        Coupon coupon = getCouponByCode(couponCode);
        
        // Calculate discount
        double discountAmount = coupon.calculateDiscount(orderAmount);
        
        if (discountAmount <= 0) {
            throw new ValidationException("Không thể áp dụng coupon cho đơn hàng này");
        }

        try {
            // Update coupon usage count
            boolean updated = couponDAO.incrementUsageCount(coupon.getCouponId());
            
            if (updated) {
                // Log coupon usage
                CouponUsage usage = new CouponUsage();
                usage.setCouponID(coupon.getCouponId());
                usage.setUserID(userId);
                usage.setOrderID(orderId);
                usage.setUsedDate(new Date());
                usage.setDiscountAmount(discountAmount);
                
                couponUsageDAO.logCouponUsage(usage);
                
                logger.info("Manually applied coupon " + couponCode + " to order " + orderId + 
                          " for user " + userId + ", discount: " + discountAmount);
                
                return discountAmount;
            } else {
                throw new ValidationException("Không thể cập nhật trạng thái coupon");
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error manually applying coupon", e);
            throw e;
        }
    }

    /**
     * Get user's coupon usage history
     */
    public List<CouponUsage> getUserCouponHistory(int userId) throws SQLException {
        return couponUsageDAO.getCouponUsageByUser(userId);
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
}