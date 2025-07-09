package dao;

import config.DatabaseConfig;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Wishlist;

public class WishlistDAO {

    public boolean isInWishlist(int userId, int productId) {
        String sql = "SELECT 1 FROM Wishlist WHERE UserID = ? AND ProductID = ?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void addWishlistItem(int userId, int productId) {
        String sql = "INSERT INTO Wishlist (UserID, ProductID, AddedDate) VALUES (?, ?, GETDATE())";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeWishlistItem(int userId, int productId) {
        String sql = "DELETE FROM Wishlist WHERE UserID = ? AND ProductID = ?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Product> getWishlistProducts(int userId) {
        List<Product> list = new ArrayList<>();
        String sql = """
            SELECT p.*
            FROM Wishlist w
            JOIN Products p ON w.ProductID = p.ProductID
            WHERE w.UserID = ?
            """;
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = ProductDAO.extractProductFromResultSet(rs);
                    list.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addWishlistItem(Wishlist wishlistItem) {
        String sql = "INSERT INTO Wishlist (UserID, ProductID, AddedDate) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, wishlistItem.getUserID());
            stmt.setInt(2, wishlistItem.getProductID());
            stmt.setTimestamp(3, new java.sql.Timestamp(wishlistItem.getAddedDate().getTime()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
