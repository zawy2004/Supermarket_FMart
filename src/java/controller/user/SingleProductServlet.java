package controller.user;

import dao.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.Category;
import model.ProductImage;
import model.ShoppingCart;
import service.ProductService;
import service.CategoryService;
import service.ShoppingCartService;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SingleProductServlet", urlPatterns = {"/single_product"})
public class SingleProductServlet extends HttpServlet {
    
    private ProductService productService;
    private CategoryService categoryService;
    private ShoppingCartService cartService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        try {
            productService = new ProductService();
            categoryService = new CategoryService();
            cartService = new ShoppingCartService();
            System.out.println("SingleProductServlet initialized successfully!");
        } catch (Exception e) {
            System.err.println("Error initializing SingleProductServlet: " + e.getMessage());
            throw new ServletException("Failed to initialize SingleProductServlet", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // lấy productId từ URL
            String productIdStr = request.getParameter("productId");
            int productId = 0;
            try {
                productId = Integer.parseInt(productIdStr);
                System.out.println("Processing ProductID: " + productId);
            } catch (NumberFormatException e) {
                System.err.println("Invalid productId: " + productIdStr);
                request.setAttribute("error", "Invalid product ID");
                request.getRequestDispatcher("User/error.jsp").forward(request, response);
                return;
            }
            
            // lấy thông tin sản phẩm
            Product product = productService.getProductById(productId);
            if (product == null || !product.isIsActive()) {
                System.err.println("Product not found or inactive: " + productId);
                request.setAttribute("error", "Product not found or inactive");
                request.getRequestDispatcher("User/error.jsp").forward(request, response);
                return;
            }
            
            // lấy danh mục
            Category category = categoryService.getCategoryById(product.getCategoryID());
            
            // lấy danh sách hình ảnh
            List<ProductImage> productImages = productService.getProductImagesByProductId(productId);
            System.out.println("Images for ProductID " + productId + ": " + productImages.size());
            
            // sản phẩm liên quan
            List<Product> relatedProducts = productService.getRelatedProducts(productId, 4);
            
            // sản phẩm nổi bật
            List<Product> featuredProducts = productService.getFeaturedProducts(8);
            
            // load hình ảnh cho featured + related
            Map<Integer, String> featuredProductImages = new HashMap<>();
            Map<Integer, String> relatedProductImages = new HashMap<>();
            
            for (Product featured : featuredProducts) {
                List<ProductImage> images = productService.getProductImagesByProductId(featured.getProductID());
                String imageUrl = images.isEmpty() ? "images/product/default.jpg"
                        : images.stream()
                                .filter(ProductImage::isIsMainImage)
                                .findFirst()
                                .map(ProductImage::getImageUrl)
                                .orElse(images.get(0).getImageUrl());
                featuredProductImages.put(featured.getProductID(), imageUrl);
            }
            
            for (Product related : relatedProducts) {
                List<ProductImage> images = productService.getProductImagesByProductId(related.getProductID());
                String imageUrl = images.isEmpty() ? "images/product/default.jpg"
                        : images.stream()
                                .filter(ProductImage::isIsMainImage)
                                .findFirst()
                                .map(ProductImage::getImageUrl)
                                .orElse(images.get(0).getImageUrl());
                relatedProductImages.put(related.getProductID(), imageUrl);
            }
            
            // giỏ hàng
            HttpSession session = request.getSession(false);
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
            System.out.println("SingleProductServlet: userId = " + userId);
            
            List<ShoppingCart> cartItems = null;
            double cartTotal = 0.0;
            double totalSaving = 0.0;
            double deliveryCharge = 1.0;
            
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
            
            // kiểm tra wishlist
            boolean isInWishlist = false;
            if (userId != null) {
                WishlistDAO wishlistDAO = new WishlistDAO();
                isInWishlist = wishlistDAO.isInWishlist(userId, productId);
            }
            
            // set attributes
            request.setAttribute("product", product);
            request.setAttribute("category", category);
            request.setAttribute("productImages", productImages);
            request.setAttribute("relatedProducts", relatedProducts);
            request.setAttribute("relatedProductImages", relatedProductImages);
            request.setAttribute("featuredProducts", featuredProducts);
            request.setAttribute("featuredProductImages", featuredProductImages);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", cartTotal);
            request.setAttribute("totalSaving", totalSaving);
            request.setAttribute("deliveryCharge", deliveryCharge);
            request.setAttribute("isInWishlist", isInWishlist);
            
            // forward
            request.getRequestDispatcher("User/single_product_view.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in SingleProductServlet doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("User/error.jsp").forward(request, response);
        }
    }
}
