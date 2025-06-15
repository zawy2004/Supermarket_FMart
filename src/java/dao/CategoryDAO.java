
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import model.Category;
import util.DBConnection;

public class CategoryDAO {
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT CategoryID, CategoryName, Description, ParentCategoryID, ImageUrl, IsActive, CreatedDate, DisplayOrder FROM Categories";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setDescription(rs.getString("Description"));
                category.setParentCategoryID(rs.getInt("ParentCategoryID"));
                category.setImageUrl(rs.getString("ImageUrl"));
                category.setIsActive(rs.getBoolean("IsActive"));
                category.setCreatedDate(rs.getDate("CreatedDate"));
                category.setDisplayOrder(rs.getInt("DisplayOrder"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return categories;
    }
    public boolean updateCategory(Category category) {
        String query = "UPDATE Categories SET CategoryName = ?, Description = ?, ImageUrl = ?, IsActive = ? WHERE CategoryID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.setString(3, category.getImageUrl());
            ps.setBoolean(4, category.getIsActive());
            ps.setInt(5, category.getCategoryID());
            
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
     public Category getCategoryByID(int categoryID) {
        Category category = null;
        String query = "SELECT CategoryID, CategoryName, Description, ParentCategoryID, ImageUrl, IsActive, CreatedDate, DisplayOrder FROM Categories WHERE CategoryID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                category = new Category();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setDescription(rs.getString("Description"));
                category.setParentCategoryID(rs.getInt("ParentCategoryID"));
                category.setImageUrl(rs.getString("ImageUrl"));
                category.setIsActive(rs.getBoolean("IsActive"));
                category.setCreatedDate(rs.getDate("CreatedDate"));
                category.setDisplayOrder(rs.getInt("DisplayOrder"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return category;
    }
}
