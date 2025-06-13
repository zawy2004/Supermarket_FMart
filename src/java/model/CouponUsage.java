package model;

import java.util.Date;

public class CouponUsage {
    private int usageID;
    private int couponID;
    private int userID;
    private int orderID;
    private Date usedDate;
    private double discountAmount;

    public CouponUsage() {}

    public CouponUsage(int usageID, int couponID, int userID, int orderID, Date usedDate, double discountAmount) {
        this.usageID = usageID;
        this.couponID = couponID;
        this.userID = userID;
        this.orderID = orderID;
        this.usedDate = usedDate;
        this.discountAmount = discountAmount;
    }

    public int getUsageID() { return usageID; }
    public void setUsageID(int usageID) { this.usageID = usageID; }
    public int getCouponID() { return couponID; }
    public void setCouponID(int couponID) { this.couponID = couponID; }
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }
    public int getOrderID() { return orderID; }
    public void setOrderID(int orderID) { this.orderID = orderID; }
    public Date getUsedDate() { return usedDate; }
    public void setUsedDate(Date usedDate) { this.usedDate = usedDate; }
    public double getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(double discountAmount) { this.discountAmount = discountAmount; }
}