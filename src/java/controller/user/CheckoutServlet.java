package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.ProductImage;
import model.ShoppingCart;
import service.ProductService;
import service.ShoppingCartService;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    
    private ProductService productService;
    private ShoppingCartService cartService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
        cartService = new ShoppingCartService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
            System.out.println("CheckoutServlet: userId = " + userId);
            
            if (userId == null) {
                response.sendRedirect("login");
                return;
            }
            
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            String unit = request.getParameter("unit");
            
            if (productIdStr == null || quantityStr == null) {
                request.setAttribute("error", "Missing product ID or quantity");
                request.getRequestDispatcher("/User/error.jsp").forward(request, response);
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            
            Product product = productService.getProductById(productId);
            if (product == null || !product.isIsActive()) {
                request.setAttribute("error", "Product not found or inactive");
                request.getRequestDispatcher("/User/error.jsp").forward(request, response);
                return;
            }
            
            List<ProductImage> productImages = productService.getProductImagesByProductId(productId);
            String mainImageUrl = productImages.stream()
                    .filter(ProductImage::isIsMainImage)
                    .findFirst()
                    .map(ProductImage::getImageUrl)
                    .orElse(productImages.isEmpty() ? "images/product/default.jpg" : productImages.get(0).getImageUrl());
            
            // Lấy toàn bộ giỏ hàng từ session
            List<ShoppingCart> cartItems = null;
            double cartTotal = 0.0;
            double totalSaving = 0.0;
            double deliveryCharge = 1.0; // Giá trị mặc định
            
            if (userId != null) {
                cartItems = cartService.getCartItemsByUserId(userId);
                for (ShoppingCart item : cartItems) {
                    Product p = productService.getProductById(item.getProductID());
                    if (p != null) {
                        cartTotal += p.getSellingPrice() * item.getQuantity();
                        if (p.getCostPrice() > p.getSellingPrice()) {
                            totalSaving += (p.getCostPrice() - p.getSellingPrice()) * item.getQuantity();
                        }
                        item.setProductName(p.getProductName());
                        item.setSellingPrice(p.getSellingPrice());
                        item.setCostPrice(p.getCostPrice());
                    }
                }
            }
            
            request.setAttribute("product", product);
            request.setAttribute("mainImageUrl", mainImageUrl);
            request.setAttribute("quantity", quantity);
            request.setAttribute("unit", unit);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.setAttribute("totalSaving", totalSaving);
            request.setAttribute("deliveryCharge", deliveryCharge);
            
            request.getRequestDispatcher("/User/checkout.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in CheckoutServlet doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        }
    }
}