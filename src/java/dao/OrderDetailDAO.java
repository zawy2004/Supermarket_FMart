package dao;

import config.DatabaseConfig;
import model.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {

    public List<OrderDetail> getDetailsByOrderId(int orderId) {
        List<OrderDetail> details = new ArrayList<>();
        String query = "SELECT * FROM OrderDetails WHERE orderID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetail detail = new OrderDetail(
                    rs.getInt("orderDetailID"),
                    rs.getInt("orderID"),
                    rs.getInt("productID"),
                    rs.getInt("quantity"),
                    rs.getDouble("unitPrice"),
                    rs.getDouble("discountPercent"),
                    rs.getDouble("discountAmount"),
                    rs.getDouble("totalPrice")
                );
                details.add(detail);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return details;
    }

    public void insertOrderDetail(OrderDetail detail) {
        String query = "INSERT INTO OrderDetails (orderID, productID, quantity, unitPrice, discountPercent, discountAmount, totalPrice) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, detail.getOrderID());
            ps.setInt(2, detail.getProductID());
            ps.setInt(3, detail.getQuantity());
            ps.setDouble(4, detail.getUnitPrice());
            ps.setDouble(5, detail.getDiscountPercent());
            ps.setDouble(6, detail.getDiscountAmount());
            ps.setDouble(7, detail.getTotalPrice());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Thêm hàm update/delete nếu cần
}
