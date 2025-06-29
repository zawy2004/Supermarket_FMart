package model;

import java.util.Date;

public class ShoppingCart {
    private int cartID;
    private int userID;
    private int productID;
    private int quantity;
    private Date addedDate;
    private String unit;
    
    private String productName;
    private double sellingPrice;
    private double costPrice;

    public ShoppingCart() {}

    public ShoppingCart(int cartID, int userID, int productID, int quantity, Date addedDate) {
        this.cartID = cartID;
        this.userID = userID;
        this.productID = productID;
        this.quantity = quantity;
        this.addedDate = addedDate;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getSellingPrice() {
        return sellingPrice;
    }

    public void setSellingPrice(double sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public double getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(double costPrice) {
        this.costPrice = costPrice;
    }
    

    public int getCartID() { return cartID; }
    public void setCartID(int cartID) { this.cartID = cartID; }
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public Date getAddedDate() { return addedDate; }
    public void setAddedDate(Date addedDate) { this.addedDate = addedDate; }
}