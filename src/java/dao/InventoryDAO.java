package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import config.DatabaseConfig;
import model.Inventory;
import model.Warehouse;

public class InventoryDAO {
    private WarehouseDAO warehouseDAO;
    public InventoryDAO() {
        // Constructor trống, không giữ connection
        warehouseDAO = new WarehouseDAO();
    }

    // CREATE
    public void addInventory(Inventory inventory) throws SQLException {
        String query = "INSERT INTO Inventory (ProductID, WarehouseID, CurrentStock, ReservedStock, Location) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, inventory.getProductID());
            stmt.setInt(2, inventory.getWarehouseID());
            stmt.setInt(3, inventory.getCurrentStock());
            stmt.setInt(4, inventory.getReservedStock());
            stmt.setString(5, inventory.getLocation());

            stmt.executeUpdate();
        }
    }

    // READ
    public Inventory getInventoryById(int id) throws SQLException {
        String query = "SELECT * FROM Inventory WHERE InventoryID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Inventory(
                        rs.getInt("InventoryID"),
                        rs.getInt("ProductID"),
                        rs.getInt("WarehouseID"),
                        rs.getInt("CurrentStock"),
                        rs.getInt("ReservedStock"),
                        rs.getTimestamp("LastStockUpdate"),
                        rs.getString("Location")
                    );
                }
            }
        }

        return null;
    }

    // UPDATE
    public void updateInventory(Inventory inventory) throws SQLException {
        String query = "UPDATE Inventory SET ProductID = ?, WarehouseID = ?, CurrentStock = ?, ReservedStock = ?, Location = ?, LastStockUpdate = ? WHERE InventoryID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, inventory.getProductID());
            stmt.setInt(2, inventory.getWarehouseID());
            stmt.setInt(3, inventory.getCurrentStock());
            stmt.setInt(4, inventory.getReservedStock());
            stmt.setString(5, inventory.getLocation());
            stmt.setTimestamp(6, new Timestamp(inventory.getLastStockUpdate().getTime()));
            stmt.setInt(7, inventory.getInventoryID());

            stmt.executeUpdate();
        }
    }

    // DELETE
    public void deleteInventory(int id) throws SQLException {
        String query = "DELETE FROM Inventory WHERE InventoryID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // LIST ALL
    public List<Inventory> getAllInventory() throws SQLException {
        List<Inventory> inventoryList = new ArrayList<>();
        String query = "SELECT * FROM Inventory";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Inventory inventory = new Inventory(
                    rs.getInt("InventoryID"),
                    rs.getInt("ProductID"),
                    rs.getInt("WarehouseID"),
                    rs.getInt("CurrentStock"),
                    rs.getInt("ReservedStock"),
                    rs.getTimestamp("LastStockUpdate"),
                    rs.getString("Location")
                );
                inventoryList.add(inventory);
            }
        }

        return inventoryList;
    }
    // Đếm tổng inventory (theo warehouse nếu có)
public int getTotalInventory(Integer warehouseID) throws SQLException {
    StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM Inventory WHERE 1=1 ");
    List<Object> params = new ArrayList<>();
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
            if (rs.next()) return rs.getInt(1);
        }
    }
    return 0;
}

// Lấy inventory theo warehouse và phân trang
public List<Inventory> getInventoryByPage(Integer warehouseID, int page, int itemsPerPage) throws SQLException {
    List<Inventory> inventoryList = new ArrayList<>();
    int offset = (page - 1) * itemsPerPage;
    StringBuilder query = new StringBuilder("SELECT * FROM Inventory WHERE 1=1 ");
    List<Object> params = new ArrayList<>();
    if (warehouseID != null && warehouseID > 0) {
        query.append("AND WarehouseID = ? ");
        params.add(warehouseID);
    }
    query.append("ORDER BY LastStockUpdate DESC, InventoryID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
    params.add(offset);
    params.add(itemsPerPage);

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query.toString())) {
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Inventory inventory = new Inventory(
                    rs.getInt("InventoryID"),
                    rs.getInt("ProductID"),
                    rs.getInt("WarehouseID"),
                    rs.getInt("CurrentStock"),
                    rs.getInt("ReservedStock"),
                    rs.getTimestamp("LastStockUpdate"),
                    rs.getString("Location")
                );
                inventoryList.add(inventory);
            }
        }
    }
    return inventoryList;
}
    // Tăng tồn kho (khi nhập hàng)
 public void increaseStock(int productID, int warehouseID, int quantity) throws SQLException {
    String sql = "UPDATE Inventory SET CurrentStock = CurrentStock + ?, LastStockUpdate = CURRENT_TIMESTAMP WHERE ProductID = ? AND WarehouseID = ?";

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, quantity);
        stmt.setInt(2, productID);
        stmt.setInt(3, warehouseID);

        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated == 0) {
            // Không tồn tại, thì insert mới
            String insertSQL = "INSERT INTO Inventory (ProductID, WarehouseID, CurrentStock, ReservedStock, LastStockUpdate) VALUES (?, ?, ?, 0, CURRENT_TIMESTAMP)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSQL)) {
                insertStmt.setInt(1, productID);
                insertStmt.setInt(2, warehouseID);
                insertStmt.setInt(3, quantity);
                insertStmt.executeUpdate();
            }
        }
    }
}


   public boolean decreaseStock(int productID, int warehouseID, int quantity) throws SQLException {
    String sql = "UPDATE Inventory " +
                 "SET CurrentStock = CurrentStock - ?, LastStockUpdate = CURRENT_TIMESTAMP " +
                 "WHERE ProductID = ? AND WarehouseID = ? AND CurrentStock >= ?";

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, quantity);       // Số lượng cần giảm
        stmt.setInt(2, productID);
        stmt.setInt(3, warehouseID);
        stmt.setInt(4, quantity);       // Điều kiện CurrentStock >= quantity

        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0; // Trả về true nếu giảm thành công, false nếu tồn kho không đủ
    }
}

   
    // Các phương thức khác (getInventoryByPage, getAllInventory, updateInventory, deleteInventory, etc.)
}
