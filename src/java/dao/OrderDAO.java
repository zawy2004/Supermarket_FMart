package dao;

import model.Order;
import java.sql.*;
import config.DatabaseConfig;

public class OrderDAO {

    private static final String INSERT_ORDER_SQL
            = "INSERT INTO Orders ([OrderNumber],[CustomerID],[OrderDate],[OrderType],[Status],[TotalAmount],[DiscountAmount],[TaxAmount],[FinalAmount],[PaymentStatus],[PaymentMethod],[DeliveryAddress],[DeliveryDate],[CompletedDate],[ProcessedBy],[Notes]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String INSERT_ORDER_DETAIL_SQL
            = "INSERT INTO OrderDetails ([OrderID],[ProductID],[Quantity],[UnitPrice],[DiscountPercent],[DiscountAmount],[TotalPrice]) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_PAYMENT_STATUS_SQL
            = "UPDATE Orders SET PaymentStatus = ?, Status = ? WHERE OrderID = ?";
    private static final String UPDATE_ORDER_STATUS_SQL
            = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
    private static final String UPDATE_ORDER_NUMBER_SQL
            = "UPDATE Orders SET OrderNumber = ? WHERE OrderID = ?";
    private static final String UPDATE_ORDER_AMOUNT_SQL
            = "UPDATE Orders SET TotalAmount = ?, DiscountAmount = ?, FinalAmount = ? WHERE OrderID = ?";

    // Thêm đơn hàng, trả về orderId (auto-increment)
    public int insertOrder(Order order, Connection conn) throws SQLException {
    int orderId = -1;
    try (PreparedStatement stmt = conn.prepareStatement(INSERT_ORDER_SQL, Statement.RETURN_GENERATED_KEYS)) {
        stmt.setString(1, order.getOrderNumber());
        stmt.setInt(2, order.getCustomerID());
        stmt.setTimestamp(3, new Timestamp(order.getOrderDate().getTime()));
        stmt.setString(4, order.getOrderType() != null ? order.getOrderType() : "Online");
        stmt.setString(5, order.getStatus() != null ? order.getStatus() : "Pending");
        stmt.setDouble(6, order.getTotalAmount());
        stmt.setDouble(7, order.getDiscountAmount());
        stmt.setDouble(8, order.getTaxAmount());
        stmt.setDouble(9, order.getFinalAmount());
        stmt.setString(10, order.getPaymentStatus() != null ? order.getPaymentStatus() : "Pending");
        stmt.setString(11, order.getPaymentMethod());
        stmt.setString(12, order.getDeliveryAddress());
        if (order.getDeliveryDate() != null)
            stmt.setTimestamp(13, new Timestamp(order.getDeliveryDate().getTime()));
        else
            stmt.setNull(13, Types.TIMESTAMP);
        if (order.getCompletedDate() != null)
            stmt.setTimestamp(14, new Timestamp(order.getCompletedDate().getTime()));
        else
            stmt.setNull(14, Types.TIMESTAMP);

        if (order.getProcessedBy() > 0)
            stmt.setInt(15, order.getProcessedBy());
        else
            stmt.setNull(15, Types.INTEGER);

        stmt.setString(16, order.getNotes());

        stmt.executeUpdate();
        try (ResultSet rs = stmt.getGeneratedKeys()) {
            if (rs.next()) orderId = rs.getInt(1);
        }
    }
    return orderId;
}


    public void insertOrderDetail(
            int orderId,
            int productId,
            int quantity,
            double unitPrice,
            double discountPercent,
            double discountAmount,
            double totalPrice,
            Connection conn
    ) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(INSERT_ORDER_DETAIL_SQL)) {
            stmt.setInt(1, orderId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.setDouble(4, unitPrice);
            stmt.setDouble(5, discountPercent);
            stmt.setDouble(6, discountAmount);
            stmt.setDouble(7, totalPrice);
            stmt.executeUpdate();
        }
    }

    // Cập nhật trạng thái đơn hàng (callback VNPAY hoặc xử lý thủ công COD)
    public void updatePaymentStatus(int orderId, String paymentStatus, String orderStatus) {
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(UPDATE_PAYMENT_STATUS_SQL)) {
            stmt.setString(1, paymentStatus);
            stmt.setString(2, orderStatus);
            stmt.setInt(3, orderId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrderStatus(int orderId, String status) {
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(UPDATE_ORDER_STATUS_SQL)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật OrderNumber
    public void updateOrderNumber(int orderId, String orderNumber) {
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(UPDATE_ORDER_NUMBER_SQL)) {
            stmt.setString(1, orderNumber);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Cập nhật số tiền của đơn hàng (khi áp dụng coupon)
     */
    public void updateOrderAmount(int orderId, double totalAmount, double discountAmount, double finalAmount) {
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_ORDER_AMOUNT_SQL)) {

            stmt.setDouble(1, totalAmount);
            stmt.setDouble(2, discountAmount);
            stmt.setDouble(3, finalAmount);
            stmt.setInt(4, orderId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Đã cập nhật số tiền đơn hàng " + orderId +
                                 ": Total=" + totalAmount + ", Discount=" + discountAmount +
                                 ", Final=" + finalAmount);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật số tiền đơn hàng: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Lấy đơn hàng theo ID
     */
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setOrderNumber(rs.getString("OrderNumber"));
                    order.setCustomerID(rs.getInt("CustomerID"));
                    order.setOrderDate(rs.getTimestamp("OrderDate"));
                    order.setOrderType(rs.getString("OrderType"));
                    order.setStatus(rs.getString("Status"));
                    order.setTotalAmount(rs.getDouble("TotalAmount"));
                    order.setDiscountAmount(rs.getDouble("DiscountAmount"));
                    order.setTaxAmount(rs.getDouble("TaxAmount"));
                    order.setFinalAmount(rs.getDouble("FinalAmount"));
                    order.setPaymentStatus(rs.getString("PaymentStatus"));
                    order.setPaymentMethod(rs.getString("PaymentMethod"));
                    order.setDeliveryAddress(rs.getString("DeliveryAddress"));
                    order.setDeliveryDate(rs.getTimestamp("DeliveryDate"));
                    order.setCompletedDate(rs.getTimestamp("CompletedDate"));
                    order.setProcessedBy(rs.getInt("ProcessedBy"));
                    order.setNotes(rs.getString("Notes"));
                    return order;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy đơn hàng theo ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
