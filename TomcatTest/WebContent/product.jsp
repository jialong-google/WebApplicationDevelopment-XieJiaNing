<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body>
<%-- 
<%
	String loginName = (String) session.getAttribute("login");
	if (loginName == null) { %>
	
	<jsp:includ page="xxx"/> 
	
	<%
	}
	else {
		out.print("Hello," + loginName + "!");
	}%>

<%
	String loginName = (String) session.getAttribute("login");
%>
--%>

<c:choose>
	<c:when test="${loginName == null}">
		<jsp:includ page="xxx"/>
	</c:when>
	<c:otherwise>
		out.print("Hello," + loginName + "!");
	</c:otherwise>
</c:choose>


<input type="button" value="Insert" action="ProductControllerServlet">


<c:url var="category_A" value="ProductControllerServlet">
	<c:param name="category" value="A"/>
</c:url>

<c:url var="category_B" value="ProductControllerServlet">
	<c:param name="category" value="B"/>
</c:url>

<c:url var="category_C" value="ProductControllerServlet">
	<c:param name="category" value="C"/>
</c:url>

<c:url var="category_D" value="ProductControllerServlet">
	<c:param name="category" value="D"/>
</c:url>

<c:url var="category_E" value="ProductControllerServlet">
	<c:param name="category" value="E"/>
</c:url>



<a href="${category_A}">Category A</a>
<br>

<a href="${category_B}">Category B</a>
<br>

<a href="${category_C}">Category C</a>
<br>

<a href="${category_D}">Category D</a>
<br>

<a href="${category_E}">Category E</a>











</body>

</html>