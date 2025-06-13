package model;

import java.util.Date;

public class Order {
    private int orderID;
    private String orderNumber;
    private int customerID;
    private Date orderDate;
    private String orderType;
    private String status;
    private double totalAmount;
    private double discountAmount;
    private double taxAmount;
    private double finalAmount;
    private String paymentStatus;
    private String paymentMethod;
    private String deliveryAddress;
    private Date deliveryDate;
    private Date completedDate;
    private int processedBy;
    private String notes;

    public Order() {}

    public Order(int orderID, String orderNumber, int customerID, Date orderDate, String orderType, String status, double totalAmount, double discountAmount, double taxAmount, double finalAmount, String paymentStatus, String paymentMethod, String deliveryAddress, Date deliveryDate, Date completedDate, int processedBy, String notes) {
        this.orderID = orderID;
        this.orderNumber = orderNumber;
        this.customerID = customerID;
        this.orderDate = orderDate;
        this.orderType = orderType;
        this.status = status;
        this.totalAmount = totalAmount;
        this.discountAmount = discountAmount;
        this.taxAmount = taxAmount;
        this.finalAmount = finalAmount;
        this.paymentStatus = paymentStatus;
        this.paymentMethod = paymentMethod;
        this.deliveryAddress = deliveryAddress;
        this.deliveryDate = deliveryDate;
        this.completedDate = completedDate;
        this.processedBy = processedBy;
        this.notes = notes;
    }

    public int getOrderID() { return orderID; }
    public void setOrderID(int orderID) { this.orderID = orderID; }
    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }
    public int getCustomerID() { return customerID; }
    public void setCustomerID(int customerID) { this.customerID = customerID; }
    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
    public String getOrderType() { return orderType; }
    public void setOrderType(String orderType) { this.orderType = orderType; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public double getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(double discountAmount) { this.discountAmount = discountAmount; }
    public double getTaxAmount() { return taxAmount; }
    public void setTaxAmount(double taxAmount) { this.taxAmount = taxAmount; }
    public double getFinalAmount() { return finalAmount; }
    public void setFinalAmount(double finalAmount) { this.finalAmount = finalAmount; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    public Date getDeliveryDate() { return deliveryDate; }
    public void setDeliveryDate(Date deliveryDate) { this.deliveryDate = deliveryDate; }
    public Date getCompletedDate() { return completedDate; }
    public void setCompletedDate(Date completedDate) { this.completedDate = completedDate; }
    public int getProcessedBy() { return processedBy; }
    public void setProcessedBy(int processedBy) { this.processedBy = processedBy; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}