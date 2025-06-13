package model;

import java.util.Date;

public class StockMovement {
    private int movementID;
    private int productID;
    private String movementType;
    private int quantity;
    private String reason;
    private int referenceID;
    private String referenceType;
    private Date movementDate;
    private int createdBy;
    private String notes;
    private double unitCost;

    public StockMovement() {}

    public StockMovement(int movementID, int productID, String movementType, int quantity, String reason, int referenceID, String referenceType, Date movementDate, int createdBy, String notes, double unitCost) {
        this.movementID = movementID;
        this.productID = productID;
        this.movementType = movementType;
        this.quantity = quantity;
        this.reason = reason;
        this.referenceID = referenceID;
        this.referenceType = referenceType;
        this.movementDate = movementDate;
        this.createdBy = createdBy;
        this.notes = notes;
        this.unitCost = unitCost;
    }

    public int getMovementID() { return movementID; }
    public void setMovementID(int movementID) { this.movementID = movementID; }
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }
    public String getMovementType() { return movementType; }
    public void setMovementType(String movementType) { this.movementType = movementType; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    public int getReferenceID() { return referenceID; }
    public void setReferenceID(int referenceID) { this.referenceID = referenceID; }
    public String getReferenceType() { return referenceType; }
    public void setReferenceType(String referenceType) { this.referenceType = referenceType; }
    public Date getMovementDate() { return movementDate; }
    public void setMovementDate(Date movementDate) { this.movementDate = movementDate; }
    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public double getUnitCost() { return unitCost; }
    public void setUnitCost(double unitCost) { this.unitCost = unitCost; }
}