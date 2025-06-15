package dao;

import config.DatabaseConfig;
import static config.DatabaseConfig.getConnection;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
public static List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products";  // Giả sử bảng tên là 'products'
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                int productID = rs.getInt("productID");
                String productName = rs.getString("productName");
                String sku = rs.getString("sku");
                int categoryID = rs.getInt("categoryID");
                int supplierID = rs.getInt("supplierID");
                String description = rs.getString("description");
                String unit = rs.getString("unit");
                double costPrice = rs.getDouble("costPrice");
                double sellingPrice = rs.getDouble("sellingPrice");
                int minStockLevel = rs.getInt("minStockLevel");
                boolean isActive = rs.getBoolean("isActive");
                Date createdDate = rs.getDate("createdDate");
                Date lastUpdated = rs.getDate("lastUpdated");
                double weight = rs.getDouble("weight");
                String dimensions = rs.getString("dimensions");
                int expiryDays = rs.getInt("expiryDays");
                String brand = rs.getString("brand");
                String origin = rs.getString("origin");

                Product product = new Product(productID, productName, sku, categoryID, supplierID, 
                        description, unit, costPrice, sellingPrice, minStockLevel, isActive,
                        createdDate, lastUpdated, weight, dimensions, expiryDays, brand, origin);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Lấy sản phẩm theo ID
    public static Product getProductById(int productID) {
        Product product = null;
        String sql = "SELECT * FROM products WHERE productID = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String productName = rs.getString("productName");
                String sku = rs.getString("sku");
                int categoryID = rs.getInt("categoryID");
                int supplierID = rs.getInt("supplierID");
                String description = rs.getString("description");
                String unit = rs.getString("unit");
                double costPrice = rs.getDouble("costPrice");
                double sellingPrice = rs.getDouble("sellingPrice");
                int minStockLevel = rs.getInt("minStockLevel");
                boolean isActive = rs.getBoolean("isActive");
                Date createdDate = rs.getDate("createdDate");
                Date lastUpdated = rs.getDate("lastUpdated");
                double weight = rs.getDouble("weight");
                String dimensions = rs.getString("dimensions");
                int expiryDays = rs.getInt("expiryDays");
                String brand = rs.getString("brand");
                String origin = rs.getString("origin");

                product = new Product(productID, productName, sku, categoryID, supplierID, 
                        description, unit, costPrice, sellingPrice, minStockLevel, isActive,
                        createdDate, lastUpdated, weight, dimensions, expiryDays, brand, origin);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    // Thêm sản phẩm mới
    public static void addProduct(Product product) {
        String sql = "INSERT INTO products (productName, sku, categoryID, supplierID, description, unit, costPrice, sellingPrice, minStockLevel, isActive, createdDate, lastUpdated, weight, dimensions, expiryDays, brand, origin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getSku());
            stmt.setInt(3, product.getCategoryID());
            stmt.setInt(4, product.getSupplierID());
            stmt.setString(5, product.getDescription());
            stmt.setString(6, product.getUnit());
            stmt.setDouble(7, product.getCostPrice());
            stmt.setDouble(8, product.getSellingPrice());
            stmt.setInt(9, product.getMinStockLevel());
            stmt.setBoolean(10, product.isIsActive());
            stmt.setDate(11, new java.sql.Date(product.getCreatedDate().getTime()));
            stmt.setDate(12, new java.sql.Date(product.getLastUpdated().getTime()));
            stmt.setDouble(13, product.getWeight());
            stmt.setString(14, product.getDimensions());
            stmt.setInt(15, product.getExpiryDays());
            stmt.setString(16, product.getBrand());
            stmt.setString(17, product.getOrigin());
            stmt.executeUpdate();
            System.out.println(" Sản phẩm đã được thêm thành công: " + product.getProductName());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật sản phẩm
    public static void updateProduct(Product product) {
        String sql = "UPDATE products SET productName = ?, sku = ?, categoryID = ?, supplierID = ?, description = ?, unit = ?, costPrice = ?, sellingPrice = ?, minStockLevel = ?, isActive = ?, lastUpdated = ?, weight = ?, dimensions = ?, expiryDays = ?, brand = ?, origin = ? WHERE productID = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getSku());
            stmt.setInt(3, product.getCategoryID());
            stmt.setInt(4, product.getSupplierID());
            stmt.setString(5, product.getDescription());
            stmt.setString(6, product.getUnit());
            stmt.setDouble(7, product.getCostPrice());
            stmt.setDouble(8, product.getSellingPrice());
            stmt.setInt(9, product.getMinStockLevel());
            stmt.setBoolean(10, product.isIsActive());
            stmt.setDate(11, new java.sql.Date(product.getLastUpdated().getTime()));
            stmt.setDouble(12, product.getWeight());
            stmt.setString(13, product.getDimensions());
            stmt.setInt(14, product.getExpiryDays());
            stmt.setString(15, product.getBrand());
            stmt.setString(16, product.getOrigin());
            stmt.setInt(17, product.getProductID());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
        public static void deleteProduct(int productID) {
        String sql = "DELETE FROM products WHERE productID = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productID);
            stmt.executeUpdate();
            System.out.println("Sản phẩm đã được xóa: ID = " + productID);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
