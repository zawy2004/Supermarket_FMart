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
import java.util.*;

@WebServlet("/shop_grid")
public class ShopGridServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String catIdStr = req.getParameter("cat");
        String sort = req.getParameter("sort");
        List<Product> products;
        try {
            List<Category> categories = CategoryDAO.getAllCategories();
            req.setAttribute("categories", categories);

            if (catIdStr != null && !catIdStr.isEmpty()) {
                int catId = Integer.parseInt(catIdStr);
                products = ProductDAO.getProductsByCategory(catId, sort);
                req.setAttribute("currentCatId", catId);
            } else {
                products = ProductDAO.getAllProducts(sort);
            }
            req.setAttribute("products", products);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("products", Collections.emptyList());
            req.setAttribute("categories", Collections.emptyList());
        }
        req.getRequestDispatcher("User/shop_grid.jsp").forward(req, resp);
    }
}

