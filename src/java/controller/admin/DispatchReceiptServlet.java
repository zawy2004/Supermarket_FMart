package controller.admin;

import dao.DispatchReceiptDAO;
import dao.DispatchDetailDAO;
import dao.WarehouseDAO;
import model.DispatchReceipt;
import model.DispatchDetail;
import model.Warehouse;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/DispatchReceiptServlet")
public class DispatchReceiptServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private DispatchReceiptDAO dispatchReceiptDAO;
    private DispatchDetailDAO dispatchDetailDAO;
    private WarehouseDAO warehouseDAO;

    public DispatchReceiptServlet() throws SQLException {
        super();
        dispatchReceiptDAO = new DispatchReceiptDAO();
        dispatchDetailDAO = new DispatchDetailDAO();
        warehouseDAO = new WarehouseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || "list".equals(action)) {
            listDispatchReceiptsWithFilter(request, response);
        } else {
            switch (action) {
                case "add":
                    showAddForm(request, response);
                    break;
                case "details": {
                    try {
                        showDispatchDetails(request, response);
                    } catch (SQLException ex) {
                        Logger.getLogger(DispatchReceiptServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                break;

                case "delete":
                    deleteDispatchReceipt(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action.");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("save".equals(action)) {
            saveDispatchReceipt(request, response);
        }
    }

    private void listDispatchReceipts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int page = 1;
            int itemsPerPage = 10;

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            int total = dispatchReceiptDAO.getTotalDispatchReceipts();
            int totalPages = (int) Math.ceil((double) total / itemsPerPage);

            if (page > totalPages && totalPages > 0) {
                page = totalPages;
            }

            List<DispatchReceipt> receipts = dispatchReceiptDAO.getDispatchReceiptsByPage(page, itemsPerPage);
            List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
            for (DispatchReceipt receipt : receipts) {
                for (Warehouse w : warehouses) {
                    if (receipt.getWarehouseID() == w.getWarehouseID()) {
                        receipt.setWarehouseName(w.getWarehouseName());
                    }
                }
            }

            request.setAttribute("dispatchReceipts", receipts);

            request.setAttribute("warehouses", warehouses);
            request.setAttribute("page", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/Admin/dispatchReceiptList.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
            request.setAttribute("warehouses", warehouses);
            request.getRequestDispatcher("/Admin/add_dispatchreceipt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading form");
        }
    }

    private void saveDispatchReceipt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));
            String dispatchType = request.getParameter("dispatchType");
            String reference = request.getParameter("reference");
            String notes = request.getParameter("notes");
            int createdBy = 1; // giả định người tạo có ID = 1
            String dateStr = request.getParameter("date");
            System.out.println("warehouseID: " + warehouseID);
            System.out.println("dispatchType: " + dispatchType);
            System.out.println("reference: " + reference);
            System.out.println("notes: " + notes);
            System.out.println("date: " + dateStr);

            java.sql.Date dispatchDate = java.sql.Date.valueOf(dateStr);

            DispatchReceipt receipt = new DispatchReceipt(0, warehouseID, dispatchDate, dispatchType, createdBy, reference, notes);
            dispatchReceiptDAO.addDispatchReceipt(receipt);

            response.sendRedirect("DispatchReceiptServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lưu biên bản xuất kho: " + e.getMessage());
        }
    }

    private void showDispatchDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        try {
            int dispatchID = Integer.parseInt(request.getParameter("dispatchID"));
            List<DispatchDetail> details = dispatchDetailDAO.getDispatchDetailsByDispatchId(dispatchID);

            request.setAttribute("dispatchID", dispatchID);
            request.setAttribute("dispatchDetails", details);
            request.getRequestDispatcher("/Admin/dispatchDetailList.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dispatch details.");
        }
    }

    private void deleteDispatchReceipt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int dispatchID = Integer.parseInt(request.getParameter("dispatchID"));
            dispatchReceiptDAO.deleteDispatchReceipt(dispatchID);
            response.sendRedirect("DispatchReceiptServlet");
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xoá biên bản xuất.");
        }
    }

    private void listDispatchReceiptsWithFilter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Nhận tham số filter
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
            String warehouseIDStr = request.getParameter("warehouseID");
            String pageStr = request.getParameter("page");

            int page = 1;
            if (pageStr != null) {
                try {
                    page = Integer.parseInt(pageStr);
                } catch (Exception ignored) {
                }
            }
            if (page < 1) {
                page = 1;
            }

            int itemsPerPage = 10;
            java.sql.Date fromDate = null, toDate = null;
            Integer warehouseID = null;
            try {
                if (fromDateStr != null && !fromDateStr.isEmpty()) {
                    fromDate = java.sql.Date.valueOf(fromDateStr);
                }
                if (toDateStr != null && !toDateStr.isEmpty()) {
                    toDate = java.sql.Date.valueOf(toDateStr);
                }
                if (warehouseIDStr != null && !warehouseIDStr.isEmpty()) {
                    warehouseID = Integer.valueOf(warehouseIDStr);
                }
            } catch (Exception e) {
            }

            // Truy vấn số lượng và danh sách xuất kho có filter (cần code ở DAO)
            int total = dispatchReceiptDAO.getTotalDispatchReceiptsFilter(fromDate, toDate, warehouseID);
            int totalPages = (int) Math.ceil((double) total / itemsPerPage);

            if (page > totalPages && totalPages > 0) {
                page = totalPages;
            }

            List<DispatchReceipt> receipts = dispatchReceiptDAO.getDispatchReceiptsFilter(fromDate, toDate, warehouseID, page, itemsPerPage);

            List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
            for (DispatchReceipt receipt : receipts) {
                for (Warehouse w : warehouses) {
                    if (receipt.getWarehouseID() == w.getWarehouseID()) {
                        receipt.setWarehouseName(w.getWarehouseName());
                    }
                }
            }

            request.setAttribute("dispatchReceipts", receipts);
            request.setAttribute("warehouses", warehouses);
            request.setAttribute("page", page);
            request.setAttribute("totalPages", totalPages);

            // Để giữ lại giá trị đã chọn
            request.setAttribute("param.fromDate", fromDateStr);
            request.setAttribute("param.toDate", toDateStr);
            request.setAttribute("param.warehouseID", warehouseIDStr);

            request.getRequestDispatcher("/Admin/dispatchReceiptList.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

}
