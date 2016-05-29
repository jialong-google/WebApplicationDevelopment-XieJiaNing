<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product Page</title>
</head>

<body>

<form action= "ProductControllerServlet" method="GET">
	<input type="hidden" name="command" value="SEARCH">
	
	<label>category</label>
	<select name="searchCategory">
		<option value="${searchCategory}" selected>${searchCategory}</option>
		<c:forEach var="oneCategory" items="${sessionScope.category_list}">
			<c:if test="${oneCategory != searchCategory}">
				<option value="${oneCategory}">${oneCategory}</option>
			</c:if>	
		</c:forEach>
	</select>
	
	&nbsp;
	&nbsp;
	<label>product name</label> <input type="text" name="searchString" value="${searchString}">
	<input type="submit" value="Search">
</form>
<br>


<input type="button" value="Insert Product" onclick="window.location.href='add-product.jsp'">
<h2>${sqlMessage}</h2>

<c:forEach var="oneCategory" items="${category_list}">
	<c:url var="categoryLink" value="ProductControllerServlet">
		<c:param name="command"  value="CATEGORY"/>
		<c:param name="category" value="${oneCategory}"/>	
	</c:url>	
	<a href="${categoryLink}">${oneCategory}</a>
</c:forEach>


<c:url var="allProductsLink" value="ProductControllerServlet">
	<c:param name="command"  value="ALLPRODUCTS"/>
</c:url>	
<a href="${allProductsLink}">All Products</a>

<br><br>

<table width="600" border="0">
	<tr valign="top">
		<th>SKU</th>
		
		<th>Name</th>
		
		<th>Price</th>
		
		<th>Category</th>
		
		<th>ACTION</th>
		
	</tr >
	<c:forEach var="product" items="${productList}">
		<c:url var="updateLink" value="ProductControllerServlet">
			<c:param name="command" value="LOAD"/>
			<c:param name="productName" value="${product.getName()}"/>
		</c:url>
		
		<c:url var="deleteLink" value="ProductControllerServlet">
			<c:param name="command" value="DELETE"/>
			<c:param name="productName" value="${product.getName()}"/>
		</c:url>
		
		<tr>
			<td style="width:100px;text-align:center;">
				${product.getSku()}
			</td>
			<td style="width:100px;text-align:center;">
				${product.getName()}
			</td>
			<td style="width:100px;text-align:center;">
				${product.getPrice()}
			</td>
			<td style="width:100px;text-align:center;">
				${product.getCategory()}
			</td>
						
			<td style="width:100px;text-align:center;">
				<a href="${updateLink}">Update</a>
				<a href="${deleteLink}" onclick="if (!(confirm('Are you sure you want to delete this product?'))) return false">Delete</a>
			</td> 
			
		</tr>
	</c:forEach>
</table>

	




<jsp:include page="Home_Jia.jsp"/>




</body>

</html>