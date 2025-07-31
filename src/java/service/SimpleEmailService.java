package service;

import model.ContactMessage;

// IMPORT CHO JAKARTA
import jakarta.mail.*;
import jakarta.mail.internet.*;

// HOẶC IMPORT CHO JAVAX (nếu dùng dependency cũ)
// import javax.mail.*;
// import javax.mail.internet.*;

import java.util.Properties;

public class SimpleEmailService {
    
    // CẤU HÌNH EMAIL - CHỈ CẦN THAY ĐỔI 3 DÒNG NÀY
    private static final String GMAIL_USERNAME = "anltne0201@gmail.com";     // Gmail của bạn
    private static final String GMAIL_PASSWORD = "jicg imof mlxu xdhd";        // App Password Gmail
    private static final String MANAGEMENT_EMAIL = "anltne0201@gmail.com";   // Email nhận thông báo
    
    // Gửi email thông báo đến management - CHỈ 1 PHƯƠNG THỨC DUY NHẤT
    public static boolean sendNotificationToManagement(ContactMessage contact) {
        try {
            // Cấu hình Gmail SMTP
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
            
            // Tạo session
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(GMAIL_USERNAME, GMAIL_PASSWORD);
                }
            });
            
            // Tạo email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(GMAIL_USERNAME, "FMart System"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(MANAGEMENT_EMAIL));
            message.setSubject("[FMart Contact] " + contact.getSubject());
            
            // Nội dung email đơn giản
            String emailBody = "THÔNG BÁO CONTACT MESSAGE MỚI\n" +
                              "================================\n" +
                              "Message ID: #" + contact.getMessageID() + "\n" +
                              "Tên: " + contact.getSenderName() + "\n" +
                              "Email: " + contact.getSenderEmail() + "\n" +
                              "Điện thoại: " + (contact.getSenderPhone() != null ? contact.getSenderPhone() : "Không có") + "\n" +
                              "Loại: " + contact.getMessageType() + "\n" +
                              "Chủ đề: " + contact.getSubject() + "\n" +
                              "Thời gian: " + contact.getCreatedDate() + "\n\n" +
                              "NỘI DUNG TIN NHẮN:\n" +
                              "------------------------\n" +
                              contact.getMessage() + "\n\n" +
                              "VUI LÒNG PHẢN HỒI KHÁCH HÀNG TRONG THỜI GIAN SỚM NHẤT!\n" +
                              "Reply trực tiếp về email: " + contact.getSenderEmail() + "\n\n" +
                              "---\n" +
                              "Tin nhắn này được gửi tự động từ FMart Contact System";
            
            message.setText(emailBody);
            
            // Gửi email
            Transport.send(message);
            System.out.println("✅ Email notification sent successfully to: " + MANAGEMENT_EMAIL);
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ Failed to send email notification: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}