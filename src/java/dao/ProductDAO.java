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
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
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
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        String sql = "INSERT INTO " + TABLE + " (productName, sku, categoryID, supplierID, description, unit, costPrice, sellingPrice, minStockLevel, isActive, createdDate, lastUpdated, weight, dimensions, expiryDays, brand, origin) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
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
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
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
    // Thay thế method searchProducts trong ProductDAO.java

public static List<Product> searchProducts(String keyword) {
    List<Product> products = new ArrayList<>();
    
    // ENHANCED SEARCH - Multiple strategies
    String sql = "SELECT * FROM " + TABLE + " WHERE isActive = 1 AND (" +
                // 1. Exact match có dấu
                "productName LIKE ? OR " +
                // 2. Search không dấu (nếu DB hỗ trợ)
                "productName COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ? OR " +
                // 3. Tách từ khóa và search từng phần
                "productName LIKE ? OR " +
                "productName LIKE ? OR " +
                "productName LIKE ? OR " +
                // 4. Search trong description và brand
                "description LIKE ? OR " +
                "brand LIKE ? OR " +
                // 5. Search SKU 
                "sku LIKE ?" +
                ") ORDER BY " +
                // Ưu tiên exact match trước
                "CASE " +
                "  WHEN productName LIKE ? THEN 1 " +
                "  WHEN productName LIKE ? THEN 2 " +
                "  WHEN productName LIKE ? THEN 3 " +
                "  ELSE 4 " +
                "END, productName";
    
    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        // Chuẩn bị các pattern search
        String[] keywords = keyword.toLowerCase().split("\\s+");
        String exactPattern = "%" + keyword + "%";
        String firstWordPattern = "%" + keywords[0] + "%";
        String lastWordPattern = keywords.length > 1 ? "%" + keywords[keywords.length-1] + "%" : firstWordPattern;
        
        // Set parameters cho search
        int paramIndex = 1;
        
        // 1-2. Exact patterns
        stmt.setString(paramIndex++, exactPattern);
        stmt.setString(paramIndex++, exactPattern);
        
        // 3-5. Word patterns
        stmt.setString(paramIndex++, firstWordPattern);
        stmt.setString(paramIndex++, lastWordPattern);
        stmt.setString(paramIndex++, exactPattern);
        
        // 6-8. Description, brand, SKU
        stmt.setString(paramIndex++, exactPattern);
        stmt.setString(paramIndex++, exactPattern);
        stmt.setString(paramIndex++, exactPattern);
        
        // Order by parameters
        stmt.setString(paramIndex++, exactPattern);
        stmt.setString(paramIndex++, firstWordPattern);
        stmt.setString(paramIndex++, lastWordPattern);
        
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product product = extractProductFromResultSet(rs);
                products.add(product);
            }
        }
        
        System.out.println("Search query: " + keyword);
        System.out.println("Found products: " + products.size());
        
    } catch (SQLException e) {
        e.printStackTrace();
        System.err.println("Error in searchProducts: " + e.getMessage());
    }
    
    return products;
}

