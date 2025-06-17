package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ResetOTPCounterServlet", urlPatterns = {"/ResetOTPCounterServlet"})
public class ResetOTPCounterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession();
            
            // Reset tất cả các attribute liên quan đến OTP
            session.removeAttribute("sendAttempts");
            session.removeAttribute("firstAttemptTime");
            session.removeAttribute("verifyCode");
            session.removeAttribute("verifyCodeTime");
            
            System.out.println("OTP counter reset for session: " + session.getId());
            
            response.setStatus(HttpServletResponse.SC_OK);
            out.write("{\"status\":\"success\",\"message\":\"OTP counter đã được reset. Bạn có thể gửi lại mã xác thực.\"}");
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"status\":\"error\",\"message\":\"Lỗi khi reset counter: " + e.getMessage() + "\"}");
            System.err.println("Reset counter error: " + e.getMessage());
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