<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product Order</title>
</head>
<body>
	<form method = "GET" action="ProductOrderControlServlet">
            <div class="form_title_row">
                <div class="form_title">
                    <h1>Shopping Cart for <%=session.getAttribute("username") %>></h1>
                </div>
                <div class="continue button">
                    <button class="continue">Continue Shooping</button>
                </div>
                <hr>
            </div>
            <div class="form_body">
                <div class="product_row">
                    <div class="product_img" >
                        <img src="default-image.jpg" /></div>
                    <div class="product_name">
                        <h2><a href="login.html">Product name</a></h2>
                        <p>Product description</p>
                    </div>
                    <div class="product_price" >
                        <h3 name="productPrice"><strong>25.00</strong></h3>
                    </div>
                    <div class="product_amount">
                        <input type="number" name="productAmount">
                    </div>
                    <div class="delete button">
                        <button type="button" class="btn btn-link btn-xs">
                            X
                            <span class="glyphicon glyphicon-trash"> </span>
                        </button>
                    </div>
                    <hr>
				</div>
                <div class="product_row">
                    <div class="product_img"><img src="default-image.jpg"/></div>
                    <div class="product_name">
                        <h2><a href="login.html">Product name</a></h2>
                        <p>Product description</p>
                    </div>
                    <div class="product_price">
                        <h3 name><strong>25.00</strong></h3>
                    </div>
                    <div class="product_amount">
                        <input type="number" name="productAmount">
                    </div>
                    <div class="delete button">
                        <button type="button" class="btn btn-link btn-xs">
                            X
                            <span class="glyphicon glyphicon-trash"> </span>
                        </button>
                    </div>
                    <hr>
				</div>
                <div class="fresh_page">
                    <h4>Added items?</h4>
                    <button class="update button">Update cart</button>
                </div>
            </div>
            <div class="form_end_row">
                <h5><strong>Total: $</strong>50</h5>
                <button type="button">Checkout</button>
			</div>
	</form>
</body>
</html>