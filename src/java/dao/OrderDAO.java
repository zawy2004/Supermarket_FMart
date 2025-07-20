package dao;

import config.DatabaseConfig;
import model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import model.OrderReport;

public class OrderDAO {

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


}
