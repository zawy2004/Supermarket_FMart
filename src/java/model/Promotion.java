package model;

import java.util.Date;

public class Promotion {
    private int promotionID;
    private String promotionName;
    private String description;
    private String promotionType;
    private double discountValue;
    private double minOrderAmount;
    private double maxDiscountAmount;
    private Date startDate;
    private Date endDate;
    private int usageLimit;
    private int usageCount;
    private boolean isActive;
    private int createdBy;
    private Date createdDate;

    public Promotion() {}

    public Promotion(int promotionID, String promotionName, String description, String promotionType, double discountValue, double minOrderAmount, double maxDiscountAmount, Date startDate, Date endDate, int usageLimit, int usageCount, boolean isActive, int createdBy, Date createdDate) {
        this.promotionID = promotionID;
        this.promotionName = promotionName;
        this.description = description;
        this.promotionType = promotionType;
        this.discountValue = discountValue;
        this.minOrderAmount = minOrderAmount;
        this.maxDiscountAmount = maxDiscountAmount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.usageLimit = usageLimit;
        this.usageCount = usageCount;
        this.isActive = isActive;
        this.createdBy = createdBy;
        this.createdDate = createdDate;
    }

    public int getPromotionID() { return promotionID; }
    public void setPromotionID(int promotionID) { this.promotionID = promotionID; }
    public String getPromotionName() { return promotionName; }
    public void setPromotionName(String promotionName) { this.promotionName = promotionName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getPromotionType() { return promotionType; }
    public void setPromotionType(String promotionType) { this.promotionType = promotionType; }
    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }
    public double getMinOrderAmount() { return minOrderAmount; }
    public void setMinOrderAmount(double minOrderAmount) { this.minOrderAmount = minOrderAmount; }
    public double getMaxDiscountAmount() { return maxDiscountAmount; }
    public void setMaxDiscountAmount(double maxDiscountAmount) { this.maxDiscountAmount = maxDiscountAmount; }
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }
    public int getUsageLimit() { return usageLimit; }
    public void setUsageLimit(int usageLimit) { this.usageLimit = usageLimit; }
    public int getUsageCount() { return usageCount; }
    public void setUsageCount(int usageCount) { this.usageCount = usageCount; }
    public boolean getIsActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
}