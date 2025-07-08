package controller.admin;

import dao.InventoryDAO;
import dao.ProductDAO;
import dao.WarehouseDAO;
import model.Inventory;
import model.Warehouse;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.Product;

@WebServlet("/InventoryManagementServlet")
public class InventoryManagementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private InventoryDAO inventoryDAO;
    private WarehouseDAO warehouseDAO;
    
    public InventoryManagementServlet() throws SQLException {
        super();
        inventoryDAO = new InventoryDAO();
        warehouseDAO = new WarehouseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

       
            listInventory(request, response);  // Hiển thị danh sách tồn kho
        
    }

   

    private void listInventory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String warehouseIDStr = request.getParameter("warehouseID");
            String pageStr = request.getParameter("page");
            int page = 1, itemsPerPage = 10;

            if (pageStr != null) {
                try { page = Integer.parseInt(pageStr); } catch (Exception ignored) {}
            }

            int warehouseID = (warehouseIDStr != null && !warehouseIDStr.isEmpty()) ? Integer.parseInt(warehouseIDStr) : 0;

            // Lấy tổng số lượng tồn kho
            int total = inventoryDAO.getTotalInventory(warehouseID);
            int totalPages = (int) Math.ceil((double) total / itemsPerPage);

            if (page > totalPages && totalPages > 0) page = totalPages;

            List<Inventory> inventories = inventoryDAO.getInventoryByPage(warehouseID, page, itemsPerPage);
            List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
            List<Product> products = ProductDAO.getAllProducts();
            request.setAttribute("products", products);
            request.setAttribute("inventories", inventories);
            request.setAttribute("warehouses", warehouses);
            request.setAttribute("page", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/Admin/inventory.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        } 
    }
}
