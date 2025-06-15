package dao;

import model.Product;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public boolean insertProduct(Product product) {
        String query = "INSERT INTO Products (productName, sku, categoryID, supplierID, description, unit, costPrice, sellingPrice, minStockLevel, isActive, createdDate, lastUpdated, weight, dimensions, expiryDays, brand, origin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                throw new SQLException("Connection to the database failed.");
            }

            PreparedStatement stmt = conn.prepareStatement(query);
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

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Products";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                throw new SQLException("Connection to the database failed.");
            }

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getString("sku"),
                        rs.getInt("categoryID"),
                        rs.getInt("supplierID"),
                        rs.getString("description"),
                        rs.getString("unit"),
                        rs.getDouble("costPrice"),
                        rs.getDouble("sellingPrice"),
                        rs.getInt("minStockLevel"),
                        rs.getBoolean("isActive"),
                        rs.getDate("createdDate"),
                        rs.getDate("lastUpdated"),
                        rs.getDouble("weight"),
                        rs.getString("dimensions"),
                        rs.getInt("expiryDays"),
                        rs.getString("brand"),
                        rs.getString("origin")
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }
public boolean updateProduct(Product product) {
    String query = "UPDATE Products SET ProductName = ?, SKU = ?, SellingPrice = ?, CostPrice = ?, Description = ?, " +
                   "Unit = ?, MinStockLevel = ?, IsActive = ?, Brand = ?, Origin = ?, ExpiryDays = ?, Dimensions = ?, " +
                   "Weight = ? WHERE ProductID = ?";

    try (Connection conn = DBConnection.getConnection()) {
        if (conn == null) {
            throw new SQLException("Connection to the database failed.");
        }

        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, product.getProductName());
        stmt.setString(2, product.getSku());
        stmt.setDouble(3, product.getSellingPrice());
        stmt.setDouble(4, product.getCostPrice());
        stmt.setString(5, product.getDescription());
        stmt.setString(6, product.getUnit());
        stmt.setInt(7, product.getMinStockLevel());
        stmt.setBoolean(8, product.isIsActive());
        stmt.setString(9, product.getBrand());
        stmt.setString(10, product.getOrigin());
        stmt.setInt(11, product.getExpiryDays());
        stmt.setString(12, product.getDimensions());
        stmt.setDouble(13, product.getWeight());
        stmt.setInt(14, product.getProductID()); // Đảm bảo rằng bạn đã truyền đúng productID

        int rowsUpdated = stmt.executeUpdate();
        return rowsUpdated > 0; // Trả về true nếu có ít nhất một dòng được cập nhật
    } catch (SQLException e) {
        e.printStackTrace();
        return false; // Trả về false nếu có lỗi xảy ra
    }
}

public Product getProductById(int productID) {
    Product product = null;
    String query = "SELECT * FROM Products WHERE ProductID = ?";

    try (Connection conn = DBConnection.getConnection()) {
        if (conn == null) {
            throw new SQLException("Connection to the database failed.");
        }

        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, productID);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            product = new Product();
            product.setProductID(rs.getInt("ProductID"));
            product.setProductName(rs.getString("ProductName"));
            product.setSku(rs.getString("SKU"));
            product.setSellingPrice(rs.getDouble("SellingPrice"));
            product.setCostPrice(rs.getDouble("CostPrice"));
            product.setDescription(rs.getString("Description"));
            product.setUnit(rs.getString("Unit"));
            product.setMinStockLevel(rs.getInt("MinStockLevel"));
            product.setIsActive(rs.getBoolean("IsActive"));
            product.setBrand(rs.getString("Brand"));
            product.setOrigin(rs.getString("Origin"));
            product.setExpiryDays(rs.getInt("ExpiryDays"));
            product.setDimensions(rs.getString("Dimensions"));
            product.setWeight(rs.getDouble("Weight"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return product;
}
public boolean addProduct(Product product) {
        String query = "INSERT INTO Products (ProductName, SKU, SellingPrice, CostPrice, Description, CategoryID) " +
                       "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                throw new SQLException("Connection failed.");
            }

            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getSku());
            stmt.setDouble(3, product.getSellingPrice());
            stmt.setDouble(4, product.getCostPrice());
            stmt.setString(5, product.getDescription());
            stmt.setInt(6, product.getCategoryID());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy ProductID của sản phẩm mới thêm vào
    public int getLastInsertedProductID() {
        String query = "SELECT MAX(ProductID) AS ProductID FROM Products";
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                throw new SQLException("Connection failed.");
            }

            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("ProductID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

}
