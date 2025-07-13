package service;

import dao.ContactDao;
import model.ContactMessage;
import java.util.List;
import java.util.regex.Pattern;
import jakarta.servlet.http.HttpServletRequest;

public class ContactService {
    
    private ContactDao contactDAO;
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$");
    
    public ContactService() {
        this.contactDAO = new ContactDao();
    }
    
    // Submit contact message with validation
    public ContactSubmissionResult submitContactMessage(ContactMessage contact, HttpServletRequest request) {
        ContactSubmissionResult result = new ContactSubmissionResult();
        
        try {
            // Validate contact message
            ValidationResult validation = validateContactMessage(contact);
            if (!validation.isValid()) {
                result.setSuccess(false);
                result.setMessage(validation.getErrorMessage());
                return result;
            }
            
            // Set additional information
            contact.setCustomerIP(getClientIpAddress(request));
            contact.setUserAgent(request.getHeader("User-Agent"));
            
            // Auto-determine priority based on message content
            contact.setPriority(determinePriority(contact));
            
            // Auto-determine message type if not set
            if (contact.getMessageType() == null || contact.getMessageType().equals("INQUIRY")) {
                contact.setMessageType(determineMessageType(contact));
            }
            
            // Save to database
            boolean saved = contactDAO.createContactMessage(contact);
            
            if (saved) {
                result.setSuccess(true);
                result.setMessage("Your message has been submitted successfully. We will get back to you within 24-48 hours.");
                result.setMessageID(contact.getMessageID());
                
                System.out.println("New contact message submitted: ID=" + contact.getMessageID() + 
                                 ", From=" + contact.getSenderEmail() + 
                                 ", Subject=" + contact.getSubject());
            } else {
                result.setSuccess(false);
                result.setMessage("Failed to submit your message. Please try again later.");
            }
            
        } catch (Exception e) {
            System.err.println("Error in submitContactMessage: " + e.getMessage());
            e.printStackTrace();
            result.setSuccess(false);
            result.setMessage("An error occurred while processing your request. Please try again.");
        }
        
        return result;
    }
    
    // Validate contact message
    private ValidationResult validateContactMessage(ContactMessage contact) {
        if (contact == null) {
            return new ValidationResult(false, "Contact message cannot be null");
        }
        
        // Validate sender name
        if (contact.getSenderName() == null || contact.getSenderName().trim().isEmpty()) {
            return new ValidationResult(false, "Full name is required");
        }
        
        if (contact.getSenderName().trim().length() < 2) {
            return new ValidationResult(false, "Full name must be at least 2 characters long");
        }
        
        if (contact.getSenderName().trim().length() > 100) {
            return new ValidationResult(false, "Full name cannot exceed 100 characters");
        }
        
        // Validate email
        if (contact.getSenderEmail() == null || contact.getSenderEmail().trim().isEmpty()) {
            return new ValidationResult(false, "Email address is required");
        }
        
        if (!EMAIL_PATTERN.matcher(contact.getSenderEmail().trim()).matches()) {
            return new ValidationResult(false, "Please enter a valid email address");
        }
        
        // Validate phone (optional but if provided, should be valid)
        if (contact.getSenderPhone() != null && !contact.getSenderPhone().trim().isEmpty()) {
            String phone = contact.getSenderPhone().replaceAll("[^0-9]", "");
            if (phone.length() < 10 || phone.length() > 15) {
                return new ValidationResult(false, "Please enter a valid phone number");
            }
        }
        
        // Validate subject
        if (contact.getSubject() == null || contact.getSubject().trim().isEmpty()) {
            return new ValidationResult(false, "Subject is required");
        }
        
        if (contact.getSubject().trim().length() < 5) {
            return new ValidationResult(false, "Subject must be at least 5 characters long");
        }
        
        if (contact.getSubject().trim().length() > 200) {
            return new ValidationResult(false, "Subject cannot exceed 200 characters");
        }
        
        // Validate message
        if (contact.getMessage() == null || contact.getMessage().trim().isEmpty()) {
            return new ValidationResult(false, "Message is required");
        }
        
        if (contact.getMessage().trim().length() < 10) {
            return new ValidationResult(false, "Message must be at least 10 characters long");
        }
        
        if (contact.getMessage().trim().length() > 2000) {
            return new ValidationResult(false, "Message cannot exceed 2000 characters");
        }
        
        // Check for spam patterns
        if (isSpamMessage(contact)) {
            return new ValidationResult(false, "Your message appears to be spam. Please contact us directly if you need assistance.");
        }
        
        return new ValidationResult(true, "Valid");
    }
    
