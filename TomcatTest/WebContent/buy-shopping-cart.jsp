<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*, productorder.ProductObj" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>Current Shopping Cart Items</h1>
    <table width="80%" border="1">
          <tr>
          	<td>product name</td>
          	<td>product price</td>
          	<td>product amount</td>
          	<td>product total price</td>
          </tr>
             

		<c:forEach var="tempProduct" items="${cart.productlist}">
		<form method="GET" action="ProductOrderControlServlet">
			<tr>
				<td class="product_name">
                      	<c:out value="${tempProduct.pName}"/>
                   </td>
                   <td class="product_price" >
                       <h3><strong>$</strong>${tempProduct.price}</h3>
                   </td>
                   <td class="product_amount">
                       <h3><strong>quantity:</strong>${tempProduct.quantity}</h3>
                   </td>
                   <td>
                   	<h3><strong>$</strong>${tempProduct.totalprice}</h3>
                   </td>
                  </tr>
                 </form>
		</c:forEach>
	</table>
	<br>
	<h1>Total: $ ${cart.cartTotalCost}</h1>
	<br>
	<form class="payment" method = "GET" action="BuyConfirmControlServlet">
	
		<h3>Pay with credit card</h3>
		<label>enter credit card number:</label>
		<input type="text" placeholder="Your car number" required>
		<input type="submit" value="Purchase"> 
	</form>		

</body>
</html>