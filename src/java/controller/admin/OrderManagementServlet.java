package controller.admin;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.OrderDetail;

import java.io.IOException;
import java.util.List;
import model.Product;

@WebServlet("/OrderManagementServlet")
public class OrderManagementServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderDetailDAO orderDetailDAO;
    private ProductDAO productDAO;
    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderDetailDAO = new OrderDetailDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "view":
                viewOrderDetail(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            default:
                listOrders(request, response);
                break;
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int pageSize = 10;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }

        // Get search parameters
        String searchName = request.getParameter("searchName");
        String status = request.getParameter("status");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        // Get the total number of orders after applying filters
        int totalOrders = orderDAO.getTotalOrders(searchName, status, fromDate, toDate);
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);

        // Fetch orders for the current page with filters
        List<Order> orders = orderDAO.getOrdersWithPagination(page, pageSize, searchName, status, fromDate, toDate);

        // Get total number of orders by each status
        int pendingCount = orderDAO.getTotalOrdersByStatus("Pending");
        int confirmedCount = orderDAO.getTotalOrdersByStatus("Confirmed");
        int processingCount = orderDAO.getTotalOrdersByStatus("Processing");
        int completedCount = orderDAO.getTotalOrdersByStatus("Completed");
        int cancelledCount = orderDAO.getTotalOrdersByStatus("Cancelled");

        // Set attributes for JSP
        request.setAttribute("orderList", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchName", searchName);
        request.setAttribute("status", status);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        
        // Set status counts for JSP
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("confirmedCount", confirmedCount);
        request.setAttribute("processingCount", processingCount);
        request.setAttribute("completedCount", completedCount);
        request.setAttribute("cancelledCount", cancelledCount);

        request.getRequestDispatcher("Admin/orders.jsp").forward(request, response);
    }

    // View order detail
private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(orderId);
        List<OrderDetail> orderDetails = orderDetailDAO.getDetailsByOrderId(orderId);

        // Lấy tên sản phẩm từ ProductDAO và gán vào OrderDetail
        for (OrderDetail item : orderDetails) {
            Product product = productDAO.getProductById(item.getProductID()); // Lấy thông tin sản phẩm
            item.setProductName(product != null ? product.getProductName() : "Unknown Product"); // Gán tên sản phẩm
        }

        // Truyền danh sách orderDetails vào JSP
        request.setAttribute("order", order);
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("Admin/order_view.jsp").forward(request, response);
    }

    // Show edit form
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(orderId);
        List<OrderDetail> orderDetails = orderDetailDAO.getDetailsByOrderId(orderId);
    // Lấy tên sản phẩm từ ProductDAO và gán vào OrderDetail
        for (OrderDetail item : orderDetails) {
            Product product = productDAO.getProductById(item.getProductID()); // Lấy thông tin sản phẩm
            item.setProductName(product != null ? product.getProductName() : "Unknown Product"); // Gán tên sản phẩm
        }
        request.setAttribute("order", order);
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("Admin/order_edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            updateOrder(request, response);
        } else {
            response.sendRedirect("OrderManagementServlet");
        }
    }

    // Update order status
    private void updateOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int orderID = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        // Lấy thông tin đơn hàng từ DAO
        Order order = orderDAO.getOrderById(orderID);
        if (order != null) {
            order.setStatus(status);  // Cập nhật trạng thái
            orderDAO.updateOrder(order);  // Cập nhật cơ sở dữ liệu
        }

        response.sendRedirect("OrderManagementServlet?action=view&id=" + orderID);  // Chuyển hướng đến trang chi tiết đơn hàng
    }
}
