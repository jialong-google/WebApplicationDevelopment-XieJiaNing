<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*,jialong.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Categories</title>
<center><p>Category</p></center>

</head>
<body>
<%
	String role=(String) session.getAttribute("role");
	if(role==null || !role.equals("owner"))
	{
		%><h1>This page is open only to owner!</h1><%
	//}
	//else{
%>
	<table>
		<tr>
			<td>
				<%@page import="java.sql.*" %>
				<%-- open connection codes --%>
				<%
					Connection conn = null;
	            	PreparedStatement pstmt = null;
	            	ResultSet rs = null;
	            	Integer nextID=(Integer) session.getAttribute("nextID");
	            	System.out.println("initial value of nextID:"+nextID);
	            	if(nextID==null)
	            	{
	            		nextID= new Integer(1);
	            		session.setAttribute("nextID",nextID);
	            	}
	            	try {
	            	    // Registering Postgresql JDBC driver with the DriverManager
	            	    Class.forName("org.postgresql.Driver");
	
		                // Open a connection to the database using DriverManager
	    	            conn = DriverManager.getConnection(
	        	            "jdbc:postgresql://localhost:5432/postgres?" +
	            	        "user=postgres&password=003426");
				%>
				<%--insertion codes --%>
				<%
					String action=request.getParameter("action");
					System.out.println("action is "+action);
					if(action!=null && action.equals("insert"))
					{
						// Begin transaction
	                    conn.setAutoCommit(false);

	                    // Create the prepared statement and use it to
	                    // INSERT student values INTO the students table.
	                    pstmt = conn
	                    .prepareStatement("INSERT INTO Category (id, name, des) VALUES (?,?, ?)");
	                    pstmt.setInt(1, nextID);//????
	                    if(!request.getParameter("name").isEmpty())
	                    	pstmt.setString(2, request.getParameter("name"));
	                    pstmt.setString(3, request.getParameter("des"));
	                    int rowCount = pstmt.executeUpdate();

	                    // Commit transaction
	                    conn.commit();
	                    conn.setAutoCommit(true);
					}
				
				%>
				<%--update codes --%>
				<%
					// Check if an update is requested
                	if (action != null && action.equals("update")) {
                    // Begin transaction
                    conn.setAutoCommit(false);
                    // Create the prepared statement and use it to
                    // UPDATE student values in the Students table.
                    pstmt=conn.prepareStatement("SELECT * FROM Category WHERE id = ?");
                	pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                	rs=pstmt.executeQuery();
                	if(rs.next())///???????
                	{	
                		System.out.println("rs:"+rs.getInt("id"));
                	}
                	else{
                		throw new SQLException();
                	}
                	conn.commit();
                	
                    pstmt = conn.prepareStatement("UPDATE Category SET name = ?, des = ? "
                            + "WHERE id = ?");
					System.out.println("three for update:");
					System.out.println(request.getParameter("name"));
					System.out.println(request.getParameter("des"));
					System.out.println(Integer.parseInt(request.getParameter("id")));
					if(!request.getParameter("name").isEmpty())
						pstmt.setString(1, request.getParameter("name"));
                    pstmt.setString(2, request.getParameter("des"));
                    pstmt.setInt(3, Integer.parseInt(request.getParameter("id")));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
				%>
				<%--delete codes --%>
				<%
                	// Check if a delete is requested
                	if (action != null && action.equals("delete")) {

                	    // Begin transaction
                	    
                	    // Create the prepared statement and use it to
                	    // DELETE students FROM the Students table.
                    conn.setAutoCommit(false);
                	// Use the created statement to SELECT
                	// the student attributes FROM the Student table.
                	pstmt=conn.prepareStatement("SELECT * FROM Category WHERE id = ?");
                	pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                	rs=pstmt.executeQuery();
                	if(rs.next())///???????
	                	System.out.println("rs:"+rs.getInt("id"));
                	else
                		throw new SQLException();
                	conn.commit();
           			
                	    pstmt = conn
                	        .prepareStatement("DELETE FROM Category WHERE id = ?");

                	    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                	    int rowCount = pstmt.executeUpdate();
                    	// Commit transaction
                    	conn.commit();
                    	conn.setAutoCommit(true);
                	}
            	%>
            	
				<%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                nextID=1;
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rs = statement.executeQuery("SELECT * FROM Category ORDER BY id");
            %>
            
	            <%-- Add an HTML table header row to format the results --%>
            	<table border="1">
            	<tr>
            	    <th>ID</th>
					<th>Name</th>
					<th>Description</th>
           	 	</tr>

	            <tr>
    	            <form action="Category_Jia.jsp" method="POST">
        	            <input type="hidden" name="action" value="insert"/>
            	        <th>&nbsp;</th>
                	    <!--  <th><input value="" name="id" size="10"/></th>-->
                    	<th><input value="" name="name" size="15"/></th>
                   	 	<th><input value="" name="des" size="15"/></th>
                    	<th><input type="submit" value="Insert"/></th>
                	</form>
            	</tr>

            	<%-- -------- Iteration Code -------- --%>
            	
				<%
				
				while(rs.next())
				{
				%>
            	<tr>
                	<form action="Category_Jia.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<%=rs.getInt("id")%>"/>

                <%-- Get the id --%>
                <td>
                    <%= rs.getInt("id") %>
                </td>

                <%-- Get the get Name --%>
                <td>
                    <input value="<%= rs.getString("name") %>" name="name" size="15"/>
                </td>

                <%-- Get the get Description --%>
                <td>
                    <input value="<%= rs.getString("des") %>" name="des" size="15"/>
                </td>

                <%-- Button --%>
                <td><input type="submit" value="Update"/></td>
                </form>
                <form action="Category_Jia.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" value="<%=rs.getInt("id") %>" name="id"/>
                    <%-- Button --%>
                <td><input type="submit" value="Delete"/></td>
                </form>
            	</tr>
            	<%
            			if(rs.getInt("id")==nextID)
	            			nextID=rs.getInt("id")+1;
            			session.setAttribute("nextID",nextID);
            			System.out.println("nextID:"+nextID);
            	    }
					//nextID=rs.getInt("id")+1;
            	
            	//-- -------- Close Connection Code -------- --
                // Close the ResultSet
                rs.close();

                // Close the Statement
                statement.close();

                // Close the Connection
                conn.close();
            } catch (SQLException e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
                System.out.println("error happens in sql.");
                %>
                <h1>Data Modification Error<h1>
                <form action="Category_Jia.jsp" method="POST">
        	    <input type="hidden" name="action" value=""/>
        	    <input type="submit" value="Get back!"/>
        	    </form>  
                <%
                //throw new RuntimeException(e);
            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation

                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) { } // Ignore
                    rs = null;
                }
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) { } // Ignore
                    pstmt = null;
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) { } // Ignore
                    conn = null;
                }
            }
            %>
        		</table>
        </td>
    </tr>
</table>

<%
}
%>
</body>




</html>