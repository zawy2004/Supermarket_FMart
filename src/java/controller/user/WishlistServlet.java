
package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Wishlist;
import service.WishlistService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {
    
    private WishlistService wishlistService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        wishlistService = new WishlistService();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession(false);
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
            System.out.println("WishlistServlet: userId = " + userId);
            
            if (userId == null) {
                out.print("{\"error\": \"User not logged in\"}");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
            
            String action = request.getParameter("action");
            String productIdStr = request.getParameter("productId");
            
            if (action == null || productIdStr == null) {
                out.print("{\"error\": \"Missing parameters\"}");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            
            if (action.equals("add")) {
                Wishlist wishlistItem = new Wishlist();
                wishlistItem.setUserID(userId);
                wishlistItem.setProductID(productId);
                wishlistItem.setAddedDate(new Date());
                wishlistService.addToWishlist(wishlistItem);
                out.print("{\"message\": \"Item added to wishlist successfully\"}");
            } else if (action.equals("remove")) {
                wishlistService.removeFromWishlist(userId, productId);
                out.print("{\"message\": \"Item removed from wishlist successfully\"}");
            } else {
                out.print("{\"error\": \"Invalid action\"}");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            System.err.println("Error in WishlistServlet doPost: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
