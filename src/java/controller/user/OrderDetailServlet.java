package controller.user;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.OrderDetail;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order_detail")
public class OrderDetailServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            Order order = orderDAO.getOrderByID(orderID);
            List<OrderDetail> details = orderDAO.getOrderDetails(orderID);

            if (order != null) {
                // Tạo DTO để xuất JSON
                OrderDTO dto = new OrderDTO();
                dto.orderNumber = order.getOrderNumber();
                dto.orderDate = new SimpleDateFormat("yyyy-MM-dd").format(order.getOrderDate());
                dto.paymentMethod = order.getPaymentMethod();
                dto.paymentStatus = order.getPaymentStatus();
                dto.status = order.getStatus();
                dto.finalAmount = order.getFinalAmount();

                for (OrderDetail d : details) {
                    ProductDTO p = new ProductDTO();
                    p.name = d.getProductName();
                    p.quantity = d.getQuantity();
                    p.price = d.getUnitPrice();
                    p.total = d.getTotalPrice();
                    p.image = getProductImage(d.getProductID());
                    dto.products.add(p);
                }

                ObjectMapper mapper = new ObjectMapper();
                String json = mapper.writeValueAsString(dto);
                response.getWriter().write(json);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Order not found\"}");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Server error\"}");
            e.printStackTrace();
        }
    }

    // Giả lập hình ảnh sản phẩm (nếu bạn có bảng Product thì thay bằng DAO)
    private String getProductImage(int productID) {
        return "images/product/" + productID + ".jpg";
    }

    // ===================== DTO Classes ======================

    private static class OrderDTO {
        public String orderNumber;
        public String orderDate;
        public String paymentMethod;
        public String paymentStatus;
        public String status;
        public double finalAmount;
        public List<ProductDTO> products = new ArrayList<>();
    }

    private static class ProductDTO {
        public String name;
        public int quantity;
        public double price;
        public double total;
        public String image;
    }
}