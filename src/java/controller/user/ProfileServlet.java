package controller.user;

import model.User;
import dao.UserDAO;
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
            // Chưa đăng nhập → chuyển về login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "overview"; // Mặc định
        }

        String destinationJsp;
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

        request.setAttribute("user", user);
        request.getRequestDispatcher(destinationJsp).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        UserDAO userDAO = new UserDAO();

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        // 1. Cập nhật thông tin cá nhân
        if ("updateInfo".equals(action)) {
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            // Có thể thêm các field khác nếu muốn

            // Kiểm tra dữ liệu đầu vào nếu cần (ví dụ không để trống)
            boolean valid = fullName != null && !fullName.trim().isEmpty();

            if (valid) {
                user.setFullName(fullName);
                user.setPhoneNumber(phoneNumber);

                boolean updated = userDAO.updateUserInfo(user);
                if (updated) {
                    // Cập nhật lại session cho đồng bộ
                    session.setAttribute("user", userDAO.getUserById(user.getUserId()));
                    request.setAttribute("msg", "Thông tin đã được cập nhật.");
                } else {
                    request.setAttribute("error", "Lỗi cập nhật, thử lại sau.");
                }
            } else {
                request.setAttribute("error", "Tên không được để trống!");
            }

            request.setAttribute("user", session.getAttribute("user"));
            request.getRequestDispatcher("User/dashboard_overview.jsp").forward(request, response);
            return;
        }

        // 2. Đổi mật khẩu
        if ("changePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (currentPassword == null || newPassword == null || confirmPassword == null) {
                request.setAttribute("error", "Không được bỏ trống các trường!");
            } else if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu mới không khớp!");
            } else if (!userDAO.checkUserPassword(user.getUserId(), currentPassword)) {
                request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            } else {
                boolean changed = userDAO.updateUserPassword(user.getUserId(), newPassword);
                if (changed) {
                    request.setAttribute("msg", "Đổi mật khẩu thành công!");
                } else {
                    request.setAttribute("error", "Đổi mật khẩu thất bại!");
                }
            }

            request.setAttribute("user", session.getAttribute("user"));
            request.getRequestDispatcher("User/dashboard_overview.jsp").forward(request, response);
            return;
        }

        // 3. Cập nhật địa chỉ (giữ nguyên như bạn cũ, có thể dùng chung cho nhiều trường)
        if ("updateAddress".equals(action)) {
            String newAddress = request.getParameter("address");

            if (newAddress != null && newAddress.trim().length() >= 10) {
                user.setAddress(newAddress);
                userDAO.updateAddress(user.getUserId(), newAddress);
                session.setAttribute("user", userDAO.getUserById(user.getUserId()));
                request.setAttribute("success", "Address updated successfully.");
            } else {
                request.setAttribute("error", "Address must be at least 10 characters.");
            }
            request.setAttribute("user", session.getAttribute("user"));
            request.getRequestDispatcher("User/dashboard_my_addresses.jsp").forward(request, response);
            return;
        }

        // Xử lý các post action khác ở đây (nếu cần)

        // Mặc định load lại trang overview
        doGet(request, response);
    }
}
