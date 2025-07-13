package dao;

import config.DatabaseConfig;
import model.ContactMessage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactDao {
    
    // Create new contact message
    public boolean createContactMessage(ContactMessage contact) {
        String sql = "INSERT INTO ContactMessages (SenderName, SenderEmail, SenderPhone, Subject, Message, MessageType, Status, Priority, CreatedDate, CustomerIP, UserAgent, CustomerID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, contact.getSenderName());
            stmt.setString(2, contact.getSenderEmail());
            stmt.setString(3, contact.getSenderPhone());
            stmt.setString(4, contact.getSubject());
            stmt.setString(5, contact.getMessage());
            stmt.setString(6, contact.getMessageType());
            stmt.setString(7, contact.getStatus());
            stmt.setString(8, contact.getPriority());
            stmt.setTimestamp(9, new Timestamp(contact.getCreatedDate().getTime()));
            stmt.setString(10, contact.getCustomerIP());
            stmt.setString(11, contact.getUserAgent());
            
            if (contact.getCustomerID() > 0) {
                stmt.setInt(12, contact.getCustomerID());
            } else {
                stmt.setNull(12, Types.INTEGER);
            }
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        contact.setMessageID(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error in createContactMessage: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Get contact message by ID
    public ContactMessage getContactMessageById(int messageID) {
        String sql = "SELECT * FROM ContactMessages WHERE MessageID = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, messageID);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractContactMessageFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getContactMessageById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Get all contact messages with pagination
    public List<ContactMessage> getAllContactMessages(int offset, int limit) {
        String sql = "SELECT * FROM ContactMessages ORDER BY CreatedDate DESC LIMIT ? OFFSET ?";
        List<ContactMessage> messages = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    messages.add(extractContactMessageFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllContactMessages: " + e.getMessage());
            e.printStackTrace();
        }
        return messages;
    }
    
    // Get contact messages by status
    public List<ContactMessage> getContactMessagesByStatus(String status) {
        String sql = "SELECT * FROM ContactMessages WHERE Status = ? ORDER BY CreatedDate DESC";
        List<ContactMessage> messages = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    messages.add(extractContactMessageFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getContactMessagesByStatus: " + e.getMessage());
            e.printStackTrace();
        }
        return messages;
    }
    
    // Get contact messages by customer ID
    public List<ContactMessage> getContactMessagesByCustomerId(int customerID) {
        String sql = "SELECT * FROM ContactMessages WHERE CustomerID = ? ORDER BY CreatedDate DESC";
        List<ContactMessage> messages = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerID);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    messages.add(extractContactMessageFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getContactMessagesByCustomerId: " + e.getMessage());
            e.printStackTrace();
        }
        return messages;
    }
    
    // Update contact message status
    public boolean updateContactMessageStatus(int messageID, String status, int assignedTo) {
        String sql = "UPDATE ContactMessages SET Status = ?, AssignedTo = ?, UpdatedDate = ? WHERE MessageID = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            
            if (assignedTo > 0) {
                stmt.setInt(2, assignedTo);
            } else {
                stmt.setNull(2, Types.INTEGER);
            }
            
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(4, messageID);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in updateContactMessageStatus: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Add response to contact message
    public boolean addResponseToContactMessage(int messageID, String response, int respondedBy) {
        String sql = "UPDATE ContactMessages SET Response = ?, ResponseDate = ?, AssignedTo = ?, Status = ?, UpdatedDate = ? WHERE MessageID = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, response);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(3, respondedBy);
            stmt.setString(4, "RESOLVED");
            stmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(6, messageID);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in addResponseToContactMessage: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Get contact message statistics
    public ContactStatistics getContactStatistics() {
        String sql = "SELECT " +
                    "COUNT(*) as total, " +
                    "SUM(CASE WHEN Status = 'NEW' THEN 1 ELSE 0 END) as newMessages, " +
                    "SUM(CASE WHEN Status = 'IN_PROGRESS' THEN 1 ELSE 0 END) as inProgress, " +
                    "SUM(CASE WHEN Status = 'RESOLVED' THEN 1 ELSE 0 END) as resolved, " +
                    "SUM(CASE WHEN Status = 'CLOSED' THEN 1 ELSE 0 END) as closed, " +
                    "SUM(CASE WHEN Priority = 'URGENT' THEN 1 ELSE 0 END) as urgent, " +
                    "SUM(CASE WHEN CreatedDate >= CURDATE() THEN 1 ELSE 0 END) as today " +
                    "FROM ContactMessages";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return new ContactStatistics(
                    rs.getInt("total"),
                    rs.getInt("newMessages"),
                    rs.getInt("inProgress"),
                    rs.getInt("resolved"),
                    rs.getInt("closed"),
                    rs.getInt("urgent"),
                    rs.getInt("today")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error in getContactStatistics: " + e.getMessage());
            e.printStackTrace();
        }
        return new ContactStatistics(0, 0, 0, 0, 0, 0, 0);
    }
    
    // Search contact messages
    public List<ContactMessage> searchContactMessages(String searchTerm) {
        String sql = "SELECT * FROM ContactMessages WHERE " +
                    "SenderName LIKE ? OR SenderEmail LIKE ? OR Subject LIKE ? OR Message LIKE ? " +
                    "ORDER BY CreatedDate DESC";
        List<ContactMessage> messages = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    messages.add(extractContactMessageFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in searchContactMessages: " + e.getMessage());
            e.printStackTrace();
        }
        return messages;
    }
    
    // Helper method to extract ContactMessage from ResultSet
    private ContactMessage extractContactMessageFromResultSet(ResultSet rs) throws SQLException {
        ContactMessage contact = new ContactMessage();
        contact.setMessageID(rs.getInt("MessageID"));
        contact.setSenderName(rs.getString("SenderName"));
        contact.setSenderEmail(rs.getString("SenderEmail"));
        contact.setSenderPhone(rs.getString("SenderPhone"));
        contact.setSubject(rs.getString("Subject"));
        contact.setMessage(rs.getString("Message"));
        contact.setMessageType(rs.getString("MessageType"));
        contact.setStatus(rs.getString("Status"));
        contact.setPriority(rs.getString("Priority"));
        contact.setCreatedDate(rs.getTimestamp("CreatedDate"));
        contact.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
        contact.setAssignedTo(rs.getInt("AssignedTo"));
        contact.setResponse(rs.getString("Response"));
        contact.setResponseDate(rs.getTimestamp("ResponseDate"));
        contact.setCustomerIP(rs.getString("CustomerIP"));
        contact.setUserAgent(rs.getString("UserAgent"));
        contact.setCustomerID(rs.getInt("CustomerID"));
        return contact;
    }
    
    // Inner class for contact statistics
    public static class ContactStatistics {
        private int total;
        private int newMessages;
        private int inProgress;
        private int resolved;
        private int closed;
        private int urgent;
        private int today;
        
        public ContactStatistics(int total, int newMessages, int inProgress, int resolved, int closed, int urgent, int today) {
            this.total = total;
            this.newMessages = newMessages;
            this.inProgress = inProgress;
            this.resolved = resolved;
            this.closed = closed;
            this.urgent = urgent;
            this.today = today;
        }
        
        // Getters
        public int getTotal() { return total; }
        public int getNewMessages() { return newMessages; }
        public int getInProgress() { return inProgress; }
        public int getResolved() { return resolved; }
        public int getClosed() { return closed; }
        public int getUrgent() { return urgent; }
        public int getToday() { return today; }
    }
}