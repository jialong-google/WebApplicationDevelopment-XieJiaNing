
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
	<a href="product.jsp">Manage Products</a>
	<br/>

<% 
}
%>

