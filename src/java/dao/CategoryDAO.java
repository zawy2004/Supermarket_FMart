package dao;

import config.DatabaseConfig;
import model.Category;

import java.sql.*;
import java.util.*;

public class CategoryDAO {

    public static List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories ORDER BY displayOrder";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new Category(
                        rs.getInt("categoryID"),
                        rs.getString("categoryName"),
                        rs.getString("description"),
                        rs.getInt("parentCategoryID"),
                        rs.getString("imageUrl"),
                        rs.getBoolean("isActive"),
                        rs.getTimestamp("createdDate"),
                        rs.getInt("displayOrder")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void addCategory(Category cat) {
        String sql = "INSERT INTO categories (categoryName, description, parentCategoryID, imageUrl, isActive, createdDate, displayOrder) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cat.getCategoryName());
            stmt.setString(2, cat.getDescription());
            // Nếu là 0 thì cho vào NULL
            if (cat.getParentCategoryID() == 0) {
                stmt.setNull(3, java.sql.Types.INTEGER);
            } else {
                stmt.setInt(3, cat.getParentCategoryID());
            }
            stmt.setString(4, cat.getImageUrl());
            stmt.setBoolean(5, cat.getIsActive());
            stmt.setDate(6, new java.sql.Date(cat.getCreatedDate().getTime()));
            stmt.setInt(7, cat.getDisplayOrder());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void updateCategory(Category cat) {
        String sql = "UPDATE categories SET categoryName=?, description=?, parentCategoryID=?, imageUrl=?, isActive=?, displayOrder=? WHERE categoryID=?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cat.getCategoryName());
            stmt.setString(2, cat.getDescription());
            if (cat.getParentCategoryID() == 0 || cat.getParentCategoryID() == cat.getCategoryID()) {
                // Không cho làm parent của chính nó hoặc root thì NULL
                stmt.setNull(3, java.sql.Types.INTEGER);
            } else {
                stmt.setInt(3, cat.getParentCategoryID());
            }
            stmt.setString(4, cat.getImageUrl());
            stmt.setBoolean(5, cat.getIsActive());
            stmt.setInt(6, cat.getDisplayOrder());
            stmt.setInt(7, cat.getCategoryID());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Category getCategoryById(int id) {
        String sql = "SELECT * FROM categories WHERE categoryID = ?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractCategory(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static Category extractCategory(ResultSet rs) throws SQLException {
        return new Category(
                rs.getInt("categoryID"),
                rs.getString("categoryName"),
                rs.getString("description"),
                rs.getInt("parentCategoryID"),
                rs.getString("imageUrl"),
                rs.getBoolean("isActive"),
                rs.getDate("createdDate"),
                rs.getInt("displayOrder")
        );
    }

    public static void deleteCategory(int id) {
        String sql = "DELETE FROM categories WHERE categoryID = ?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
