package dao;

import config.DatabaseConfig;
import model.Supplier;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO {

    public SupplierDAO() {
        // Không giữ Connection toàn cục
    }

    // Lấy tất cả nhà cung cấp
    public List<Supplier> getAllSuppliers() throws SQLException {
        List<Supplier> suppliers = new ArrayList<>();
        String query = "SELECT supplierID, supplierName, contactPerson, phoneNumber, email, address, taxCode, isActive, createdDate, notes FROM suppliers";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Supplier supplier = new Supplier(
                        rs.getInt("supplierID"),
                        rs.getString("supplierName"),
                        rs.getString("contactPerson"),
                        rs.getString("phoneNumber"),
                        rs.getString("email"),
                        rs.getString("address"),
                        rs.getString("taxCode"),
                        rs.getBoolean("isActive"),
                        rs.getDate("createdDate"),
                        rs.getString("notes")
                );
                suppliers.add(supplier);
            }
        }

        return suppliers;
    }

    // Lấy nhà cung cấp theo ID
    public Supplier getSupplierById(int supplierID) throws SQLException {
        String query = "SELECT * FROM Suppliers WHERE SupplierID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, supplierID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Supplier(
                            rs.getInt("SupplierID"),
                            rs.getString("SupplierName"),
                            rs.getString("ContactPerson"),
                            rs.getString("PhoneNumber"),
                            rs.getString("Email"),
                            rs.getString("Address"),
                            rs.getString("TaxCode"),
                            rs.getBoolean("IsActive"),
                            rs.getDate("CreatedDate"),
                            rs.getString("Notes")
                    );
                }
            }
        }

        return null;
    }

    // TODO: Thêm phương thức thêm, cập nhật, xoá nhà cung cấp nếu cần
}
