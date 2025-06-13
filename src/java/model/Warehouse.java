package model;

import java.util.Date;

public class Warehouse {
    private int warehouseID;
    private String warehouseName;
    private String location;

    public Warehouse() {}

    public Warehouse(int warehouseID, String warehouseName, String location) {
        this.warehouseID = warehouseID;
        this.warehouseName = warehouseName;
        this.location = location;
    }

    public int getWarehouseID() { return warehouseID; }
    public void setWarehouseID(int warehouseID) { this.warehouseID = warehouseID; }
    public String getWarehouseName() { return warehouseName; }
    public void setWarehouseName(String warehouseName) { this.warehouseName = warehouseName; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
}