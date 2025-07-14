
package dao;

import config.DatabaseConfig;
import model.Wishlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

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
    

     // Lấy toàn bộ sản phẩm yêu thích của user (dạng Product, thường dùng để hiển thị)
    public List<Product> getWishlistProducts(int userID) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.* FROM Wishlist w JOIN Products p ON w.ProductID = p.ProductID WHERE w.UserID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setSellingPrice(rs.getDouble("SellingPrice"));
                product.setImageUrl(rs.getString("ImageUrl"));
                // ...set các thuộc tính khác nếu cần
                products.add(product);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return products;
    }

    // Thêm sản phẩm vào wishlist
    public boolean addToWishlist(int userID, int productID) {
        String sql = "INSERT INTO Wishlist (UserID, ProductID, AddedDate) VALUES (?, ?, GETDATE())";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, productID);
            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Xóa sản phẩm khỏi wishlist
    public boolean removeFromWishlist(int userID, int productID) {
        String sql = "DELETE FROM Wishlist WHERE UserID = ? AND ProductID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, productID);
            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Kiểm tra sản phẩm đã tồn tại trong wishlist chưa (tránh duplicate)
    public boolean existsInWishlist(int userID, int productID) {
        String sql = "SELECT 1 FROM Wishlist WHERE UserID = ? AND ProductID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, productID);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }
}

