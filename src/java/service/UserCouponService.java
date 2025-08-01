package service;

import dao.UserCouponDAO;
import model.UserCoupon;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service class for UserCoupon operations
 * Handles business logic for personal coupon assignments
 */
public class UserCouponService {
    
    private static final Logger logger = Logger.getLogger(UserCouponService.class.getName());
    private UserCouponDAO userCouponDAO = new UserCouponDAO();

    /**
     * Assign welcome coupon to new user
     */
    public boolean assignWelcomeCoupon(int userId) {
        try {
            return userCouponDAO.assignCouponToUser(
                userId, 
                "FMART50K", 
                "SYSTEM", 
                "Welcome coupon for new user registration", 
                90 // 90 days expiry
            );
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error assigning welcome coupon to user " + userId, e);
            return false;
        }
    }

    /**
     * Assign birthday coupon to user
     */
    public boolean assignBirthdayCoupon(int userId) {
        try {
            return userCouponDAO.assignCouponToUser(
                userId, 
                "BIRTHDAY20", 
                "SYSTEM", 
                "Birthday coupon - Happy Birthday!", 
                60 // 60 days expiry
            );
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error assigning birthday coupon to user " + userId, e);
            return false;
        }
    }

    /**
     * Assign VIP coupon to loyal customer
     */
    public boolean assignVIPCoupon(int userId) {
        try {
            return userCouponDAO.assignCouponToUser(
                userId, 
                "VIP15", 
                "SYSTEM", 
                "VIP customer reward - Thank you for your loyalty", 
                180 // 180 days expiry
            );
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error assigning VIP coupon to user " + userId, e);
            return false;
        }
    }

    /**
     * Assign comeback coupon to returning customer
     */
    public boolean assignComebackCoupon(int userId) {
        try {
            return userCouponDAO.assignCouponToUser(
                userId, 
                "COMEBACK100K", 
                "SYSTEM", 
                "Welcome back! We missed you", 
                60 // 60 days expiry
            );
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error assigning comeback coupon to user " + userId, e);
            return false;
        }
    }

    /**
     * Assign custom coupon to user
     */
    public boolean assignCouponToUser(int userId, String couponCode, String assignedBy, String notes, int expiryDays) {
        try {
            return userCouponDAO.assignCouponToUser(userId, couponCode, assignedBy, notes, expiryDays);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error assigning coupon " + couponCode + " to user " + userId, e);
            return false;
        }
    }

    /**
     * Get user's coupon history
     */
    public List<UserCoupon> getUserCouponHistory(int userId) {
        try {
            return userCouponDAO.getUserCouponHistory(userId);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting coupon history for user " + userId, e);
            return List.of(); // Return empty list on error
        }
    }

    /**
     * Get available coupons for user
     */
    public List<UserCoupon> getAvailableCouponsForUser(int userId) {
        try {
            return userCouponDAO.getAvailableCouponsForUser(userId);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting available coupons for user " + userId, e);
            return List.of(); // Return empty list on error
        }
    }

    /**
     * Use a coupon
     */
    public boolean useCoupon(int userId, String couponCode) {
        try {
            return userCouponDAO.useCoupon(userId, couponCode);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error using coupon " + couponCode + " for user " + userId, e);
            return false;
        }
    }

    /**
     * Check if user has a specific coupon
     */
    public boolean userHasCoupon(int userId, String couponCode) {
        try {
            return userCouponDAO.userHasCoupon(userId, couponCode);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking if user " + userId + " has coupon " + couponCode, e);
            return false;
        }
    }

    /**
     * Get expired coupons
     */
    public List<UserCoupon> getExpiredCoupons() {
        try {
            return userCouponDAO.getExpiredCoupons();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting expired coupons", e);
            return List.of(); // Return empty list on error
        }
    }

    /**
     * Clean up expired coupons
     */
    public int cleanupExpiredCoupons(int daysOld) {
        try {
            return userCouponDAO.cleanupExpiredCoupons(daysOld);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error cleaning up expired coupons", e);
            return 0;
        }
    }

    /**
     * Auto-assign coupons based on user activity
     * This method can be called periodically or triggered by events
     */
    public void autoAssignCoupons(int userId, String triggerEvent) {
        logger.info("Auto-assigning coupons for user " + userId + " triggered by: " + triggerEvent);
        
        switch (triggerEvent.toLowerCase()) {
            case "registration":
                assignWelcomeCoupon(userId);
                break;
            case "birthday":
                assignBirthdayCoupon(userId);
                break;
            case "vip_upgrade":
                assignVIPCoupon(userId);
                break;
            case "comeback":
                assignComebackCoupon(userId);
                break;
            default:
                logger.info("No auto-assignment rule for trigger: " + triggerEvent);
        }
    }

    /**
     * Get coupon statistics for a user
     */
    public UserCouponStats getUserCouponStats(int userId) {
        try {
            List<UserCoupon> allCoupons = getUserCouponHistory(userId);
            
            int totalAssigned = allCoupons.size();
            int used = (int) allCoupons.stream().filter(UserCoupon::isUsed).count();
            int available = (int) allCoupons.stream().filter(UserCoupon::isAvailable).count();
            int expired = (int) allCoupons.stream().filter(UserCoupon::isExpired).count();
            
            return new UserCouponStats(totalAssigned, used, available, expired);
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting coupon stats for user " + userId, e);
            return new UserCouponStats(0, 0, 0, 0);
        }
    }

    /**
     * Inner class for coupon statistics
     */
    public static class UserCouponStats {
        private final int totalAssigned;
        private final int used;
        private final int available;
        private final int expired;

        public UserCouponStats(int totalAssigned, int used, int available, int expired) {
            this.totalAssigned = totalAssigned;
            this.used = used;
            this.available = available;
            this.expired = expired;
        }

        public int getTotalAssigned() { return totalAssigned; }
        public int getUsed() { return used; }
        public int getAvailable() { return available; }
        public int getExpired() { return expired; }
    }
}
