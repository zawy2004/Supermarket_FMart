package controller.user;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Order;
import model.User;

@WebServlet("/orders")
public class MyOrdersServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = user.getUserId(); // Giả sử User có method getUserID()
        List<Order> orders = orderDAO.getOrdersByCustomerId(customerId);

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("User/dashboard_my_orders.jsp").forward(request, response);
    }
}
