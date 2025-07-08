package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import config.DatabaseConfig;
import model.ImportReceipt;

public class ImportReceiptDAO {

    public ImportReceiptDAO() {
        // Không giữ connection toàn cục
    }

    // CREATE
    public void addImportReceipt(ImportReceipt receipt) throws SQLException {
        String query = "INSERT INTO ImportReceipts (SupplierID, WarehouseID, ImportDate, Notes) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, receipt.getSupplierID());
            stmt.setInt(2, receipt.getWarehouseID());
            stmt.setDate(3, new java.sql.Date(receipt.getImportDate().getTime()));
            stmt.setString(4, receipt.getNotes());
            stmt.executeUpdate();
        }
    }

    // READ by ID
    public ImportReceipt getImportReceiptById(int id) throws SQLException {
        String query = "SELECT * FROM ImportReceipts WHERE ImportID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new ImportReceipt(
                            rs.getInt("ImportID"),
                            rs.getInt("SupplierID"),
                            rs.getInt("WarehouseID"),
                            rs.getDate("ImportDate"),
                            rs.getString("Notes"));
                }
            }
        }
        return null;
    }

    // UPDATE
    public void updateImportReceipt(ImportReceipt receipt) throws SQLException {
        String query = "UPDATE ImportReceipts SET SupplierID = ?, WarehouseID = ?, ImportDate = ?, Notes = ? WHERE ImportID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, receipt.getSupplierID());
            stmt.setInt(2, receipt.getWarehouseID());
            stmt.setDate(3, new java.sql.Date(receipt.getImportDate().getTime()));
            stmt.setString(4, receipt.getNotes());
            stmt.setInt(5, receipt.getImportID());
            stmt.executeUpdate();
        }
    }

    // DELETE
    public void deleteImportReceipt(int id) throws SQLException {
        String query = "DELETE FROM ImportReceipts WHERE ImportID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // LIST ALL
    public List<ImportReceipt> getAllImportReceipts() throws SQLException {
        List<ImportReceipt> receipts = new ArrayList<>();
        String query = "SELECT * FROM ImportReceipts";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                receipts.add(new ImportReceipt(
                        rs.getInt("ImportID"),
                        rs.getInt("SupplierID"),
                        rs.getInt("WarehouseID"),
                        rs.getDate("ImportDate"),
                        rs.getString("Notes")));
            }
        }
        return receipts;
    }

    // Tổng số phiếu nhập
    public int getTotalImportReceipts() throws SQLException {
        String query = "SELECT COUNT(*) FROM ImportReceipts";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Phân trang phiếu nhập
    public List<ImportReceipt> getImportReceiptsByPage(int page, int itemsPerPage) throws SQLException {
        List<ImportReceipt> receipts = new ArrayList<>();
        int offset = (page - 1) * itemsPerPage;
        String query = "SELECT * FROM ImportReceipts ORDER BY ImportID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, offset);
            stmt.setInt(2, itemsPerPage);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    receipts.add(new ImportReceipt(
                            rs.getInt("ImportID"),
                            rs.getInt("SupplierID"),
                            rs.getInt("WarehouseID"),
                            rs.getDate("ImportDate"),
                            rs.getString("Notes")));
                }
            }
        }
        return receipts;
    }
    public List<ImportReceipt> getImportReceiptsFilter(
        Date fromDate, Date toDate, Integer warehouseID, int page, int itemsPerPage
) throws SQLException {
    List<ImportReceipt> receipts = new ArrayList<>();
    int offset = (page - 1) * itemsPerPage;

    StringBuilder query = new StringBuilder(
        "SELECT ir.*, s.SupplierName, w.WarehouseName " +
        "FROM ImportReceipts ir " +
        "LEFT JOIN Suppliers s ON ir.SupplierID = s.SupplierID " +
        "LEFT JOIN Warehouses w ON ir.WarehouseID = w.WarehouseID " +
        "WHERE 1=1 "
    );
    List<Object> params = new ArrayList<>();

    // Bộ lọc từ ngày
    if (fromDate != null) {
        query.append("AND ir.ImportDate >= ? ");
        params.add(new java.sql.Date(fromDate.getTime()));
    }
    // Bộ lọc đến ngày
    if (toDate != null) {
        query.append("AND ir.ImportDate <= ? ");
        params.add(new java.sql.Date(toDate.getTime()));
    }
    // Bộ lọc kho
    if (warehouseID != null && warehouseID > 0) {
        query.append("AND ir.WarehouseID = ? ");
        params.add(warehouseID);
    }

    query.append("ORDER BY ir.ImportDate DESC, ir.ImportID DESC ");
    query.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

    params.add(offset);
    params.add(itemsPerPage);

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query.toString())) {

        // set parameters
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ImportReceipt ir = new ImportReceipt(
                        rs.getInt("ImportID"),
                        rs.getInt("SupplierID"),
                        rs.getInt("WarehouseID"),
                        rs.getDate("ImportDate"),
                        rs.getString("Notes")
                );
                ir.setSupplierName(rs.getString("SupplierName"));
                ir.setWarehouseName(rs.getString("WarehouseName"));
                receipts.add(ir);
            }
        }
    }
    return receipts;
}
    public int getTotalImportReceiptsFilter(Date fromDate, Date toDate, Integer warehouseID) throws SQLException {
    StringBuilder query = new StringBuilder(
        "SELECT COUNT(*) FROM ImportReceipts WHERE 1=1 "
    );
    List<Object> params = new ArrayList<>();

    if (fromDate != null) {
        query.append("AND ImportDate >= ? ");
        params.add(new java.sql.Date(fromDate.getTime()));
    }
    if (toDate != null) {
        query.append("AND ImportDate <= ? ");
        params.add(new java.sql.Date(toDate.getTime()));
    }
    if (warehouseID != null && warehouseID > 0) {
        query.append("AND WarehouseID = ? ");
        params.add(warehouseID);
    }

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query.toString())) {
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
    }
    return 0;
}


}
