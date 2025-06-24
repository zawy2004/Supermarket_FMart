package dao;

import model.Coupon;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CouponDAO {
    private static final String DB_URL = "jdbc:sqlserver://DESKTOP-MK7ODO2;databaseName=FmartDB;encrypt=false";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "123456";

    public int addCoupon(Coupon coupon) throws SQLException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             CallableStatement stmt = conn.prepareCall("{call sp_AddCoupon(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}")) {
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
            ResultSet rs = stmt.getResultSet();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return -1;
        }
    }

    public double applyCouponToOrder(int orderId, String couponCode, int createdBy) throws SQLException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             CallableStatement stmt = conn.prepareCall("{call sp_ApplyCouponToOrder(?, ?, ?)}")) {
            stmt.setInt(1, orderId);
            stmt.setString(2, couponCode);
            stmt.setInt(3, createdBy);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("AppliedDiscount");
            }
            return 0.0;
        }
    }

    public List<Coupon> getAllCoupons() throws SQLException {
        List<Coupon> coupons = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM Coupons")) {
            while (rs.next()) {
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
                coupons.add(coupon);
            }
        }
        return coupons;
    }
}