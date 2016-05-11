<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.sql.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product Browsing</title>
<center><p>Product Browsing</p></center>
</head>
<body>

<% 
	String role=(String) session.getAttribute("role");
	if( role==null || !role.equals("customer"))
	{
		%><h1>This page is open only to customers!</h1><%
	//}
	//else{
%>

<%--get Categories --%>
<%
	ArrayList<String> categories= new ArrayList<String>();
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
	    // Registering Postgresql JDBC driver with the DriverManager
	    Class.forName("org.postgresql.Driver");

        // Open a connection to the database using DriverManager
        conn = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/postgres?" +
	        "user=postgres&password=003426");
		conn.setAutoCommit(false);
    	pstmt=conn.prepareStatement("SELECT name FROM Category");
		rs=pstmt.executeQuery();
		while(rs.next())
		{	
			categories.add(rs.getString("name"));
		}
		conn.setAutoCommit(true);
		System.out.println(categories.toString());
	}
	catch(SQLException e)
	{
		throw new RuntimeException(e);
	}

%>
<%-- Search hit --%>
<%
	String action=request.getParameter("action");
	System.out.println("action:"+action);
	if(action!=null&& action.equals("search"))
	{
		System.out.println("the action is "+action);
		System.out.println("search content is "+request.getParameter("search_content"));
	}
%>

<%-- Category hit --%>
<%
	if(action!=null && action.equals("category"))
	{
		String currentCate=request.getParameter("category_hit");
		System.out.println("the action is "+ action);
		System.out.println("which is hit: "+request.getParameter("category_hit"));
		session.setAttribute("current_category", currentCate);
		try {
		    // Registering Postgresql JDBC driver with the DriverManager
		    //Class.forName("org.postgresql.Driver");

	        // Open a connection to the database using DriverManager
	        //conn = DriverManager.getConnection(
	        //    "jdbc:postgresql://localhost:5432/postgres?" +
		    //    "user=postgres&password=003426");
			conn.setAutoCommit(false);
	    	pstmt=conn.prepareStatement("SELECT name FROM Category,Classification,product, Where Category.name=classification.name ");/////////
			rs=pstmt.executeQuery();
			while(rs.next())
			{	
				categories.add(rs.getString("name"));
			}
			conn.setAutoCommit(true);
			System.out.println(categories.toString());
		}
		catch(SQLException e)
		{
			throw new RuntimeException(e);
		}
		
		
	}
%>


<table width="600" border="0">
<tr valign="top">
	<td colspan="2" style="background-color:#99bbbb;">
	<form action="ProductBrowsing_Jia.jsp" method="POST">
        	<input type="hidden" name="action" value="search"/>
              <input value="" name="search_content" size="70"/>
              <input type="submit" value="Search"/>
	</form>
	</td>
</tr>

<tr valign="top">
	<td style="background-color:#ffff99;width:100px;text-align:top;">
	<%-- show category --%>
	<%-- if hit category, go back to this website again --%>
		<b>Categories</b><br />
		<%
			for(int i=0;i<categories.size();i++)
			{
				%>
				<c:url value="ProductBrowsing_Jia.jsp" var="e">
					<c:param name="action" value="category"/>
					<c:param name="category_hit" value="<%=categories.get(i) %>"/>
				</c:url>
				<a href="${e}"><%=categories.get(i)%></a>
				<br/>
				<%
			}
		%>
	</td>

	<td style="background-color:#EEEEEE;width:400px;text-align:top;">
		Content goes here
	<%-- show result, if hit, go to product order--%>
	</td>
</tr>


</table>

<%
	}
%>
</body>
</html>
