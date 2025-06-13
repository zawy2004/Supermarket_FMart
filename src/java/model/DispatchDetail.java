package model;

import java.util.Date;

public class DispatchDetail {
    private int dispatchDetailID;
    private int dispatchID;
    private int productID;
    private int quantity;
    private double unitCost;
    private String reason;

    public DispatchDetail() {}

    public DispatchDetail(int dispatchDetailID, int dispatchID, int productID, int quantity, double unitCost, String reason) {
        this.dispatchDetailID = dispatchDetailID;
        this.dispatchID = dispatchID;
        this.productID = productID;
        this.quantity = quantity;
        this.unitCost = unitCost;
        this.reason = reason;
    }

    public int getDispatchDetailID() { return dispatchDetailID; }
    public void setDispatchDetailID(int dispatchDetailID) { this.dispatchDetailID = dispatchDetailID; }
    public int getDispatchID() { return dispatchID; }
    public void setDispatchID(int dispatchID) { this.dispatchID = dispatchID; }
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getUnitCost() { return unitCost; }
    public void setUnitCost(double unitCost) { this.unitCost = unitCost; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
}