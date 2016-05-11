package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class loginValidate {
	
	private String userRole;
	
	public boolean isUserSigned(String[] validate) throws Exception {
		Connection conn = null;
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		
		boolean isExist = false;
		
		try {
			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/xiejianing", "jwxie", "12345");
			conn.setAutoCommit(false);
			
			String sql = "SELECT * FROM users WHERE user_id  = ? and password = ?";
			pStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
			pStmt.setString(1, validate[0]);
			pStmt.setString(2, validate[1]);
			rSet = pStmt.executeQuery();

			//get user role
			setUserRole(rSet.getString("role"));
			
			//return existance
			isExist = rSet.next();
			rSet.beforeFirst();
			System.out.println(isExist);
			conn.commit();
			conn.setAutoCommit(true);
			return isExist;
		}
		finally {
			close(conn, pStmt, rSet);
		}	
		
	}
	
	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	private static void close(Connection conn, PreparedStatement pStmt, ResultSet rSet) {

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
