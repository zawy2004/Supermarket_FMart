package util;

import config.DatabaseConfig;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Transaction Manager for handling database transactions
 */
public class TransactionManager {
    
    private static final Logger logger = Logger.getLogger(TransactionManager.class.getName());
    
    /**
     * Execute operations within a transaction
     */
    public static <T> T executeInTransaction(TransactionOperation<T> operation) throws SQLException {
        Connection conn = null;
        boolean originalAutoCommit = true;
        
        try {
            conn = DatabaseConfig.getConnection();
            originalAutoCommit = conn.getAutoCommit();
            conn.setAutoCommit(false);
            
            logger.info("Transaction started");
            
            T result = operation.execute(conn);
            
            conn.commit();
            logger.info("Transaction committed successfully");
            
            return result;
            
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                    logger.warning("Transaction rolled back due to error: " + e.getMessage());
                } catch (SQLException rollbackEx) {
                    logger.log(Level.SEVERE, "Error during rollback", rollbackEx);
                }
            }
            
            if (e instanceof SQLException) {
                throw (SQLException) e;
            } else {
                throw new SQLException("Transaction failed", e);
            }
            
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(originalAutoCommit);
                    conn.close();
                } catch (SQLException e) {
                    logger.log(Level.WARNING, "Error closing connection", e);
                }
            }
        }
    }
    
    /**
     * Execute operations within a transaction (void return)
     */
    public static void executeInTransactionVoid(TransactionOperationVoid operation) throws SQLException {
        executeInTransaction(conn -> {
            operation.execute(conn);
            return null;
        });
    }
    
    /**
     * Functional interface for transaction operations with return value
     */
    @FunctionalInterface
    public interface TransactionOperation<T> {
        T execute(Connection conn) throws SQLException;
    }
    
    /**
     * Functional interface for transaction operations without return value
     */
    @FunctionalInterface
    public interface TransactionOperationVoid {
        void execute(Connection conn) throws SQLException;
    }
}
