package model;

import java.util.Date;

public class Product {
    private int productID;
    private String productName;
    private String sku;
    private int categoryID;
    private int supplierID;
    private String description;
    private String unit;
    private double costPrice;
    private double sellingPrice;
    private int minStockLevel;
    private boolean isActive;
    private Date createdDate;
    private Date lastUpdated;
    private double weight;
    private String dimensions;
    private int expiryDays;
    private String brand;
    private String origin;

    // Constructors, Getters, and Setters...

    public Product() {}

    public Product(int productID, String productName, String sku, int categoryID, int supplierID,
                   String description, String unit, double costPrice, double sellingPrice, int minStockLevel,
                   boolean isActive, Date createdDate, Date lastUpdated, double weight,
                   String dimensions, int expiryDays, String brand, String origin) {
        this.productID = productID;
        this.productName = productName;
        this.sku = sku;
        this.categoryID = categoryID;
        this.supplierID = supplierID;
        this.description = description;
        this.unit = unit;
        this.costPrice = costPrice;
        this.sellingPrice = sellingPrice;
        this.minStockLevel = minStockLevel;
        this.isActive = isActive;
        this.createdDate = createdDate;
        this.lastUpdated = lastUpdated;
        this.weight = weight;
        this.dimensions = dimensions;
        this.expiryDays = expiryDays;
        this.brand = brand;
        this.origin = origin;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public double getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(double costPrice) {
        this.costPrice = costPrice;
    }

    public double getSellingPrice() {
        return sellingPrice;
    }

    public void setSellingPrice(double sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public int getMinStockLevel() {
        return minStockLevel;
    }

    public void setMinStockLevel(int minStockLevel) {
        this.minStockLevel = minStockLevel;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getDimensions() {
        return dimensions;
    }

    public void setDimensions(String dimensions) {
        this.dimensions = dimensions;
    }

    public int getExpiryDays() {
        return expiryDays;
    }

    public void setExpiryDays(int expiryDays) {
        this.expiryDays = expiryDays;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public void setSKU(String string) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    
}