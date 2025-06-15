package controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import java.util.Date;
import java.util.List;
import model.Product;

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
        } else if ("view".equals(action)) {
            handleViewProduct(request, response);
        } else if ("edit".equals(action)) {
            handleEditProduct(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action.");
        }
    } catch (NumberFormatException e) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format.");
    } catch (Exception e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error.");
        e.printStackTrace(); // Log for debugging
    }
}
private void handleProductList(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    List<Product> products = ProductDAO.getAllProducts();
    request.setAttribute("products", products);
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

    if ("update".equals(action)) {
        try {
            int productID = Integer.parseInt(request.getParameter("productId"));
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
            Date lastUpdated = new Date();

            Product updatedProduct = new Product(productID, productName, sku, categoryID, supplierID, description,
                    unit, costPrice, sellingPrice, minStockLevel, isActive, null, lastUpdated,
                    weight, dimensions, expiryDays, brand, origin);

            ProductDAO.updateProduct(updatedProduct);
            request.getSession().setAttribute("msg", "Product updated successfully!");
            response.sendRedirect("ProductServlet");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error.");
        }
    }
    else if ("add".equals(action)) {
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
    response.sendRedirect("ProductServlet");
}
    }
}