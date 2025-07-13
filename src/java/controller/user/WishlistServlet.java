package controller.user;

import dao.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import model.Product;
import model.ProductImage;
import service.ProductService;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Product> wishlistItems = wishlistDAO.getWishlistProducts(user.getUserId());

      
        ProductService productService = new ProductService();
        Map<Integer, String> wishlistImages = new HashMap<>();
        for (Product p : wishlistItems) {
            List<ProductImage> imgs = productService.getProductImagesByProductId(p.getProductID());
            String imgUrl = "images/product/default.jpg";
            boolean foundMain = false;
            for (ProductImage img : imgs) {
                if (img.isIsMainImage()) {
                    imgUrl = img.getImageUrl();
                    foundMain = true;
                    break;
                }
            }
            if (!foundMain && !imgs.isEmpty()) {
                imgUrl = imgs.get(0).getImageUrl();
            }
            wishlistImages.put(p.getProductID(), imgUrl);
        }

        request.setAttribute("wishlistItems", wishlistItems);
        request.setAttribute("wishlistImages", wishlistImages);

        request.getRequestDispatcher("/User/dashboard_my_wishlist.jsp").forward(request, response);
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
}
