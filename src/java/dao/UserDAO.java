package dao;

import config.DatabaseConfig;
import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String query = "SELECT UserID, Username, Email, PasswordHash, FullName, PhoneNumber, Address, DateOfBirth, Gender, RoleID, IsActive, CreatedDate, LastLoginDate, ProfileImageUrl FROM Users";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("Username"),
                        rs.getString("Email"),
                        rs.getString("PasswordHash"),
                        rs.getString("FullName"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address"),
                        rs.getDate("DateOfBirth"),
                        rs.getString("Gender"),
                        rs.getInt("RoleID"),
                        rs.getBoolean("IsActive"),
                        rs.getTimestamp("CreatedDate"),
                        rs.getTimestamp("LastLoginDate"),
                        rs.getString("ProfileImageUrl")
                );
                users.add(user);
            }
        }

        return users;
    }

    public User getUserById(int userId) throws SQLException {
        String query = "SELECT UserID, Username, Email, PasswordHash, FullName, PhoneNumber, Address, DateOfBirth, Gender, RoleID, IsActive, CreatedDate, LastLoginDate, ProfileImageUrl FROM Users WHERE UserID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("UserID"),
                            rs.getString("Username"),
                            rs.getString("Email"),
                            rs.getString("PasswordHash"),
                            rs.getString("FullName"),
                            rs.getString("PhoneNumber"),
                            rs.getString("Address"),
                            rs.getDate("DateOfBirth"),
                            rs.getString("Gender"),
                            rs.getInt("RoleID"),
                            rs.getBoolean("IsActive"),
                            rs.getTimestamp("CreatedDate"),
                            rs.getTimestamp("LastLoginDate"),
                            rs.getString("ProfileImageUrl")
                    );
                }
            }
        }
        return null;
    }

    public boolean insertUser(User user) throws SQLException {
        String query = "INSERT INTO Users (Username, Email, PasswordHash, FullName, PhoneNumber, Address, DateOfBirth, Gender, RoleID, IsActive, CreatedDate, ProfileImageUrl) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getPhoneNumber());
            stmt.setString(6, user.getAddress());
            stmt.setDate(7, new java.sql.Date(user.getDateOfBirth().getTime()));
            stmt.setString(8, user.getGender());
            stmt.setInt(9, user.getRoleID());
            stmt.setBoolean(10, user.isIsActive());
            stmt.setTimestamp(11, new Timestamp(user.getCreatedDate().getTime()));
            stmt.setString(12, user.getProfileImageUrl());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateUser(User user) throws SQLException {
        String query = "UPDATE Users SET Email = ?, FullName = ?, PhoneNumber = ?, Address = ?, DateOfBirth = ?, Gender = ?, RoleID = ?, IsActive = ?, CreatedDate = ?, ProfileImageUrl = ? WHERE UserID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getFullName());
            stmt.setString(3, user.getPhoneNumber());
            stmt.setString(4, user.getAddress());
            stmt.setDate(5, new java.sql.Date(user.getDateOfBirth().getTime()));
            stmt.setString(6, user.getGender());
            stmt.setInt(7, user.getRoleID());
            stmt.setBoolean(8, user.isIsActive());
            stmt.setTimestamp(9, new Timestamp(user.getCreatedDate().getTime()));
            stmt.setString(10, user.getProfileImageUrl());
            stmt.setInt(11, user.getUserID());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteUser(int userId) throws SQLException {
        String query = "DELETE FROM Users WHERE UserID = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean existsByEmail(String email) throws SQLException {
        String query = "SELECT 1 FROM Users WHERE Email = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Nếu tìm thấy kết quả → email đã tồn tại
            }
        }
    }

    public boolean save(User user) {
        try {
            return insertUser(user);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}