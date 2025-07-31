package controller.user;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CancelServlet", urlPatterns = {"/cancel"})
public class CancelServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        String orderCode = request.getParameter("orderCode");
        String status = request.getParameter("status");

        response.getWriter().println("<!DOCTYPE html>");
        response.getWriter().println("<html lang='vi'>");
        response.getWriter().println("<head>");
        response.getWriter().println("<meta charset='UTF-8'>");
        response.getWriter().println("<title>Hủy thanh toán</title>");
        response.getWriter().println("<style>");
        response.getWriter().println("body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }");
        response.getWriter().println(".btn { display: inline-block; padding: 10px 20px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px; margin-top: 20px; }");
        response.getWriter().println("</style>");
        response.getWriter().println("</head>");
        response.getWriter().println("<body>");
        response.getWriter().println("<h1>Thanh toán bị hủy!</h1>");
        response.getWriter().println("<p><strong>Mã đơn hàng:</strong> " + (orderCode != null ? orderCode : "Không rõ") + "</p>");
        response.getWriter().println("<p><strong>Trạng thái:</strong> " + (status != null ? status : "Không rõ") + "</p>");
        response.getWriter().println("<a class='btn' href='" + request.getContextPath() + "/shop'>Tiếp tục mua sắm</a>");
        response.getWriter().println("</body>");
        response.getWriter().println("</html>");
    }
}