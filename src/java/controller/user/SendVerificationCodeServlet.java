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

@WebServlet(name = "SendVerificationCodeServlet", urlPatterns = {"/SendVerificationCodeServlet"})
public class SendVerificationCodeServlet extends HttpServlet {

    private static final String EMAIL_USERNAME = "anltne0201@gmail.com"; // Thay bằng email của bạn
    private static final String EMAIL_PASSWORD = "zknkwdsixhbifspr"; // Thay bằng App Password nếu dùng 2FA
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;
    private static final int MAX_ATTEMPTS = 10; // Tăng lên 10 lần
    private static final int OTP_TIMEOUT_MINUTES = 15; // 15 phút
    private static final int RESET_COUNTER_MINUTES = 60; // Reset counter sau 60 phút

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String email = request.getParameter("emailaddress");

        try {
            if (email == null || !ValidationUtil.isValidEmail(email)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"status\":\"error\",\"message\":\"Invalid email format.\"}");
                return;
            }
            
            HttpSession session = request.getSession();
            Integer sendAttempts = (Integer) session.getAttribute("sendAttempts");
            Long firstAttemptTime = (Long) session.getAttribute("firstAttemptTime");
            long currentTime = System.currentTimeMillis();
            
            // Reset counter nếu đã quá thời gian reset (60 phút)
            if (firstAttemptTime != null && 
                (currentTime - firstAttemptTime) > (RESET_COUNTER_MINUTES * 60 * 1000)) {
                System.out.println("Resetting send attempts counter after " + RESET_COUNTER_MINUTES + " minutes");
                sendAttempts = 0;
                session.removeAttribute("sendAttempts");
                session.removeAttribute("firstAttemptTime");
                firstAttemptTime = null;
            }
            
            if (sendAttempts == null) {
                sendAttempts = 0;
                firstAttemptTime = currentTime;
                session.setAttribute("firstAttemptTime", firstAttemptTime);
            }
            
            if (sendAttempts >= MAX_ATTEMPTS) {
                long timeRemaining = RESET_COUNTER_MINUTES * 60 * 1000 - (currentTime - firstAttemptTime);
                long minutesRemaining = timeRemaining / (60 * 1000);
                
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"status\":\"error\",\"message\":\"Bạn đã gửi quá nhiều lần (" + MAX_ATTEMPTS + "). Vui lòng thử lại sau " + minutesRemaining + " phút.\"}");
                return;
            }

            // Sinh OTP 4 chữ số
            String code = String.format("%04d", new Random().nextInt(10000));

            // Lưu mã OTP và thời gian gửi vào session
            session.setAttribute("verifyCode", code);
            session.setAttribute("verifyCodeTime", new java.sql.Timestamp(currentTime));
            session.setAttribute("sendAttempts", sendAttempts + 1);
            
            // Set session timeout to OTP timeout (15 minutes)
            session.setMaxInactiveInterval(OTP_TIMEOUT_MINUTES * 60);

            // Log để debug
            System.out.println("Send OTP - sessionID: " + session.getId() + 
                             " | OTP: " + code + 
                             " | Time: " + new java.sql.Timestamp(currentTime) +
                             " | Email: " + email +
                             " | Attempt: " + (sendAttempts + 1) + "/" + MAX_ATTEMPTS);

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

            // Tắt debug để không spam log
            mailSession.setDebug(false);

            try {
                Message message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress(EMAIL_USERNAME));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                message.setSubject("Your Verification Code for Fmart");
                
                // Tạo email content đẹp hơn và rõ ràng hơn
                String emailContent = String.format(
                    "Xin chào,\n\n" +
                    "Mã xác thực của bạn cho Fmart là: %s\n\n" +
                    "Mã này sẽ hết hạn sau %d phút.\n" +
                    "Vui lòng không chia sẻ mã này với bất kỳ ai.\n\n" +
                    "Nếu bạn không yêu cầu mã này, vui lòng bỏ qua email này.\n\n" +
                    "Trân trọng,\n" +
                    "Đội ngũ Fmart", 
                    code, OTP_TIMEOUT_MINUTES
                );
                
                message.setText(emailContent);
                Transport.send(message);
                
                response.setStatus(HttpServletResponse.SC_OK);
                int remainingAttempts = MAX_ATTEMPTS - (sendAttempts + 1);
                String successMessage = String.format(
                    "Mã xác thực đã được gửi đến %s. Còn lại %d lần gửi.", 
                    email, remainingAttempts
                );
                out.write("{\"status\":\"success\",\"message\":\"" + successMessage + "\"}");
                System.out.println("OTP sent successfully to " + email + " at " + new java.util.Date());
                
            } catch (MessagingException e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"status\":\"error\",\"message\":\"Không thể gửi mã xác thực: " + e.getMessage() + "\"}");
                System.err.println("Email sending failed: " + e.getMessage());
                e.printStackTrace();
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"status\":\"error\",\"message\":\"Lỗi server: " + e.getMessage() + "\"}");
            System.err.println("Servlet error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET not supported.");
    }
}