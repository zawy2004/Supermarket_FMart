package model;

import java.util.Date;

public class DispatchReceipt {
    private int dispatchID;
    private int warehouseID;
    private Date dispatchDate;
    private String dispatchType;
    private int createdBy;
    private String reference;
    private String notes;
    private String supplierName;
    private String warehouseName;

    public DispatchReceipt() {}

    public DispatchReceipt(int dispatchID, int warehouseID, Date dispatchDate, String dispatchType, int createdBy, String reference, String notes) {
        this.dispatchID = dispatchID;
        this.warehouseID = warehouseID;
        this.dispatchDate = dispatchDate;
        this.dispatchType = dispatchType;
        this.createdBy = createdBy;
        this.reference = reference;
        this.notes = notes;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public int getDispatchID() { return dispatchID; }
    public void setDispatchID(int dispatchID) { this.dispatchID = dispatchID; }
    public int getWarehouseID() { return warehouseID; }
    public void setWarehouseID(int warehouseID) { this.warehouseID = warehouseID; }
    public Date getDispatchDate() { return dispatchDate; }
    public void setDispatchDate(Date dispatchDate) { this.dispatchDate = dispatchDate; }
    public String getDispatchType() { return dispatchType; }
    public void setDispatchType(String dispatchType) { this.dispatchType = dispatchType; }
    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }
    public String getReference() { return reference; }
    public void setReference(String reference) { this.reference = reference; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}