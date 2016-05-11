<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body>

<input type="button" value="Insert Product" action="add-product.jsp">

<%
	String[] category_list = {"A","B","C","D","E","F"};
%>

<c:forEach var="oneCategory" items="${category_list}">
	<c:url var="categoryLink" value="ProductControllerServlet">
		<c:param name="command"  value="category"/>
		<c:param name="category" value="${oneCategory}"/>	
	</c:url>
	
	<a href="${categoryLink}">"${oneCategory}"</a>
</c:forEach>


<table>
	<c:forEach var="product" items="${product_list}">
		<tr>
			${product.name}$
		</tr>
	</c:forEach>
</table>

	









</body>

</html>