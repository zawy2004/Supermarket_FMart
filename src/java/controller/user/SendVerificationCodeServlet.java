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
    private static final int MAX_ATTEMPTS = 3;

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
            if (sendAttempts == null) sendAttempts = 0;
            if (sendAttempts >= MAX_ATTEMPTS) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"status\":\"error\",\"message\":\"Maximum send attempts reached (3).\"}");
                return;
            }

            String code = String.format("%04d", new Random().nextInt(10000));
            session.setAttribute("verifyCode", code);
            session.setMaxInactiveInterval(300); // 5 minutes
            session.setAttribute("sendAttempts", sendAttempts + 1);

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

            mailSession.setDebug(true); // Bật debug để xem log email

            try {
                Message message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress(EMAIL_USERNAME));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                message.setSubject("Your Verification Code for Fmart");
                message.setText("Your verification code is: " + code + ". It expires in 5 minutes.");
                Transport.send(message);
                response.setStatus(HttpServletResponse.SC_OK);
                out.write("{\"status\":\"success\",\"message\":\"Verification code sent to " + email + "\"}");
                System.out.println("OTP sent successfully to " + email + " at " + new java.util.Date());
            } catch (MessagingException e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"status\":\"error\",\"message\":\"Failed to send verification code: " + e.getMessage() + "\"}");
                System.err.println("Email sending failed: " + e.getMessage());
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"status\":\"error\",\"message\":\"Server error: " + e.getMessage() + "\"}");
            System.err.println("Servlet error: " + e.getMessage());
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