package controller.user;

import util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/**
 * Servlet xử lý gửi mã xác minh đến email người dùng.
 * Nhận email từ request, validate, sinh mã, và gửi qua email từ tài khoản cố định.
 */
@WebServlet(name = "SendVerificationCodeServlet", urlPatterns = {"/SendVerificationCodeServlet"})
public class SendVerificationCodeServlet extends HttpServlet {

    // Cấu hình email cố định (thay EMAIL_PASSWORD bằng mật khẩu thực tế của bạn)
    private static final String EMAIL_USERNAME = "anltne0201@gmail.com"; // Email của Fmart
    private static final String EMAIL_PASSWORD = "Ancute1233@";     // Thay bằng mật khẩu ứng dụng nếu dùng 2FA
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nhận email từ request (email của khách hàng)
        String email = request.getParameter("emailaddress");
        response.setContentType("text/plain;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Validate định dạng email của khách hàng
            if (email == null || !ValidationUtil.isValidEmail(email)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"status\":\"error\",\"message\":\"Invalid email format.\"}");
                return;
            }

            // Sinh mã ngẫu nhiên 4 chữ số
            String code = String.format("%04d", new Random().nextInt(10000)); // Ex: "0234"
            HttpSession session = request.getSession();
            session.setAttribute("verifyCode", code); // Lưu mã vào session
            session.setMaxInactiveInterval(300); // Mã hết hạn sau 5 phút

            System.out.println("Generated OTP for " + email + ": " + code); // Debug log

            // Cấu hình và gửi email
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

            mailSession.setDebug(true); // Bật debug cho mail session

            try {
                Message message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress(EMAIL_USERNAME)); // Gửi từ email Fmart
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email)); // Gửi đến email khách hàng
                message.setSubject("Your Verification Code for Fmart");
                message.setText("Your verification code is: " + code);

                Transport.send(message);
                response.setStatus(HttpServletResponse.SC_OK);
                out.write("{\"status\":\"success\",\"message\":\"Verification code sent to " + email + "\"}");
                System.out.println("Email sent successfully to " + email);
            } catch (MessagingException e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"status\":\"error\",\"message\":\"Failed to send verification code: " + e.getMessage() + "\"}");
                System.out.println("Failed to send email to " + email + ": " + e.getMessage()); // Debug log
                e.printStackTrace();
            }
        }
    }

    // Disable GET method for this servlet
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET not supported.");
    }

    @Override
    public String getServletInfo() {
        return "SendVerificationCodeServlet - Gửi mã xác thực đến email hợp lệ";
    }
}