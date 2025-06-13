package model;

import java.util.Date;

public class Category {
    private int categoryID;
    private String categoryName;
    private String description;
    private int parentCategoryID;
    private String imageUrl;
    private boolean isActive;
    private Date createdDate;
    private int displayOrder;

    public Category() {}

    public Category(int categoryID, String categoryName, String description, int parentCategoryID, String imageUrl, boolean isActive, Date createdDate, int displayOrder) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.description = description;
        this.parentCategoryID = parentCategoryID;
        this.imageUrl = imageUrl;
        this.isActive = isActive;
        this.createdDate = createdDate;
        this.displayOrder = displayOrder;
    }

    public int getCategoryID() { return categoryID; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getParentCategoryID() { return parentCategoryID; }
    public void setParentCategoryID(int parentCategoryID) { this.parentCategoryID = parentCategoryID; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public boolean getIsActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }
}