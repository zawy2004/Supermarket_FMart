package model;

import java.util.Date;

public class Inventory {
    private int inventoryID;
    private int productID;
    private int warehouseID;
    private int currentStock;
    private int reservedStock;
    private Date lastStockUpdate;
    private String location;

    public Inventory() {}

    public Inventory(int inventoryID, int productID, int warehouseID, int currentStock, int reservedStock, Date lastStockUpdate, String location) {
        this.inventoryID = inventoryID;
        this.productID = productID;
        this.warehouseID = warehouseID;
        this.currentStock = currentStock;
        this.reservedStock = reservedStock;
        this.lastStockUpdate = lastStockUpdate;
        this.location = location;
    }

    public int getInventoryID() { return inventoryID; }
    public void setInventoryID(int inventoryID) { this.inventoryID = inventoryID; }
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }
    public int getWarehouseID() { return warehouseID; }
    public void setWarehouseID(int warehouseID) { this.warehouseID = warehouseID; }
    public int getCurrentStock() { return currentStock; }
    public void setCurrentStock(int currentStock) { this.currentStock = currentStock; }
    public int getReservedStock() { return reservedStock; }
    public void setReservedStock(int reservedStock) { this.reservedStock = reservedStock; }
    public Date getLastStockUpdate() { return lastStockUpdate; }
    public void setLastStockUpdate(Date lastStockUpdate) { this.lastStockUpdate = lastStockUpdate; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
}