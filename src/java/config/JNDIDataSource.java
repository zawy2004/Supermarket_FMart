package config;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * JNDI DataSource utility class
 * Alternative to DatabaseConfig for production environments
 */
public class JNDIDataSource {
    
    private static final Logger logger = Logger.getLogger(JNDIDataSource.class.getName());
    private static final String JNDI_NAME = "java:comp/env/jdbc/FmartDB";
    private static DataSource dataSource;
    
    static {
        try {
            Context initContext = new InitialContext();
            dataSource = (DataSource) initContext.lookup(JNDI_NAME);
            logger.info("JNDI DataSource initialized successfully");
        } catch (NamingException e) {
            logger.log(Level.SEVERE, "Failed to initialize JNDI DataSource: " + e.getMessage(), e);
            // Fallback to DatabaseConfig if JNDI fails
            dataSource = null;
        }
    }
    
    /**
     * Get database connection from JNDI DataSource
     * Falls back to DatabaseConfig if JNDI is not available
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource != null) {
            try {
                Connection conn = dataSource.getConnection();
                logger.fine("Connection obtained from JNDI DataSource");
                return conn;
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Failed to get connection from JNDI, falling back to DatabaseConfig", e);
            }
        }
        
        // Fallback to DatabaseConfig
        logger.info("Using DatabaseConfig fallback");
        return DatabaseConfig.getConnection();
    }
    
    /**
     * Check if JNDI DataSource is available
     */
    public static boolean isJNDIAvailable() {
        return dataSource != null;
    }
}
