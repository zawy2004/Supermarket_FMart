package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import config.DatabaseConfig;
import model.StockMovement;

public class StockMovementDAO {

    public StockMovementDAO() {
        // Không giữ connection cố định
    }

    // CREATE: Thêm một lần di chuyển kho
    public void addStockMovement(StockMovement movement) throws SQLException {
        String query = "INSERT INTO StockMovements (ProductID, MovementType, Quantity, Reason, ReferenceID, ReferenceType, MovementDate, UnitCost, CreatedBy) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, movement.getProductID());
            stmt.setString(2, movement.getMovementType());
            stmt.setInt(3, movement.getQuantity());
            stmt.setString(4, movement.getReason());
            stmt.setInt(5, movement.getReferenceID());
            stmt.setString(6, movement.getReferenceType());
            stmt.setTimestamp(7, new Timestamp(movement.getMovementDate().getTime()));
            stmt.setBigDecimal(8, movement.getUnitCost());
            stmt.setInt(9, movement.getCreatedBy());

            stmt.executeUpdate();
        }
    }

    // READ: Lấy tất cả các lần di chuyển kho
    public List<StockMovement> getAllStockMovements() throws SQLException {
        List<StockMovement> movements = new ArrayList<>();
        String query = "SELECT * FROM StockMovements";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                StockMovement movement = new StockMovement(
                        rs.getInt("MovementID"),
                        rs.getInt("ProductID"),
                        rs.getString("MovementType"),
                        rs.getInt("Quantity"),
                        rs.getString("Reason"),
                        rs.getInt("ReferenceID"),
                        rs.getString("ReferenceType"),
                        rs.getTimestamp("MovementDate"),
                        rs.getBigDecimal("UnitCost"),
                        rs.getInt("CreatedBy")
                );
                movements.add(movement);
            }
        }

        return movements;
    }
}
