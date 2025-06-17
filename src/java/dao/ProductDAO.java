package dao;

import config.DatabaseConfig;
import model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Dùng đúng tên bảng, tên trường (chữ hoa/thường tuỳ DBMS)
    private static final String TABLE = "Products";

    // 1. Mapping product
    public static Product extractProductFromResultSet(ResultSet rs) throws SQLException {
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

        return new Product(productID, productName, sku, categoryID, supplierID,
                description, unit, costPrice, sellingPrice, minStockLevel, isActive,
                createdDate, lastUpdated, weight, dimensions, expiryDays, brand, origin);
    }

    // 2. Lấy tất cả sản phẩm
    public static List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE;
        try (Connection conn = DatabaseConfig.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Product product = extractProductFromResultSet(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // 3. Lấy sản phẩm theo ID
    public static Product getProductById(int productID) {
        Product product = null;
        String sql = "SELECT * FROM " + TABLE + " WHERE productID = ?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = extractProductFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    // 4. Thêm sản phẩm mới
    public static void addProduct(Product product) {
        String sql = "INSERT INTO " + TABLE + " (productName, sku, categoryID, supplierID, description, unit, costPrice, sellingPrice, minStockLevel, isActive, createdDate, lastUpdated, weight, dimensions, expiryDays, brand, origin) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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
            System.out.println("Sản phẩm đã được thêm: " + product.getProductName());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 5. Cập nhật sản phẩm
    public static void updateProduct(Product product) {
        String sql = "UPDATE " + TABLE + " SET productName = ?, sku = ?, categoryID = ?, supplierID = ?, description = ?, unit = ?, costPrice = ?, sellingPrice = ?, minStockLevel = ?, isActive = ?, lastUpdated = ?, weight = ?, dimensions = ?, expiryDays = ?, brand = ?, origin = ? WHERE productID = ?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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

    // 6. Xoá sản phẩm
    public static void deleteProduct(int productID) {
        String sql = "DELETE FROM " + TABLE + " WHERE productID = ?";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productID);
            stmt.executeUpdate();
            System.out.println("Sản phẩm đã được xóa: ID = " + productID);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 7. Lấy sản phẩm theo trang
    public static List<Product> getProductsByPage(int offset, int pageSize) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE + " ORDER BY productID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = extractProductFromResultSet(rs);
                    products.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // 8. Đếm tổng số sản phẩm
    public static int getTotalProducts() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM " + TABLE;
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    // 9. Tìm kiếm sản phẩm theo keyword và category

    public static List<Product> searchProducts(String keyword, String categoryId) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM " + TABLE + " WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (productName LIKE ? OR sku LIKE ? OR brand LIKE ? OR description LIKE ?)");
            String key = "%" + keyword.trim() + "%";
            params.add(key);
            params.add(key);
            params.add(key);
            params.add(key);
        }
        if (categoryId != null && !categoryId.isEmpty()) {
            sql.append(" AND categoryID = ?");
            params.add(Integer.parseInt(categoryId));
        }

        sql.append(" ORDER BY productID DESC"); // Để hiển thị mới nhất trên cùng

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = extractProductFromResultSet(rs);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
// Tìm kiếm + phân trang 
public static List<Product> searchProductsPaged(String keyword, String categoryId, int offset, int pageSize) {
    List<Product> products = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE 1=1");
    List<Object> params = new ArrayList<>();

    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (productName LIKE ? OR sku LIKE ? OR brand LIKE ? OR description LIKE ?)");
        String key = "%" + keyword.trim() + "%";
        for (int i = 0; i < 4; i++) params.add(key);
    }
    if (categoryId != null && !categoryId.isEmpty()) {
        sql.append(" AND categoryID = ?");
        params.add(Integer.parseInt(categoryId));
    }
    sql.append(" ORDER BY productID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
    params.add(offset);
    params.add(pageSize);

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product product = extractProductFromResultSet(rs);
                products.add(product);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return products;
}

// Đếm số sản phẩm thỏa điều kiện tìm kiếm
public static int countSearchProducts(String keyword, String categoryId) {
    int count = 0;
    StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products WHERE 1=1");
    List<Object> params = new ArrayList<>();

    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (productName LIKE ? OR sku LIKE ? OR brand LIKE ? OR description LIKE ?)");
        String key = "%" + keyword.trim() + "%";
        for (int i = 0; i < 4; i++) params.add(key);
    }
    if (categoryId != null && !categoryId.isEmpty()) {
        sql.append(" AND categoryID = ?");
        params.add(Integer.parseInt(categoryId));
    }

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return count;
}
}