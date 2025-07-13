package controller.user;

import dao.ContactDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ContactMessage;
import model.User;
import service.ContactService;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ContactServlet", urlPatterns = {"/contact", "/contact-us", "/support"})
public class ContactServlet extends HttpServlet {
    
    private ContactService contactService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        contactService = new ContactService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("history".equals(action)) {
            handleContactHistory(request, response);
        } else if ("view".equals(action)) {
            handleViewMessage(request, response);
        } else {
            handleContactForm(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("submit".equals(action)) {
            handleContactSubmission(request, response);
        } else {
            response.sendRedirect("contact");
        }
    }
    
    // Handle contact form display
    private void handleContactForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get current user if logged in
            HttpSession session = request.getSession(false);
            User user = null;
            if (session != null) {
                user = (User) session.getAttribute("user");
            }
            
            // Pre-fill form if user is logged in
            if (user != null) {
                request.setAttribute("userFullName", user.getFullName());
                request.setAttribute("userEmail", user.getEmail());
                request.setAttribute("userPhone", user.getPhoneNumber());
            }
            
            // Get contact statistics for display
            ContactDao.ContactStatistics stats = contactService.getContactStatistics();
            request.setAttribute("contactStats", stats);
            
            // Set page title and meta
            request.setAttribute("pageTitle", "Contact Us - FMart Super Market");
            request.setAttribute("pageDescription", "Get in touch with FMart customer service. We're here to help with your questions, feedback, and support needs.");
            
            // Forward to contact us page
            request.getRequestDispatcher("/User/contact_us.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in handleContactForm: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to load contact form. Please try again.");
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        }
    }
    
    // Handle contact form submission
    private void handleContactSubmission(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get form parameters
            String senderName = request.getParameter("sendername");
            String senderEmail = request.getParameter("emailaddress");
            String senderPhone = request.getParameter("phone");
            String subject = request.getParameter("sendersubject");
            String message = request.getParameter("sendermessage");
            String messageType = request.getParameter("messagetype");
            
            // Create contact message object
            ContactMessage contact = new ContactMessage();
            contact.setSenderName(senderName != null ? senderName.trim() : "");
            contact.setSenderEmail(senderEmail != null ? senderEmail.trim() : "");
            contact.setSenderPhone(senderPhone != null ? senderPhone.trim() : "");
            contact.setSubject(subject != null ? subject.trim() : "");
            contact.setMessage(message != null ? message.trim() : "");
            contact.setMessageType(messageType != null ? messageType.trim() : "INQUIRY");
            
            // Set customer ID if user is logged in
            HttpSession session = request.getSession(false);
            if (session != null) {
                User user = (User) session.getAttribute("user");
                Integer userId = (Integer) session.getAttribute("userId");
                if (user != null && userId != null) {
                    contact.setCustomerID(userId);
                }
            }
            
            // Submit contact message
            ContactService.ContactSubmissionResult result = contactService.submitContactMessage(contact, request);
            
            if (result.isSuccess()) {
                // Success - redirect with success message
                session = request.getSession(true);
                session.setAttribute("contactSuccess", result.getMessage());
                session.setAttribute("contactMessageId", result.getMessageID());
                
                System.out.println("Contact message submitted successfully: ID=" + result.getMessageID() + 
                                 ", From=" + contact.getSenderEmail());
                
                response.sendRedirect(request.getContextPath() + "/contact?success=true");
            } else {
                // Error - return to form with error message
                request.setAttribute("error", result.getMessage());
                request.setAttribute("formData", contact); // To preserve form data
                
                System.out.println("Contact message submission failed: " + result.getMessage());
                
                // Forward back to contact form
                handleContactForm(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Error in handleContactSubmission: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", "An error occurred while processing your request. Please try again.");
            handleContactForm(request, response);
        }
    }
    
    // Handle contact history for logged-in users
    private void handleContactHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                response.sendRedirect("login?redirect=contact?action=history");
                return;
            }
            
            User user = (User) session.getAttribute("user");
            Integer userId = (Integer) session.getAttribute("userId");
            
            if (user == null || userId == null) {
                response.sendRedirect("login?redirect=contact?action=history");
                return;
            }
            
            // Get customer's contact messages
            List<ContactMessage> contactHistory = contactService.getCustomerContactMessages(userId);
            
            request.setAttribute("contactHistory", contactHistory);
            request.setAttribute("user", user);
            request.setAttribute("pageTitle", "My Contact History - FMart");
            
            request.getRequestDispatcher("/User/contact_history.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in handleContactHistory: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to load contact history.");
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        }
    }
    
    // Handle view specific message
    private void handleViewMessage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String messageIdStr = request.getParameter("id");
            if (messageIdStr == null || messageIdStr.trim().isEmpty()) {
                response.sendRedirect("contact?action=history");
                return;
            }
            
            int messageId = Integer.parseInt(messageIdStr);
            
            // Check if user is logged in
            HttpSession session = request.getSession(false);
            if (session == null) {
                response.sendRedirect("login");
                return;
            }
            
            User user = (User) session.getAttribute("user");
            Integer userId = (Integer) session.getAttribute("userId");
            
            if (user == null || userId == null) {
                response.sendRedirect("login");
                return;
            }
            
            // Get contact message and verify ownership
            ContactMessage contactMessage = contactService.getContactMessageById(messageId);
            
            if (contactMessage == null) {
                request.setAttribute("error", "Contact message not found.");
                request.getRequestDispatcher("/User/error.jsp").forward(request, response);
                return;
            }
            
            // Verify that the message belongs to the current user
            if (contactMessage.getCustomerID() != userId) {
                request.setAttribute("error", "Access denied. You can only view your own messages.");
                request.getRequestDispatcher("/User/error.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("contactMessage", contactMessage);
            request.setAttribute("user", user);
            request.setAttribute("pageTitle", "Contact Message - " + contactMessage.getSubject());
            
            request.getRequestDispatcher("/User/contact_view.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid message ID.");
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in handleViewMessage: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to load contact message.");
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        }
    }
    
    // Utility method to get client IP
    private String getClientIpAddress(HttpServletRequest request) {
        String xForwardedForHeader = request.getHeader("X-Forwarded-For");
        if (xForwardedForHeader == null) {
            return request.getRemoteAddr();
        } else {
            return xForwardedForHeader.split(",")[0];
        }
    }
    
    // Utility method to sanitize input
    private String sanitizeInput(String input) {
        if (input == null) {
            return "";
        }
        
        // Basic XSS prevention
        return input.replaceAll("<", "&lt;")
                   .replaceAll(">", "&gt;")
                   .replaceAll("\"", "&quot;")
                   .replaceAll("'", "&#x27;")
                   .replaceAll("/", "&#x2F;");
    }
}