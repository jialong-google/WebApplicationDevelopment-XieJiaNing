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
		String message = (String)request.getAttribute("message");
		if (message==null) {
			System.out.println("Messagae is null");
		}
		else if (message.equals("notEmpty")){
	%>
	<h1>Congradulations! Your Products are Bought Successfully!</h1>
	<%
		}else{
	%>
	<h1>Uh-Oh! Your Shopping-Cart is Empty!</h1>
	<%
		}%>
		
	<h2>${errorSQL}</h2>
	
	<a href="testproductorder.jsp">click to go back to product browsing page (current test page)</a>
</body>
</html>