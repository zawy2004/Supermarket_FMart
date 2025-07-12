package dao;

import config.DatabaseConfig;
import java.sql.*;

public class ProductImageDAO {

    // Thêm hình ảnh vào bảng ProductImages
    public boolean addProductImage(int productID, String imagePath) {
        String query = "INSERT INTO ProductImages (ProductID, ImageUrl, IsMainImage) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection()) {
            if (conn == null) {
                throw new SQLException("Connection failed.");
            }

            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, productID);
            stmt.setString(2, imagePath);
            stmt.setBoolean(3, true);  // Đặt mặc định là hình ảnh chính

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
