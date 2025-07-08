package controller.admin;

import dao.DispatchDetailDAO;
import dao.DispatchReceiptDAO;
import dao.InventoryDAO;
import dao.ProductDAO;
import model.DispatchDetail;
import model.DispatchReceipt;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/DispatchDetailServlet")
public class DispatchDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DispatchDetailDAO dispatchDetailDAO;
    private ProductDAO productDAO;
    private DispatchReceiptDAO dispatchReceiptDAO;
    private InventoryDAO inventoryDAO;        
    public DispatchDetailServlet() throws SQLException {
        super();
        dispatchDetailDAO = new DispatchDetailDAO();
        productDAO = new ProductDAO();
        dispatchReceiptDAO = new DispatchReceiptDAO();
        inventoryDAO = new InventoryDAO();  
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String dispatchIDStr = request.getParameter("dispatchID");

        try {
            if (action == null || action.equals("list")) {
                if (dispatchIDStr != null) {
                    int dispatchID = Integer.parseInt(dispatchIDStr);
                    listDispatchDetails(request, response, dispatchID);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing dispatchID for listing details.");
                }
            } else {
                switch (action) {
                    case "add":
                        showAddDispatchDetailForm(request, response);
                        break;
                    case "edit":
                        showEditDispatchDetailForm(request, response);
                        break;
                    case "delete":
                        deleteDispatchDetail(request, response);
                        break;
                    default:
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action: " + action);
                        break;
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid dispatchID format.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("save".equals(action)) {
            saveDispatchDetail(request, response);
        }
    }

    private void listDispatchDetails(HttpServletRequest request, HttpServletResponse response, int dispatchID) throws ServletException, IOException {
        try {
            DispatchReceipt receipt = dispatchReceiptDAO.getDispatchReceiptById(dispatchID);
            List<DispatchDetail> details = dispatchDetailDAO.getDispatchDetailsByDispatchId(dispatchID);
                List<Product> products = productDAO.getAllProducts();
                request.setAttribute("products", products);

            request.setAttribute("dispatchDetails", details);
            request.setAttribute("dispatchReceipt", receipt);
            request.setAttribute("dispatchID", dispatchID);
            request.getRequestDispatcher("/Admin/dispatchDetailList.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error while listing dispatch details.");
        }
    }

    private void showAddDispatchDetailForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int dispatchID = Integer.parseInt(request.getParameter("dispatchID"));
            List<Product> products = productDAO.getAllProducts();

            request.setAttribute("dispatchID", dispatchID);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/Admin/add_dispatchdetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid dispatchID.");
        }
    }

    private void showEditDispatchDetailForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int dispatchDetailID = Integer.parseInt(request.getParameter("dispatchDetailID"));
            DispatchDetail dispatchDetail = dispatchDetailDAO.getDispatchDetailById(dispatchDetailID);
            List<Product> products = productDAO.getAllProducts();

            request.setAttribute("dispatchDetail", dispatchDetail);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/Admin/edit_dispatchdetail.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading edit form.");
        }
    }

   private void saveDispatchDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        int dispatchID = Integer.parseInt(request.getParameter("dispatchID"));
        int productID = Integer.parseInt(request.getParameter("productID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double unitCost = Double.parseDouble(request.getParameter("unitCost"));
        String reason = request.getParameter("reason");

        // Thêm chi tiết xuất kho vào cơ sở dữ liệu
        DispatchDetail detail = new DispatchDetail(0, dispatchID, productID, quantity, unitCost, reason);
        dispatchDetailDAO.addDispatchDetail(detail);

        // Cập nhật tồn kho sau khi xuất hàng
        DispatchReceipt receipt = dispatchReceiptDAO.getDispatchReceiptById(dispatchID);
        if (receipt != null) {
            // Lấy warehouseID từ DispatchReceipt để cập nhật tồn kho đúng kho
            int warehouseID = receipt.getWarehouseID();
            // Cập nhật giảm tồn kho trong Inventory
            inventoryDAO.decreaseStock(productID, warehouseID, quantity);
        }

        // Sau khi thêm chi tiết xuất và cập nhật tồn kho, chuyển hướng về danh sách chi tiết xuất kho
        response.sendRedirect("DispatchDetailServlet?dispatchID=" + dispatchID);
    } catch (SQLException | NumberFormatException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving dispatch detail.");
    }
}


    private void deleteDispatchDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int dispatchDetailID = Integer.parseInt(request.getParameter("dispatchDetailID"));
            int dispatchID = Integer.parseInt(request.getParameter("dispatchID"));

            dispatchDetailDAO.deleteDispatchDetail(dispatchDetailID);
            response.sendRedirect("DispatchDetailServlet?dispatchID=" + dispatchID);
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting dispatch detail.");
        }
    }
}
