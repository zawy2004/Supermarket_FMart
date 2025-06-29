
package dao;

import config.DatabaseConfig;
import model.Wishlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WishlistDAO {
    
    public boolean isInWishlist(int userId, int productId) {
        String sql = "SELECT 1 FROM Wishlist WHERE UserID = ? AND ProductID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("Error in isInWishlist: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public void addWishlistItem(Wishlist wishlistItem) {
        String sql = "INSERT INTO Wishlist (UserID, ProductID, AddedDate) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, wishlistItem.getUserID());
            stmt.setInt(2, wishlistItem.getProductID());
            stmt.setTimestamp(3, new java.sql.Timestamp(wishlistItem.getAddedDate().getTime()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in addWishlistItem: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to add wishlist item: " + e.getMessage());
        }
    }
    
    public void removeWishlistItem(int userId, int productId) {
        String sql = "DELETE FROM Wishlist WHERE UserID = ? AND ProductID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in removeWishlistItem: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
