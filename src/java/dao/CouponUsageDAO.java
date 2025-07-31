package dao;

import config.DatabaseConfig;
import model.CouponUsage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class CouponUsageDAO {
    
    private static final Logger logger = Logger.getLogger(CouponUsageDAO.class.getName());

    /**
     * Log coupon usage when applied to an order (compatible with current database schema)
     */
    public boolean logCouponUsage(CouponUsage couponUsage) throws SQLException {
        String sql = """
            INSERT INTO CouponUsage (CouponID, OrderID, UsedDate, DiscountAmount)
            VALUES (?, ?, ?, ?)
            """;

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, couponUsage.getCouponID());
            stmt.setInt(2, couponUsage.getOrderID());
            stmt.setTimestamp(3, new Timestamp(couponUsage.getUsedDate().getTime()));
            stmt.setDouble(4, couponUsage.getDiscountAmount());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        couponUsage.setUsageID(rs.getInt(1));
                        logger.info("Logged coupon usage: Coupon ID " + couponUsage.getCouponID() +
                                  ", Order ID " + couponUsage.getOrderID());
                        return true;
                    }
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error logging coupon usage", e);
            throw e;
        }
        
        return false;
    }

    /**
     * Get coupon usage history by user (legacy method - may not work with current schema)
     */
    public List<CouponUsage> getCouponUsageByUser(int userId) throws SQLException {
        List<CouponUsage> usageList = new ArrayList<>();
        String sql = """
            SELECT cu.*, c.CouponCode, c.CouponName
            FROM CouponUsage cu
            INNER JOIN Coupons c ON cu.CouponID = c.CouponID
            WHERE cu.UserID = ?
            ORDER BY cu.UsedDate DESC
            """;

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CouponUsage usage = mapResultSetToCouponUsage(rs);
                    usageList.add(usage);
                }
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting coupon usage by user: " + userId, e);
            throw e;
        }

        return usageList;
    }

    /**
     * Get coupon usage history by user through orders (compatible with current database schema)
     */
    public List<CouponUsage> getCouponUsageByUserOrders(int userId) throws SQLException {
        List<CouponUsage> usageList = new ArrayList<>();
        String sql = """
            SELECT cu.*, c.CouponCode, c.CouponName, o.OrderNumber
            FROM CouponUsage cu
            INNER JOIN Coupons c ON cu.CouponID = c.CouponID
            INNER JOIN Orders o ON cu.OrderID = o.OrderID
            WHERE o.CustomerID = ?
            ORDER BY cu.UsedDate DESC
            """;

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CouponUsage usage = mapResultSetToCouponUsage(rs);
                    usageList.add(usage);
                }
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting coupon usage by user orders: " + userId, e);
            throw e;
        }

        return usageList;
    }

    /**
     * Get coupon usage history by order
     */
    public List<CouponUsage> getCouponUsageByOrder(int orderId) throws SQLException {
        List<CouponUsage> usageList = new ArrayList<>();
        String sql = """
            SELECT cu.*, c.CouponCode, c.CouponName
            FROM CouponUsage cu
            INNER JOIN Coupons c ON cu.CouponID = c.CouponID
            WHERE cu.OrderID = ?
            ORDER BY cu.UsedDate DESC
            """;
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CouponUsage usage = mapResultSetToCouponUsage(rs);
                    usageList.add(usage);
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting coupon usage by order: " + orderId, e);
            throw e;
        }
        
        return usageList;
    }

    /**
     * Get coupon usage count by user and coupon (compatible with current database schema)
     */
    public int getUserCouponUsageCount(int userId, int couponId) throws SQLException {
        String sql = """
            SELECT COUNT(*)
            FROM CouponUsage cu
            INNER JOIN Orders o ON cu.OrderID = o.OrderID
            WHERE o.CustomerID = ? AND cu.CouponID = ?
            """;

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, couponId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting user coupon usage count", e);
            throw e;
        }

        return 0;
    }

    /**
     * Get total discount amount for a coupon
     */
    public double getTotalDiscountByCoupon(int couponId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(DiscountAmount), 0) FROM CouponUsage WHERE CouponID = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, couponId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting total discount by coupon: " + couponId, e);
            throw e;
        }
        
        return 0.0;
    }

    /**
     * Get coupon usage statistics
     */
    public List<CouponUsageStats> getCouponUsageStats() throws SQLException {
        List<CouponUsageStats> statsList = new ArrayList<>();
        String sql = """
            SELECT 
                c.CouponID,
                c.CouponCode,
                c.CouponName,
                c.UsageLimit,
                c.UsageCount,
                COALESCE(SUM(cu.DiscountAmount), 0) as TotalDiscount,
                COUNT(cu.UsageID) as ActualUsageCount
            FROM Coupons c
            LEFT JOIN CouponUsage cu ON c.CouponID = cu.CouponID
            GROUP BY c.CouponID, c.CouponCode, c.CouponName, c.UsageLimit, c.UsageCount
            ORDER BY c.CreatedDate DESC
            """;
        
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                CouponUsageStats stats = new CouponUsageStats();
                stats.setCouponId(rs.getInt("CouponID"));
                stats.setCouponCode(rs.getString("CouponCode"));
                stats.setCouponName(rs.getString("CouponName"));
                stats.setUsageLimit(rs.getInt("UsageLimit"));
                stats.setUsageCount(rs.getInt("UsageCount"));
                stats.setTotalDiscount(rs.getDouble("TotalDiscount"));
                stats.setActualUsageCount(rs.getInt("ActualUsageCount"));
                statsList.add(stats);
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting coupon usage statistics", e);
            throw e;
        }
        
        return statsList;
    }

    /**
     * Check if user has used coupon for specific order
     */
    public boolean hasUserUsedCouponForOrder(int userId, int couponId, int orderId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM CouponUsage WHERE UserID = ? AND CouponID = ? AND OrderID = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, couponId);
            stmt.setInt(3, orderId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking if user used coupon for order", e);
            throw e;
        }
        
        return false;
    }

    /**
     * Helper method to map ResultSet to CouponUsage object (compatible with current database schema)
     */
    private CouponUsage mapResultSetToCouponUsage(ResultSet rs) throws SQLException {
        CouponUsage usage = new CouponUsage();
        usage.setUsageID(rs.getInt("UsageID"));
        usage.setCouponID(rs.getInt("CouponID"));
        // UserID is derived from Order.CustomerID, not stored directly in CouponUsage
        usage.setOrderID(rs.getInt("OrderID"));
        usage.setUsedDate(rs.getTimestamp("UsedDate"));
        usage.setDiscountAmount(rs.getDouble("DiscountAmount"));
        return usage;
    }

    /**
     * Inner class for coupon usage statistics
     */
    public static class CouponUsageStats {
        private int couponId;
        private String couponCode;
        private String couponName;
        private int usageLimit;
        private int usageCount;
        private double totalDiscount;
        private int actualUsageCount;

        // Getters and Setters
        public int getCouponId() { return couponId; }
        public void setCouponId(int couponId) { this.couponId = couponId; }

        public String getCouponCode() { return couponCode; }
        public void setCouponCode(String couponCode) { this.couponCode = couponCode; }

        public String getCouponName() { return couponName; }
        public void setCouponName(String couponName) { this.couponName = couponName; }

        public int getUsageLimit() { return usageLimit; }
        public void setUsageLimit(int usageLimit) { this.usageLimit = usageLimit; }

        public int getUsageCount() { return usageCount; }
        public void setUsageCount(int usageCount) { this.usageCount = usageCount; }

        public double getTotalDiscount() { return totalDiscount; }
        public void setTotalDiscount(double totalDiscount) { this.totalDiscount = totalDiscount; }

        public int getActualUsageCount() { return actualUsageCount; }
        public void setActualUsageCount(int actualUsageCount) { this.actualUsageCount = actualUsageCount; }

        public double getUsagePercentage() {
            return usageLimit > 0 ? (double) actualUsageCount / usageLimit * 100 : 0;
        }
    }
}