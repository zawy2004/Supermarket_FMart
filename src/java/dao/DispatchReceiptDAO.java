package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import config.DatabaseConfig;
import model.DispatchDetail;
import model.DispatchReceipt;

public class DispatchReceiptDAO {

    public DispatchReceiptDAO() {
        // Constructor trống
    }

    // CREATE
   public void addDispatchReceipt(DispatchReceipt receipt) throws SQLException {
    String query = "INSERT INTO DispatchReceipts (WarehouseID, DispatchDate, DispatchType, CreatedBy, Reference, Notes) VALUES (?, ?, ?, ?, ?, ?)";
    try (PreparedStatement stmt = DatabaseConfig.getConnection().prepareStatement(query)) {
        stmt.setInt(1, receipt.getWarehouseID());
        stmt.setDate(2, new java.sql.Date(receipt.getDispatchDate().getTime()));
        stmt.setString(3, receipt.getDispatchType());
        stmt.setInt(4, receipt.getCreatedBy());
        stmt.setString(5, receipt.getReference());
        stmt.setString(6, receipt.getNotes());
        stmt.executeUpdate();
    }
}


    // READ
    public DispatchReceipt getDispatchReceiptById(int id) throws SQLException {
        String query = "SELECT * FROM DispatchReceipts WHERE DispatchID = ?";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new DispatchReceipt(
                            rs.getInt("DispatchID"),
                            rs.getInt("WarehouseID"),
                            rs.getDate("DispatchDate"),
                            rs.getString("DispatchType"),
                            rs.getInt("CreatedBy"),
                            rs.getString("Reference"),
                            rs.getString("Notes")
                    );
                }
            }
        }

        return null;
    }

    // UPDATE
    public void updateDispatchReceipt(DispatchReceipt receipt) throws SQLException {
        String query = "UPDATE DispatchReceipts SET WarehouseID = ?, DispatchDate = ?, DispatchType = ?, CreatedBy = ?, Reference = ?, Notes = ? WHERE DispatchID = ?";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, receipt.getWarehouseID());
            stmt.setDate(2, new java.sql.Date(receipt.getDispatchDate().getTime()));
            stmt.setString(3, receipt.getDispatchType());
            stmt.setInt(4, receipt.getCreatedBy());
            stmt.setString(5, receipt.getReference());
            stmt.setString(6, receipt.getNotes());
            stmt.setInt(7, receipt.getDispatchID());

            stmt.executeUpdate();
        }
    }

    // DELETE
    public void deleteDispatchReceipt(int id) throws SQLException {
        String query = "DELETE FROM DispatchReceipts WHERE DispatchID = ?";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // LIST ALL
    public List<DispatchReceipt> getAllDispatchReceipts() throws SQLException {
        List<DispatchReceipt> receipts = new ArrayList<>();
        String query = "SELECT * FROM DispatchReceipts";

        try (Connection conn = DatabaseConfig.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                receipts.add(new DispatchReceipt(
                        rs.getInt("DispatchID"),
                        rs.getInt("WarehouseID"),
                        rs.getDate("DispatchDate"),
                        rs.getString("DispatchType"),
                        rs.getInt("CreatedBy"),
                        rs.getString("Reference"),
                        rs.getString("Notes")
                ));
            }
        }

        return receipts;
    }

    public int getTotalDispatchReceipts() throws SQLException {
        String query = "SELECT COUNT(*) AS total FROM DispatchReceipts";
        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    public List<DispatchReceipt> getDispatchReceiptsByPage(int page, int itemsPerPage) throws SQLException {
        List<DispatchReceipt> receipts = new ArrayList<>();
        int offset = (page - 1) * itemsPerPage;
        String query = "SELECT * FROM DispatchReceipts ORDER BY DispatchID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, offset);
            stmt.setInt(2, itemsPerPage);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    receipts.add(new DispatchReceipt(
                            rs.getInt("DispatchID"),
                            rs.getInt("WarehouseID"),
                            rs.getDate("DispatchDate"),
                            rs.getString("DispatchType"),
                            rs.getInt("CreatedBy"),
                            rs.getString("Reference"),
                            rs.getString("Notes")
                    ));
                }
            }
        }

        return receipts;
    }
    // Đếm tổng số phiếu xuất theo filter
public int getTotalDispatchReceiptsFilter(java.sql.Date fromDate, java.sql.Date toDate, Integer warehouseID) throws SQLException {
    StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM DispatchReceipts WHERE 1=1 ");
    List<Object> params = new ArrayList<>();
    if (fromDate != null) { query.append("AND DispatchDate >= ? "); params.add(fromDate); }
    if (toDate != null)   { query.append("AND DispatchDate <= ? "); params.add(toDate); }
    if (warehouseID != null && warehouseID > 0) { query.append("AND WarehouseID = ? "); params.add(warehouseID); }
    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query.toString())) {
        for (int i = 0; i < params.size(); i++) stmt.setObject(i + 1, params.get(i));
        try (ResultSet rs = stmt.executeQuery()) { if (rs.next()) return rs.getInt(1); }
    }
    return 0;
}

// Lấy list phiếu xuất theo filter và phân trang
public List<DispatchReceipt> getDispatchReceiptsFilter(java.sql.Date fromDate, java.sql.Date toDate, Integer warehouseID, int page, int itemsPerPage) throws SQLException {
    List<DispatchReceipt> receipts = new ArrayList<>();
    int offset = (page - 1) * itemsPerPage;
    StringBuilder query = new StringBuilder("SELECT * FROM DispatchReceipts WHERE 1=1 ");
    List<Object> params = new ArrayList<>();
    if (fromDate != null) { query.append("AND DispatchDate >= ? "); params.add(fromDate); }
    if (toDate != null)   { query.append("AND DispatchDate <= ? "); params.add(toDate); }
    if (warehouseID != null && warehouseID > 0) { query.append("AND WarehouseID = ? "); params.add(warehouseID); }
    query.append("ORDER BY DispatchDate DESC, DispatchID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
    params.add(offset); params.add(itemsPerPage);

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query.toString())) {
        for (int i = 0; i < params.size(); i++) stmt.setObject(i + 1, params.get(i));
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                receipts.add(new DispatchReceipt(
                    rs.getInt("DispatchID"),
                    rs.getInt("WarehouseID"),
                    rs.getDate("DispatchDate"),
                    rs.getString("DispatchType"),
                    rs.getInt("CreatedBy"),
                    rs.getString("Reference"),
                    rs.getString("Notes")
                ));
            }
        }
    }
    return receipts;
}


    

}
