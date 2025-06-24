package service;

import dao.CouponDAO;
import model.Coupon;

import java.sql.SQLException;
import java.util.List;

public class CouponService {
    private CouponDAO couponDAO = new CouponDAO();

    public int createCoupon(Coupon coupon) throws SQLException {
        return couponDAO.addCoupon(coupon);
    }

    public double applyCouponToOrder(int orderId, String couponCode, int createdBy) throws SQLException {
        return couponDAO.applyCouponToOrder(orderId, couponCode, createdBy);
    }

    public List<Coupon> getAllCoupons() throws SQLException {
        return couponDAO.getAllCoupons();
    }
}