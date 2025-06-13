package model;

import java.util.Date;

public class ShoppingCart {
    private int cartID;
    private int userID;
    private int productID;
    private int quantity;
    private Date addedDate;

    public ShoppingCart() {}

    public ShoppingCart(int cartID, int userID, int productID, int quantity, Date addedDate) {
        this.cartID = cartID;
        this.userID = userID;
        this.productID = productID;
        this.quantity = quantity;
        this.addedDate = addedDate;
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