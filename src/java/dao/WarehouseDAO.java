package dao;

import config.DatabaseConfig;
import model.Warehouse;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDAO {

    public WarehouseDAO() {
        // Không giữ connection cố định
    }

    // Lấy tất cả kho
    public List<Warehouse> getAllWarehouses() throws SQLException {
        List<Warehouse> warehouses = new ArrayList<>();
        String query = "SELECT * FROM Warehouses";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                warehouses.add(new Warehouse(
                        rs.getInt("WarehouseID"),
                        rs.getString("WarehouseName"),
                        rs.getString("Location")
                ));
            }
        }

        return warehouses;
    }

    // Lấy kho theo ID
    public Warehouse getWarehouseById(int warehouseID) throws SQLException {
        String query = "SELECT * FROM Warehouses WHERE WarehouseID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, warehouseID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Warehouse(
                            rs.getInt("WarehouseID"),
                            rs.getString("WarehouseName"),
                            rs.getString("Location")
                    );
                }
            }
        }

        return null;
    }
}
