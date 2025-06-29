package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ShoppingCart;
import service.ShoppingCartService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {
    
    private ShoppingCartService cartService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        cartService = new ShoppingCartService();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            
            if (userId == null) {
                out.print("{\"error\": \"User not logged in\"}");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
            
            String action = request.getParameter("action");
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            String cartIdStr = request.getParameter("cartId");
            String promoCode = request.getParameter("promoCode");
            String unit = request.getParameter("unit");
            
            if (action == null) {
                out.print("{\"error\": \"Missing action\"}");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            
            switch (action) {
                case "add":
                    if (productIdStr == null || quantityStr == null) {
                        out.print("{\"error\": \"Missing parameters\"}");
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        return;
                    }
                    int productId = Integer.parseInt(productIdStr);
                    int quantity = Integer.parseInt(quantityStr);
                    ShoppingCart cartItem = new ShoppingCart();
                    cartItem.setUserID(userId);
                    cartItem.setProductID(productId);
                    cartItem.setQuantity(quantity);
                    cartItem.setUnit(unit);
                    cartItem.setAddedDate(new Date());
                    cartService.addToCart(cartItem);
                    out.print("{\"message\": \"Item added to cart successfully\"}");
                    break;
                    
                case "update":
                    if (cartIdStr == null || quantityStr == null) {
                        out.print("{\"error\": \"Missing parameters\"}");
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        return;
                    }
                    int cartId = Integer.parseInt(cartIdStr);
                    quantity = Integer.parseInt(quantityStr);
                    ShoppingCart existingItem = new ShoppingCart();
                    existingItem.setCartID(cartId);
                    existingItem.setQuantity(quantity);
                    existingItem.setAddedDate(new Date());
                    cartService.updateCartItem(cartId, quantity); // Giả định method này đã có
                    out.print("{\"message\": \"Cart updated successfully\"}");
                    break;
                    
                case "remove":
                    if (cartIdStr == null) {
                        out.print("{\"error\": \"Missing parameters\"}");
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        return;
                    }
                    cartId = Integer.parseInt(cartIdStr);
                    cartService.removeCartItem(cartId);
                    out.print("{\"message\": \"Item removed from cart successfully\"}");
                    break;
                    
                case "applyPromo":
                    if (promoCode == null) {
                        out.print("{\"error\": \"Missing promo code\"}");
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        return;
                    }
                    // Logic áp dụng promo code (giả định chưa có, cần thêm vào sau)
                    out.print("{\"message\": \"Promo code applied successfully\"}");
                    break;
                    
                default:
                    out.print("{\"error\": \"Invalid action\"}");
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            System.err.println("Error in CartServlet doPost: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            
            if (userId == null) {
                out.print("{\"error\": \"User not logged in\", \"count\": 0}");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
            
            String action = request.getParameter("action");
            if ("count".equals(action)) {
                List<ShoppingCart> cartItems = cartService.getCartItemsByUserId(userId);
                int count = (cartItems != null) ? cartItems.size() : 0;
                out.print("{\"count\": " + count + "}");
            } else {
                // Logic hiện tại để trả về nội dung giỏ hàng (nếu cần)
                request.setAttribute("cartItems", cartService.getCartItemsByUserId(userId));
                request.setAttribute("cartTotal", calculateCartTotal(userId));
                request.setAttribute("totalSaving", calculateTotalSaving(userId));
                request.setAttribute("deliveryCharge", 1.0); // Giả định
                request.getRequestDispatcher("/User/cart_sidebar.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error in CartServlet doGet: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"error\": \"" + e.getMessage() + "\", \"count\": 0}");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    private double calculateCartTotal(int userId) {
        List<ShoppingCart> cartItems = cartService.getCartItemsByUserId(userId);
        double total = 0.0;
        if (cartItems != null) {
            for (ShoppingCart item : cartItems) {
                // Giả định lấy giá từ product service
                // Cần tích hợp ProductService để lấy sellingPrice
                total += item.getSellingPrice() * item.getQuantity();
            }
        }
        return total;
    }
    
    private double calculateTotalSaving(int userId) {
        List<ShoppingCart> cartItems = cartService.getCartItemsByUserId(userId);
        double saving = 0.0;
        if (cartItems != null) {
            for (ShoppingCart item : cartItems) {
                if (item.getCostPrice() > item.getSellingPrice()) {
                    saving += (item.getCostPrice() - item.getSellingPrice()) * item.getQuantity();
                }
            }
        }
        return saving;
    }
}