// THÊM method này để search linh hoạt hơn
public static List<Product> smartSearch(String keyword) {
    List<Product> results = new ArrayList<>();
    
    // Nếu search thông thường không có kết quả, thử các chiến lược khác
    results = searchProducts(keyword);
    
    if (results.isEmpty() && keyword.length() > 3) {
        System.out.println("No exact matches, trying fuzzy search...");
        
        // Thử search từng từ riêng biệt
        String[] words = keyword.toLowerCase().split("\\s+");
        for (String word : words) {
            if (word.length() > 2) {
                List<Product> wordResults = searchProducts(word);
                for (Product p : wordResults) {
                    if (!results.contains(p)) {
                        results.add(p);
                    }
                }
            }
        }
    }
    
    return results;
}

    // 11. Lấy sản phẩm featured (ví dụ: có giảm giá hoặc bán chạy)
    public static List<Product> getFeaturedProducts(int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " * FROM " + TABLE + " WHERE isActive = 1 " +
                    "AND costPrice > sellingPrice ORDER BY ((costPrice - sellingPrice) / costPrice) DESC";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
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
        String sql = "SELECT TOP " + limit + " * FROM " + TABLE + " WHERE isActive = 1 " +
                    "ORDER BY createdDate DESC";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
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
        String sql = "SELECT * FROM " + TABLE + " WHERE isActive = 1 " +
                    "AND sellingPrice >= ? AND sellingPrice <= ? ORDER BY sellingPrice";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        String sql = "SELECT TOP " + limit + " * FROM " + TABLE + " WHERE isActive = 1 " +
                    "AND costPrice > 0 AND sellingPrice < costPrice " +
                    "ORDER BY ((costPrice - sellingPrice) / costPrice) DESC";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
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
    String sql = "SELECT TOP " + limit + " p.* FROM " + TABLE + " p " +
                 "JOIN " + TABLE + " curr ON p.categoryID = curr.categoryID " +
                 "WHERE p.isActive = 1 AND p.productID != ? AND curr.productID = ? " +
                 "ORDER BY p.createdDate DESC";
    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, productID);
        stmt.setInt(2, productID);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product product = extractProductFromResultSet(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } catch (SQLException e) {
        e.printStackTrace();
        System.err.println("Error in getRelatedProducts: " + e.getMessage());
    }
    return products;
}

    // 17. Lấy sản phẩm active
    public static List<Product> getActiveProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE + " WHERE isActive = 1 ORDER BY productName";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
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
    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
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
    // Thay thế method getAutocompleteSuggestions trong ProductDAO.java

public static List<Product> getAutocompleteSuggestions(String keyword) {
    List<Product> suggestions = new ArrayList<>();
    
    // Enhanced search query with multiple strategies and better image handling
    String sql = "SELECT DISTINCT p.*, " +
                 "CASE WHEN pi.ImageUrl IS NOT NULL THEN pi.ImageUrl " +
                 "     ELSE CONCAT('User/images/product/img-', p.productID, '.jpg') END as mainImageUrl " +
                 "FROM Products p " +
                 "LEFT JOIN ProductImages pi ON p.productID = pi.ProductID AND pi.IsMainImage = 1 " +
                 "WHERE p.isActive = 1 AND (" +
                 // 1. Exact product name match (highest priority)
                 "LOWER(p.productName) LIKE LOWER(?) OR " +
                 // 2. Word-based matching
                 "LOWER(p.productName) LIKE LOWER(?) OR " +
                 "LOWER(p.productName) LIKE LOWER(?) OR " +
                 // 3. Brand matching
                 "LOWER(p.brand) LIKE LOWER(?) OR " +
                 // 4. Description matching (lower priority)
                 "LOWER(p.description) LIKE LOWER(?) " +
                 ") " +
                 "ORDER BY " +
                 // Priority ordering: exact match first, then by relevance
                 "CASE " +
                 "  WHEN LOWER(p.productName) LIKE LOWER(?) THEN 1 " +  // Exact match
                 "  WHEN LOWER(p.productName) LIKE LOWER(?) THEN 2 " +  // Starts with keyword
                 "  WHEN LOWER(p.brand) LIKE LOWER(?) THEN 3 " +        // Brand match
                 "  WHEN LOWER(p.productName) LIKE LOWER(?) THEN 4 " +  // Contains keyword
                 "  ELSE 5 " +
                 "END, " +
                 "p.productName " +
                 "OFFSET 0 ROWS FETCH NEXT 8 ROWS ONLY"; // Limit to 8 results
    
    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        // Prepare search patterns
        String exactPattern = "%" + keyword + "%";
        String startsWithPattern = keyword + "%";
        String[] words = keyword.toLowerCase().split("\\s+");
        String firstWordPattern = words.length > 0 ? "%" + words[0] + "%" : exactPattern;
        
        System.out.println("🔍 DAO: Executing autocomplete query for: " + keyword);
        
        // Set parameters for WHERE clause
        int paramIndex = 1;
        stmt.setString(paramIndex++, exactPattern);      // 1. Exact match
        stmt.setString(paramIndex++, startsWithPattern); // 2. Starts with
        stmt.setString(paramIndex++, firstWordPattern);  // 3. First word
        stmt.setString(paramIndex++, exactPattern);      // 4. Brand match
        stmt.setString(paramIndex++, exactPattern);      // 5. Description match
        
        // Set parameters for ORDER BY clause
        stmt.setString(paramIndex++, exactPattern);      // ORDER BY 1
        stmt.setString(paramIndex++, startsWithPattern); // ORDER BY 2
        stmt.setString(paramIndex++, exactPattern);      // ORDER BY 3
        stmt.setString(paramIndex++, exactPattern);      // ORDER BY 4
        
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product product = extractProductFromResultSet(rs);
                
                // Set the main image URL from the query
                String mainImageUrl = rs.getString("mainImageUrl");
                product.setImageUrl(mainImageUrl);
                
                suggestions.add(product);
                
                System.out.println("🔍 Found: " + product.getProductName() + 
                                 " (ID: " + product.getProductID() + 
                                 ", Image: " + mainImageUrl + ")");
            }
        }
        
        System.out.println("🔍 DAO: Retrieved " + suggestions.size() + " autocomplete suggestions");
        
    } catch (SQLException e) {
        System.err.println("🔍 Error in getAutocompleteSuggestions: " + e.getMessage());
        e.printStackTrace();
        
        // Fallback: try simple search if complex query fails
        try {
            System.out.println("🔍 Trying fallback search...");
            suggestions = searchProducts(keyword);
            if (suggestions.size() > 8) {
                suggestions = suggestions.subList(0, 8);
            }
            // Set default image URLs for fallback results
            for (Product p : suggestions) {
                if (p.getImageUrl() == null || p.getImageUrl().isEmpty()) {
                    p.setImageUrl("User/images/product/img-" + p.getProductID() + ".jpg");
                }
            }
        } catch (Exception fallbackError) {
            System.err.println("🔍 Fallback search also failed: " + fallbackError.getMessage());
        }
    }
    
    return suggestions;
}

