
package dao;

import config.DatabaseConfig;
import model.ShoppingCart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ShoppingCartDAO {
    
    public ShoppingCart getCartItem(int userId, int productId) {
        String sql = "SELECT * FROM ShoppingCart WHERE UserID = ? AND ProductID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ShoppingCart cartItem = new ShoppingCart();
                    cartItem.setCartID(rs.getInt("CartID"));
                    cartItem.setUserID(rs.getInt("UserID"));
                    cartItem.setProductID(rs.getInt("ProductID"));
                    cartItem.setQuantity(rs.getInt("Quantity"));
                    cartItem.setUnit(rs.getString("Unit"));
                    cartItem.setAddedDate(rs.getDate("AddedDate"));
                    return cartItem;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getCartItem: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public ShoppingCart getCartItemById(int cartId) {
        String sql = "SELECT * FROM ShoppingCart WHERE CartID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ShoppingCart cartItem = new ShoppingCart();
                    cartItem.setCartID(rs.getInt("CartID"));
                    cartItem.setUserID(rs.getInt("UserID"));
                    cartItem.setProductID(rs.getInt("ProductID"));
                    cartItem.setQuantity(rs.getInt("Quantity"));
                    cartItem.setUnit(rs.getString("Unit"));
                    cartItem.setAddedDate(rs.getDate("AddedDate"));
                    return cartItem;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getCartItemById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public void addCartItem(ShoppingCart cartItem) {
        String sql = "INSERT INTO ShoppingCart (UserID, ProductID, Quantity, Unit, AddedDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartItem.getUserID());
            stmt.setInt(2, cartItem.getProductID());
            stmt.setInt(3, cartItem.getQuantity());
            stmt.setString(4, cartItem.getUnit());
            stmt.setTimestamp(5, new java.sql.Timestamp(cartItem.getAddedDate().getTime()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in addCartItem: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to add cart item: " + e.getMessage());
        }
    }
    
    public void updateCartItem(ShoppingCart cartItem) {
        String sql = "UPDATE ShoppingCart SET Quantity = ?, Unit = ?, AddedDate = ? WHERE CartID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartItem.getQuantity());
            stmt.setString(2, cartItem.getUnit());
            stmt.setTimestamp(3, new java.sql.Timestamp(cartItem.getAddedDate().getTime()));
            stmt.setInt(4, cartItem.getCartID());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in updateCartItem: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to update cart item: " + e.getMessage());
        }
    }
    
    public void removeCartItem(int cartId) {
        String sql = "DELETE FROM ShoppingCart WHERE CartID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error in removeCartItem: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public List<ShoppingCart> getCartItemsByUserId(int userId) {
        List<ShoppingCart> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM ShoppingCart WHERE UserID = ? ORDER BY AddedDate DESC";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ShoppingCart cartItem = new ShoppingCart();
                    cartItem.setCartID(rs.getInt("CartID"));
                    cartItem.setUserID(rs.getInt("UserID"));
                    cartItem.setProductID(rs.getInt("ProductID"));
                    cartItem.setQuantity(rs.getInt("Quantity"));
                    cartItem.setUnit(rs.getString("Unit"));
                    cartItem.setAddedDate(rs.getDate("AddedDate"));
                    cartItems.add(cartItem);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getCartItemsByUserId: " + e.getMessage());
            e.printStackTrace();
        }
        return cartItems;
    }
}
