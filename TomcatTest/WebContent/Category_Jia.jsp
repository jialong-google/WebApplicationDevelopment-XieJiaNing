<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Categories</title>
<center>
<p>Category</p>
</center>

</head>
<body>
<!--  Initialization of “database” (students and nextPID)-->
<% 
	LinkedHashMap<String,String> students=request.getParameter("students");
	application.setAttribute("students", students);
%>
<!--  Retrieval Code (after initialization)-->
<%
	//retrieves student data from application scope
	LinkedHashMap<String, String> students = (LinkedHashMap<String, String>)application.getAttribute("students");
	//retrieves the latest pid
	Integer nextPID = (Integer)(application.getAttribute("nextPID"));
%>
<% String action = request.getParameter("action"); %> 
<!--  Insert Code-->
<%

%>
<!--Update Code-->
<%

%>
<!--Delete Code-->
<%

%>
	<table>
		<tr>
			<td>
				<th>Name</th>
				<th>Description</th>
			</td>
		</tr>
		<td>
		<form action="Category_Jia.jsp" method="POST">
			<input type="hidden" name="action" value="insert"/> 
			<th>&nbsp;</th>
			<th><input value="" name="Name" size="10"/></th>
			<th><input value="" name="Description" size="15"/></th>
			<th><input type="submit" value="Insert"/></th>
		</form>
		
		
		<Insert Form Code>
		<% // Iterate through student map
		Iterator it = students.entrySet().iterator();
		while(it.hasNext()){
		//<Iteration Code>
		
		}%>
		</td>
	</table>
</body>
</html>