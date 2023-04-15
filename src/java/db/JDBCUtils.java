package db;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

public class JDBCUtils {

    public static String baseURL = "jdbc:mysql://localhost:3306/student_management";
    
    public static Connection getConnection() {
        Connection connect = null;
        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            
            String username = "root";
            String password = "";
            
            connect = DriverManager.getConnection(baseURL, username, password);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return connect;
    }

    public static void closeConnection(Connection c) {
        if (c != null) {
            try {
                c.close();
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
    }
}
