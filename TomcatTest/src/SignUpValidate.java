import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignUpValidate {
	public void insertUser(String firstName, String lastName, int strAge, String role, String userID, String password, String state) throws SQLException {
		Connection conn = null;
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/main?" + "user=postgres&password=mn1987");
			conn.setAutoCommit(false);
			
			String sql = "INSERT INTO users (user_id, password, first_name, last_name, age, role, state) "
					+ "VALUES(?,?,?,?,?,?,?)";
			pStmt = conn.prepareStatement(sql);
			
			pStmt.setString(1, userID);
			pStmt.setString(2,password);
			pStmt.setString(3,firstName);
			pStmt.setString(4,lastName);
			pStmt.setInt(5,strAge);
			pStmt.setString(6,role);
			pStmt.setString(7,state);
			
			pStmt.executeUpdate();
			conn.commit();
			conn.setAutoCommit(true);
		}
		catch(SQLException exc) {
			throw exc;
		}
		catch(Exception exc) {
			exc.printStackTrace();
		}
		finally {
			close(conn, pStmt, rSet);
		}
	}
	
	
	private void close(Connection conn, PreparedStatement pStmt, ResultSet rSet) {

		try {
			if (conn != null) {
				conn.close();
			}
			
			if (pStmt != null) {
				pStmt.close();
			}
			
			if (rSet != null) {
				rSet.close();   // doesn't really close it ... just puts back in connection pool
			}
		}
		catch (Exception exc) {
			exc.printStackTrace();
		}
	}
}
