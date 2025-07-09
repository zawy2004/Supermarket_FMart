package dao;

import config.DatabaseConfig;
import model.ProductImage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    // Lấy tất cả ảnh của 1 sản phẩm
    public List<ProductImage> getProductImagesByProductId(int productId) {
        List<ProductImage> images = new ArrayList<>();
        String sql = "SELECT * FROM ProductImages WHERE ProductID = ?";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductImage img = new ProductImage();
                    img.setImageID(rs.getInt("ImageID"));
                    img.setProductID(rs.getInt("ProductID"));
                    img.setImageUrl(rs.getString("ImageUrl"));
                    img.setAltText(rs.getString("AltText"));
                    img.setIsMainImage(rs.getBoolean("IsMainImage"));
                    img.setDisplayOrder(rs.getInt("DisplayOrder"));
                    img.setCreatedDate(rs.getTimestamp("CreatedDate"));
                    images.add(img);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }

    public static String getMainImageUrl(int productId) {
        String sql = "SELECT TOP 1 ImageUrl FROM ProductImages WHERE ProductID = ? AND IsMainImage = 1";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("ImageUrl");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
