package model;

import java.util.Date;

public class ContactMessage {
    private int messageID;
    private String senderName;
    private String senderEmail;
    private String senderPhone;
    private String subject;
    private String message;
    private String messageType; // INQUIRY, COMPLAINT, FEEDBACK, SUPPORT
    private String status; // NEW, IN_PROGRESS, RESOLVED, CLOSED
    private String priority; // LOW, MEDIUM, HIGH, URGENT
    private Date createdDate;
    private Date updatedDate;
    private int assignedTo; // Staff member ID
    private String response;
    private Date responseDate;
    private String customerIP;
    private String userAgent;
    private int customerID; // If logged in customer
    
    // Default constructor
    public ContactMessage() {
        this.createdDate = new Date();
        this.status = "NEW";
        this.priority = "MEDIUM";
        this.messageType = "INQUIRY";
    }
    
    // Constructor with basic fields
    public ContactMessage(String senderName, String senderEmail, String subject, String message) {
        this();
        this.senderName = senderName;
        this.senderEmail = senderEmail;
        this.subject = subject;
        this.message = message;
    }
    
    // Getters and Setters
    public int getMessageID() {
        return messageID;
    }
    
    public void setMessageID(int messageID) {
        this.messageID = messageID;
    }
    
    public String getSenderName() {
        return senderName;
    }
    
    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }
    
    public String getSenderEmail() {
        return senderEmail;
    }
    
    public void setSenderEmail(String senderEmail) {
        this.senderEmail = senderEmail;
    }
    
    public String getSenderPhone() {
        return senderPhone;
    }
    
    public void setSenderPhone(String senderPhone) {
        this.senderPhone = senderPhone;
    }
    
    public String getSubject() {
        return subject;
    }
    
    public void setSubject(String subject) {
        this.subject = subject;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public String getMessageType() {
        return messageType;
    }
    
    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getPriority() {
        return priority;
    }
    
    public void setPriority(String priority) {
        this.priority = priority;
    }
    
    public Date getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
    public Date getUpdatedDate() {
        return updatedDate;
    }
    
    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }
    
    public int getAssignedTo() {
        return assignedTo;
    }
    
    public void setAssignedTo(int assignedTo) {
        this.assignedTo = assignedTo;
    }
    
    public String getResponse() {
        return response;
    }
    
    public void setResponse(String response) {
        this.response = response;
    }
    
    public Date getResponseDate() {
        return responseDate;
    }
    
    public void setResponseDate(Date responseDate) {
        this.responseDate = responseDate;
    }
    
    public String getCustomerIP() {
        return customerIP;
    }
    
    public void setCustomerIP(String customerIP) {
        this.customerIP = customerIP;
    }
    
    public String getUserAgent() {
        return userAgent;
    }
    
    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }
    
    public int getCustomerID() {
        return customerID;
    }
    
    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }
    
    @Override
    public String toString() {
        return "ContactMessage{" +
                "messageID=" + messageID +
                ", senderName='" + senderName + '\'' +
                ", senderEmail='" + senderEmail + '\'' +
                ", subject='" + subject + '\'' +
                ", messageType='" + messageType + '\'' +
                ", status='" + status + '\'' +
                ", priority='" + priority + '\'' +
                ", createdDate=" + createdDate +
                '}';
    }
}