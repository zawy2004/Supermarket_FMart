
package model;

import java.util.Date;

public class Wishlist {
    private int wishlistID;
    private int userID;
    private int productID;
    private Date addedDate;

    // Constructor
    public Wishlist() {
        this.addedDate = new Date(); // Khởi tạo mặc định
    }

    // Getters and Setters
    public int getWishlistID() {
        return wishlistID;
    }

    public void setWishlistID(int wishlistID) {
        this.wishlistID = wishlistID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public Date getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Date addedDate) {
        this.addedDate = addedDate != null ? addedDate : new Date();
    }
}
