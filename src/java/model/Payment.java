package model;

import java.util.Date;

public class Payment {
    private int paymentID;
    private int orderID;
    private String paymentMethod;
    private String paymentProvider;
    private double amount;
    private String transactionID;
    private String status;
    private Date paymentDate;
    private int processedBy;
    private String notes;

    public Payment() {}

    public Payment(int paymentID, int orderID, String paymentMethod, String paymentProvider, double amount, String transactionID, String status, Date paymentDate, int processedBy, String notes) {
        this.paymentID = paymentID;
        this.orderID = orderID;
        this.paymentMethod = paymentMethod;
        this.paymentProvider = paymentProvider;
        this.amount = amount;
        this.transactionID = transactionID;
        this.status = status;
        this.paymentDate = paymentDate;
        this.processedBy = processedBy;
        this.notes = notes;
    }

    public int getPaymentID() { return paymentID; }
    public void setPaymentID(int paymentID) { this.paymentID = paymentID; }
    public int getOrderID() { return orderID; }
    public void setOrderID(int orderID) { this.orderID = orderID; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public String getPaymentProvider() { return paymentProvider; }
    public void setPaymentProvider(String paymentProvider) { this.paymentProvider = paymentProvider; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public String getTransactionID() { return transactionID; }
    public void setTransactionID(String transactionID) { this.transactionID = transactionID; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Date paymentDate) { this.paymentDate = paymentDate; }
    public int getProcessedBy() { return processedBy; }
    public void setProcessedBy(int processedBy) { this.processedBy = processedBy; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}