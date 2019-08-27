package DatabasePackage;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConn {
	private static final String USER = "root";
	private static final String PASSWORD = "root";
	
    public static Connection getConnection(String db) throws SQLException {
    	Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, USER, PASSWORD);
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} 
		return connection;
    }
     
    public static void closeConnection(Connection conn) throws SQLException {
		if (conn != null) {
			conn.close();
		}
    }
    
    private DatabaseConn(){}
}