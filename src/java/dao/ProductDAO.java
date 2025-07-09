package dao;

import config.DatabaseConfig;
import model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ProductImage;

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
    // Thêm các method này vào cuối class ProductDAO.java hiện có

    // 9. Lấy sản phẩm theo category ID
    public static List<Product> getProductsByCategory(int categoryID) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE + " WHERE categoryID = ? AND isActive = 1 ORDER BY productName";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryID);
            try (ResultSet rs = stmt.executeQuery()) {
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

    // 10. Tìm kiếm sản phẩm theo từ khóa
    public static List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE + " WHERE isActive = 1 AND "
                + "(productName LIKE ? OR description LIKE ? OR brand LIKE ?) "
                + "ORDER BY productName";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            try (ResultSet rs = stmt.executeQuery()) {
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

    // 11. Lấy sản phẩm featured (ví dụ: có giảm giá hoặc bán chạy)
    public static List<Product> getFeaturedProducts(int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " * FROM " + TABLE + " WHERE isActive = 1 "
                + "AND costPrice > sellingPrice ORDER BY ((costPrice - sellingPrice) / costPrice) DESC";
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

    // 12. Lấy sản phẩm mới nhất
    public static List<Product> getNewestProducts(int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " * FROM " + TABLE + " WHERE isActive = 1 "
                + "ORDER BY createdDate DESC";
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

    // 13. Lấy sản phẩm theo khoảng giá
    public static List<Product> getProductsByPriceRange(double minPrice, double maxPrice) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE + " WHERE isActive = 1 "
                + "AND sellingPrice >= ? AND sellingPrice <= ? ORDER BY sellingPrice";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, minPrice);
            stmt.setDouble(2, maxPrice);
            try (ResultSet rs = stmt.executeQuery()) {
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

    // 14. Đếm số sản phẩm theo category
    public static int countProductsByCategory(int categoryID) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM " + TABLE + " WHERE categoryID = ? AND isActive = 1";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // 15. Lấy sản phẩm có giảm giá
    public static List<Product> getDiscountedProducts(int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " * FROM " + TABLE + " WHERE isActive = 1 "
                + "AND costPrice > 0 AND sellingPrice < costPrice "
                + "ORDER BY ((costPrice - sellingPrice) / costPrice) DESC";
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

    // 16. Lấy sản phẩm liên quan (cùng category, trừ sản phẩm hiện tại)
    public static List<Product> getRelatedProducts(int productID, int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " p.* FROM " + TABLE + " p "
                + "JOIN " + TABLE + " c ON p.categoryID = c.categoryID "
                + "WHERE p.isActive = 1 AND p.productID != ? AND c.productID = ? "
                + "ORDER BY p.createdDate DESC";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productID);
            stmt.setInt(2, productID);
            try (ResultSet rs = stmt.executeQuery()) {
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

    // 17. Lấy sản phẩm active
    public static List<Product> getActiveProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE + " WHERE isActive = 1 ORDER BY productName";
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

    public static List<ProductImage> getProductImagesByProductId(int productId) {
        List<ProductImage> images = new ArrayList<>();
        String sql = "SELECT * FROM ProductImages WHERE ProductID = ? ORDER BY DisplayOrder, IsMainImage DESC";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductImage image = new ProductImage();
                    image.setImageID(rs.getInt("ImageID"));
                    image.setProductID(rs.getInt("ProductID"));
                    image.setImageUrl(rs.getString("ImageUrl"));
                    image.setAltText(rs.getString("AltText"));
                    image.setIsMainImage(rs.getBoolean("IsMainImage"));
                    image.setDisplayOrder(rs.getInt("DisplayOrder"));
                    image.setCreatedDate(rs.getDate("CreatedDate"));
                    images.add(image);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return images;
    }

    public List<Product> getProductsForShopPage(Integer categoryId, String search, Integer userId) {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Products WHERE 1=1 ";
        if (categoryId != null) {
            sql += " AND CategoryID = ?";
        }
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND ProductName LIKE ?";
        }

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            int idx = 1;
            if (categoryId != null) {
                stmt.setInt(idx++, categoryId);
            }
            if (search != null && !search.trim().isEmpty()) {
                stmt.setString(idx++, "%" + search + "%");
            }

            try (ResultSet rs = stmt.executeQuery()) {
                WishlistDAO wishlistDAO = new WishlistDAO();
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setSellingPrice(rs.getDouble("SellingPrice"));
                    product.setCostPrice(rs.getDouble("CostPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setMinStockLevel(rs.getInt("MinStockLevel"));
                    // ... gán thêm thuộc tính khác nếu cần

                    if (userId != null) {
                        product.setIsWishlisted(
                                wishlistDAO.isInWishlist(userId, product.getProductID())
                        );
                    } else {
                        product.setIsWishlisted(false);
                    }

                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
