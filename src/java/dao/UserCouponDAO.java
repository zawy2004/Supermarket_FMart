package dao;

import config.DatabaseConfig;
import model.UserCoupon;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO class for UserCoupons table operations
 * Handles personal coupon assignments to users
 */
public class UserCouponDAO {
    
    private static final Logger logger = Logger.getLogger(UserCouponDAO.class.getName());

    /**
     * Assign a coupon to a user using stored procedure
     */
    public boolean assignCouponToUser(int userId, String couponCode, String assignedBy, String notes, int expiryDays) throws SQLException {
        String sql = "{CALL sp_AssignCouponToUser(?, ?, ?, ?, ?)}";
        
        try (Connection conn = DatabaseConfig.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, couponCode);
            stmt.setString(3, assignedBy != null ? assignedBy : "SYSTEM");
            stmt.setString(4, notes);
            stmt.setInt(5, expiryDays);
            
            boolean hasResultSet = stmt.execute();
            
            // Check if procedure executed successfully (returned result set)
            if (hasResultSet) {
                try (ResultSet rs = stmt.getResultSet()) {
                    return rs.next(); // If there's a result, assignment was successful
                }
            }
            
            return false;
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error assigning coupon to user", e);
            throw e;
        }
    }

    /**
     * Get user's coupon history using stored procedure
     */
    public List<UserCoupon> getUserCouponHistory(int userId) throws SQLException {
        List<UserCoupon> userCoupons = new ArrayList<>();
        String sql = "{CALL sp_GetUserCouponHistory(?)}";
        
        try (Connection conn = DatabaseConfig.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    UserCoupon userCoupon = mapResultSetToUserCoupon(rs);
                    userCoupons.add(userCoupon);
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting user coupon history", e);
            throw e;
        }
        
        return userCoupons;
    }

    /**
     * Get available coupons for a user
     */
    public List<UserCoupon> getAvailableCouponsForUser(int userId) throws SQLException {
        List<UserCoupon> availableCoupons = new ArrayList<>();
        String sql = """
            SELECT uc.UserCouponID, uc.UserID, uc.CouponID, uc.AssignedDate, 
                   uc.IsUsed, uc.UsedDate, uc.ExpiryDate, uc.AssignedBy, uc.Notes,
                   c.CouponCode, c.CouponName, c.DiscountType, c.DiscountValue,
                   u.FullName as UserFullName, u.Email as UserEmail
            FROM UserCoupons uc
            INNER JOIN Coupons c ON uc.CouponID = c.CouponID
            INNER JOIN Users u ON uc.UserID = u.UserID
            WHERE uc.UserID = ? 
            AND uc.IsUsed = 0 
            AND c.IsActive = 1
            AND (uc.ExpiryDate IS NULL OR uc.ExpiryDate > GETDATE())
            ORDER BY uc.AssignedDate DESC
            """;
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    UserCoupon userCoupon = mapResultSetToUserCoupon(rs);
                    availableCoupons.add(userCoupon);
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting available coupons for user", e);
            throw e;
        }
        
        return availableCoupons;
    }

    /**
     * Use a coupon - INTEGRATED VERSION
     * This method is now mainly for standalone personal coupon usage
     * For order-based usage, use CouponDAO.applyCouponToOrder instead
     */
    public boolean useCoupon(int userId, String couponCode) throws SQLException {
        String sql = """
            UPDATE uc SET IsUsed = 1, UsedDate = GETDATE()
            FROM UserCoupons uc
            INNER JOIN Coupons c ON uc.CouponID = c.CouponID
            WHERE uc.UserID = ? AND c.CouponCode = ?
            AND uc.IsUsed = 0
            AND c.IsActive = 1
            AND (uc.ExpiryDate IS NULL OR uc.ExpiryDate > GETDATE())
            """;

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, couponCode);

            int updated = stmt.executeUpdate();

            if (updated > 0) {
                logger.info("Personal coupon " + couponCode + " marked as used for user " + userId);
                return true;
            }

            return false;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error using coupon", e);
            throw e;
        }
    }

    /**
     * Check if user has a specific coupon (unused)
     */
    public boolean userHasCoupon(int userId, String couponCode) throws SQLException {
        String sql = """
            SELECT 1 FROM UserCoupons uc
            INNER JOIN Coupons c ON uc.CouponID = c.CouponID
            WHERE uc.UserID = ? AND c.CouponCode = ? 
            AND uc.IsUsed = 0 
            AND (uc.ExpiryDate IS NULL OR uc.ExpiryDate > GETDATE())
            """;
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, couponCode);
            
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking if user has coupon", e);
            throw e;
        }
    }

    /**
     * Get expired coupons using stored procedure
     */
    public List<UserCoupon> getExpiredCoupons() throws SQLException {
        List<UserCoupon> expiredCoupons = new ArrayList<>();
        String sql = "{CALL sp_GetExpiredCoupons}";
        
        try (Connection conn = DatabaseConfig.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    UserCoupon userCoupon = new UserCoupon();
                    userCoupon.setUserCouponId(rs.getInt("UserCouponID"));
                    userCoupon.setUserFullName(rs.getString("FullName"));
                    userCoupon.setUserEmail(rs.getString("Email"));
                    userCoupon.setCouponCode(rs.getString("CouponCode"));
                    userCoupon.setCouponName(rs.getString("CouponName"));
                    userCoupon.setAssignedDate(rs.getTimestamp("AssignedDate"));
                    userCoupon.setExpiryDate(rs.getTimestamp("ExpiryDate"));
                    
                    expiredCoupons.add(userCoupon);
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting expired coupons", e);
            throw e;
        }
        
        return expiredCoupons;
    }

    /**
     * Clean up expired coupons using stored procedure
     */
    public int cleanupExpiredCoupons(int daysOld) throws SQLException {
        String sql = "{CALL sp_CleanupExpiredCoupons(?)}";
        
        try (Connection conn = DatabaseConfig.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            
            stmt.setInt(1, daysOld);
            stmt.execute();
            
            // Return value would need to be captured from procedure output
            // For now, return 0 as placeholder
            return 0;
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error cleaning up expired coupons", e);
            throw e;
        }
    }

    /**
     * Map ResultSet to UserCoupon object
     */
    private UserCoupon mapResultSetToUserCoupon(ResultSet rs) throws SQLException {
        UserCoupon userCoupon = new UserCoupon();
        
        userCoupon.setUserCouponId(rs.getInt("UserCouponID"));
        userCoupon.setUserId(rs.getInt("UserID"));
        userCoupon.setCouponId(rs.getInt("CouponID"));
        userCoupon.setAssignedDate(rs.getTimestamp("AssignedDate"));
        userCoupon.setUsed(rs.getBoolean("IsUsed"));
        userCoupon.setUsedDate(rs.getTimestamp("UsedDate"));
        userCoupon.setExpiryDate(rs.getTimestamp("ExpiryDate"));
        userCoupon.setAssignedBy(rs.getString("AssignedBy"));
        userCoupon.setNotes(rs.getString("Notes"));
        
        // Additional fields if available
        try {
            userCoupon.setCouponCode(rs.getString("CouponCode"));
            userCoupon.setCouponName(rs.getString("CouponName"));
            userCoupon.setDiscountType(rs.getString("DiscountType"));
            userCoupon.setDiscountValue(rs.getDouble("DiscountValue"));
            userCoupon.setUserFullName(rs.getString("UserFullName"));
            userCoupon.setUserEmail(rs.getString("UserEmail"));
        } catch (SQLException e) {
            // These fields might not be available in all queries
        }
        
        return userCoupon;
    }
}
