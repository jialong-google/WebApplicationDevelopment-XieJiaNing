import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SignUpValidate {
	
	public boolean isUserExist(String[] userName) throws Exception {
		Connection conn = null;
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		
		boolean isExist = false;
		
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/sign-up?" + "user=postgres&password=mn1987");
			conn.setAutoCommit(false);
			
			String sql = "SELECT * FROM USERS WHERE FirstName  = ? AND LastName = ?";
			pStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
			pStmt.setString(1, userName[0].toUpperCase());
			pStmt.setString(2, userName[1].toUpperCase());
			rSet = pStmt.executeQuery();
			
			
			isExist = rSet.next();
			rSet.beforeFirst();
			
			conn.commit();
			conn.setAutoCommit(true);
			return isExist;
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
