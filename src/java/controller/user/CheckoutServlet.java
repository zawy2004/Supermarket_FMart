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
import java.util.ArrayList;
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
            
            // Lấy thông tin từ "Order Now"
            String productIdStr = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String quantityStr = request.getParameter("quantity");
            String unit = request.getParameter("unit");
            String sellingPriceStr = request.getParameter("sellingPrice");
            String totalPriceStr = request.getParameter("totalPrice");

            // Khởi tạo danh sách giỏ hàng tạm
            List<ShoppingCart> cartItems = new ArrayList<>();
            double cartTotal = 0.0;
            double totalSaving = 0.0;
            double deliveryCharge = 20000.0; // Giá trị mặc định

            // Chỉ xử lý sản phẩm từ "Order Now" nếu có productIdStr
            if (productIdStr != null && quantityStr != null && sellingPriceStr != null) {
                int productId = Integer.parseInt(productIdStr);
                int quantity = Integer.parseInt(quantityStr);
                double sellingPrice = Double.parseDouble(sellingPriceStr);
                double totalPrice = Double.parseDouble(totalPriceStr);
                double costPrice = productService.getProductById(productId).getCostPrice();

                ShoppingCart orderItem = new ShoppingCart();
                orderItem.setUserID(userId);
                orderItem.setProductID(productId);
                orderItem.setQuantity(quantity);
                orderItem.setUnit(unit);
                orderItem.setAddedDate(new Date());
                orderItem.setProductName(productName);
                orderItem.setSellingPrice(sellingPrice);
                orderItem.setCostPrice(costPrice > 0 ? costPrice : sellingPrice);
                cartItems.add(orderItem);

                cartTotal = totalPrice;
                if (costPrice > sellingPrice) {
                    totalSaving = (costPrice - sellingPrice) * quantity;
                }
            } else {
                // Nếu không có productIdStr, lấy giỏ hàng (cho trường hợp checkout từ giỏ)
                List<ShoppingCart> existingCartItems = cartService.getCartItemsByUserId(userId);
                if (existingCartItems != null && !existingCartItems.isEmpty()) {
                    cartItems.addAll(existingCartItems);
                    for (ShoppingCart item : existingCartItems) {
                        Product p = productService.getProductById(item.getProductID());
                        if (p != null) {
                            item.setProductName(p.getProductName());
                            item.setSellingPrice(p.getSellingPrice());
                            item.setCostPrice(p.getCostPrice());
                            cartTotal += p.getSellingPrice() * item.getQuantity();
                            if (p.getCostPrice() > p.getSellingPrice()) {
                                totalSaving += (p.getCostPrice() - p.getSellingPrice()) * item.getQuantity();
                            }
                        }
                    }
                }
            }

            // Lấy hình ảnh chính của sản phẩm từ "Order Now" nếu có
            String mainImageUrl = "images/product/default.jpg";
            if (productIdStr != null) {
                int productId = Integer.parseInt(productIdStr);
                List<ProductImage> productImages = productService.getProductImagesByProductId(productId);
                mainImageUrl = productImages.stream()
                        .filter(ProductImage::isIsMainImage)
                        .findFirst()
                        .map(ProductImage::getImageUrl)
                        .orElse(productImages.isEmpty() ? "images/product/default.jpg" : productImages.get(0).getImageUrl());
            }

            // Set attributes
            request.setAttribute("product", productIdStr != null ? productService.getProductById(Integer.parseInt(productIdStr)) : null);
            request.setAttribute("mainImageUrl", mainImageUrl);
            request.setAttribute("quantity", quantityStr != null ? Integer.parseInt(quantityStr) : 1);
            request.setAttribute("unit", unit);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.setAttribute("totalSaving", totalSaving);
            request.setAttribute("deliveryCharge", deliveryCharge);
            request.setAttribute("productPrice", sellingPriceStr != null ? Double.parseDouble(sellingPriceStr) : 0.0);
            request.setAttribute("productOriginalPrice", productIdStr != null ? productService.getProductById(Integer.parseInt(productIdStr)).getCostPrice() : 0.0);

            request.getRequestDispatcher("/User/checkout.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in CheckoutServlet doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("/User/error.jsp").forward(request, response);
        }
    }
}