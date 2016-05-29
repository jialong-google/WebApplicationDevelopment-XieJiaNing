<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%

	String role=(String) session.getAttribute("role");
	if(role==null)
	{
		%>
		
		<p>
		ERROR!
		</p>
		
		<%
	}
	else if(role.equals("customer"))
	{//produc */ */ */t browsing
		
%>
		<a href="ProductBrowsing_Jia.jsp">Product Browsing</a>
		<br/>

<% 	}else if(role.equals("owner")){%>
	<a href="Category_Jia.jsp">Manage Categories</a>
	<br/>
	
	<c:url var="categoryListLink" value="ProductControllerServlet">
		<c:param name="command"  value="SETUP"/>
	</c:url>
		
	<a href="${categoryListLink}">Manage Products</a>
	<br/>
<% 
}
%>

