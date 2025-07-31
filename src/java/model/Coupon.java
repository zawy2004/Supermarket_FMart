package model;

import java.sql.Date;

public class Coupon {
    private int couponId;
    private String couponCode;
    private String couponName;
    private String description;
    private String discountType; // "Percentage" hoặc "Fixed"
    private double discountValue;
    private double minOrderAmount;
    private double maxDiscountAmount;
    private int usageLimit;
    private int usageCount;
    private int orderLimit; // Giới hạn số đơn hàng mỗi user có thể dùng
    private Date startDate;
    private Date endDate;
    private boolean isActive;
    private int createdBy;
    private Date createdDate;

    // Constructors
    public Coupon() {
        this.isActive = true;
        this.usageCount = 0;
    }

    public Coupon(String couponCode, String couponName, String description, 
                  String discountType, double discountValue, double minOrderAmount, 
                  double maxDiscountAmount, int usageLimit, int orderLimit, 
                  Date startDate, Date endDate, int createdBy) {
        this();
        this.couponCode = couponCode;
        this.couponName = couponName;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.minOrderAmount = minOrderAmount;
        this.maxDiscountAmount = maxDiscountAmount;
        this.usageLimit = usageLimit;
        this.orderLimit = orderLimit;
        this.startDate = startDate;
        this.endDate = endDate;
        this.createdBy = createdBy;
        this.createdDate = new Date(System.currentTimeMillis());
    }

    // Getters and Setters
    public int getCouponId() { return couponId; }
    public void setCouponId(int couponId) { this.couponId = couponId; }

    public String getCouponCode() { return couponCode; }
    public void setCouponCode(String couponCode) { 
        this.couponCode = couponCode != null ? couponCode.toUpperCase().trim() : null; 
    }

    public String getCouponName() { return couponName; }
    public void setCouponName(String couponName) { this.couponName = couponName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public double getMinOrderAmount() { return minOrderAmount; }
    public void setMinOrderAmount(double minOrderAmount) { this.minOrderAmount = minOrderAmount; }

    public double getMaxDiscountAmount() { return maxDiscountAmount; }
    public void setMaxDiscountAmount(double maxDiscountAmount) { this.maxDiscountAmount = maxDiscountAmount; }

    public int getUsageLimit() { return usageLimit; }
    public void setUsageLimit(int usageLimit) { this.usageLimit = usageLimit; }

    public int getUsageCount() { return usageCount; }
    public void setUsageCount(int usageCount) { this.usageCount = usageCount; }

    public int getOrderLimit() { return orderLimit; }
    public void setOrderLimit(int orderLimit) { this.orderLimit = orderLimit; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    // Business methods
    public boolean isExpired() {
        Date now = new Date(System.currentTimeMillis());
        return now.after(this.endDate);
    }

    public boolean isStarted() {
        Date now = new Date(System.currentTimeMillis());
        return now.after(this.startDate) || now.equals(this.startDate);
    }

    public boolean isValid() {
        return isActive && isStarted() && !isExpired() && usageCount < usageLimit;
    }

    public double calculateDiscount(double orderAmount) {
        if (!isValid() || orderAmount < minOrderAmount) {
            return 0.0;
        }

        double discount;
        if ("Percentage".equals(discountType)) {
            discount = orderAmount * (discountValue / 100.0);
        } else {
            discount = discountValue;
        }

        // Apply max discount limit
        if (maxDiscountAmount > 0 && discount > maxDiscountAmount) {
            discount = maxDiscountAmount;
        }

        return discount;
    }

    @Override
    public String toString() {
        return "Coupon{" +
                "couponId=" + couponId +
                ", couponCode='" + couponCode + '\'' +
                ", couponName='" + couponName + '\'' +
                ", discountType='" + discountType + '\'' +
                ", discountValue=" + discountValue +
                ", isActive=" + isActive +
                '}';
    }
}