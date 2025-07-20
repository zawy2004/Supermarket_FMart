package controller.user;

import dao.WishlistDAO;
import jakarta.servlet.ServletException; // Để lấy thêm thông tin sản phẩm nếu cần
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private WishlistDAO wishlistDAO = new WishlistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy user từ session (giả sử đã đăng nhập)
        HttpSession session = request.getSession();
        model.User user = (model.User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int userID = user.getUserId();

        // Lấy list sản phẩm wishlist
        List<Product> wishlistItems = wishlistDAO.getWishlistProducts(userID);
        request.setAttribute("wishlistItems", wishlistItems);

        // Chuyển đến trang JSP để hiển thị wishlist
        request.getRequestDispatcher("User/dashboard_my_wishlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy user từ session
        HttpSession session = request.getSession();
        model.User user = (model.User) session.getAttribute("user");
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        int userID = user.getUserId();

        String action = request.getParameter("action");
        int productID = Integer.parseInt(request.getParameter("productId"));

        boolean result = false;

        if ("add".equals(action)) {
            // Kiểm tra đã có chưa, nếu chưa thì thêm
            if (!wishlistDAO.existsInWishlist(userID, productID)) {
                result = wishlistDAO.addToWishlist(userID, productID);
            } else {
                result = true; // Đã tồn tại cũng trả về true
            }
        } else if ("remove".equals(action)) {
            result = wishlistDAO.removeFromWishlist(userID, productID);
        }

        // Nếu gọi bằng AJAX thì chỉ cần trả plain text
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": " + result + "}");
    }
}
