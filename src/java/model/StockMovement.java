package model;

import java.math.BigDecimal;
import java.util.Date;

public class StockMovement {
    private int movementID;
    private int productID;
    private String movementType; // 'IN' hoặc 'OUT'
    private int quantity;
    private String reason;
    private int referenceID;
    private String referenceType;
    private Date movementDate;
    private BigDecimal unitCost;
    private int createdBy;

    public StockMovement(int movementID, int productID, String movementType, int quantity, String reason, int referenceID, String referenceType, Date movementDate, BigDecimal unitCost, int createdBy) {
        this.movementID = movementID;
        this.productID = productID;
        this.movementType = movementType;
        this.quantity = quantity;
        this.reason = reason;
        this.referenceID = referenceID;
        this.referenceType = referenceType;
        this.movementDate = movementDate;
        this.unitCost = unitCost;
        this.createdBy = createdBy;
    }

    // Getters và setters
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
    public BigDecimal getUnitCost() { return unitCost; }
    public void setUnitCost(BigDecimal unitCost) { this.unitCost = unitCost; }
    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }
}
