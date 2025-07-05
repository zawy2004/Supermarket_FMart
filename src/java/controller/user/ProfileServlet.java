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
        // nếu sau này cần update thông tin user
        doGet(request, response);
    }
}
