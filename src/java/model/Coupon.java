package model;

<<<<<<< Updated upstream
import java.util.Date;

public class Coupon {
    private int couponID;
=======
import java.sql.Date;

public class Coupon {
    private int couponId;
>>>>>>> Stashed changes
    private String couponCode;
    private String couponName;
    private String description;
    private String discountType;
    private double discountValue;
    private double minOrderAmount;
    private double maxDiscountAmount;
    private int usageLimit;
    private int usageCount;
<<<<<<< Updated upstream
    private int userLimit;
=======
    private int orderLimit;
>>>>>>> Stashed changes
    private Date startDate;
    private Date endDate;
    private boolean isActive;
    private int createdBy;
    private Date createdDate;

<<<<<<< Updated upstream
    public Coupon() {}

    public Coupon(int couponID, String couponCode, String couponName, String description, String discountType, double discountValue, double minOrderAmount, double maxDiscountAmount, int usageLimit, int usageCount, int userLimit, Date startDate, Date endDate, boolean isActive, int createdBy, Date createdDate) {
        this.couponID = couponID;
=======
    // Constructors
    public Coupon() {}

    public Coupon(String couponCode, String couponName, String description, String discountType, double discountValue,
                  double minOrderAmount, double maxDiscountAmount, int usageLimit, int orderLimit, Date startDate,
                  Date endDate, int createdBy) {
>>>>>>> Stashed changes
        this.couponCode = couponCode;
        this.couponName = couponName;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.minOrderAmount = minOrderAmount;
        this.maxDiscountAmount = maxDiscountAmount;
        this.usageLimit = usageLimit;
<<<<<<< Updated upstream
        this.usageCount = usageCount;
        this.userLimit = userLimit;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isActive = isActive;
        this.createdBy = createdBy;
        this.createdDate = createdDate;
    }

    public int getCouponID() { return couponID; }
    public void setCouponID(int couponID) { this.couponID = couponID; }
=======
        this.orderLimit = orderLimit;
        this.startDate = startDate;
        this.endDate = endDate;
        this.createdBy = createdBy;
        this.isActive = true;
    }

    // Getters and Setters
    public int getCouponId() { return couponId; }
    public void setCouponId(int couponId) { this.couponId = couponId; }
>>>>>>> Stashed changes
    public String getCouponCode() { return couponCode; }
    public void setCouponCode(String couponCode) { this.couponCode = couponCode; }
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
<<<<<<< Updated upstream
    public int getUserLimit() { return userLimit; }
    public void setUserLimit(int userLimit) { this.userLimit = userLimit; }
=======
    public int getOrderLimit() { return orderLimit; }
    public void setOrderLimit(int orderLimit) { this.orderLimit = orderLimit; }
>>>>>>> Stashed changes
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }
<<<<<<< Updated upstream
    public boolean getIsActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
=======
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
>>>>>>> Stashed changes
    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
}