package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database configuration class to manage connection to the Fmart database.
 * @author thanh
 */
public class DatabaseConfig {
    // Database connection parameters
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=Fmart;encrypt=true;trustServerCertificate=true";
    private static final String USER = "sa"; // Replace with your SQL Server username
    private static final String PASSWORD = "123"; // Replace with your SQL Server password

    // Singleton connection instance
    private static Connection connection = null;

    /**
     * Private constructor to prevent instantiation
     */
    private DatabaseConfig() {
    }

    /**
     * Establishes and returns a connection to the Fmart database.
     * @return Connection object
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                // Load the SQL Server JDBC driver
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                // Establish the connection
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Database connection established successfully.");
            } catch (ClassNotFoundException e) {
                System.err.println("SQL Server JDBC Driver not found.");
                throw new SQLException("Driver not found: " + e.getMessage());
            } catch (SQLException e) {
                System.err.println("Failed to connect to the database.");
                throw new SQLException("Connection error: " + e.getMessage());
            }
        }
        return connection;
    }

    /**
     * Closes the database connection if it is open.
     */
    public static void closeConnection() {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                    System.out.println("Database connection closed successfully.");
                }
            } catch (SQLException e) {
                System.err.println("Error closing database connection: " + e.getMessage());
            } finally {
                connection = null;
            }
        }
    }

    /**
     * Tests the database connection.
     * @return true if connection is successful, false otherwise
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Connection test failed: " + e.getMessage());
            return false;
        }
    }

    /**
     * Main method for testing the connection (for debugging purposes).
     */
    public static void main(String[] args) {
        if (testConnection()) {
            System.out.println("Connection test successful!");
            closeConnection();
        } else {
            System.out.println("Connection test failed.");
        }
    }
}