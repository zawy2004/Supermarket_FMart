package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import config.DatabaseConfig;
import model.DispatchDetail;
import model.DispatchReceipt;

public class DispatchDetailDAO {

    public DispatchDetailDAO() {
        // Constructor trống
    }

    // CREATE
    public void addDispatchDetail(DispatchDetail detail) throws SQLException {
        String query = "INSERT INTO DispatchDetails (DispatchID, ProductID, Quantity, UnitCost, Reason) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, detail.getDispatchID());
            stmt.setInt(2, detail.getProductID());
            stmt.setInt(3, detail.getQuantity());
            stmt.setDouble(4, detail.getUnitCost());
            stmt.setString(5, detail.getReason());

            stmt.executeUpdate();
            DispatchReceipt receipt = new DispatchReceiptDAO().getDispatchReceiptById(detail.getDispatchID());
        if (receipt != null) {
            new InventoryDAO().decreaseStock(detail.getProductID(), receipt.getWarehouseID(), detail.getQuantity());
        }
        }
    }

    // READ
    public DispatchDetail getDispatchDetailById(int id) throws SQLException {
        String query = "SELECT * FROM DispatchDetails WHERE DispatchDetailID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new DispatchDetail(
                        rs.getInt("DispatchDetailID"),
                        rs.getInt("DispatchID"),
                        rs.getInt("ProductID"),
                        rs.getInt("Quantity"),
                        rs.getDouble("UnitCost"),
                        rs.getString("Reason")
                    );
                }
            }
        }

        return null;
    }

    // UPDATE
    public void updateDispatchDetail(DispatchDetail detail) throws SQLException {
        String query = "UPDATE DispatchDetails SET DispatchID = ?, ProductID = ?, Quantity = ?, UnitCost = ?, Reason = ? WHERE DispatchDetailID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, detail.getDispatchID());
            stmt.setInt(2, detail.getProductID());
            stmt.setInt(3, detail.getQuantity());
            stmt.setDouble(4, detail.getUnitCost());
            stmt.setString(5, detail.getReason());
            stmt.setInt(6, detail.getDispatchDetailID());

            stmt.executeUpdate();
        }
    }

    // DELETE
    public void deleteDispatchDetail(int id) throws SQLException {
        String query = "DELETE FROM DispatchDetails WHERE DispatchDetailID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // LIST ALL
    public List<DispatchDetail> getAllDispatchDetails() throws SQLException {
        List<DispatchDetail> details = new ArrayList<>();
        String query = "SELECT * FROM DispatchDetails";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                details.add(new DispatchDetail(
                    rs.getInt("DispatchDetailID"),
                    rs.getInt("DispatchID"),
                    rs.getInt("ProductID"),
                    rs.getInt("Quantity"),
                    rs.getDouble("UnitCost"),
                    rs.getString("Reason")
                ));
            }
        }

        return details;
    }
    public List<DispatchDetail> getDispatchDetailsByDispatchId(int dispatchID) throws SQLException {
        List<DispatchDetail> details = new ArrayList<>();
        String query = "SELECT * FROM DispatchDetails WHERE DispatchID = ?";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, dispatchID);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    details.add(new DispatchDetail(
                            rs.getInt("DispatchDetailID"),
                            rs.getInt("DispatchID"),
                            rs.getInt("ProductID"),
                            rs.getInt("Quantity"),
                            rs.getDouble("UnitCost"),
                            rs.getString("Reason")
                    ));
                }
            }
        }

        return details;
    }
}