// Enhanced method to get product with main image
public static Product getProductWithMainImage(int productID) {
    Product product = null;
    String sql = "SELECT p.*, " +
                 "CASE WHEN pi.ImageUrl IS NOT NULL THEN pi.ImageUrl " +
                 "     ELSE CONCAT('User/images/product/img-', p.productID, '.jpg') END as mainImageUrl " +
                 "FROM Products p " +
                 "LEFT JOIN ProductImages pi ON p.productID = pi.ProductID AND pi.IsMainImage = 1 " +
                 "WHERE p.productID = ?";
    
    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, productID);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                product = extractProductFromResultSet(rs);
                product.setImageUrl(rs.getString("mainImageUrl"));
            }
        }
    } catch (SQLException e) {
        System.err.println("Error in getProductWithMainImage: " + e.getMessage());
        e.printStackTrace();
    }
    return product;
   }
public static List<Product> searchProductsPaged(String keyword, String categoryId, int offset, int pageSize) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (productName LIKE ? OR sku LIKE ? OR brand LIKE ? OR description LIKE ?)");
            String key = "%" + keyword.trim() + "%";
            for (int i = 0; i < 4; i++) {
                params.add(key);
            }
        }
        if (categoryId != null && !categoryId.isEmpty()) {
            sql.append(" AND categoryID = ?");
            params.add(Integer.parseInt(categoryId));
        }
        sql.append(" ORDER BY productID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

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
//

    //// Đếm số sản phẩm thỏa điều kiện tìm kiếm
public static int countSearchProducts(String keyword, String categoryId) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (productName LIKE ? OR sku LIKE ? OR brand LIKE ? OR description LIKE ?)");
            String key = "%" + keyword.trim() + "%";
            for (int i = 0; i < 4; i++) {
                params.add(key);
            }
        }
        if (categoryId != null && !categoryId.isEmpty()) {
            sql.append(" AND categoryID = ?");
            params.add(Integer.parseInt(categoryId));
        }

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }


}
