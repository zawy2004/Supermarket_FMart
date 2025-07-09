package controller.user;

import dao.WishlistDAO;
import dao.ProductDAO;
import dao.ProductImageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import model.Product;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {

    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {
        wishlistDAO = new WishlistDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().print("{\"message\":\"Please log in first.\"}");
            return;
        }

        int userId = user.getUserId();
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        if ("add".equals(action)) {
            if (!wishlistDAO.isInWishlist(userId, productId)) {
                wishlistDAO.addWishlistItem(userId, productId);
            }
            response.getWriter().print("{\"message\":\"Item added to wishlist\"}");
        } else if ("remove".equals(action)) {
            wishlistDAO.removeWishlistItem(userId, productId);
            response.getWriter().print("{\"message\":\"Item removed from wishlist\"}");
        } else {
            response.getWriter().print("{\"message\":\"Invalid action\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Product> wishlistItems = wishlistDAO.getWishlistProducts(user.getUserId());
        Map<Integer, String> wishlistImages = new HashMap<>();

        for (Product p : wishlistItems) {
            String img = ProductImageDAO.getMainImageUrl(p.getProductID());
            wishlistImages.put(p.getProductID(),
                    img != null ? img : "images/product/default.jpg"
            );
        }

        request.setAttribute("wishlistItems", wishlistItems);
        request.setAttribute("wishlistImages", wishlistImages);

        request.getRequestDispatcher("/User/dashboard_my_wishlist.jsp").forward(request, response);
    }
}
