package DatabasePackage;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class DatabaseInsert {
		public static boolean registerUser(String username, String password, String email, String bio, String picPath) {
			// inserts user into database if email does not already exist
			if (DatabaseQuery.checkEmailExists(email)) {
				return false;
			}
			insertUser(username,password,email,bio,picPath);
			return true;
		}
	
	
		private static void insertUser(String username, String password, String email, String bio, String picPath) {
			Connection conn = null;
			PreparedStatement ps = null;
			try {
				conn = DatabaseConn.getConnection("PartyPeople");
				ps = conn.prepareStatement("INSERT INTO User (username,password,email,bio,picPath) VALUES(?,?,?,?,?)");
				ps.setString(1, username);
				ps.setString(2, password);
				ps.setString(3, email);
				ps.setString(4, bio);
				ps.setString(5, picPath);
				ps.execute();
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			} finally {
				try {
					DatabaseConn.closeConnection(conn);
					DatabaseManager.closeUtil(ps);	
				} catch (SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				}
			}
		}
		
		public static void insertEvent(String username, String eventname, String place, Timestamp timeBegin, Timestamp timeEnd, String details, String affiliation, String tags) {
			Connection conn = null;
			PreparedStatement ps = null;
			try {
				conn = DatabaseConn.getConnection("PartyPeople");
				ps = conn.prepareStatement("INSERT INTO Event (name,place,timeBegin,timeEnd,host,details,affiliation,tags) VALUES(?,?,?,?,?,?,?,?)");
				ps.setString(1, eventname);
				ps.setString(2, place);
				ps.setTimestamp(3, timeBegin);
				ps.setTimestamp(4, timeEnd);
				ps.setInt(5, DatabaseQuery.getUserID(username));
				ps.setString(6, details);
				ps.setString(7, affiliation);
				ps.setString(8, tags);
				ps.execute();
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			} finally {
				try {
					DatabaseConn.closeConnection(conn);
					DatabaseManager.closeUtil(ps);
				} catch (SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				}
			}
		}
	
		public static void insertAttending(String username, int eventID) {
			Connection conn = null;
			PreparedStatement ps = null;
			try {
				conn = DatabaseConn.getConnection("PartyPeople");
				ps = conn.prepareStatement("INSERT INTO Attending (eventID,userID) VALUES(?,?)");
				ps.setInt(1, eventID);
				ps.setInt(2, DatabaseQuery.getUserID(username));
				ps.execute();
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			} finally {
				try {
					DatabaseConn.closeConnection(conn);
					DatabaseManager.closeUtil(ps);
				} catch (SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				}
			}
		}
		
		public static void insertInterested(String username, int eventID) {
			Connection conn = null;
			PreparedStatement ps = null;
			try {
				conn = DatabaseConn.getConnection("PartyPeople");
				ps = conn.prepareStatement("INSERT INTO Interested (eventID,userID) VALUES(?,?)");
				ps.setInt(1, eventID);
				ps.setInt(2, DatabaseQuery.getUserID(username));
				ps.execute();
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			} finally {
				try {
					DatabaseConn.closeConnection(conn);
					DatabaseManager.closeUtil(ps);
				} catch (SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				}
			}
		}
		
		public static void insertNotAttending(String username, int eventID) {
			Connection conn = null;
			PreparedStatement ps = null;
			try {
				conn = DatabaseConn.getConnection("PartyPeople");
				ps = conn.prepareStatement("INSERT INTO NotAttending (eventID,userID) VALUES(?,?)");
				ps.setInt(1, eventID);
				ps.setInt(2, DatabaseQuery.getUserID(username));
				ps.execute();
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			} finally {
				try {
					DatabaseConn.closeConnection(conn);
					DatabaseManager.closeUtil(ps);
				} catch (SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				}
			}
		}
		
		public static void insertRating(String rater, int hostID, int eventID, int rating, String comments) {
			Connection conn = null;
			PreparedStatement ps = null;
			try {
				conn = DatabaseConn.getConnection("PartyPeople");
				ps = conn.prepareStatement("INSERT INTO Rating (raterID,hostID,eventID,rating,comments) VALUES(?,?,?,?,?)");
				ps.setInt(1, DatabaseQuery.getUserID(rater));
				ps.setInt(2, hostID);
				ps.setInt(3, eventID);
				ps.setInt(4, rating);
				ps.setString(5, comments);
				ps.execute();
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			} finally {
				try {
					DatabaseConn.closeConnection(conn);
					DatabaseManager.closeUtil(ps);
				} catch (SQLException sqle) {
					System.out.println("sqle: " + sqle.getMessage());
				}
			}
		}
}
