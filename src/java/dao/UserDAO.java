package dao;

import model.User;
import config.DatabaseConfig;
import java.sql.*;

public class UserDAO {
    private Connection conn;

    public UserDAO() {
        try {
            conn = DatabaseConfig.getConnection();
        } catch (SQLException e) {
            System.err.println("Failed to initialize UserDAO: " + e.getMessage());
        }
    }

    public boolean save(User user) {
        String sql = "INSERT INTO Users (Email, PasswordHash, LoginType, FullName, PhoneNumber, Address, DateOfBirth, Gender, RoleID, IsActive, CreatedDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPasswordHash());
            pstmt.setString(3, user.getLoginType());
            pstmt.setString(4, user.getFullName());
            pstmt.setString(5, user.getPhoneNumber());
            pstmt.setString(6, user.getAddress());
            pstmt.setDate(7, user.getDateOfBirth());
            pstmt.setString(8, user.getGender());
            pstmt.setInt(9, user.getRoleId());
            pstmt.setBoolean(10, user.isActive());
            pstmt.setTimestamp(11, user.getCreatedDate());
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error saving user: " + e.getMessage());
            return false;
        }
    }

    public boolean existsByEmail(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
        }
        return false;
    }

    // Đóng kết nối khi không cần thiết (tùy chọn, thường servlet sẽ quản lý)
    public void close() {
        DatabaseConfig.closeConnection();
    }
}