    // Determine priority based on content
    private String determinePriority(ContactMessage contact) {
        String content = (contact.getSubject() + " " + contact.getMessage()).toLowerCase();
        
        // Urgent keywords
        String[] urgentKeywords = {"urgent", "emergency", "critical", "broken", "not working", "can't access", "payment failed", "billing error"};
        for (String keyword : urgentKeywords) {
            if (content.contains(keyword)) {
                return "URGENT";
            }
        }
        
        // High priority keywords
        String[] highKeywords = {"complaint", "refund", "cancel", "problem", "issue", "error", "bug"};
        for (String keyword : highKeywords) {
            if (content.contains(keyword)) {
                return "HIGH";
            }
        }
        
        // Low priority keywords
        String[] lowKeywords = {"suggestion", "feature", "improvement", "feedback", "compliment"};
        for (String keyword : lowKeywords) {
            if (content.contains(keyword)) {
                return "LOW";
            }
        }
        
        return "MEDIUM"; // Default
    }
    
    // Determine message type based on content
    private String determineMessageType(ContactMessage contact) {
        String content = (contact.getSubject() + " " + contact.getMessage()).toLowerCase();
        
        // Complaint keywords
        String[] complaintKeywords = {"complaint", "complain", "dissatisfied", "angry", "disappointed", "terrible", "awful", "bad service"};
        for (String keyword : complaintKeywords) {
            if (content.contains(keyword)) {
                return "COMPLAINT";
            }
        }
        
        // Support keywords
        String[] supportKeywords = {"help", "support", "assistance", "how to", "can't", "unable", "problem", "issue", "error", "bug", "not working"};
        for (String keyword : supportKeywords) {
            if (content.contains(keyword)) {
                return "SUPPORT";
            }
        }
        
        // Feedback keywords
        String[] feedbackKeywords = {"feedback", "suggestion", "improve", "feature", "recommend", "love", "great", "excellent", "amazing"};
        for (String keyword : feedbackKeywords) {
            if (content.contains(keyword)) {
                return "FEEDBACK";
            }
        }
        
        return "INQUIRY"; // Default
    }
    
    // Check for spam patterns
    private boolean isSpamMessage(ContactMessage contact) {
        String content = (contact.getSubject() + " " + contact.getMessage()).toLowerCase();
        
        // Common spam patterns
        String[] spamKeywords = {
            "viagra", "cialis", "lottery", "winner", "congratulations you have won",
            "click here", "free money", "make money fast", "work from home",
            "nigerian prince", "inheritance", "million dollars", "cryptocurrency",
            "bitcoin", "investment opportunity", "guaranteed profit"
        };
        
        for (String keyword : spamKeywords) {
            if (content.contains(keyword)) {
                return true;
            }
        }
        
        // Check for excessive links
        if (content.split("http").length > 3) {
            return true;
        }
        
        // Check for excessive capitalization
        long upperCaseCount = content.chars().filter(Character::isUpperCase).count();
        if (upperCaseCount > content.length() * 0.7 && content.length() > 20) {
            return true;
        }
        
        return false;
    }
    
    // Get client IP address
    private String getClientIpAddress(HttpServletRequest request) {
        String xForwardedForHeader = request.getHeader("X-Forwarded-For");
        if (xForwardedForHeader == null) {
            return request.getRemoteAddr();
        } else {
            return xForwardedForHeader.split(",")[0];
        }
    }
    
    // Get contact message by ID  
    public ContactMessage getContactMessageById(int messageId) {
        return contactDAO.getContactMessageById(messageId);
    }
    
    // Get contact messages for admin
    public List<ContactMessage> getAllContactMessages(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return contactDAO.getAllContactMessages(offset, pageSize);
    }
    
    // Get contact messages by status
    public List<ContactMessage> getContactMessagesByStatus(String status) {
        return contactDAO.getContactMessagesByStatus(status);
    }
    
    // Get customer's contact messages
    public List<ContactMessage> getCustomerContactMessages(int customerID) {
        return contactDAO.getContactMessagesByCustomerId(customerID);
    }
    
    // Get contact statistics - Return DAO type directly
    public ContactDao.ContactStatistics getContactStatistics() {
        return contactDAO.getContactStatistics();
    }
    
    // Update message status (for admin)
    public boolean updateMessageStatus(int messageID, String status, int assignedTo) {
        return contactDAO.updateContactMessageStatus(messageID, status, assignedTo);
    }
    
    // Add response to message (for admin)
    public boolean addResponse(int messageID, String response, int respondedBy) {
        return contactDAO.addResponseToContactMessage(messageID, response, respondedBy);
    }
    
    // Search contact messages
    public List<ContactMessage> searchContactMessages(String searchTerm) {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return getAllContactMessages(1, 50);
        }
        return contactDAO.searchContactMessages(searchTerm.trim());
    }
    
    // Inner classes for results
    public static class ContactSubmissionResult {
        private boolean success;
        private String message;
        private int messageID;
        
        public ContactSubmissionResult() {}
        
        public ContactSubmissionResult(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
        
        // Getters and Setters
        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        public int getMessageID() { return messageID; }
        public void setMessageID(int messageID) { this.messageID = messageID; }
    }
    
    public static class ValidationResult {
        private boolean valid;
        private String errorMessage;
        
        public ValidationResult(boolean valid, String errorMessage) {
            this.valid = valid;
            this.errorMessage = errorMessage;
        }
        
        public boolean isValid() { return valid; }
        public String getErrorMessage() { return errorMessage; }
    }
}