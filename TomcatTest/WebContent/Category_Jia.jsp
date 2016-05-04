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
 
<%
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
%>

<% String action = request.getParameter("action"); %> 
<%--  Insert Code--%>
<%
	if(action!=null && action.equals("insert"))
	{
		Category_Jia newItem=new Category_Jia();
		newItem.setName(request.getParameter("name"));
		newItem.setDes(request.getParameter("description"));
		item.put(nextID, newItem);
		nextID++;
		application.setAttribute("nextID", nextID);
	}
%>
<%--Update Code--%>
<%
	if(action!=null && action.equals("update"))
	{
		Category_Jia updated=item.get(Integer.parseInt(request.getParameter("id")));
		//judge if it had existed.
		updated.setName(request.getParameter("name"));
		updated.setDes(request.getParameter("description"));
	}
%>
<%--Delete Code--%>
<%
	if(action!=null && action.equals("delete"))
	{
		item.remove(Integer.parseInt(request.getParameter("id")));
	}
%> 
	<table>
		<tr>
			<td>

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
                   	 	<th><input value="" name="description" size="15"/></th>
                    	<th><input type="submit" value="Insert"/></th>
                	</form>
            	</tr>

            	<%-- -------- Iteration Code -------- --%>
            	<%
                	// loop through the student data
                	Iterator it = item.entrySet().iterator();
                	while(it.hasNext()){
                	    // current element pair
                	    Map.Entry pair = (Map.Entry)it.next();
            	%>

            	<tr>
                	<form action="Category_Jia.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<%= pair.getKey() %>"/>

                <%-- Get the id --%>
                <td>
                    <%= pair.getKey() %>
                </td>

                <%-- Get the get Name --%>
                <td>
                    <input value="<%= ((Category_Jia)pair.getValue()).getName() %>" name="name" size="15"/>
                </td>

                <%-- Get the get Description --%>
                <td>
                    <input value="<%=((Category_Jia)pair.getValue()).getDes()%>" name="description" size="15"/>
                </td>

                <%-- Button --%>
                <td><input type="submit" value="Update"/></td>
                </form>
                <form action="Category_Jia.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" value="<%=pair.getKey() %>" name="id"/>
                    <%-- Button --%>
                <td><input type="submit" value="Delete"/></td>
                </form>
            	</tr>
            	<%
            	    }
            	%>
        		</table>
        </td>
    </tr>
</table>
</body>
</html>