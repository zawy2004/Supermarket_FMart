package model;

import java.sql.Timestamp;

/**
 * Model class for UserCoupons table
 * Represents personal coupon assignments to users
 */
public class UserCoupon {
    private int userCouponId;
    private int userId;
    private int couponId;
    private Timestamp assignedDate;
    private boolean isUsed;
    private Timestamp usedDate;
    private Timestamp expiryDate;
    private String assignedBy;
    private String notes;
    
    // Additional fields for joined queries
    private String couponCode;
    private String couponName;
    private String discountType;
    private double discountValue;
    private String userFullName;
    private String userEmail;

    // Constructors
    public UserCoupon() {
        this.isUsed = false;
        this.assignedDate = new Timestamp(System.currentTimeMillis());
    }

    public UserCoupon(int userId, int couponId, String assignedBy, String notes, Timestamp expiryDate) {
        this();
        this.userId = userId;
        this.couponId = couponId;
        this.assignedBy = assignedBy;
        this.notes = notes;
        this.expiryDate = expiryDate;
    }

    // Getters and Setters
    public int getUserCouponId() {
        return userCouponId;
    }

    public void setUserCouponId(int userCouponId) {
        this.userCouponId = userCouponId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCouponId() {
        return couponId;
    }

    public void setCouponId(int couponId) {
        this.couponId = couponId;
    }

    public Timestamp getAssignedDate() {
        return assignedDate;
    }

    public void setAssignedDate(Timestamp assignedDate) {
        this.assignedDate = assignedDate;
    }

    public boolean isUsed() {
        return isUsed;
    }

    public void setUsed(boolean used) {
        isUsed = used;
    }

    public Timestamp getUsedDate() {
        return usedDate;
    }

    public void setUsedDate(Timestamp usedDate) {
        this.usedDate = usedDate;
    }

    public Timestamp getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Timestamp expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getAssignedBy() {
        return assignedBy;
    }

    public void setAssignedBy(String assignedBy) {
        this.assignedBy = assignedBy;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    // Additional fields getters/setters
    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public String getUserFullName() {
        return userFullName;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    // Utility methods
    public boolean isExpired() {
        if (expiryDate == null) {
            return false;
        }
        return expiryDate.before(new Timestamp(System.currentTimeMillis()));
    }

    public boolean isAvailable() {
        return !isUsed && !isExpired();
    }

    public String getStatus() {
        if (isUsed) {
            return "Used";
        } else if (isExpired()) {
            return "Expired";
        } else {
            return "Available";
        }
    }

    @Override
    public String toString() {
        return "UserCoupon{" +
                "userCouponId=" + userCouponId +
                ", userId=" + userId +
                ", couponId=" + couponId +
                ", assignedDate=" + assignedDate +
                ", isUsed=" + isUsed +
                ", usedDate=" + usedDate +
                ", expiryDate=" + expiryDate +
                ", assignedBy='" + assignedBy + '\'' +
                ", notes='" + notes + '\'' +
                ", couponCode='" + couponCode + '\'' +
                ", couponName='" + couponName + '\'' +
                '}';
    }
}
