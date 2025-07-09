package controller.user;

import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // chưa đăng nhập → chuyển về login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "overview"; // mặc định
        }

        String destinationJsp = "";

        switch (action) {
            case "overview":
                destinationJsp = "User/dashboard_overview.jsp";
                break;
            case "orders":
                destinationJsp = "User/dashboard_my_orders.jsp";
                break;
            case "wishlist":
                destinationJsp = "User/dashboard_my_wishlist.jsp";
                break;
            case "wallet":
                destinationJsp = "User/dashboard_my_wallet.jsp";
                break;
            case "addresses":
                destinationJsp = "User/dashboard_my_addresses.jsp";
                break;
            default:
                destinationJsp = "User/dashboard_overview.jsp";
                break;
        }

        request.setAttribute("user", user); // có thể dùng trong jsp
        request.getRequestDispatcher(destinationJsp).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("updateAddress".equals(action)) {
            String newAddress = request.getParameter("address");

            if (newAddress != null && newAddress.trim().length() >= 10) {
                user.setAddress(newAddress);

                // ✅ GỌI DAO để cập nhật vào DB
                dao.UserDAO userDAO = new dao.UserDAO();
                userDAO.updateAddress(user.getUserId(), newAddress);

                // ✅ Cập nhật lại session từ DB (đảm bảo đồng bộ)
                User updatedUser = userDAO.getUserById(user.getUserId());
                session.setAttribute("user", updatedUser);

                request.setAttribute("success", "Address updated successfully.");
            } else {
                request.setAttribute("error", "Address must be at least 10 characters.");
            }

            request.setAttribute("user", session.getAttribute("user")); // đảm bảo đúng user mới
            request.getRequestDispatcher("User/dashboard_my_addresses.jsp").forward(request, response);
            return;
        }

        doGet(request, response);
    }

}
