package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Product;
import model.Category;
import dao.WishlistDAO;
import service.ProductService;
import service.CategoryService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ShopServlet", urlPatterns = {"/shop", "/shop_grid"})
public class ShopServlet extends HttpServlet {
    
    private ProductService productService;
    private CategoryService categoryService;
    private static final int PRODUCTS_PER_PAGE = 12;
    
    @Override
    public void init() throws ServletException {
        super.init();
        try {
            productService = new ProductService();
            categoryService = new CategoryService();
            System.out.println("ShopServlet initialized successfully!");
        } catch (Exception e) {
            System.err.println("Error initializing ShopServlet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Failed to initialize ShopServlet", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String categoryIdStr = request.getParameter("categoryId");
            String pageStr = request.getParameter("page");
            String sortBy = request.getParameter("sortBy");
            String search = request.getParameter("search");
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            
            int categoryId = 0;
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr);
                } catch (NumberFormatException ignored) {}
            }
            
            int currentPage = 1;
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                try {
                    currentPage = Math.max(1, Integer.parseInt(pageStr));
                } catch (NumberFormatException ignored) {}
            }
            
            double minPrice = 0;
            double maxPrice = Double.MAX_VALUE;
            if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
                try {
                    minPrice = Math.max(0, Double.parseDouble(minPriceStr));
                } catch (NumberFormatException ignored) {}
            }
            if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
                try {
                    maxPrice = Math.max(0, Double.parseDouble(maxPriceStr));
                    if (maxPrice < minPrice) maxPrice = Double.MAX_VALUE;
                } catch (NumberFormatException ignored) {}
            }
            
            List<Product> products;
            String pageTitle = "All Products";
            Category currentCategory = null;
            
            if (search != null && !search.trim().isEmpty()) {
                products = productService.searchProducts(search.trim());
                pageTitle = "Search Results: " + search;
            } else if (categoryId > 0) {
                currentCategory = categoryService.getActiveCategoryById(categoryId);
                if (currentCategory != null) {
                    products = productService.getProductsByCategory(categoryId);
                    pageTitle = currentCategory.getCategoryName();
                } else {
                    products = productService.getActiveProducts();
                    categoryId = 0;
                }
            } else {
                products = productService.getActiveProducts();
            }
            
            // price filter
            if (minPrice > 0 || maxPrice < Double.MAX_VALUE) {
                products = productService.filterProductsByPrice(products, minPrice, maxPrice);
            }
            
            // sort
            if (sortBy != null && !sortBy.trim().isEmpty()) {
                products = productService.sortProducts(products, sortBy);
            }
            
            int totalProducts = products.size();
            int totalPages = totalProducts > 0 ? (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE) : 1;
            if (currentPage > totalPages) currentPage = totalPages;
            
            int startIndex = (currentPage - 1) * PRODUCTS_PER_PAGE;
            int endIndex = Math.min(startIndex + PRODUCTS_PER_PAGE, totalProducts);
            List<Product> pageProducts;
            if (startIndex < totalProducts) {
                pageProducts = products.subList(startIndex, endIndex);
            } else {
                pageProducts = new java.util.ArrayList<>();
            }
            
            // BỔ SUNG: kiểm tra wishlist nếu user đã login
            HttpSession session = request.getSession(false);
            Integer userId = (session != null && session.getAttribute("userId") != null)
                    ? (Integer) session.getAttribute("userId") : null;
            if (userId != null) {
                WishlistDAO wishlistDAO = new WishlistDAO();
                for (Product p : pageProducts) {
                    p.setIsWishlisted(wishlistDAO.isInWishlist(userId, p.getProductID()));
                }
            }
            
            // categories
            List<Category> categories = categoryService.getActiveCategories();
            Map<Integer, Integer> categoryProductCount = productService.getProductCountByCategory();
            
            // set attributes
            request.setAttribute("products", pageProducts);
            request.setAttribute("categories", categories);
            request.setAttribute("currentCategory", currentCategory);
            request.setAttribute("categoryProductCount", categoryProductCount);
            request.setAttribute("pageTitle", pageTitle);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("categoryId", categoryId);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("search", search);
            request.setAttribute("minPrice", minPrice > 0 ? minPrice : "");
            request.setAttribute("maxPrice", maxPrice < Double.MAX_VALUE ? maxPrice : "");
            
            request.getRequestDispatcher("/User/shop_grid.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error: " + e.getMessage());
            request.setAttribute("products", new java.util.ArrayList<>());
            try {
                request.setAttribute("categories", categoryService.getActiveCategories());
            } catch (Exception ex) {
                request.setAttribute("categories", new java.util.ArrayList<>());
            }
            request.setAttribute("totalProducts", 0);
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 1);
            request.setAttribute("pageTitle", "Error");
            request.getRequestDispatcher("/User/shop_grid.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String categoryId = request.getParameter("categoryId");
        StringBuilder redirectUrl = new StringBuilder("shop?");
        
        if (search != null && !search.trim().isEmpty()) {
            redirectUrl.append("search=").append(java.net.URLEncoder.encode(search, "UTF-8"));
        }
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            if (redirectUrl.length() > 5) redirectUrl.append("&");
            redirectUrl.append("categoryId=").append(categoryId);
        }
        response.sendRedirect(redirectUrl.toString());
    }
}
