package model;

import java.util.Date;

public class ImportDetail {
    private int importDetailID;
    private int importID;
    private int productID;
    private int quantity;
    private double unitPrice;

    public ImportDetail() {}

    public ImportDetail(int importDetailID, int importID, int productID, int quantity, double unitPrice) {
        this.importDetailID = importDetailID;
        this.importID = importID;
        this.productID = productID;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public int getImportDetailID() { return importDetailID; }
    public void setImportDetailID(int importDetailID) { this.importDetailID = importDetailID; }
    public int getImportID() { return importID; }
    public void setImportID(int importID) { this.importID = importID; }
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }
}