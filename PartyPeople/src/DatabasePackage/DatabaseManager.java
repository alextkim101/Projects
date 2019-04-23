package DatabasePackage;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseManager {
	
	public static void checkDatabase() {
		if (!checkDatabaseExists()) {
			createDatabase();
		}
	}
	
	private static boolean checkDatabaseExists() {
		boolean found = false;
		Connection conn = null;
		try {
			conn = DatabaseConn.getConnection("");
			ResultSet databases = conn.getMetaData().getCatalogs();
			String db = "PartyPeople";
			while (databases.next()) {
				if (databases.getString(1).equals(db)) {
					found = true;
				}
			}
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} finally {
			try {
				DatabaseConn.closeConnection(conn);
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		return found;
	}
	
	@SuppressWarnings("resource")
	private static void createDatabase() {
		Connection conn = null;
		PreparedStatement ps = null;
		
		String createDB = "CREATE DATABASE PartyPeople";
		String useDB = "USE PartyPeople";
		
		String userTable = "CREATE TABLE User(" +
							"userID INT(11) PRIMARY KEY AUTO_INCREMENT, " +
							"username VARCHAR(45) NOT NULL, " +
							"password VARCHAR(45) NOT NULL, " +
							"email VARCHAR(45) NOT NULL, " +
							"bio VARCHAR(5000) NOT NULL, " +
							"picPath VARCHAR(200) NOT NULL)";
		
		String eventTable = "CREATE TABLE Event(" +
							"eventID INT(11) PRIMARY KEY AUTO_INCREMENT, " +
							"name VARCHAR(50) NOT NULL, " +
							"place VARCHAR(200) NOT NULL, " +
							"timeBegin DATETIME NOT NULL, " +
							"timeEnd DATETIME NOT NULL, " +
							"host INT(11) NOT NULL, " +
							"details VARCHAR(5000) NOT NULL, " +
							"affiliation VARCHAR(100) NOT NULL, " +
							"tags VARCHAR(1000) NOT NULL, " +
							"FOREIGN KEY fk1(host) REFERENCES User(userID));";
		
		String attendTable = "CREATE TABLE Attending(" +
							"eventID INT(11) NOT NULL, " +
							"userID INT(11) NOT NULL, " +
							"FOREIGN KEY fk2(eventID) REFERENCES Event(eventID), " +
							"FOREIGN KEY fk3(userID) REFERENCES User(userID));";
		
		String interestTable = "CREATE TABLE Interested(" +
							"eventID INT(11) NOT NULL, " +
							"userID INT(11) NOT NULL, " +
							"FOREIGN KEY fk4(eventID) REFERENCES Event(eventID), " +
							"FOREIGN KEY fk5(userID) REFERENCES User(userID));";
		
		String notAttendTable = "CREATE TABLE NotAttending(" +
							"eventID INT(11) NOT NULL, " +
							"userID INT(11) NOT NULL, " +
							"FOREIGN KEY fk6(eventID) REFERENCES Event(eventID), " +
							"FOREIGN KEY fk7(userID) REFERENCES User(userID));";
		
		String ratingTable = "CREATE TABLE Rating(" +
							"raterID INT(11) NOT NULL, " +
							"hostID INT(11) NOT NULL, " +
							"eventID INT(11) NOT NULL, " +
							"rating INT(1) NOT NULL, " +
							"comments VARCHAR(1000) NOT NULL, " +
							"FOREIGN KEY fk8(eventID) REFERENCES Event(eventID), " +
							"FOREIGN KEY fk9(raterID) REFERENCES User(userID), " +
							"FOREIGN KEY fk10(hostID) REFERENCES User(userID));";
		
		
		try {
			conn = DatabaseConn.getConnection("");
			ps = conn.prepareStatement(createDB);
			ps.executeUpdate();
			ps = conn.prepareStatement(useDB);
			ps.execute();
			ps = conn.prepareStatement(userTable);
			ps.executeUpdate();
			ps = conn.prepareStatement(eventTable);
			ps.executeUpdate();
			ps = conn.prepareStatement(attendTable);
			ps.executeUpdate();
			ps = conn.prepareStatement(interestTable);
			ps.executeUpdate();
			ps = conn.prepareStatement(notAttendTable);
			ps.executeUpdate();
			ps = conn.prepareStatement(ratingTable);
			ps.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} finally {
			try {
				DatabaseConn.closeConnection(conn);
				closeUtil(ps);
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
	}
	
	public static void closeUtil(PreparedStatement ps, ResultSet rs) throws SQLException {
		if (rs != null) {
			rs.close();
		}
		if (ps != null) {
			ps.close();
		}
	}
	
	public static void closeUtil(PreparedStatement ps) throws SQLException {
		if (ps != null) {
			ps.close();
		}
	}
}
