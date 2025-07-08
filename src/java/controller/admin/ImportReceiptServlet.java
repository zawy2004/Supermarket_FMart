package controller.admin;

import dao.ImportReceiptDAO;
import dao.ImportDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ImportReceipt;
import model.ImportDetail;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.Supplier;
import dao.SupplierDAO;
import dao.WarehouseDAO;
import java.util.HashMap;
import java.util.Map;
import model.Warehouse;

@WebServlet("/ImportReceiptServlet")
public class ImportReceiptServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ImportReceiptDAO importReceiptDAO;
    private ImportDetailDAO importDetailDAO;
    private SupplierDAO supplierDAO;
    private WarehouseDAO warehouseDAO;

    public ImportReceiptServlet() throws SQLException {
        super();
        importReceiptDAO = new ImportReceiptDAO();
        importDetailDAO = new ImportDetailDAO();
        supplierDAO = new SupplierDAO();
        warehouseDAO = new WarehouseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

     if (action == null || "list".equals(action)) {
            listImportReceiptsWithFilter(request, response);
        } else {
            switch (action) {
                case "add":
                    addImportReceiptForm(request, response);
                    break;
                case "details":
                    showImportDetails(request, response);
                    break;
                case "delete":
                    deleteImportReceipt(request, response);
                    break;
                default:
                    break;
            }
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("save".equals(action)) {
            saveImportReceipt(request, response);
        }
    }

    private void listImportReceipts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the current page from request, default to page 1 if not provided
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            // Ensure page is within a valid range
            if (page < 1) {
                page = 1;  // Ensure page is at least 1
            }

            int itemsPerPage = 10;  // Set the number of items per page

            // Get total number of import receipts using the optimized getTotalImportReceipts method
            int totalReceipts = importReceiptDAO.getTotalImportReceipts();
            int totalPages = (int) Math.ceil((double) totalReceipts / itemsPerPage);  // Calculate total pages

            // Ensure page does not exceed total pages
            if (page > totalPages) {
                page = totalPages;
            }

            // Fetch the paginated import receipts using the optimized getImportReceiptsByPage method
            List<ImportReceipt> importReceipts = importReceiptDAO.getImportReceiptsByPage(page, itemsPerPage);

            // Fetch all warehouses for the dropdown in the JSP
            List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();

            // Set the warehouses as an attribute to populate the warehouse dropdown
            request.setAttribute("warehouses", warehouses);

            // Fetch all suppliers at once to optimize performance
            List<Supplier> suppliers = supplierDAO.getAllSuppliers();  // Assume getAllSuppliers exists

            // Create a map of supplierId to supplierName for quick lookup
            Map<Integer, String> supplierMap = new HashMap<>();
            for (Supplier supplier : suppliers) {
                supplierMap.put(supplier.getSupplierID(), supplier.getSupplierName());
            }

            // Create a map of warehouseId to warehouseName for quick lookup
            Map<Integer, String> warehouseMap = new HashMap<>();
            for (Warehouse warehouse : warehouses) {
                warehouseMap.put(warehouse.getWarehouseID(), warehouse.getWarehouseName());
            }

            // Set supplier and warehouse names for each import receipt
            for (ImportReceipt receipt : importReceipts) {
                String supplierName = supplierMap.get(receipt.getSupplierID());
                String warehouseName = warehouseMap.get(receipt.getWarehouseID());

                // Set the supplier and warehouse names in the ImportReceipt object
                receipt.setSupplierName(supplierName);
                receipt.setWarehouseName(warehouseName);
            }

            // Set the importReceipts, current page, and total pages as attributes for the JSP
            request.setAttribute("importReceipts", importReceipts);
            request.setAttribute("page", page);
            request.setAttribute("totalPages", totalPages);

            // Forward the request to the importReceiptList.jsp page
            request.getRequestDispatcher("/Admin/importReceiptList.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }

    private void addImportReceiptForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch suppliers and warehouses to populate dropdowns
            List<Supplier> suppliers = supplierDAO.getAllSuppliers(); // Assuming supplierDAO exists
            List<Warehouse> warehouses = warehouseDAO.getAllWarehouses(); // Assuming warehouseDAO exists

            request.setAttribute("suppliers", suppliers);
            request.setAttribute("warehouses", warehouses);
            request.getRequestDispatcher("/Admin/add_importreceipt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    private void saveImportReceipt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Parse the form data
            int supplierID = Integer.parseInt(request.getParameter("supplierID"));
            int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));
            String notes = request.getParameter("notes");
            String dateStr = request.getParameter("date"); // Assuming a date is being submitted from the form

            // Parse the date from the string (adjust the format if necessary)
            java.sql.Date importDate = java.sql.Date.valueOf(dateStr);

            // Create a new ImportReceipt object
            ImportReceipt receipt = new ImportReceipt(0, supplierID, warehouseID, importDate, notes);

            // Add the import receipt to the database
            importReceiptDAO.addImportReceipt(receipt);

            // Redirect to the import receipt list page
            response.sendRedirect("ImportReceiptServlet");

        } catch (SQLException | IllegalArgumentException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error or invalid input");
        }
    }

    private void showImportDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int importID = Integer.parseInt(request.getParameter("importID"));
        try {
            List<ImportDetail> details = importDetailDAO.getImportDetailsByImportId(importID);
            request.setAttribute("importDetails", details);
            request.getRequestDispatcher("/Admin/importDetailList.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
     // Method to delete an import receipt
    private void deleteImportReceipt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the importID from the request
            int importID = Integer.parseInt(request.getParameter("importID"));

            // Call the DAO method to delete the receipt
            importReceiptDAO.deleteImportReceipt(importID);

            // Redirect back to the list of import receipts
            response.sendRedirect("ImportReceiptServlet");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error while deleting receipt");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ImportID");
        }
    }
    private void listImportReceiptsWithFilter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        // 1. Lấy tham số lọc
        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");
        String warehouseIDStr = request.getParameter("warehouseID");
        String pageStr = request.getParameter("page");

        int page = 1;
        if (pageStr != null) {
            try { page = Integer.parseInt(pageStr); } catch (Exception ignored) {}
        }
        if (page < 1) page = 1;

        int itemsPerPage = 10;

        // 2. Parse filter params
        java.sql.Date fromDate = null, toDate = null;
        Integer warehouseID = null;
        try {
            if (fromDateStr != null && !fromDateStr.isEmpty()) fromDate = java.sql.Date.valueOf(fromDateStr);
            if (toDateStr != null && !toDateStr.isEmpty()) toDate = java.sql.Date.valueOf(toDateStr);
            if (warehouseIDStr != null && !warehouseIDStr.isEmpty()) warehouseID = Integer.valueOf(warehouseIDStr);
        } catch (Exception e) {
            // Trường hợp nhập sai định dạng ngày/tháng/năm sẽ bị bỏ qua
        }

        // 3. Truy vấn dữ liệu có filter
        int totalReceipts = importReceiptDAO.getTotalImportReceiptsFilter(fromDate, toDate, warehouseID);
        int totalPages = (int) Math.ceil((double) totalReceipts / itemsPerPage);

        if (page > totalPages && totalPages > 0) page = totalPages;

        List<ImportReceipt> importReceipts = importReceiptDAO.getImportReceiptsFilter(fromDate, toDate, warehouseID, page, itemsPerPage);

        // 4. Lấy danh sách warehouse để fill select box
        List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
        request.setAttribute("warehouses", warehouses);

        // 5. Lấy danh sách suppliers để map tên
        List<Supplier> suppliers = supplierDAO.getAllSuppliers();
        Map<Integer, String> supplierMap = new HashMap<>();
        for (Supplier supplier : suppliers) {
            supplierMap.put(supplier.getSupplierID(), supplier.getSupplierName());
        }
        Map<Integer, String> warehouseMap = new HashMap<>();
        for (Warehouse warehouse : warehouses) {
            warehouseMap.put(warehouse.getWarehouseID(), warehouse.getWarehouseName());
        }

        for (ImportReceipt receipt : importReceipts) {
            String supplierName = supplierMap.get(receipt.getSupplierID());
            String warehouseName = warehouseMap.get(receipt.getWarehouseID());
            receipt.setSupplierName(supplierName);
            receipt.setWarehouseName(warehouseName);
        }

        // 6. Set thuộc tính về lại request
        request.setAttribute("importReceipts", importReceipts);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);

        // Các tham số filter cũng set lại để giữ nguyên trên form
        request.setAttribute("param.fromDate", fromDateStr);
        request.setAttribute("param.toDate", toDateStr);
        request.setAttribute("param.warehouseID", warehouseIDStr);

        request.getRequestDispatcher("/Admin/importReceiptList.jsp").forward(request, response);

    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
    }
}

}
