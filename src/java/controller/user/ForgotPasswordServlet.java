package controller.user;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;
import util.ValidationUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import java.sql.Timestamp;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private UserDAO userDAO;
    
    // Email configuration (same as SendVerificationCodeServlet)
    private static final String EMAIL_USERNAME = "anltne0201@gmail.com";
    private static final String EMAIL_PASSWORD = "zknkwdsixhbifspr";
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;
    private static final int MAX_ATTEMPTS = 5;
    private static final int RESET_TOKEN_TIMEOUT_MINUTES = 30; // 30 phút

    @Override
    public void init() {
        System.out.println("Initializing ForgotPasswordServlet...");
        userDAO = new UserDAO();
        if (userDAO.testConnection()) {
            System.out.println("UserDAO initialized successfully");
        } else {
            System.err.println("UserDAO initialization failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String token = request.getParameter("token");

        if ("reset".equals(action) && token != null) {
            // Hiển thị form reset password với token
            request.setAttribute("resetToken", token);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/User/reset_password.jsp");
            dispatcher.forward(request, response);
        } else {
            // Hiển thị form forgot password
            RequestDispatcher dispatcher = request.getRequestDispatcher("/User/forgot_password.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("send-reset-email".equals(action)) {
            handleSendResetEmail(request, response);
        } else if ("reset-password".equals(action)) {
            handleResetPassword(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void handleSendResetEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("=== Send Reset Email Process Started ===");
        
        try {
            String email = request.getParameter("email");
            
            // Validation
            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng nhập email.");
                forwardToForgotPassword(request, response);
                return;
            }

            if (!ValidationUtil.isValidEmail(email)) {
                request.setAttribute("errorMessage", "Email không hợp lệ.");
                forwardToForgotPassword(request, response);
                return;
            }

            // Check rate limiting
            HttpSession session = request.getSession();
            Integer sendAttempts = (Integer) session.getAttribute("forgotPasswordAttempts");
            Long firstAttemptTime = (Long) session.getAttribute("forgotPasswordFirstAttempt");
            long currentTime = System.currentTimeMillis();
            
            // Reset counter after 1 hour
            if (firstAttemptTime != null && (currentTime - firstAttemptTime) > (60 * 60 * 1000)) {
                sendAttempts = 0;
                session.removeAttribute("forgotPasswordAttempts");
                session.removeAttribute("forgotPasswordFirstAttempt");
                firstAttemptTime = null;
            }
            
            if (sendAttempts == null) {
                sendAttempts = 0;
                firstAttemptTime = currentTime;
                session.setAttribute("forgotPasswordFirstAttempt", firstAttemptTime);
            }
            
            if (sendAttempts >= MAX_ATTEMPTS) {
                request.setAttribute("errorMessage", "Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau 1 giờ.");
                forwardToForgotPassword(request, response);
                return;
            }

            // Check if user exists
            User user = userDAO.getUserByEmail(email.trim());
            if (user == null) {
                // Don't reveal if email exists or not for security
                request.setAttribute("successMessage", "Nếu email tồn tại, chúng tôi đã gửi link reset mật khẩu đến email của bạn.");
                forwardToForgotPassword(request, response);
                return;
            }

            // Check if user is OAuth user
            if (user.getPasswordHash() == null) {
                String provider = user.getAuthProvider() != null ? user.getAuthProvider() : "social media";
                request.setAttribute("errorMessage", "Tài khoản này được tạo bằng " + provider + ". Vui lòng đăng nhập bằng " + provider + ".");
                forwardToForgotPassword(request, response);
                return;
            }

            // Generate reset token (6 digits for simplicity)
            String resetToken = String.format("%06d", new Random().nextInt(1000000));
            
            // Store reset token in session
            session.setAttribute("resetToken", resetToken);
            session.setAttribute("resetTokenEmail", email);
            session.setAttribute("resetTokenTime", new Timestamp(currentTime));
            session.setAttribute("forgotPasswordAttempts", sendAttempts + 1);
            
            System.out.println("Reset token generated for " + email + ": " + resetToken);

            // Send reset email
            boolean emailSent = sendResetEmail(email, resetToken);
            
            if (emailSent) {
                request.setAttribute("successMessage", "Mã reset mật khẩu đã được gửi đến email của bạn. Mã có hiệu lực trong " + RESET_TOKEN_TIMEOUT_MINUTES + " phút.");
                request.setAttribute("showResetForm", true);
                forwardToForgotPassword(request, response);
            } else {
                request.setAttribute("errorMessage", "Không thể gửi email. Vui lòng thử lại sau.");
                forwardToForgotPassword(request, response);
            }

        } catch (Exception e) {
            System.err.println("Error in handleSendResetEmail: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            forwardToForgotPassword(request, response);
        }
    }

    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("=== Reset Password Process Started ===");
        
        try {
            String resetToken = request.getParameter("resetToken");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Validation
            if (resetToken == null || resetToken.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng nhập mã reset.");
                request.setAttribute("showResetForm", true);
                forwardToForgotPassword(request, response);
                return;
            }

            if (newPassword == null || newPassword.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng nhập mật khẩu mới.");
                request.setAttribute("showResetForm", true);
                forwardToForgotPassword(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp.");
                request.setAttribute("showResetForm", true);
                forwardToForgotPassword(request, response);
                return;
            }

            if (!ValidationUtil.isValidPassword(newPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ và số.");
                request.setAttribute("showResetForm", true);
                forwardToForgotPassword(request, response);
                return;
            }

            // Verify reset token
            HttpSession session = request.getSession();
            String sessionToken = (String) session.getAttribute("resetToken");
            String sessionEmail = (String) session.getAttribute("resetTokenEmail");
            Timestamp tokenTime = (Timestamp) session.getAttribute("resetTokenTime");

            if (sessionToken == null || !sessionToken.equals(resetToken.trim())) {
                request.setAttribute("errorMessage", "Mã reset không hợp lệ.");
                request.setAttribute("showResetForm", true);
                forwardToForgotPassword(request, response);
                return;
            }

            if (sessionEmail == null) {
                request.setAttribute("errorMessage", "Phiên làm việc đã hết hạn. Vui lòng thử lại.");
                forwardToForgotPassword(request, response);
                return;
            }

            // Check token expiration
            if (tokenTime != null) {
                long currentTime = System.currentTimeMillis();
                long tokenAge = currentTime - tokenTime.getTime();
                long maxAge = RESET_TOKEN_TIMEOUT_MINUTES * 60 * 1000;
                
                if (tokenAge > maxAge) {
                    request.setAttribute("errorMessage", "Mã reset đã hết hạn. Vui lòng yêu cầu mã mới.");
                    session.removeAttribute("resetToken");
                    session.removeAttribute("resetTokenEmail");
                    session.removeAttribute("resetTokenTime");
                    forwardToForgotPassword(request, response);
                    return;
                }
            }

            // Get user and update password
            User user = userDAO.getUserByEmail(sessionEmail);
            if (user == null) {
                request.setAttribute("errorMessage", "Người dùng không tồn tại.");
                forwardToForgotPassword(request, response);
                return;
            }

            // Hash new password
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            
            // Update password in database (you need to implement this method in UserDAO)
            boolean updateResult = updateUserPassword(user.getUserId(), hashedPassword);
            
            if (updateResult) {
                // Clear reset token from session
                session.removeAttribute("resetToken");
                session.removeAttribute("resetTokenEmail");
                session.removeAttribute("resetTokenTime");
                session.removeAttribute("forgotPasswordAttempts");
                session.removeAttribute("forgotPasswordFirstAttempt");
                
                System.out.println("Password reset successfully for user: " + sessionEmail);
                request.setAttribute("successMessage", "Mật khẩu đã được reset thành công. Bạn có thể đăng nhập với mật khẩu mới.");
                
                // Redirect to login page
                response.sendRedirect(request.getContextPath() + "/login?message=password-reset-success");
            } else {
                request.setAttribute("errorMessage", "Không thể cập nhật mật khẩu. Vui lòng thử lại.");
                request.setAttribute("showResetForm", true);
                forwardToForgotPassword(request, response);
            }

        } catch (Exception e) {
            System.err.println("Error in handleResetPassword: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.setAttribute("showResetForm", true);
            forwardToForgotPassword(request, response);
        }
    }

    private boolean sendResetEmail(String email, String resetToken) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);

            Session mailSession = Session.getInstance(props, new jakarta.mail.Authenticator() {
                @Override
                protected jakarta.mail.PasswordAuthentication getPasswordAuthentication() {
                    return new jakarta.mail.PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });

            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Reset Password - FMart");
            
            String emailContent = String.format(
                "Xin chào,\n\n" +
                "Bạn đã yêu cầu reset mật khẩu cho tài khoản FMart.\n\n" +
                "Mã reset mật khẩu của bạn là: %s\n\n" +
                "Mã này sẽ hết hạn sau %d phút.\n" +
                "Vui lòng không chia sẻ mã này với bất kỳ ai.\n\n" +
                "Nếu bạn không yêu cầu reset mật khẩu, vui lòng bỏ qua email này.\n\n" +
                "Trân trọng,\n" +
                "Đội ngũ FMart", 
                resetToken, RESET_TOKEN_TIMEOUT_MINUTES
            );
            
            message.setText(emailContent);
            Transport.send(message);
            
            System.out.println("Reset password email sent successfully to " + email);
            return true;
            
        } catch (MessagingException e) {
            System.err.println("Error sending reset email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private boolean updateUserPassword(int userId, String hashedPassword) {
        // You need to implement this method in UserDAO
        String sql = "UPDATE Users SET PasswordHash = ? WHERE UserID = ?";
        try (java.sql.PreparedStatement pstmt = userDAO.getConnection().prepareStatement(sql)) {
            pstmt.setString(1, hashedPassword);
            pstmt.setInt(2, userId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("Error updating user password: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private void forwardToForgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/User/forgot_password.jsp");
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "forgot_password.jsp not found");
        }
    }

    @Override
    public void destroy() {
        System.out.println("Destroying ForgotPasswordServlet...");
        if (userDAO != null) {
            userDAO.close();
        }
    }
}