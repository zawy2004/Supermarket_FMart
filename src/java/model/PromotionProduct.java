package model;

import java.util.Date;

public class PromotionProduct {
    private int promotionProductID;
    private int promotionID;
    private int productID;
    private int categoryID;

    public PromotionProduct() {}

    public PromotionProduct(int promotionProductID, int promotionID, int productID, int categoryID) {
        this.promotionProductID = promotionProductID;
        this.promotionID = promotionID;
        this.productID = productID;
        this.categoryID = categoryID;
    }

    public int getPromotionProductID() { return promotionProductID; }
    public void setPromotionProductID(int promotionProductID) { this.promotionProductID = promotionProductID; }
    public int getPromotionID() { return promotionID; }
    public void setPromotionID(int promotionID) { this.promotionID = promotionID; }
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }
    public int getCategoryID() { return categoryID; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }
}