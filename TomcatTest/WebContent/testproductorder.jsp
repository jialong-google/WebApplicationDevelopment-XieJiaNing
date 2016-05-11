<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String product = "cool";
		double price = 100.00;
		session.setAttribute("price",price);
		session.setAttribute("pName",product);
	%> 
	
	<a href="product-order.jsp">click here to transfer data: cool/100.00</a>
	 
</body>
</html>