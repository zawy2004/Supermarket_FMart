package controller.user;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

public class BlognosidebarServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Có thể thêm logic xử lý dữ liệu ở đây
        // Ví dụ: lấy danh sách offers từ database
        
        // Forward đến JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/User/blog_no_sidebar.jsp");
        dispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Xử lý POST request nếu cần
        doGet(request, response);
    }
}