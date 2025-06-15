
package controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import model.Product;
import java.util.List;

public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/products.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        java.util.Date createdDate = new java.util.Date();
        java.util.Date lastUpdated = new java.util.Date();
        double weight = Double.parseDouble(request.getParameter("weight"));
        String dimensions = request.getParameter("dimensions");
        int expiryDays = Integer.parseInt(request.getParameter("expiryDays"));
        String brand = request.getParameter("brand");
        String origin = request.getParameter("origin");

        Product product = new Product(0, productName, sku, categoryID, supplierID, description, unit, costPrice, sellingPrice, minStockLevel, isActive, createdDate, lastUpdated, weight, dimensions, expiryDays, brand, origin);
        
        if (productDAO.insertProduct(product)) {
            response.sendRedirect("productList");
        } else {
            response.getWriter().write("Error adding product.");
        }
    }
}
