

package controller.admin;

import dao.OrderDAO;
import model.OrderReport;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO(); // Khởi tạo DAO để lấy dữ liệu
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy các tham số tìm kiếm từ request
        String searchName = request.getParameter("searchName");
        String status = request.getParameter("status");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String export = request.getParameter("export"); // Kiểm tra nếu yêu cầu xuất Excel

        // Lấy dữ liệu từ DAO với các tham số tìm kiếm
        List<OrderReport> ordersPerHour = orderDAO.getOrdersPerHour(searchName, status, startDate, endDate);
        List<OrderReport> ordersPerDay = orderDAO.getOrdersPerDay(searchName, status, startDate, endDate);
        List<OrderReport> ordersPerMonth = orderDAO.getOrdersPerMonth(searchName, status, startDate, endDate);

        // Lưu dữ liệu vào request để truyền cho JSP
        request.setAttribute("ordersPerHour", ordersPerHour);
        request.setAttribute("ordersPerDay", ordersPerDay);
        request.setAttribute("ordersPerMonth", ordersPerMonth);
        request.setAttribute("searchName", searchName);
        request.setAttribute("status", status);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);

        // Nếu yêu cầu xuất Excel, gọi hàm export
        if ("excel".equalsIgnoreCase(export)) {
            exportToExcel(response, ordersPerDay);
        } else {
            // Nếu không, chuyển hướng đến trang báo cáo
            request.getRequestDispatcher("Admin/reports.jsp").forward(request, response);
        }
    }

    // Hàm xuất Excel
    private void exportToExcel(HttpServletResponse response, List<OrderReport> reports) throws IOException {
        // Kiểm tra nếu không có dữ liệu
        if (reports == null || reports.isEmpty()) {
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write("No data available for export.");
            return;
        }

        // Set response headers trước khi tạo workbook
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"order_report.xlsx\"");
        response.setHeader("Cache-Control", "no-cache");

        // Tạo workbook mới
        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            // Tạo sheet mới
            XSSFSheet sheet = workbook.createSheet("Order Reports");

            // Tạo style cho header
            XSSFCellStyle headerStyle = workbook.createCellStyle();
            XSSFFont headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 12);
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // Tạo hàng tiêu đề
            XSSFRow headerRow = sheet.createRow(0);
            String[] headers = {"Year", "Month", "Day", "Total Orders", "Total Sales"};

            for (int i = 0; i < headers.length; i++) {
                XSSFCell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // Điền dữ liệu vào các hàng tiếp theo
            int rowNum = 1;
            for (OrderReport report : reports) {
                XSSFRow row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(report.getYear());
                row.createCell(1).setCellValue(report.getMonth());
                row.createCell(2).setCellValue(report.getDay());
                row.createCell(3).setCellValue(report.getTotalOrders());
                row.createCell(4).setCellValue(report.getTotalSales());
            }

            // Auto-size columns
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Ghi workbook vào output stream của response
            try (ServletOutputStream out = response.getOutputStream()) {
                workbook.write(out);
                out.flush();
            }

        } catch (IOException e) {
            // Log the error properly
            e.printStackTrace();

            // Only write error message if response hasn't been committed
            if (!response.isCommitted()) {
                response.reset();
                response.setContentType("text/plain; charset=UTF-8");
                response.getWriter().write("Error while exporting the file: " + e.getMessage());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward POST requests to doGet
        doGet(request, response);
    }
}
