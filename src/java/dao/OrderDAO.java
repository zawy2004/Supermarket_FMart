/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import model.Order;
import java.sql.*;
import config.DatabaseConfig;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import model.OrderDetail;
import model.OrderReport;

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





    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM [Orders]";

        try (Connection conn = DatabaseConfig.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("orderID"),
                        rs.getString("orderNumber"),
                        rs.getInt("customerID"),
                        rs.getDate("orderDate"),
                        rs.getString("orderType"),
                        rs.getString("status"),
                        rs.getDouble("totalAmount"),
                        rs.getDouble("discountAmount"),
                        rs.getDouble("taxAmount"),
                        rs.getDouble("finalAmount"),
                        rs.getString("paymentStatus"),
                        rs.getString("paymentMethod"),
                        rs.getString("deliveryAddress"),
                        rs.getDate("deliveryDate"),
                        rs.getDate("completedDate"),
                        rs.getInt("processedBy"),
                        rs.getString("notes")
                );
                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public Order getOrderById(int orderId) {
        String query = "SELECT * FROM [Orders] WHERE orderID = ?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Order(
                        rs.getInt("orderID"),
                        rs.getString("orderNumber"),
                        rs.getInt("customerID"),
                        rs.getDate("orderDate"),
                        rs.getString("orderType"),
                        rs.getString("status"),
                        rs.getDouble("totalAmount"),
                        rs.getDouble("discountAmount"),
                        rs.getDouble("taxAmount"),
                        rs.getDouble("finalAmount"),
                        rs.getString("paymentStatus"),
                        rs.getString("paymentMethod"),
                        rs.getString("deliveryAddress"),
                        rs.getDate("deliveryDate"),
                        rs.getDate("completedDate"),
                        rs.getInt("processedBy"),
                        rs.getString("notes")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public void updateOrder(Order order) {
        // Câu lệnh SQL chỉ cập nhật status
        String sql = "UPDATE [Orders] SET "
                + "status = ? "
                + "WHERE orderID = ?";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            // Set giá trị cho parameter của PreparedStatement
            ps.setString(1, order.getStatus());  // Cập nhật trạng thái
            ps.setInt(2, order.getOrderID());    // Cập nhật theo orderID

            // Thực thi câu lệnh cập nhật
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    // Phân trang với tìm kiếm theo tên khách hàng và trạng thái

    public List<Order> getOrdersWithPaginationAndSearch(int page, int pageSize, String searchName, String status) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM [Orders] WHERE 1=1";

        // Thêm điều kiện tìm kiếm tên (nếu có)
        if (searchName != null && !searchName.isEmpty()) {
            sql += " AND customerName LIKE ?";
        }

        // Thêm điều kiện tìm kiếm theo trạng thái (nếu có)
        if (status != null && !status.isEmpty()) {
            sql += " AND status = ?";
        }

        // Thêm phân trang
        sql += " ORDER BY orderDate OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            int index = 1;

            // Thêm tham số tìm kiếm tên vào prepared statement
            if (searchName != null && !searchName.isEmpty()) {
                ps.setString(index++, "%" + searchName + "%");
            }

            // Thêm tham số trạng thái vào prepared statement
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }

            // Thêm tham số phân trang vào prepared statement
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setOrderNumber(rs.getString("orderNumber"));
                order.setOrderDate(rs.getDate("orderDate"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setFinalAmount(rs.getDouble("finalAmount"));
                order.setDeliveryAddress(rs.getString("deliveryAddress"));

                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getOrdersWithPagination(int page, int pageSize, String searchName, String status, String fromDate, String toDate) {
    List<Order> orders = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM [Orders] o JOIN [Users] u ON o.CustomerID = u.UserID WHERE 1=1");

    // Add filters
    if (searchName != null && !searchName.isEmpty()) {
        sql.append(" AND u.FullName LIKE ?");
    }
    if (status != null && !status.isEmpty()) {
        sql.append(" AND o.Status = ?");
    }
    if (fromDate != null && !fromDate.isEmpty()) {
        sql.append(" AND o.OrderDate >= ?");
    }
    if (toDate != null && !toDate.isEmpty()) {
        sql.append(" AND o.OrderDate <= ?");
    }

    sql.append(" ORDER BY o.OrderDate OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        int paramIndex = 1;

        // Set parameters for filters
        if (searchName != null && !searchName.isEmpty()) {
            ps.setString(paramIndex++, "%" + searchName + "%");
        }
        if (status != null && !status.isEmpty()) {
            ps.setString(paramIndex++, status);
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            ps.setDate(paramIndex++, Date.valueOf(fromDate));
        }
        if (toDate != null && !toDate.isEmpty()) {
            ps.setDate(paramIndex++, Date.valueOf(toDate));
        }

        // Set pagination parameters
        ps.setInt(paramIndex++, (page - 1) * pageSize);
        ps.setInt(paramIndex++, pageSize);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Order order = new Order();
            order.setOrderID(rs.getInt("OrderID"));
            order.setOrderNumber(rs.getString("OrderNumber"));
            order.setOrderDate(rs.getDate("OrderDate"));
            order.setStatus(rs.getString("Status"));
            order.setTotalAmount(rs.getDouble("TotalAmount"));
            order.setFinalAmount(rs.getDouble("FinalAmount"));
            order.setDeliveryAddress(rs.getString("DeliveryAddress"));

            orders.add(order);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return orders;
}

public int getTotalOrders(String searchName, String status, String fromDate, String toDate) {
    int totalOrders = 0;
    StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Orders o JOIN Users u ON o.CustomerID = u.UserID WHERE 1=1");

    if (searchName != null && !searchName.isEmpty()) {
        sql.append(" AND u.FullName LIKE ?");
    }
    if (status != null && !status.isEmpty()) {
        sql.append(" AND o.Status = ?");
    }
    if (fromDate != null && !fromDate.isEmpty()) {
        sql.append(" AND o.OrderDate >= ?");
    }
    if (toDate != null && !toDate.isEmpty()) {
        sql.append(" AND o.OrderDate <= ?");
    }

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        int paramIndex = 1;

        if (searchName != null && !searchName.isEmpty()) {
            ps.setString(paramIndex++, "%" + searchName + "%");
        }
        if (status != null && !status.isEmpty()) {
            ps.setString(paramIndex++, status);
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            ps.setDate(paramIndex++, Date.valueOf(fromDate));
        }
        if (toDate != null && !toDate.isEmpty()) {
            ps.setDate(paramIndex++, Date.valueOf(toDate));
        }

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            totalOrders = rs.getInt(1);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return totalOrders;
}
   public List<OrderReport> getOrdersPerHour(String searchName, String status, String startDate, String endDate) {
        List<OrderReport> reports = new ArrayList<>();
        
        String sql = "SELECT HOUR(orderDate) as hour, COUNT(*) as totalOrders, SUM(finalAmount) as totalSales " +
                     "FROM Orders WHERE orderDate BETWEEN ? AND ? ";

        if (status != null && !status.isEmpty()) {
            sql += " AND status = ? ";
        }

        sql += " GROUP BY HOUR(orderDate) ORDER BY hour";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, startDate);
            ps.setString(2, endDate);

            if (status != null && !status.isEmpty()) {
                ps.setString(3, status);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int hour = rs.getInt("hour");
                int totalOrders = rs.getInt("totalOrders");
                double totalSales = rs.getDouble("totalSales");

                reports.add(new OrderReport(hour, totalOrders, totalSales));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reports;
    }
    // Lấy các đơn hàng theo ngày
    public List<OrderReport> getOrdersPerDay(String searchName, String status, String startDate, String endDate) {
    List<OrderReport> reports = new ArrayList<>();

    String sql = "SELECT YEAR(orderDate) as year, MONTH(orderDate) as month, DAY(orderDate) as day, " +
                 "COUNT(*) as totalOrders, SUM(finalAmount) as totalSales " +
                 "FROM Orders WHERE orderDate BETWEEN ? AND ? ";

    if (status != null && !status.isEmpty()) {
        sql += " AND status = ? ";
    }

    sql += " GROUP BY YEAR(orderDate), MONTH(orderDate), DAY(orderDate) ORDER BY year, month, day";

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, startDate);
        ps.setString(2, endDate);

        if (status != null && !status.isEmpty()) {
            ps.setString(3, status);
        }

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int year = rs.getInt("year");
            int month = rs.getInt("month");
            int day = rs.getInt("day");
            int totalOrders = rs.getInt("totalOrders");
            double totalSales = rs.getDouble("totalSales");

            reports.add(new OrderReport(year, month, day, totalOrders, totalSales));
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return reports;
}


   public List<OrderReport> getOrdersPerMonth(String searchName, String status, String startDate, String endDate) {
    List<OrderReport> reports = new ArrayList<>();

    String sql = "SELECT YEAR(orderDate) as year, MONTH(orderDate) as month, " +
                 "COUNT(*) as totalOrders, SUM(finalAmount) as totalSales " +
                 "FROM Orders WHERE orderDate BETWEEN ? AND ? ";

    if (status != null && !status.isEmpty()) {
        sql += " AND status = ? ";
    }

    sql += " GROUP BY YEAR(orderDate), MONTH(orderDate) ORDER BY year, month";

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, startDate);
        ps.setString(2, endDate);

        if (status != null && !status.isEmpty()) {
            ps.setString(3, status);
        }

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int year = rs.getInt("year");
            int month = rs.getInt("month");
            int totalOrders = rs.getInt("totalOrders");
            double totalSales = rs.getDouble("totalSales");

            reports.add(new OrderReport(year, month, totalOrders, totalSales));
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return reports;
}
   public int getTotalOrdersByStatus(String status) {
    int count = 0;
    String sql = "SELECT COUNT(*) FROM orders WHERE status = ?";
    
    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, status);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            count = rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return count;
}
public List<Order> getOrdersByCustomerId(int customerId) {
    List<Order> orders = new ArrayList<>();
    String sql = "SELECT * FROM [Orders] WHERE customerID = ? ORDER BY orderDate DESC";

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, customerId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Order order = new Order();
            order.setOrderID(rs.getInt("orderID"));
            order.setOrderNumber(rs.getString("orderNumber"));
            order.setCustomerID(rs.getInt("customerID"));
            order.setOrderDate(rs.getTimestamp("orderDate"));
            order.setOrderType(rs.getString("orderType"));
            order.setStatus(rs.getString("status"));
            order.setTotalAmount(rs.getDouble("totalAmount"));
            order.setDiscountAmount(rs.getDouble("discountAmount"));
            order.setTaxAmount(rs.getDouble("taxAmount"));
            order.setFinalAmount(rs.getDouble("finalAmount"));
            order.setPaymentStatus(rs.getString("paymentStatus"));
            order.setPaymentMethod(rs.getString("paymentMethod"));
            order.setDeliveryAddress(rs.getString("deliveryAddress"));
            order.setDeliveryDate(rs.getTimestamp("deliveryDate"));
            order.setCompletedDate(rs.getTimestamp("completedDate"));
            order.setProcessedBy(rs.getInt("processedBy"));
            order.setNotes(rs.getString("notes"));

            orders.add(order);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return orders;
}
public Order getOrderByID(int orderID) {
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("OrderID"));
                order.setOrderNumber(rs.getString("OrderNumber"));
                order.setOrderDate(rs.getDate("OrderDate"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
                order.setPaymentStatus(rs.getString("PaymentStatus"));
                order.setStatus(rs.getString("Status"));
                order.setFinalAmount(rs.getDouble("FinalAmount"));
                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderDetail> getOrderDetails(int orderID) throws SQLException {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT od.*, p.ProductName, p.ImageUrl "
                + "FROM OrderDetails od "
                + "JOIN Products p ON od.ProductID = p.ProductID "
                + "WHERE od.OrderID = ?";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail od = new OrderDetail();
                    od.setOrderDetailID(rs.getInt("OrderDetailID"));
                    od.setOrderID(rs.getInt("OrderID"));
                    od.setProductID(rs.getInt("ProductID"));
                    od.setProductName(rs.getString("ProductName")); // <-- fix lỗi cũ
                    od.setQuantity(rs.getInt("Quantity"));
                    od.setUnitPrice(rs.getDouble("UnitPrice"));
                    od.setDiscountPercent(rs.getDouble("DiscountPercent"));
                    od.setDiscountAmount(rs.getDouble("DiscountAmount"));
                    od.setTotalPrice(rs.getDouble("TotalPrice"));
                    // Nếu muốn thêm ImageUrl, bạn nên dùng một Map hoặc DTO ngoài
                    details.add(od);
                }
            }
        }
        return details;
    }


}



