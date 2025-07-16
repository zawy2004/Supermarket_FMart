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
                
                // Xóa tất cả session attributes liên quan đến user
                session.removeAttribute("user");
                session.removeAttribute("userEmail");
                session.removeAttribute("userFullName");
                session.removeAttribute("userId");
                session.removeAttribute("loginType");
                
                // Xóa các session attributes khác có thể có
                session.removeAttribute("redirectAfterLogin");
                session.removeAttribute("loginSuccessMessage");
                session.removeAttribute("resetToken");
                session.removeAttribute("resetTokenTime");
                session.removeAttribute("resetEmail");
                session.removeAttribute("resetAttempts");
                session.removeAttribute("resetFirstAttemptTime");
                session.removeAttribute("resendAttempts");
                session.removeAttribute("codeVerified");
                session.removeAttribute("verifyCode");
                session.removeAttribute("verifyCodeTime");
                session.removeAttribute("sendAttempts");
                
                // Invalidate toàn bộ session
                session.invalidate();
                System.out.println("Session invalidated successfully");
            }
            
            // Xóa tất cả cookies liên quan đến user
            clearAllUserCookies(response);
            
            System.out.println("All user cookies cleared");
            System.out.println("=== Logout Process Completed ===");
            
            // Chuyển hướng về trang home với thông báo logout thành công
            response.sendRedirect(request.getContextPath() + "/home?logout=success");
            
        } catch (Exception e) {
            System.err.println("Logout error: " + e.getMessage());
            e.printStackTrace();
            
            // Vẫn chuyển về home page ngay cả khi có lỗi
            response.sendRedirect(request.getContextPath() + "/home?logout=error");
        }
    }
    
    private void clearAllUserCookies(HttpServletResponse response) {
        // Danh sách các cookies cần xóa
        String[] cookiesToClear = {
            "rememberedEmail",
            "rememberedPassword", 
            "userInfo",
            "loginToken",
            "sessionId",
            "authToken",
            "userPrefs"
        };
        
        for (String cookieName : cookiesToClear) {
            Cookie cookie = new Cookie(cookieName, "");
            cookie.setMaxAge(0);
            cookie.setPath("/");
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
        }
        
        System.out.println("Cleared cookies: " + String.join(", ", cookiesToClear));
    }
}