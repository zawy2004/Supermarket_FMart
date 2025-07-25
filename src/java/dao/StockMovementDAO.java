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
    public void addStockMovement(int productID, String movementType, int quantity, String reason,
            Integer referenceID, String referenceType, int createdBy,
            String notes, double unitCost) throws SQLException {

        String sql = "INSERT INTO StockMovements "
                + "(ProductID, MovementType, Quantity, Reason, ReferenceID, ReferenceType, CreatedBy, Notes, UnitCost) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productID);
            stmt.setString(2, movementType); // 'IN', 'OUT', 'ADJUSTMENT'
            stmt.setInt(3, quantity);
            stmt.setString(4, reason);

            if (referenceID != null) {
                stmt.setInt(5, referenceID);
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }

            stmt.setString(6, referenceType);
            stmt.setInt(7, createdBy);

            if (notes != null) {
                stmt.setString(8, notes);
            } else {
                stmt.setNull(8, java.sql.Types.NVARCHAR);
            }

            stmt.setDouble(9, unitCost);

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
                Integer refID = rs.getInt("ReferenceID");
                if (rs.wasNull()) {
                    refID = null;
                }

                StockMovement movement = new StockMovement(
                        rs.getInt("MovementID"),
                        rs.getInt("ProductID"),
                        rs.getString("MovementType"),
                        rs.getInt("Quantity"),
                        rs.getString("Reason"),
                        refID,
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

    // READ: Lọc + phân trang
    public List<StockMovement> getStockMovementsFiltered(Integer productID, String movementType, int offset, int limit) throws SQLException {
        List<StockMovement> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM StockMovements WHERE 1=1");

        if (productID != null) {
            sql.append(" AND ProductID = ?");
        }
        if (movementType != null && !movementType.isEmpty()) {
            sql.append(" AND MovementType = ?");
        }
        sql.append(" ORDER BY MovementDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = DatabaseConfig.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            if (productID != null) {
                stmt.setInt(paramIndex++, productID);
            }
            if (movementType != null && !movementType.isEmpty()) {
                stmt.setString(paramIndex++, movementType);
            }

            stmt.setInt(paramIndex++, offset);
            stmt.setInt(paramIndex, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Integer refID = rs.getInt("ReferenceID");
                    if (rs.wasNull()) {
                        refID = null;
                    }

                    StockMovement m = new StockMovement(
                            rs.getInt("MovementID"),
                            rs.getInt("ProductID"),
                            rs.getString("MovementType"),
                            rs.getInt("Quantity"),
                            rs.getString("Reason"),
                            refID,
                            rs.getString("ReferenceType"),
                            rs.getTimestamp("MovementDate"),
                            rs.getBigDecimal("UnitCost"),
                            rs.getInt("CreatedBy")
                    );
                    list.add(m);
                }
            }
        }
        return list;
    }

    public int countStockMovements(Integer productID, String movementType) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM StockMovements WHERE 1=1");
        if (productID != null) {
            sql.append(" AND ProductID = ?");
        }
        if (movementType != null && !movementType.isEmpty()) {
            sql.append(" AND MovementType = ?");
        }

        try (Connection conn = DatabaseConfig.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (productID != null) {
                stmt.setInt(paramIndex++, productID);
            }
            if (movementType != null && !movementType.isEmpty()) {
                stmt.setString(paramIndex++, movementType);
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
