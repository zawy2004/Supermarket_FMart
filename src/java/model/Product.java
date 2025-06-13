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

    // Getters and Setters here
}
