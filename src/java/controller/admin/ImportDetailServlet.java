package controller.admin;

import dao.ImportDetailDAO;
import dao.ImportReceiptDAO;
import dao.InventoryDAO;
import dao.ProductDAO;
import dao.StockMovementDAO;
import model.ImportDetail;
import model.ImportReceipt;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ImportDetailServlet")
public class ImportDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ImportDetailDAO importDetailDAO;
    private ProductDAO productDAO;
    private ImportReceiptDAO importReceiptDAO;
    private InventoryDAO inventoryDAO;

    public ImportDetailServlet() throws SQLException {
        super();
        importDetailDAO = new ImportDetailDAO();
        productDAO = new ProductDAO();
        importReceiptDAO = new ImportReceiptDAO();
        inventoryDAO = new InventoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String importIDStr = request.getParameter("importID");

        try {
            if (action == null || action.equals("list")) {
                if (importIDStr != null) {
                    int importID = Integer.parseInt(importIDStr);
                    listImportDetails(request, response, importID);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing importID for listing details.");
                }
            } else {
                switch (action) {
                    case "add":
                        showAddImportDetailForm(request, response);
                        break;
                    case "edit":
                        showEditImportDetailForm(request, response);
                        break;
                    case "delete":
                        deleteImportDetail(request, response);
                        break;
                    default:
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action: " + action);
                        break;
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid importID format.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("save".equals(action)) {
            saveImportDetail(request, response);
        }
    }

    private void listImportDetails(HttpServletRequest request, HttpServletResponse response, int importID) throws ServletException, IOException {
        try {
            ImportReceipt receipt = importReceiptDAO.getImportReceiptById(importID);
            List<ImportDetail> details = importDetailDAO.getImportDetailsByImportId(importID);

            request.setAttribute("importDetails", details);
            request.setAttribute("importReceipt", receipt);
            request.setAttribute("importID", importID);
            request.getRequestDispatcher("/Admin/importdetail.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error while listing import details.");
        }
    }

    private void showAddImportDetailForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int importID = Integer.parseInt(request.getParameter("importID"));
            List<Product> products = productDAO.getAllProducts();

            request.setAttribute("importID", importID);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/Admin/add_importdetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid importID.");
        }
    }

    private void showEditImportDetailForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int importDetailID = Integer.parseInt(request.getParameter("importDetailID"));
            ImportDetail importDetail = importDetailDAO.getImportDetailById(importDetailID);
            List<Product> products = productDAO.getAllProducts();

            request.setAttribute("importDetail", importDetail);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/Admin/edit_importdetail.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading edit form.");
        }
    }
private void saveImportDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        int importID = Integer.parseInt(request.getParameter("importID"));
        int productID = Integer.parseInt(request.getParameter("productID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));

        // Thêm chi tiết nhập
        ImportDetail detail = new ImportDetail(0, importID, productID, quantity, unitPrice);
        importDetailDAO.addImportDetail(detail);

        // Cập nhật tồn kho trong Inventory
        ImportReceipt receipt = importReceiptDAO.getImportReceiptById(importID);
        if (receipt != null) {
            int warehouseID = receipt.getWarehouseID();
            inventoryDAO.increaseStock(productID, warehouseID, quantity);
        }

        // === Ghi log vào StockMovements ===
        HttpSession session = request.getSession();
        int userID = (int) session.getAttribute("userId"); // hoặc "userID" tùy cách bạn set
        StockMovementDAO stockMovementDAO = new StockMovementDAO();
        stockMovementDAO.addStockMovement(
            productID,
            "IN",                      // MovementType
            quantity,
            "Nhập kho",               // Reason (hoặc request.getParameter("reason") nếu có)
            importID,                 // ReferenceID
            "IMPORT",                 // ReferenceType
            userID,                   // CreatedBy
            null,                     // Notes nếu có thể truyền thêm
            unitPrice                 // Giá nhập
        );

        // Chuyển về danh sách chi tiết nhập
        response.sendRedirect("ImportDetailServlet?importID=" + importID);
    } catch (SQLException | NumberFormatException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving import detail.");
    }
}


    private void deleteImportDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int importDetailID = Integer.parseInt(request.getParameter("importDetailID"));
            int importID = Integer.parseInt(request.getParameter("importID"));

            importDetailDAO.deleteImportDetail(importDetailID);
            response.sendRedirect("ImportDetailServlet?action=list&importID=" + importID);
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting import detail.");
        }
    }
}
