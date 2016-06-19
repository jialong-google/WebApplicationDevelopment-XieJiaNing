<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sales Analytics</title>
</head>
<body>
<%
	String role=(String) session.getAttribute("role");
	System.out.println(role);
	if(role==null || !role.equals("owner"))
	{
		%><h1>This page is open only to owner!</h1><%
	//}
	//else{
%>
<%
	// get content of showing.
	ArrayList<String> productlist=new ArrayList<String>();
	ArrayList<String> statelist= new ArrayList<String>();
	HashMap<String,ArrayList<String>> content= new HashMap<String,ArrayList<String>>();
	productlist.add("aa");
	productlist.add("bb");
	productlist.add("californiagirlsunforgetablecc");
	statelist.add("11");
	statelist.add("22");
	statelist.add("33");
	ArrayList<String > yiyi=new ArrayList<String>();
	yiyi.add("a1");yiyi.add("b1");yiyi.add("c1");
	content.put("11",yiyi);
	ArrayList<String > erer=new ArrayList<String>();
	erer.add("a2");erer.add("b2");erer.add("c2");
	content.put("22",erer);
	ArrayList<String > sasa=new ArrayList<String>();
	sasa.add("a3");sasa.add("b3");sasa.add("c3");
	content.put("33",sasa);
	
	 int productlen=productlist.size();
	 int statelen=statelist.size();
	 
	
%>

<%
	//show the content of two dimensional array. 


%>
<table border="1">
	<tr>
		<th>&nbsp;</th>
		<%	for(int i=0;i<productlen;i++)
			{
				String trunc=productlist.get(i);
		%>	<th><%=trunc.substring(0,10>trunc.length()? trunc.length():10) %></th>
		<%} %>
	</tr>
	<%
	for (int i=0;i<statelen;i++)
	{
	%>
	<tr>
		<th><%=statelist.get(i) %></th>
		<% 
			ArrayList<String> inner=content.get(statelist.get(i));
			for(int j=0;j<productlen;j++)
			{
		%>
				<td><%=inner.get(j) %></td>
		<%} %>
	</tr>
	
	<%} %>
</table>


<!-- Category filter -->

<form action="Sales" method="GET">
	<input type="hidden" name="command"	value="ADD"/>

	<label>Category</label>	
	<select name="category" >
		<c:forEach var="oneCategory" items="${category_list}">
			<option value="${oneCategory}">${oneCategory}</option>
		</c:forEach>
	</select>
	<br><br>
	<input type="submit" value="Run Query">		
	<br><br>
	<input type="submit" value="Refresh">	
</form>
<%} %>
</body>
</html>