package controller.user;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SuccessServlet", urlPatterns = {"/success"})
public class SuccessServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        String orderCode = request.getParameter("orderCode");
        String status = request.getParameter("status");

        response.getWriter().println("<h1>Thanh toán thành công!</h1>");
        response.getWriter().println("<p>Mã đơn hàng: " + orderCode + "</p>");
        response.getWriter().println("<p>Trạng thái: " + status + "</p>");
    }
}