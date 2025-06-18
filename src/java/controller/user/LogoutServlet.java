package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleLogout(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleLogout(request, response);
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== Logout Process Started ===");
        
        try {
            HttpSession session = request.getSession(false);
            
            if (session != null) {
                String userEmail = (String) session.getAttribute("userEmail");
                String loginType = (String) session.getAttribute("loginType");
                
                System.out.println("Logging out user: " + userEmail + " (LoginType: " + loginType + ")");
                
                // Xóa tất cả attributes trong session
                session.invalidate();
                System.out.println("Session invalidated successfully");
            }
            
            // Xóa Remember Me cookie nếu user logout
            Cookie emailCookie = new Cookie("rememberedEmail", "");
            emailCookie.setMaxAge(0);
            emailCookie.setPath("/");
            emailCookie.setHttpOnly(true);
            response.addCookie(emailCookie);
            
            System.out.println("Remember Me cookie cleared");
            System.out.println("=== Logout Process Completed ===");
            
            // Chuyển hướng về trang login với thông báo
            HttpSession newSession = request.getSession();
            newSession.setAttribute("logoutMessage", "Bạn đã đăng xuất thành công!");
            
            response.sendRedirect(request.getContextPath() + "/login");
            
        } catch (Exception e) {
            System.err.println("Logout error: " + e.getMessage());
            e.printStackTrace();
            
            // Vẫn chuyển về login page ngay cả khi có lỗi
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}