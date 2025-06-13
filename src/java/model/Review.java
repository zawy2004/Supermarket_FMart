package model;

import java.util.Date;

public class Review {
    private int reviewID;
    private int productID;
    private int userID;
    private int orderID;
    private int rating;
    private String reviewTitle;
    private String reviewContent;
    private boolean isVerifiedPurchase;
    private boolean isApproved;
    private Date createdDate;
    private int approvedBy;
    private Date approvedDate;

    public Review() {}

    public Review(int reviewID, int productID, int userID, int orderID, int rating, String reviewTitle, String reviewContent, boolean isVerifiedPurchase, boolean isApproved, Date createdDate, int approvedBy, Date approvedDate) {
        this.reviewID = reviewID;
        this.productID = productID;
        this.userID = userID;
        this.orderID = orderID;
        this.rating = rating;
        this.reviewTitle = reviewTitle;
        this.reviewContent = reviewContent;
        this.isVerifiedPurchase = isVerifiedPurchase;
        this.isApproved = isApproved;
        this.createdDate = createdDate;
        this.approvedBy = approvedBy;
        this.approvedDate = approvedDate;
    }

    public int getReviewID() { return reviewID; }
    public void setReviewID(int reviewID) { this.reviewID = reviewID; }
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }
    public int getOrderID() { return orderID; }
    public void setOrderID(int orderID) { this.orderID = orderID; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getReviewTitle() { return reviewTitle; }
    public void setReviewTitle(String reviewTitle) { this.reviewTitle = reviewTitle; }
    public String getReviewContent() { return reviewContent; }
    public void setReviewContent(String reviewContent) { this.reviewContent = reviewContent; }
    public boolean getIsVerifiedPurchase() { return isVerifiedPurchase; }
    public void setIsVerifiedPurchase(boolean isVerifiedPurchase) { this.isVerifiedPurchase = isVerifiedPurchase; }
    public boolean getIsApproved() { return isApproved; }
    public void setIsApproved(boolean isApproved) { this.isApproved = isApproved; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    public int getApprovedBy() { return approvedBy; }
    public void setApprovedBy(int approvedBy) { this.approvedBy = approvedBy; }
    public Date getApprovedDate() { return approvedDate; }
    public void setApprovedDate(Date approvedDate) { this.approvedDate = approvedDate; }
}