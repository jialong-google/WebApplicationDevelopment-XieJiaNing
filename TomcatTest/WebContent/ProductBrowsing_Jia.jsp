<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
    
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


<%-- Search hit --%>
<%
	String action=request.getParameter("action");
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
		HTML<br />
		CSS<br />
		JavaScript<br/>
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
