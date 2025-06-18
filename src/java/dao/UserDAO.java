package dao;

import model.User;
import config.DatabaseConfig;
import java.sql.*;

public class UserDAO {
    public UserDAO() {
        // Test connection during initialization
        try (Connection testConn = DatabaseConfig.getConnection()) {
            if (testConn != null) {
                System.out.println("Database connection established successfully during UserDAO initialization");
            } else {
                System.err.println("Failed to obtain database connection during UserDAO initialization");
            }
        } catch (SQLException e) {
            System.err.println("Failed to initialize UserDAO: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public boolean save(User user) {
        String sql = "INSERT INTO Users " +
                "(Username, Email, PasswordHash, FullName, PhoneNumber, Address, DateOfBirth, Gender, RoleID, IsActive, CreatedDate, " +
                "LastLoginDate, ProfileImageUrl, StudentID, Department, AuthProvider, ExternalID) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        System.out.println("Executing SQL: " + sql);
        System.out.println("User data: " + user.toString());

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            String username = user.getUsername() != null ? user.getUsername() : user.getEmail();
            if (username == null || username.trim().isEmpty()) {
                System.err.println("Username/Email cannot be null or empty");
                return false;
            }

            pstmt.setString(1, username);
            System.out.println("1. Username: " + username);

            if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
                System.err.println("Email cannot be null or empty");
                return false;
            }
            pstmt.setString(2, user.getEmail());
            System.out.println("2. Email: " + user.getEmail());

            pstmt.setString(3, user.getPasswordHash());
            System.out.println("3. PasswordHash: " + (user.getPasswordHash() != null ? "***" : "NULL"));

            if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
                System.err.println("FullName cannot be null or empty");
                return false;
            }
            pstmt.setString(4, user.getFullName().trim());
            System.out.println("4. FullName: " + user.getFullName());

            pstmt.setString(5, user.getPhoneNumber());
            pstmt.setString(6, user.getAddress());
            pstmt.setDate(7, user.getDateOfBirth());
            pstmt.setString(8, user.getGender());
            pstmt.setInt(9, user.getRoleId());
            pstmt.setBoolean(10, user.isActive());
            pstmt.setTimestamp(11, user.getCreatedDate());
            pstmt.setTimestamp(12, null); // LastLoginDate
            pstmt.setString(13, null); // ProfileImageUrl
            pstmt.setString(14, null); // StudentID
            pstmt.setString(15, null); // Department
            pstmt.setString(16, user.getAuthProvider() != null ? user.getAuthProvider() : "Local");
            pstmt.setString(17, user.getExternalID());

            System.out.println("About to execute update...");
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int userId = generatedKeys.getInt(1);
                        user.setUserId(userId);
                        System.out.println("Generated UserID: " + userId);

                        if (verifyUserSaved(userId)) {
                            System.out.println("User saved and verified successfully");
                            return true;
                        } else {
                            System.err.println("User was not saved properly - verification failed");
                            return false;
                        }
                    } else {
                        System.err.println("No generated keys returned");
                        return false;
                    }
                }
            } else {
                System.err.println("No rows were affected - insert failed");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error saving user: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        }
    }

    private boolean verifyUserSaved(int userId) {
        String sql = "SELECT COUNT(*) FROM Users WHERE UserID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("Verification: Found " + count + " user(s) with ID " + userId);
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error verifying user saved: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean existsByEmail(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("Email check for " + email + ": " + count + " records found");
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setUsername(rs.getString("Username"));
                    user.setEmail(rs.getString("Email"));
                    user.setPasswordHash(rs.getString("PasswordHash"));
                    user.setFullName(rs.getString("FullName"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                    user.setAddress(rs.getString("Address"));
                    user.setDateOfBirth(rs.getDate("DateOfBirth"));
                    user.setGender(rs.getString("Gender"));
                    user.setRoleId(rs.getInt("RoleID"));
                    user.setIsActive(rs.getBoolean("IsActive"));
                    user.setCreatedDate(rs.getTimestamp("CreatedDate"));
                    user.setLastLoginDate(rs.getTimestamp("LastLoginDate"));
                    user.setProfileImageUrl(rs.getString("ProfileImageUrl"));
                    user.setStudentId(rs.getString("StudentID"));
                    user.setDepartment(rs.getString("Department"));
                    user.setAuthProvider(rs.getString("AuthProvider"));
                    user.setExternalID(rs.getString("ExternalID"));
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by email: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUserPassword(int userId, String hashedPassword) {
        String sql = "UPDATE Users SET PasswordHash = ? WHERE UserID = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, hashedPassword);
            pstmt.setInt(2, userId);
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Password update for UserID " + userId + ": " + rowsAffected + " rows affected");
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user password: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        }
    }

    public boolean testConnection() {
        try (Connection conn = DatabaseConfig.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("Connection is active");
                return true;
            } else {
                System.err.println("Connection is null or closed");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error testing connection: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public void close() {
        System.out.println("UserDAO close called - no connection to close as connections are managed by DatabaseConfig");
    }
}