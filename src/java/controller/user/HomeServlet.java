package controller.user;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== HomeServlet accessed ===");
        
        try {
            // Kiểm tra trạng thái đăng nhập
            HttpSession session = request.getSession(false);
            boolean isLoggedIn = session != null && session.getAttribute("userId") != null;
            
            System.out.println("User login status: " + isLoggedIn);
            
            // Set các attributes để JSP sử dụng
            request.setAttribute("isLoggedIn", isLoggedIn);
            
            if (isLoggedIn) {
                // Nếu đã đăng nhập, set thông tin user
                request.setAttribute("userFullName", session.getAttribute("userFullName"));
                request.setAttribute("userEmail", session.getAttribute("userEmail"));
                request.setAttribute("userId", session.getAttribute("userId"));
                
                System.out.println("User info set - Name: " + session.getAttribute("userFullName") + 
                                 ", Email: " + session.getAttribute("userEmail"));
            }
            
            // Kiểm tra có thông báo logout không (từ URL parameter)
            String logoutMessage = request.getParameter("logout");
            if ("success".equals(logoutMessage)) {
                request.setAttribute("logoutMessage", "Bạn đã đăng xuất thành công!");
            }
            
            // Forward đến trang index
            request.getRequestDispatcher("/User/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("HomeServlet error: " + e.getMessage());
            e.printStackTrace();
            
            // Nếu có lỗi, vẫn forward đến index nhưng không set user info
            request.setAttribute("isLoggedIn", false);
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi tải trang chủ.");
            request.getRequestDispatcher("/User/index.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}