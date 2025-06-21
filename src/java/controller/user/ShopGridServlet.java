package controller.user;

import dao.ProductDAO;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.Category;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/shop_grid")
public class ShopGridServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String catIdStr = req.getParameter("cat");
        List<Product> products;
        try {
            if (catIdStr != null && !catIdStr.isEmpty()) {
                int catId = Integer.parseInt(catIdStr);
                products = ProductDAO.getProductsByCategory(catId);
                req.setAttribute("currentCatId", catId);
            } else {
                products = ProductDAO.getAllProducts();
            }
            List<Category> categories = CategoryDAO.getAllCategories();
            req.setAttribute("categories", categories);
            req.setAttribute("products", products);
            req.getRequestDispatcher("User/shop_grid.jsp").forward(req, resp);
        } catch (Exception ex) {
            ex.printStackTrace();
            resp.sendError(500, "Internal Server Error");
        }
    }
}
