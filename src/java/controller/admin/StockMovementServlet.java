package controller.admin;

import dao.ProductDAO;
import dao.StockMovementDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.StockMovement;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/StockMovementServlet")
public class StockMovementServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StockMovementDAO movementDAO = new StockMovementDAO();
        ProductDAO productDAO = new ProductDAO();

        // Lấy tham số
        String productIDParam = req.getParameter("productID");
        String movementType = req.getParameter("movementType");
        String pageParam = req.getParameter("page");

        Integer productID = (productIDParam != null && !productIDParam.isEmpty()) ? Integer.parseInt(productIDParam) : null;
        int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
        int offset = (page - 1) * PAGE_SIZE;

        try {
            List<StockMovement> movements = movementDAO.getStockMovementsFiltered(productID, movementType, offset, PAGE_SIZE);
            int total = movementDAO.countStockMovements(productID, movementType);
            int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);

            List<Product> products = productDAO.getAllProducts();

            req.setAttribute("movements", movements);
            req.setAttribute("products", products);
            req.setAttribute("page", page);
            req.setAttribute("totalPages", totalPages);

            req.getRequestDispatcher("Admin/stockmovement.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Database error while loading stock movements", e);
        }
    }
}
