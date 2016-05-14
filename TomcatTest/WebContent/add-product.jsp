<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert Product</title>
</head>
<body>

<form action="ProductControllerServlet" method="GET">
	<input type="hidden" name="command"	value="ADD"/>
	<label>Product Name</label>
	<input type="text" name="productName">
	<br><br>

	<label>SKU</label>
	<input type="text" name="sku">
	<br><br>
		
	<label>Price</label>
	<input type="text" name="price">
	<br><br>

	<label>Category</label>	
	<select name="category" >
		<c:forEach var="oneCategory" items="${category_list}">
			<option value="${oneCategory}">${oneCategory}</option>
		</c:forEach>
	</select>
	<!-- <input type="text" name="category" placeholder="category">  -->
	
	<br><br>

	<label></label>
	<input type="submit" value="Save">			
</form>

</body>
</html>