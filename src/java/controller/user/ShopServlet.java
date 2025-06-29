package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.Category;
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
        
        System.out.println("ShopServlet doGet called with URI: " + request.getRequestURI());
        System.out.println("Query String: " + request.getQueryString());
        
        try {
            // Lấy parameters
            String categoryIdStr = request.getParameter("categoryId");
            String pageStr = request.getParameter("page");
            String sortBy = request.getParameter("sortBy");
            String search = request.getParameter("search");
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            
            System.out.println("Parameters - categoryId: " + categoryIdStr + ", page: " + pageStr);
            
            // Parse parameters
            int categoryId = 0;
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid categoryId: " + categoryIdStr);
                    categoryId = 0;
                }
            }
            
            int currentPage = 1;
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                try {
                    currentPage = Math.max(1, Integer.parseInt(pageStr));
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            
            double minPrice = 0;
            double maxPrice = Double.MAX_VALUE;
            if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
                try {
                    minPrice = Math.max(0, Double.parseDouble(minPriceStr));
                } catch (NumberFormatException e) {
                    minPrice = 0;
                }
            }
            if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
                try {
                    maxPrice = Math.max(0, Double.parseDouble(maxPriceStr));
                    if (maxPrice < minPrice) maxPrice = Double.MAX_VALUE;
                } catch (NumberFormatException e) {
                    maxPrice = Double.MAX_VALUE;
                }
            }
            
            // Lấy danh sách sản phẩm
            List<Product> products;
            String pageTitle = "All Products";
            Category currentCategory = null;
            
            System.out.println("Processing request for categoryId: " + categoryId);
            
            if (search != null && !search.trim().isEmpty()) {
                // Tìm kiếm sản phẩm
                System.out.println("Searching products with keyword: " + search);
                products = productService.searchProducts(search.trim());
                pageTitle = "Search Results: " + search;
            } else if (categoryId > 0) {
                // Kiểm tra category có tồn tại không
                System.out.println("Getting products for category: " + categoryId);
                currentCategory = categoryService.getActiveCategoryById(categoryId);
                if (currentCategory != null) {
                    System.out.println("Category found: " + currentCategory.getCategoryName());
                    // Lấy sản phẩm theo category
                    products = productService.getProductsByCategory(categoryId);
                    pageTitle = currentCategory.getCategoryName();
                    System.out.println("Found " + products.size() + " products in category");
                } else {
                    System.err.println("Category not found or inactive for ID: " + categoryId);
                    // Category không tồn tại hoặc không active
                    products = productService.getActiveProducts();
                    pageTitle = "All Products";
                    categoryId = 0; // Reset categoryId
                }
            } else {
                // Lấy tất cả sản phẩm active
                System.out.println("Getting all active products");
                products = productService.getActiveProducts();
                pageTitle = "All Products";
            }
            
            System.out.println("Total products before filtering: " + products.size());
            
            // Lọc theo giá nếu có
            if (minPrice > 0 || maxPrice < Double.MAX_VALUE) {
                products = productService.filterProductsByPrice(products, minPrice, maxPrice);
                System.out.println("Products after price filtering: " + products.size());
            }
            
            // Sắp xếp sản phẩm
            if (sortBy != null && !sortBy.trim().isEmpty()) {
                products = productService.sortProducts(products, sortBy);
                System.out.println("Products sorted by: " + sortBy);
            }
            
            // Phân trang
            int totalProducts = products.size();
            int totalPages = totalProducts > 0 ? (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE) : 1;
            
            // Đảm bảo currentPage không vượt quá totalPages
            if (currentPage > totalPages) {
                currentPage = Math.max(1, totalPages);
            }
            
            int startIndex = (currentPage - 1) * PRODUCTS_PER_PAGE;
            int endIndex = Math.min(startIndex + PRODUCTS_PER_PAGE, totalProducts);
            
            List<Product> pageProducts;
            if (startIndex < totalProducts) {
                pageProducts = products.subList(startIndex, endIndex);
            } else {
                pageProducts = new java.util.ArrayList<>();
            }
            
            System.out.println("Page products: " + pageProducts.size() + " (page " + currentPage + " of " + totalPages + ")");
            
            // Lấy danh sách categories cho filter
            List<Category> categories = categoryService.getActiveCategories();
            System.out.println("Active categories: " + categories.size());
            
            // Lấy số lượng sản phẩm theo category
            Map<Integer, Integer> categoryProductCount = productService.getProductCountByCategory();
            
            // Set attributes
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
            
            System.out.println("Forwarding to User/shop_grid.jsp");
            
            // FIXED: Forward đến đúng đường dẫn file JSP
            request.getRequestDispatcher("/User/shop_grid.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in ShopServlet doGet: " + e.getMessage());
            e.printStackTrace();
            
            // Xử lý lỗi gracefully
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
            
            // FIXED: Forward đến đúng đường dẫn khi có lỗi
            request.getRequestDispatcher("/User/shop_grid.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("ShopServlet doPost called");
        
        // Handle search form submission
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
        
        System.out.println("Redirecting to: " + redirectUrl.toString());
        response.sendRedirect(redirectUrl.toString());
    }
}