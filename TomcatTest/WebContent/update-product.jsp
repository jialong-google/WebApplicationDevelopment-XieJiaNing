<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Product</title>
</head>

<body>
<form action="ProductControllerServlet" method="GET">
	<input type="hidden" name="command"	value="UPDATE"/>
	<input type="hidden" name="oldProduct" value="${productToUpdate.getSku()}"/>
		
	<label>Product Name</label>
	<input type="text" name="productName" value="${productToUpdate.getName()}">
	<br><br>

	<label>SKU</label>
	<input type="text" name="sku" value="${productToUpdate.getSku()}">
	<br><br>
		
	<label>Price</label>
	<input type="text" name="price" value="${productToUpdate.getPrice()}">
	<br><br>

	<label>Category</label>	
	<!-- <select name="category" >
		<c:forEach var="oneCategory" items="${category_list}">
			<option value="${oneCategory}">${oneCategory}</option>
		</c:forEach>
	</select> -->
	<input type="text" name="category" value="${productToUpdate.getCategory()}">
	
	<br><br>

	<label></label>
	<input type="submit" value="Update">			
</form>
</body>
</html>