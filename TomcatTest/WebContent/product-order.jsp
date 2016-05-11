<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*, productorder.ProductObj" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product Order</title>
</head>
<body>
	
            <div class="form_title_row">
                <div class="form_title">
                    <h1>Shopping Cart for <%=session.getAttribute("username") %></h1>
                </div>
                <div class="continue button">
                    <button class="continue">Continue Shopping</button>
                </div>
                <hr>
            </div>
            
            <form method="get" action="ProductOrderControlServlet">
	            <div class="current item">
	            	<h1>Set quantity for current item</h1>
	            	<div class="product_name">
                        <h2><%=session.getAttribute("pName") %></h2>
	                </div>
	                <div class="product_price" >
	                    <h3><strong>$</strong><%=session.getAttribute("price") %>
	                    </h3>
	                </div>
                    <div class="product_amount">
	                    <input type="number" name="quantity">
	                </div>
	                <div class="submit">
	                	<input type="submit" name="addToCart" value="Add to Cart">
	                </div>
	            	<hr>
	            </div>
            </form>
            
            <!--create shopping cart table  -->
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
	
</body>
</html>