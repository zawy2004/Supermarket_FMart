package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import config.DatabaseConfig;
import model.ImportDetail;
import model.ImportReceipt;

public class ImportDetailDAO {

    public ImportDetailDAO() {
        // No need to store connection here
    }

    // CREATE
    public void addImportDetail(ImportDetail detail) throws SQLException {
        String sql = "INSERT INTO ImportDetails (ImportID, ProductID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, detail.getImportID());
            stmt.setInt(2, detail.getProductID());
            stmt.setInt(3, detail.getQuantity());
            stmt.setDouble(4, detail.getUnitPrice());
            stmt.executeUpdate();
            ImportReceipt receipt = new ImportReceiptDAO().getImportReceiptById(detail.getImportID());
                if (receipt != null) {
            new InventoryDAO().increaseStock(detail.getProductID(), receipt.getWarehouseID(), detail.getQuantity());
            }
        }
    }

    // READ by ID
    public ImportDetail getImportDetailById(int id) throws SQLException {
        String query = "SELECT * FROM ImportDetails WHERE ImportDetailID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new ImportDetail(
                            rs.getInt("ImportDetailID"),
                            rs.getInt("ImportID"),
                            rs.getInt("ProductID"),
                            rs.getInt("Quantity"),
                            rs.getDouble("UnitPrice"));
                }
            }
        }
        return null;
    }

    // UPDATE
    public void updateImportDetail(ImportDetail detail) throws SQLException {
        String query = "UPDATE ImportDetails SET ImportID = ?, ProductID = ?, Quantity = ?, UnitPrice = ? WHERE ImportDetailID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, detail.getImportID());
            stmt.setInt(2, detail.getProductID());
            stmt.setInt(3, detail.getQuantity());
            stmt.setDouble(4, detail.getUnitPrice());
            stmt.setInt(5, detail.getImportDetailID());
            stmt.executeUpdate();
        }
    }

    // DELETE
    public void deleteImportDetail(int id) throws SQLException {
        String query = "DELETE FROM ImportDetails WHERE ImportDetailID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // LIST ALL
    public List<ImportDetail> getAllImportDetails() throws SQLException {
        List<ImportDetail> details = new ArrayList<>();
        String query = "SELECT * FROM ImportDetails";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                details.add(new ImportDetail(
                        rs.getInt("ImportDetailID"),
                        rs.getInt("ImportID"),
                        rs.getInt("ProductID"),
                        rs.getInt("Quantity"),
                        rs.getDouble("UnitPrice")));
            }
        }
        return details;
    }

    // READ by ImportID
    public List<ImportDetail> getImportDetailsByImportId(int importID) throws SQLException {
        List<ImportDetail> details = new ArrayList<>();
        String query = "SELECT d.*, p.ProductName FROM ImportDetails d JOIN Products p ON d.ProductID = p.ProductID WHERE d.ImportID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, importID);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ImportDetail detail = new ImportDetail(
                            rs.getInt("ImportDetailID"),
                            rs.getInt("ImportID"),
                            rs.getInt("ProductID"),
                            rs.getInt("Quantity"),
                            rs.getDouble("UnitPrice")
                    );
                    detail.setProductName(rs.getString("ProductName")); // cần set nếu có trường này
                    details.add(detail);
                }
            }
        }
        return details;
    }
}
