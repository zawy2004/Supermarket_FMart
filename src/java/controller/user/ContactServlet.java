package controller.user;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final String EMAIL_HOST = "smtp.gmail.com";
    private static final String EMAIL_USER = "duyluong2892004@gmail.com";
    private static final String EMAIL_PASS = "rpjz xfza mlux jsdl"; // App Password
    private static final String TO_EMAIL = "duyluong2892004@gmail.com"; // Admin nhận thông báo

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String name = request.getParameter("sendername");
        String email = request.getParameter("emailaddress");
        String subject = request.getParameter("sendersubject");
        String message = request.getParameter("sendermessage");
        String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

        boolean isError = false;
        String resultMessage = "";

        // 1. Gửi email cho admin
        try {
            sendEmail(name, email, subject, message, timestamp);
        } catch (Exception ex) {
            isError = true;
            resultMessage = "Không thể gửi email: " + ex.getMessage();
            ex.printStackTrace();
        }

        // 2. Lưu vào file CSV nếu gửi email không lỗi
        if (!isError) {
            try {
                saveToCSV(name, email, subject, message, timestamp);
            } catch (Exception ex) {
                isError = true;
                resultMessage = "Không thể lưu vào file CSV: " + ex.getMessage();
                ex.printStackTrace();
            }
        }

        // 3. Trả kết quả về giao diện
        if (!isError) {
            request.setAttribute("success", "Yêu cầu của bạn đã được gửi thành công!");
        } else {
            request.setAttribute("error", resultMessage);
        }
        request.getRequestDispatcher("User/contact_us.jsp").forward(request, response);
    }

    private void sendEmail(String name, String email, String subject, String message, String timestamp) throws MessagingException, UnsupportedEncodingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", EMAIL_HOST);
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USER, EMAIL_PASS);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(EMAIL_USER, "FMart Contact Bot"));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(TO_EMAIL));
        msg.setSubject("Yêu Cầu Hỗ Trợ: " + subject);
        msg.setText(
                "Yêu Cầu Hỗ Trợ từ FMart\n\n" +
                "Họ và Tên: " + name + "\n" +
                "Email: " + email + "\n" +
                "Chủ Đề: " + subject + "\n" +
                "Nội Dung:\n" + message + "\n" +
                "Thời Gian: " + timestamp
        );
        Transport.send(msg);
    }

    private void saveToCSV(String name, String email, String subject, String message, String timestamp) throws IOException {
        // Lưu tại folder gốc của project/webapp hoặc đặt lại đường dẫn tùy bạn
        String filePath = getServletContext().getRealPath("/") + "contact_log.csv";
        boolean writeHeader = false;
        File file = new File(filePath);
        if (!file.exists()) {
            writeHeader = true;
        }
        try (FileWriter fw = new FileWriter(file, true)) {
            if (writeHeader) {
                fw.write("Họ tên,Email,Chủ đề,Nội dung,Thời gian\n");
            }
            // Escape dấu phẩy trong nội dung
            String row = String.format("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
                    name.replace("\"", "\"\""),
                    email.replace("\"", "\"\""),
                    subject.replace("\"", "\"\""),
                    message.replace("\"", "\"\""),
                    timestamp);
            fw.write(row);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.getRequestDispatcher("User/contact_us.jsp").forward(request, response);
    }
}
