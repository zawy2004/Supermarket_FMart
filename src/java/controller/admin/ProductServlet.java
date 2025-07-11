package controller.admin;

import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import model.Category;
import model.Product;
import model.ProductImage;
import service.ProductService;

public class ProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ProductServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                handleProductList(request, response);
            } else if ("list".equals(action)) {
                handleProductList(request, response);
            } else if ("view".equals(action)) {
                handleViewProduct(request, response);
            } else if ("edit".equals(action)) {
                handleEditProduct(request, response);
            } else if ("add".equals(action)) {
                List<Category> categories = CategoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/add_product.jsp");
                dispatcher.forward(request, response);
            } else if ("delete".equals(action)) {
                String productIdParam = request.getParameter("productId");
                if (productIdParam != null && !productIdParam.isEmpty()) {
                    int productID = Integer.parseInt(productIdParam);
                    ProductDAO.deleteProduct(productID);
                    response.sendRedirect("ProductServlet"); // Quay lại danh sách sản phẩm
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product ID for deletion.");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action.");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error.");
        }
    }

    private void handleProductList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int pageSize = 5;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int offset = (page - 1) * pageSize;

        // Nhận filter từ form
        String keyword = request.getParameter("keyword");
        String categoryId = request.getParameter("categoryId");

        List<Product> products;
        int totalProducts;

        if ((keyword != null && !keyword.isEmpty()) || (categoryId != null && !categoryId.isEmpty())) {
            products = ProductDAO.searchProductsPaged(keyword, categoryId, offset, pageSize);
            totalProducts = ProductDAO.countSearchProducts(keyword, categoryId);
        } else {
            products = ProductDAO.getProductsByPage(offset, pageSize);
            totalProducts = ProductDAO.getTotalProducts();
        }
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // ======= BỔ SUNG PHẦN LẤY ẢNH ĐẠI DIỆN =======
        ProductService productService = new ProductService();
        Map<Integer, String> productMainImages = new HashMap<>();
        for (Product p : products) {
            List<ProductImage> imgs = productService.getProductImagesByProductId(p.getProductID());
            String imgUrl = "images/product/default.jpg"; // Đường dẫn ảnh mặc định
            boolean foundMain = false;
            for (ProductImage img : imgs) {
                if (img.isIsMainImage()) {
                    imgUrl = img.getImageUrl();
                    foundMain = true;
                    break;
                }
            }
            if (!foundMain && imgs.size() > 0) {
                imgUrl = imgs.get(0).getImageUrl();
            }
            productMainImages.put(p.getProductID(), imgUrl);
        }
        request.setAttribute("productMainImages", productMainImages);
        // ==============================================

        request.setAttribute("products", products);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("categoryId", categoryId);

        List<Category> categories = CategoryDAO.getAllCategories();
        request.setAttribute("categories", categories);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/products.jsp");
        dispatcher.forward(request, response);
    }

    private void handleViewProduct(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String productIdParam = request.getParameter("productId");

    if (productIdParam != null && !productIdParam.isEmpty()) {
        int productID = Integer.parseInt(productIdParam);
        Product product = ProductDAO.getProductById(productID);

        if (product != null) {
            // ====== LẤY ẢNH CHÍNH SẢN PHẨM (giống ở products.jsp) =======
            ProductService productService = new ProductService();
            List<ProductImage> productImages = productService.getProductImagesByProductId(productID);
            String mainImageUrl = "images/product/default.jpg";
            if (productImages != null && !productImages.isEmpty()) {
                ProductImage mainImage = productImages.stream()
                        .filter(ProductImage::isIsMainImage)
                        .findFirst()
                        .orElse(productImages.get(0));
                mainImageUrl = mainImage.getImageUrl();
            }
            request.setAttribute("productMainImage", mainImageUrl);
            // ===========================================================

            request.setAttribute("product", product);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/product_view.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found.");
        }
    } else {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product ID.");
    }
}


    private void handleEditProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");

        if (productIdParam != null && !productIdParam.isEmpty()) {
            int productID = Integer.parseInt(productIdParam);
            Product product = ProductDAO.getProductById(productID);

            if (product != null) {
                request.setAttribute("product", product);
                RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/edit_product.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found.");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product ID.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                int productID = parseIntSafe(request.getParameter("productId"));
                Date lastUpdated = new Date();

                Product updatedProduct = buildProductFromRequest(request);
                updatedProduct.setProductID(productID);
                updatedProduct.setLastUpdated(lastUpdated);

                ProductDAO.updateProduct(updatedProduct);
                request.getSession().setAttribute("msg", "Product updated successfully!");
                response.sendRedirect("ProductServlet");
            } else if ("add".equals(action)) {
                try {

                    String productName = request.getParameter("productName");
                    String sku = request.getParameter("sku");
                    int categoryID = Integer.parseInt(request.getParameter("categoryID"));
                    int supplierID = Integer.parseInt(request.getParameter("supplierID"));
                    String description = request.getParameter("description");
                    String unit = request.getParameter("unit");
                    double costPrice = Double.parseDouble(request.getParameter("costPrice"));
                    double sellingPrice = Double.parseDouble(request.getParameter("sellingPrice"));
                    int minStockLevel = Integer.parseInt(request.getParameter("minStockLevel"));
                    boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
                    double weight = Double.parseDouble(request.getParameter("weight"));
                    String dimensions = request.getParameter("dimensions");
                    int expiryDays = Integer.parseInt(request.getParameter("expiryDays"));
                    String brand = request.getParameter("brand");
                    String origin = request.getParameter("origin");

                    Date createdDate = new Date();
                    Date lastUpdated = new Date();

                    Product newProduct = new Product(0, productName, sku, categoryID, supplierID, description, unit,
                            costPrice, sellingPrice, minStockLevel, isActive, createdDate, lastUpdated,
                            weight, dimensions, expiryDays, brand, origin);

                    ProductDAO.addProduct(newProduct);
                    System.out.println(" Thêm thành công: " + productName);
                    response.sendRedirect("ProductServlet");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ hoặc thiếu.");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action.");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error.");
        }
    }

    // Build product object from form data
    private Product buildProductFromRequest(HttpServletRequest request) {
        String productName = request.getParameter("productName");
        String sku = request.getParameter("sku");
        int categoryID = parseIntSafe(request.getParameter("categoryID"));
        int supplierID = parseIntSafe(request.getParameter("supplierID"));
        String description = request.getParameter("description");
        String unit = request.getParameter("unit");
        double costPrice = parseDoubleSafe(request.getParameter("costPrice"));
        double sellingPrice = parseDoubleSafe(request.getParameter("sellingPrice"));
        int minStockLevel = parseIntSafe(request.getParameter("minStockLevel"));
        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
        double weight = parseDoubleSafe(request.getParameter("weight"));
        String dimensions = request.getParameter("dimensions");
        int expiryDays = parseIntSafe(request.getParameter("expiryDays"));
        String brand = request.getParameter("brand");
        String origin = request.getParameter("origin");

        return new Product(0, productName, sku, categoryID, supplierID, description,
                unit, costPrice, sellingPrice, minStockLevel, isActive, null, null,
                weight, dimensions, expiryDays, brand, origin);
    }

    private int parseIntSafe(String value) {
        try {
            return (value != null && !value.trim().isEmpty()) ? Integer.parseInt(value.trim()) : 0;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private double parseDoubleSafe(String value) {
        try {
            return (value != null && !value.trim().isEmpty()) ? Double.parseDouble(value.trim()) : 0.0;
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }
}