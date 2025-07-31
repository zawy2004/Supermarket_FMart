package dao;

import config.DatabaseConfig;
import model.Coupon;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class CouponDAO {
    
    private static final Logger logger = Logger.getLogger(CouponDAO.class.getName());


    public int addCoupon(Coupon coupon) throws SQLException {
        String sql = "{call sp_AddCoupon(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        
        try (Connection conn = DatabaseConfig.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
            
            stmt.setString(1, coupon.getCouponCode());
            stmt.setString(2, coupon.getCouponName());
            stmt.setString(3, coupon.getDescription());
            stmt.setString(4, coupon.getDiscountType());
            stmt.setDouble(5, coupon.getDiscountValue());
            stmt.setDouble(6, coupon.getMinOrderAmount());
            stmt.setDouble(7, coupon.getMaxDiscountAmount());
            stmt.setInt(8, coupon.getUsageLimit());
            stmt.setInt(9, coupon.getOrderLimit());
            stmt.setDate(10, coupon.getStartDate());
            stmt.setDate(11, coupon.getEndDate());
            stmt.setInt(12, coupon.getCreatedBy());
            
            stmt.execute();
            
            try (ResultSet rs = stmt.getResultSet()) {
                if (rs.next()) {
                    int couponId = rs.getInt(1);
                    logger.info("Created coupon with ID: " + couponId + ", Code: " + coupon.getCouponCode());
                    return couponId;
                }
            }
            
            return -1;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error adding coupon: " + coupon.getCouponCode(), e);
            throw e;
        }
    }

  
    public List<Coupon> getAllCoupons() throws SQLException {
        List<Coupon> coupons = new ArrayList<>();
        String sql = "SELECT * FROM Coupons ORDER BY CreatedDate DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                coupons.add(mapResultSetToCoupon(rs));
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting all coupons", e);
            throw e;
        }
        
        return coupons;
    }

    /**
     * Get active coupons for customers
     */
    public List<Coupon> getActiveCoupons() throws SQLException {
        List<Coupon> coupons = new ArrayList<>();
        String sql = """
            SELECT * FROM Coupons 
            WHERE IsActive = 1 
            AND StartDate <= GETDATE() 
            AND EndDate >= GETDATE()
            AND UsageCount < UsageLimit
            ORDER BY CreatedDate DESC
            """;
        
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                coupons.add(mapResultSetToCoupon(rs));
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting active coupons", e);
            throw e;
        }
        
        return coupons;
    }

    /**
     * Get coupon by code
     */
    public Coupon getCouponByCode(String couponCode) throws SQLException {
        String sql = "SELECT * FROM Coupons WHERE CouponCode = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, couponCode);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCoupon(rs);
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting coupon by code: " + couponCode, e);
            throw e;
        }
        
        return null;
    }

    public Coupon getCouponById(int couponId) throws SQLException {
        String sql = "SELECT * FROM Coupons WHERE CouponID = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, couponId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCoupon(rs);
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting coupon by ID: " + couponId, e);
            throw e;
        }
        
        return null;
    }

    /**
     * Check if coupon code exists
     */
    public boolean couponCodeExists(String couponCode) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Coupons WHERE CouponCode = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, couponCode);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking coupon code existence: " + couponCode, e);
            throw e;
        }
        
        return false;
    }

    /**
     * Update coupon usage count
     */
    public boolean incrementUsageCount(int couponId) throws SQLException {
        String sql = "UPDATE Coupons SET UsageCount = UsageCount + 1 WHERE CouponID = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, couponId);
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                logger.info("Incremented usage count for coupon ID: " + couponId);
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error incrementing usage count for coupon ID: " + couponId, e);
            throw e;
        }
        
        return false;
    }

    public boolean updateCouponStatus(int couponId, boolean isActive) throws SQLException {
        String sql = "UPDATE Coupons SET IsActive = ? WHERE CouponID = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setBoolean(1, isActive);
            stmt.setInt(2, couponId);
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                logger.info("Updated status for coupon ID: " + couponId + " to " + isActive);
                return true;
            }
            
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating status for coupon ID: " + couponId, e);
            throw e;
        }
        
        return false;
    }

 
    public double applyCouponToOrder(int orderId, String couponCode, int createdBy) throws SQLException {
        String sql = "{call sp_ApplyCouponToOrder(?, ?, ?)}";

        try (Connection conn = DatabaseConfig.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setInt(1, orderId);
            stmt.setString(2, couponCode);
            stmt.setInt(3, createdBy);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    double discount = rs.getDouble("AppliedDiscount");
                    logger.info("Applied coupon " + couponCode + " to order " + orderId + ", discount: " + discount);
                    return discount;
                }
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error applying coupon to order. Order: " + orderId + ", Coupon: " + couponCode, e);
            throw e;
        }

        return 0.0;
    }

    /**
     * Get user's usage count for a specific coupon
     */
    public int getUserCouponUsageCount(int couponId, int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM CouponUsage WHERE CouponID = ? AND UserID = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, couponId);
            stmt.setInt(2, userId);
            
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
     * Tìm kiếm coupon với phân trang
     */
    public List<Coupon> searchCoupons(String keyword, String statusFilter, String typeFilter, int offset, int limit) throws SQLException {
        List<Coupon> coupons = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Coupons WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (CouponCode LIKE ? OR CouponName LIKE ? OR Description LIKE ?)");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            if ("active".equals(statusFilter)) {
                sql.append(" AND IsActive = 1");
            } else if ("inactive".equals(statusFilter)) {
                sql.append(" AND IsActive = 0");
            } else if ("expired".equals(statusFilter)) {
                sql.append(" AND EndDate < GETDATE()");
            } else if ("valid".equals(statusFilter)) {
                sql.append(" AND IsActive = 1 AND StartDate <= GETDATE() AND EndDate >= GETDATE()");
            }
        }

        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append(" AND DiscountType = ?");
            params.add(typeFilter);
        }

        sql.append(" ORDER BY CreatedDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    coupons.add(mapResultSetToCoupon(rs));
                }
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error searching coupons", e);
            throw e;
        }

        return coupons;
    }

    /**
     * Đếm số lượng coupon theo điều kiện tìm kiếm
     */
    public int countSearchCoupons(String keyword, String statusFilter, String typeFilter) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Coupons WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm (giống như searchCoupons)
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (CouponCode LIKE ? OR CouponName LIKE ? OR Description LIKE ?)");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            if ("active".equals(statusFilter)) {
                sql.append(" AND IsActive = 1");
            } else if ("inactive".equals(statusFilter)) {
                sql.append(" AND IsActive = 0");
            } else if ("expired".equals(statusFilter)) {
                sql.append(" AND EndDate < GETDATE()");
            } else if ("valid".equals(statusFilter)) {
                sql.append(" AND IsActive = 1 AND StartDate <= GETDATE() AND EndDate >= GETDATE()");
            }
        }

        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append(" AND DiscountType = ?");
            params.add(typeFilter);
        }

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error counting search coupons", e);
            throw e;
        }

        return 0;
    }

    /**
     * Cập nhật thông tin coupon
     */
    public boolean updateCoupon(Coupon coupon) throws SQLException {
        String sql = """
            UPDATE Coupons SET
                CouponCode = ?, CouponName = ?, Description = ?,
                DiscountType = ?, DiscountValue = ?, MinOrderAmount = ?,
                MaxDiscountAmount = ?, UsageLimit = ?, OrderLimit = ?,
                StartDate = ?, EndDate = ?
            WHERE CouponID = ?
            """;

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, coupon.getCouponCode());
            stmt.setString(2, coupon.getCouponName());
            stmt.setString(3, coupon.getDescription());
            stmt.setString(4, coupon.getDiscountType());
            stmt.setDouble(5, coupon.getDiscountValue());
            stmt.setDouble(6, coupon.getMinOrderAmount());
            stmt.setDouble(7, coupon.getMaxDiscountAmount());
            stmt.setInt(8, coupon.getUsageLimit());
            stmt.setInt(9, coupon.getOrderLimit());
            stmt.setDate(10, coupon.getStartDate());
            stmt.setDate(11, coupon.getEndDate());
            stmt.setInt(12, coupon.getCouponId());

            int rowsAffected = stmt.executeUpdate();
            boolean success = rowsAffected > 0;

            if (success) {
                logger.info("Updated coupon with ID: " + coupon.getCouponId());
            }

            return success;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating coupon: " + coupon.getCouponId(), e);
            throw e;
        }
    }

    /**
     * Xóa coupon (soft delete - chỉ set IsActive = false)
     */
    public boolean deleteCoupon(int couponId) throws SQLException {
        String sql = "UPDATE Coupons SET IsActive = 0 WHERE CouponID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, couponId);

            int rowsAffected = stmt.executeUpdate();
            boolean success = rowsAffected > 0;

            if (success) {
                logger.info("Soft deleted coupon with ID: " + couponId);
            }

            return success;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting coupon: " + couponId, e);
            throw e;
        }
    }

    /**
     * Xóa coupon vĩnh viễn (hard delete)
     */
    public boolean hardDeleteCoupon(int couponId) throws SQLException {
        String sql = "DELETE FROM Coupons WHERE CouponID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, couponId);

            int rowsAffected = stmt.executeUpdate();
            boolean success = rowsAffected > 0;

            if (success) {
                logger.info("Hard deleted coupon with ID: " + couponId);
            }

            return success;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error hard deleting coupon: " + couponId, e);
            throw e;
        }
    }

    private Coupon mapResultSetToCoupon(ResultSet rs) throws SQLException {
        Coupon coupon = new Coupon();
        coupon.setCouponId(rs.getInt("CouponID"));
        coupon.setCouponCode(rs.getString("CouponCode"));
        coupon.setCouponName(rs.getString("CouponName"));
        coupon.setDescription(rs.getString("Description"));
        coupon.setDiscountType(rs.getString("DiscountType"));
        coupon.setDiscountValue(rs.getDouble("DiscountValue"));
        coupon.setMinOrderAmount(rs.getDouble("MinOrderAmount"));
        coupon.setMaxDiscountAmount(rs.getDouble("MaxDiscountAmount"));
        coupon.setUsageLimit(rs.getInt("UsageLimit"));
        coupon.setUsageCount(rs.getInt("UsageCount"));
        coupon.setOrderLimit(rs.getInt("OrderLimit"));
        coupon.setStartDate(rs.getDate("StartDate"));
        coupon.setEndDate(rs.getDate("EndDate"));
        coupon.setActive(rs.getBoolean("IsActive"));
        coupon.setCreatedBy(rs.getInt("CreatedBy"));
        coupon.setCreatedDate(rs.getDate("CreatedDate"));
        return coupon;
    }
}