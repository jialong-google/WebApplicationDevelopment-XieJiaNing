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
<%--  Initialization of “database” (students and nextPID)--%>
<%--  Retrieval Code (after initialization)--%>
 
<%--
	LinkedHashMap<Integer,Category_Jia> item = (LinkedHashMap<Integer,Category_Jia>) request.getAttribute("Category-item");
	if(item==null)
	{
		item=new LinkedHashMap<Integer,Category_Jia>();
		application.setAttribute("Category-item", item);
	}
	Integer nextID=(Integer) request.getAttribute("nextID");
	if(nextID==null)
	{
		nextID= new Integer(0);
		application.setAttribute("nextID",nextID);
	}
--%>

<%-- String action = request.getParameter("action"); --%> 
<%--  Insert Code--%>
<%--
	if(action!=null && action.equals("insert"))
	{
		Category_Jia newItem=new Category_Jia();
		newItem.setName(request.getParameter("name"));
		newItem.setDes(request.getParameter("description"));
		item.put(nextID, newItem);
		nextID++;
		application.setAttribute("nextID", nextID);
	}
--%>
<%--Update Code--%>
<%--
	if(action!=null && action.equals("update"))
	{
		Category_Jia updated=item.get(Integer.parseInt(request.getParameter("id")));
		//judge if it had existed.
		updated.setName(request.getParameter("name"));
		updated.setDes(request.getParameter("description"));
	}
--%>
<%--Delete Code--%>
<%--
	if(action!=null && action.equals("delete"))
	{
		item.remove(Integer.parseInt(request.getParameter("id")));
	}
--%> 
	<table>
		<tr>
			<td>
				<%@page import="java.sql.*" %>
				<%-- open connection codes --%>
				<%
					Connection conn = null;
	            	PreparedStatement pstmt = null;
	            	ResultSet rs = null;
	            
	            	try {
	            	    // Registering Postgresql JDBC driver with the DriverManager
	            	    Class.forName("org.postgresql.Driver");
	
		                // Open a connection to the database using DriverManager
	    	            conn = DriverManager.getConnection(
	        	            "jdbc:postgresql://localhost/cse135?" +
	            	        "user=postgres&password=postgres");
				%>
				<%--insertion codes --%>
				<%
					String action=request.getParameter("action");
					if(action!=null && action.equals("insert"))
					{
						// Begin transaction
	                    conn.setAutoCommit(false);

	                    // Create the prepared statement and use it to
	                    // INSERT student values INTO the students table.
	                    pstmt = conn
	                    .prepareStatement("INSERT INTO Category (id, name, des) VALUES (?,?, ?)");
	                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));//????
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
                    pstmt = conn.prepareStatement("UPDATE Category SET name = ?, des = ?, "
                            + "WHERE id = ?");

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
                	    conn.setAutoCommit(false);
                	    // Create the prepared statement and use it to
                	    // DELETE students FROM the Students table.
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
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rs = statement.executeQuery("SELECT * FROM Category");
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
            	<%--
                	// loop through the student data
                	Iterator it = item.entrySet().iterator();
                	while(it.hasNext()){
                	    // current element pair
                	    Map.Entry pair = (Map.Entry)it.next();
            	--%>
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
            	    }
            	
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
                throw new RuntimeException(e);
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
</body>




</html>