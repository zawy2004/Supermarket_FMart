package model;

import java.util.Date;

public class ImportReceipt {
    private int importID;
    private int supplierID;
    private int warehouseID;
    private Date importDate;
    private String notes;
    private String supplierName;
    private String warehouseName;
    public ImportReceipt() {}

    public ImportReceipt(int importID, int supplierID, int warehouseID, Date importDate, String notes) {
        this.importID = importID;
        this.supplierID = supplierID;
        this.warehouseID = warehouseID;
        this.importDate = importDate;
        this.notes = notes;
    }

    public int getImportID() { return importID; }
    public void setImportID(int importID) { this.importID = importID; }
    public int getSupplierID() { return supplierID; }
    public void setSupplierID(int supplierID) { this.supplierID = supplierID; }
    public int getWarehouseID() { return warehouseID; }
    public void setWarehouseID(int warehouseID) { this.warehouseID = warehouseID; }
    public Date getImportDate() { return importDate; }
    public void setImportDate(Date importDate) { this.importDate = importDate; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

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
    
}