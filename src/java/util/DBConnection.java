package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DB_URL = "jdbc:sqlserver://DEMO\\ABC123;databaseName=Fmart;encrypt=false";  // Cập nhật URL theo máy chủ của bạn
    private static final String DB_USER = "sa";  // Cập nhật username của bạn
    private static final String DB_PASSWORD = "1234";  // Cập nhật password của bạn

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Đảm bảo có driver JDBC cho SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
        return connection;
    }
}
