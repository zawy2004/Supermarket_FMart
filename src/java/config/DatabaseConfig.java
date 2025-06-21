package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DatabaseConfig {

    private static final String URL = "jdbc:sqlserver://DEMO\\ABC123;databaseName=Fmart1;encrypt=false";
    private static final String USER = "sa";
    private static final String PASSWORD = "1234";


    private static Connection connection = null;

    private DatabaseConfig() {
    }

    public static synchronized Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                // Load the SQL Server JDBC driver
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                // Establish the connection
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                if (connection != null) {
                    System.out.println("Database connection established successfully at " + new java.util.Date());
                }
            } catch (ClassNotFoundException e) {
                System.err.println("SQL Server JDBC Driver not found: " + e.getMessage());
                throw new SQLException("JDBC Driver not found", e);
            } catch (SQLException e) {
                System.err.println("Failed to connect to the database: " + e.getMessage());
                throw new SQLException("Database connection error", e);
            }
        }
        return connection;
    }

    /**
     * Closes the database connection if it is open.
     */
    public static synchronized void closeConnection() {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                    System.out.println("Database connection closed successfully at " + new java.util.Date());
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
            System.out.println("Connection test successful at " + new java.util.Date() + "!");
            closeConnection();
        } else {
            System.out.println("Connection test failed at " + new java.util.Date() + ".");
        }
    }
}