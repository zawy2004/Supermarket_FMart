package controller.user;

import dao.UserDAO;
import model.User;
import util.ValidationUtil;
import util.PasswordUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

    private UserDAO userDAO;
    
    // Email configuration - same as SendVerificationCodeServlet
    private static final String EMAIL_USERNAME = "anltne0201@gmail.com";
    private static final String EMAIL_PASSWORD = "zknkwdsixhbifspr";
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;
    private static final int MAX_ATTEMPTS = 5;
    private static final int RESET_TOKEN_TIMEOUT_MINUTES = 15; // 15 phút như RegisterServlet
    private static final int RESET_COUNTER_MINUTES = 60;

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
        
        if ("verify".equals(action)) {
            // Hiển thị trang verify code
            RequestDispatcher dispatcher = request.getRequestDispatcher("/User/verify_reset_code.jsp");
            dispatcher.forward(request, response);
        } else if ("reset".equals(action)) {
            // Hiển thị trang reset password
            RequestDispatcher dispatcher = request.getRequestDispatcher("/User/reset_password.jsp");
            dispatcher.forward(request, response);
        } else {
            // Hiển thị trang forgot password
            RequestDispatcher dispatcher = request.getRequestDispatcher("/User/forgot_password.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("send-reset-code".equals(action)) {
            handleSendResetCode(request, response);
        } else if ("verify-reset-code".equals(action)) {
            handleVerifyResetCode(request, response);
        } else if ("resend-reset-code".equals(action)) {
            handleResendResetCode(request, response);
        } else if ("reset-password".equals(action)) {
            handleResetPassword(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void handleSendResetCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== Send Reset Code Process Started ===");
        
        try {
            String email = request.getParameter("emailaddress"); // Match JSP field name
            
            // Validation
            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập email.");
                forwardToForgotPassword(request, response);
                return;
            }
            
            if (!ValidationUtil.isValidEmail(email)) {
                request.setAttribute("error", "Email không hợp lệ.");
                forwardToForgotPassword(request, response);
                return;
            }
            
            // Rate limiting check - sử dụng cùng logic với RegisterServlet
            HttpSession session = request.getSession();
            Integer sendAttempts = (Integer) session.getAttribute("resetAttempts");
            Long firstAttemptTime = (Long) session.getAttribute("resetFirstAttemptTime");
            long currentTime = System.currentTimeMillis();
            
            // Reset counter if time passed
            if (firstAttemptTime != null && 
                (currentTime - firstAttemptTime) > (RESET_COUNTER_MINUTES * 60 * 1000)) {
                sendAttempts = 0;
                session.removeAttribute("resetAttempts");
                session.removeAttribute("resetFirstAttemptTime");
                firstAttemptTime = null;
            }
            
            if (sendAttempts == null) {
                sendAttempts = 0;
                firstAttemptTime = currentTime;
                session.setAttribute("resetFirstAttemptTime", firstAttemptTime);
            }
            
            if (sendAttempts >= MAX_ATTEMPTS) {
                long timeRemaining = RESET_COUNTER_MINUTES * 60 * 1000 - (currentTime - firstAttemptTime);
                long minutesRemaining = timeRemaining / (60 * 1000);
                
                request.setAttribute("error", 
                    "Bạn đã gửi quá nhiều yêu cầu (" + MAX_ATTEMPTS + "). Vui lòng thử lại sau " + minutesRemaining + " phút.");
                forwardToForgotPassword(request, response);
                return;
            }
            
            // Check if user exists
            User user = userDAO.getUserByEmail(email.trim());
            if (user == null) {
                // For security, still redirect to verify page even if user doesn't exist
                session.setAttribute("resetEmail", email.trim());
                response.sendRedirect(request.getContextPath() + "/forgot-password?action=verify");
                return;
            }
            
            // Check if account is active
            if (!user.isActive()) {
                request.setAttribute("error", "Tài khoản đã bị khóa. Vui lòng liên hệ admin.");
                forwardToForgotPassword(request, response);
                return;
            }
            
            // Check if OAuth account
            if (user.getPasswordHash() == null) {
                String provider = user.getAuthProvider() != null ? user.getAuthProvider() : "social media";
                request.setAttribute("error", 
                    "Tài khoản này được tạo bằng " + provider + ". Vui lòng đăng nhập bằng " + provider + ".");
                forwardToForgotPassword(request, response);
                return;
            }
            
            // Generate 4-digit reset token (same as RegisterServlet)
            String resetToken = String.format("%04d", new Random().nextInt(10000));
            
            // Save to session (using same session attributes as RegisterServlet)
            session.setAttribute("verifyCode", resetToken); // Same as RegisterServlet
            session.setAttribute("verifyCodeTime", new Timestamp(currentTime)); // Same as RegisterServlet
            session.setAttribute("resetEmail", email.trim());
            session.setAttribute("resetAttempts", sendAttempts + 1);
            session.setAttribute("sendAttempts", 0); // Reset resend counter for verify page
            
            // Set session timeout to OTP timeout (15 minutes)
            session.setMaxInactiveInterval(RESET_TOKEN_TIMEOUT_MINUTES * 60);
            
            System.out.println("Reset token generated: " + resetToken + " for email: " + email);
            
            // Send email
            boolean emailSent = sendResetEmail(email.trim(), resetToken, user.getFullName());
            
            if (emailSent) {
                // Redirect to verify page
                response.sendRedirect(request.getContextPath() + "/forgot-password?action=verify");
                System.out.println("Reset email sent successfully to: " + email);
            } else {
                request.setAttribute("error", "Không thể gửi email. Vui lòng thử lại sau.");
                forwardToForgotPassword(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Send reset code error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            forwardToForgotPassword(request, response);
        }
    }

    private void handleVerifyResetCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== Verify Reset Code Process Started ===");
        
        try {
            // Get OTP from input fields (4 digits like RegisterServlet)
            String code1 = request.getParameter("code1");
            String code2 = request.getParameter("code2");
            String code3 = request.getParameter("code3");
            String code4 = request.getParameter("code4");
            
            // Check all OTP fields are not null and not empty
            if (code1 == null || code1.trim().isEmpty() ||
                code2 == null || code2.trim().isEmpty() ||
                code3 == null || code3.trim().isEmpty() ||
                code4 == null || code4.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ mã OTP 4 số.");
                forwardToVerifyCode(request, response);
                return;
            }
            
            String code = code1.trim() + code2.trim() + code3.trim() + code4.trim();
            
            // Check OTP contains only numbers and is exactly 4 characters
            if (!code.matches("\\d{4}")) {
                request.setAttribute("errorMessage", "Mã OTP phải là 4 chữ số.");
                forwardToVerifyCode(request, response);
                return;
            }
            
            // Get OTP and creation time from session (same as RegisterServlet)
            HttpSession session = request.getSession();
            String verifyCode = (String) session.getAttribute("verifyCode"); // Same as RegisterServlet
            Timestamp codeTime = (Timestamp) session.getAttribute("verifyCodeTime"); // Same as RegisterServlet
            String resetEmail = (String) session.getAttribute("resetEmail");
            
            System.out.println("OTP Verification:");
            System.out.println("- OTP entered: " + code);
            System.out.println("- OTP session: " + verifyCode);
            System.out.println("- Email: " + resetEmail);
            
            // Check OTP
            if (verifyCode == null) {
                request.setAttribute("errorMessage", "Bạn chưa gửi mã xác thực hoặc đã hết hạn, hãy nhấn Gửi lại!");
                forwardToVerifyCode(request, response);
                return;
            }
            
            if (!verifyCode.equals(code)) {
                request.setAttribute("errorMessage", "Mã xác minh không đúng, hãy kiểm tra lại mã gửi về email.");
                forwardToVerifyCode(request, response);
                return;
            }
            
            // Check expiration time
            if (codeTime != null) {
                long currentTime = System.currentTimeMillis();
                long otpTime = codeTime.getTime();
                long timeDiff = currentTime - otpTime;
                long maxTime = RESET_TOKEN_TIMEOUT_MINUTES * 60 * 1000; // 15 minutes
                
                if (timeDiff > maxTime) {
                    request.setAttribute("errorMessage", "Mã xác minh đã hết hạn, hãy nhấn Gửi lại!");
                    forwardToVerifyCode(request, response);
                    return;
                }
            }
            
            System.out.println("Reset code verification passed successfully");
            
            // Mark as verified
            session.setAttribute("codeVerified", true);
            
            // Redirect to reset password page
            response.sendRedirect(request.getContextPath() + "/forgot-password?action=reset");
            
        } catch (Exception e) {
            System.err.println("Verify reset code error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            forwardToVerifyCode(request, response);
        }
    }

    private void handleResendResetCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession();
            String resetEmail = (String) session.getAttribute("resetEmail");
            
            if (resetEmail == null) {
                out.write("{\"status\":\"error\",\"message\":\"Phiên làm việc đã hết hạn.\"}");
                return;
            }
            
            // Check rate limiting for resend (same logic as SendVerificationCodeServlet)
            Integer sendAttempts = (Integer) session.getAttribute("sendAttempts");
            if (sendAttempts == null) {
                sendAttempts = 0;
            }
            
            if (sendAttempts >= 3) {
                out.write("{\"status\":\"error\",\"message\":\"Bạn đã gửi lại quá nhiều lần. Vui lòng thử lại sau.\"}");
                return;
            }
            
            // Generate new 4-digit code
            String newResetToken = String.format("%04d", new Random().nextInt(10000));
            long currentTime = System.currentTimeMillis();
            
            // Update session
            session.setAttribute("verifyCode", newResetToken);
            session.setAttribute("verifyCodeTime", new Timestamp(currentTime));
            session.setAttribute("sendAttempts", sendAttempts + 1);
            
            // Get user info
            User user = userDAO.getUserByEmail(resetEmail);
            String fullName = (user != null) ? user.getFullName() : "Người dùng";
            
            // Send new email
            boolean emailSent = sendResetEmail(resetEmail, newResetToken, fullName);
            
            if (emailSent) {
                int remainingAttempts = 3 - (sendAttempts + 1);
                String successMessage = String.format(
                    "Mã xác thực mới đã được gửi đến %s. Còn lại %d lần gửi.", 
                    resetEmail, remainingAttempts
                );
                out.write("{\"status\":\"success\",\"message\":\"" + successMessage + "\"}");
                System.out.println("New reset code sent to: " + resetEmail);
            } else {
                out.write("{\"status\":\"error\",\"message\":\"Không thể gửi email. Vui lòng thử lại sau.\"}");
            }
            
        } catch (Exception e) {
            System.err.println("Resend reset code error: " + e.getMessage());
            e.printStackTrace();
            out.write("{\"status\":\"error\",\"message\":\"Lỗi hệ thống.\"}");
        } finally {
            out.close();
        }
    }

    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== Reset Password Process Started ===");
        
        try {
            String newPassword = request.getParameter("passwordnew");
            String confirmPassword = request.getParameter("passwordconfirm");
            
            HttpSession session = request.getSession();
            Boolean codeVerified = (Boolean) session.getAttribute("codeVerified");
            String resetEmail = (String) session.getAttribute("resetEmail");
            
            // Check if code was verified
            if (codeVerified == null || !codeVerified) {
                request.setAttribute("error", "Vui lòng xác thực mã OTP trước.");
                response.sendRedirect(request.getContextPath() + "/forgot-password?action=verify");
                return;
            }
            
            // Validation
            if (newPassword == null || newPassword.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập mật khẩu mới.");
                forwardToResetPassword(request, response);
                return;
            }
            
            if (!ValidationUtil.isValidPassword(newPassword)) {
                request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ và số.");
                forwardToResetPassword(request, response);
                return;
            }
            
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
                forwardToResetPassword(request, response);
                return;
            }
            
            if (resetEmail == null) {
                request.setAttribute("error", "Phiên làm việc đã hết hạn. Vui lòng thử lại.");
                forwardToResetPassword(request, response);
                return;
            }
            
            // Get user from database
            User user = userDAO.getUserByEmail(resetEmail);
            if (user == null) {
                request.setAttribute("error", "Tài khoản không tồn tại.");
                forwardToResetPassword(request, response);
                return;
            }
            
            // Hash new password
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            
            // Update password in database
            boolean updateResult = userDAO.updateUserPassword(user.getUserId(), hashedPassword);
            
            if (updateResult) {
                // Clear all reset-related session attributes
                session.removeAttribute("verifyCode");
                session.removeAttribute("verifyCodeTime");
                session.removeAttribute("resetEmail");
                session.removeAttribute("resetAttempts");
                session.removeAttribute("resetFirstAttemptTime");
                session.removeAttribute("sendAttempts");
                session.removeAttribute("codeVerified");
                
                System.out.println("Password updated successfully for user: " + resetEmail);
                
                // Redirect to login with success message
                HttpSession newSession = request.getSession();
                newSession.setAttribute("loginSuccessMessage", "Mật khẩu đã được cập nhật thành công! Vui lòng đăng nhập với mật khẩu mới.");
                response.sendRedirect(request.getContextPath() + "/login");
                
            } else {
                request.setAttribute("error", "Không thể cập nhật mật khẩu. Vui lòng thử lại.");
                forwardToResetPassword(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Reset password error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            forwardToResetPassword(request, response);
        }
    }

    private boolean sendResetEmail(String email, String resetToken, String fullName) {
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

            mailSession.setDebug(false);

            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Your Password Reset Code for Fmart");
            
            // Create email content (similar to SendVerificationCodeServlet)
            String emailContent = String.format(
                "Xin chào %s,\n\n" +
                "Chúng tôi nhận được yêu cầu reset password cho tài khoản Fmart của bạn.\n\n" +
                "Mã xác thực reset password của bạn là: %s\n\n" +
                "Mã này sẽ hết hạn sau %d phút.\n" +
                "Vui lòng không chia sẻ mã này với bất kỳ ai.\n\n" +
                "Nếu bạn không yêu cầu reset password, vui lòng bỏ qua email này.\n\n" +
                "Trân trọng,\n" +
                "Đội ngũ Fmart", 
                fullName != null ? fullName : "bạn", 
                resetToken, 
                RESET_TOKEN_TIMEOUT_MINUTES
            );
            
            message.setText(emailContent);
            Transport.send(message);
            
            return true;
            
        } catch (MessagingException e) {
            System.err.println("Failed to send reset email: " + e.getMessage());
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

    private void forwardToVerifyCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/User/verify_reset_code.jsp");
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "verify_reset_code.jsp not found");
        }
    }

    private void forwardToResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/User/reset_password.jsp");
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "reset_password.jsp not found");
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