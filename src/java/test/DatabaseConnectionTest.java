package test;

import config.DatabaseConfig;
import config.JNDIDataSource;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Test class để kiểm tra database connections với FmartDB
 */
public class DatabaseConnectionTest {
    
    public static void main(String[] args) {
        System.out.println("=== DATABASE CONNECTION TEST ===");
        
        // Test DatabaseConfig
        testDatabaseConfig();
        
        // Test JNDI DataSource
        testJNDIDataSource();
    }
    
    private static void testDatabaseConfig() {
        System.out.println("\n1. Testing DatabaseConfig...");
        try (Connection conn = DatabaseConfig.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ DatabaseConfig connection: SUCCESS");
                System.out.println("   Database: " + conn.getCatalog());
                System.out.println("   URL: " + conn.getMetaData().getURL());
            } else {
                System.out.println("❌ DatabaseConfig connection: FAILED - Connection is null or closed");
            }
        } catch (SQLException e) {
            System.out.println("❌ DatabaseConfig connection: FAILED");
            System.out.println("   Error: " + e.getMessage());
        }
    }
    
    private static void testJNDIDataSource() {
        System.out.println("\n2. Testing JNDI DataSource...");
        
        if (JNDIDataSource.isJNDIAvailable()) {
            System.out.println("   JNDI DataSource is available");
            try (Connection conn = JNDIDataSource.getConnection()) {
                if (conn != null && !conn.isClosed()) {
                    System.out.println("✅ JNDI DataSource connection: SUCCESS");
                    System.out.println("   Database: " + conn.getCatalog());
                } else {
                    System.out.println("❌ JNDI DataSource connection: FAILED - Connection is null or closed");
                }
            } catch (SQLException e) {
                System.out.println("❌ JNDI DataSource connection: FAILED");
                System.out.println("   Error: " + e.getMessage());
            }
        } else {
            System.out.println("⚠️  JNDI DataSource not available (fallback to DatabaseConfig)");
            try (Connection conn = JNDIDataSource.getConnection()) {
                if (conn != null && !conn.isClosed()) {
                    System.out.println("✅ Fallback connection: SUCCESS");
                } else {
                    System.out.println("❌ Fallback connection: FAILED");
                }
            } catch (SQLException e) {
                System.out.println("❌ Fallback connection: FAILED");
                System.out.println("   Error: " + e.getMessage());
            }
        }
    }
}
