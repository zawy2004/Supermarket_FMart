package controller.user;

import dao.OrderDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.OrderDetail;
import java.io.IOException;
import java.util.List;

@WebServlet("/order_detail")
public class OrderDetailServlet extends HttpServlet {
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");

        // Kiểm tra null hoặc rỗng
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.sendRedirect("User/dashboard_my_orders.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);

            List<OrderDetail> orderDetails = orderDetailDAO.getDetailsByOrderId(orderId);

            if (orderDetails == null || orderDetails.isEmpty()) {
                request.setAttribute("error", "No order details found for this order.");
            }

            request.setAttribute("orderId", orderId);
            request.setAttribute("orderDetails", orderDetails);

            request.getRequestDispatcher("User/order_detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Nếu orderId không phải là số
            response.sendRedirect("User/dashboard_my_orders.jsp");
        }
    }
}