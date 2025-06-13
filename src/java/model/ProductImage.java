package model;

import java.util.Date;

public class ProductImage {
    private int imageID;
    private int productID;
    private String imageUrl;
    private String altText;
    private boolean isMainImage;
    private int displayOrder;
    private Date createdDate;

    public ProductImage() {}

    public ProductImage(int imageID, int productID, String imageUrl, String altText, boolean isMainImage, int displayOrder, Date createdDate) {
        this.imageID = imageID;
        this.productID = productID;
        this.imageUrl = imageUrl;
        this.altText = altText;
        this.isMainImage = isMainImage;
        this.displayOrder = displayOrder;
        this.createdDate = createdDate;
    }

    public int getImageID() { return imageID; }
    public void setImageID(int imageID) { this.imageID = imageID; }
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getAltText() { return altText; }
    public void setAltText(String altText) { this.altText = altText; }
    public boolean getIsMainImage() { return isMainImage; }
    public void setIsMainImage(boolean isMainImage) { this.isMainImage = isMainImage; }
    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
}