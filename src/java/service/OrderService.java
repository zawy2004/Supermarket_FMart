package service;

import config.DatabaseConfig;
import dao.OrderDAO;
import model.Order;
import model.OrderDetail;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 *
 * @author thanh
 */
public class OrderService {

    private final OrderDAO orderDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
    }

    public int createOrderFromCart(Order order, List<OrderDetail> details) throws Exception {
        Connection conn = null;
        int orderId;

        try {
            conn = DatabaseConfig.getConnection();
            conn.setAutoCommit(false); // Bắt đầu giao dịch
             OrderDAO dao = new OrderDAO();
            String orderNumber = "ORD" + System.currentTimeMillis();


            order.setOrderNumber(orderNumber);
            // 1. Thêm đơn hàng, sử dụng cùng connection
            orderId = orderDAO.insertOrder(order, conn);
            if (orderId <= 0) {
                throw new SQLException("Không thể thêm đơn hàng.");
            }

            // 2. Thêm chi tiết đơn hàng ORD1752595049412 ORD20250717175275618
            for (OrderDetail d : details) {
                orderDAO.insertOrderDetail(
                        orderId,
                        d.getProductID(),
                        d.getQuantity(),
                        d.getUnitPrice(),
                        d.getDiscountPercent(),
                        d.getDiscountAmount(),
                        d.getTotalPrice(),
                        conn
                );
            }

            // 3. Commit nếu mọi thứ thành công
            conn.commit();
        } catch (Exception e) {
            if (conn != null) {
                conn.rollback(); // Rollback nếu có lỗi
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Trả lại trạng thái ban đầu
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return orderId;
    }

    /**
     * Cập nhật trạng thái thanh toán và đơn hàng (thường dùng sau khi thanh
     * toán thành công).
     */
    public void updatePaymentStatus(int orderId, String paymentStatus, String orderStatus) {
        orderDAO.updatePaymentStatus(orderId, paymentStatus, orderStatus);
    }

    
      //Cập nhật trạng thái đơn hàng.
     
    public void updateOrderStatus(int orderId, String status) {
        orderDAO.updateOrderStatus(orderId, status);
    }

    
      //Cập nhật mã đơn hàng (sau khi sinh tự động).
     
    public void updateOrderNumber(int orderId, String orderNumber) {
        orderDAO.updateOrderNumber(orderId, orderNumber);
    }

    /**
     * Cập nhật số tiền của đơn hàng khi áp dụng coupon
     * @param orderId ID đơn hàng
     * @param totalAmount Tổng tiền hàng
     * @param discountAmount Số tiền giảm giá
     * @param finalAmount Số tiền cuối cùng
     */
    public void updateOrderAmount(int orderId, double totalAmount, double discountAmount, double finalAmount) {
        orderDAO.updateOrderAmount(orderId, totalAmount, discountAmount, finalAmount);
    }

    /**
     * Lấy đơn hàng theo ID
     * @param orderId ID đơn hàng
     * @return Order object hoặc null nếu không tìm thấy
     */
    public Order getOrderById(int orderId) {
        return orderDAO.getOrderById(orderId);
    }

//    private String generateOrderNumber() {
//        // Ví dụ: FM20250717-1699871234567
//        String prefix = "ORD";
//        String date = java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyyMMdd"));
//        long timestamp = System.currentTimeMillis();
//        return prefix + date + "-" + timestamp;
//    }

}