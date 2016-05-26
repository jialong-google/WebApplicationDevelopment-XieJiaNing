<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Failed</title>
</head>
<body>
	<form class = "form" method = "GET" action="LoginControlServlet">
            <div class="login wrap">
            	<h1>Username or Password is Wrong. Please check and login again.</h1>
                <label>
                    User ID
                </label>
                <input type="text" name="username"/>
            </div>
            <div class="login wrap">
                <label>
                    Password
                </label>
                <input type="password" name="password"/>
            </div>
            <button type="submit" class="button">Login</button>
        </form>
        <form action="sign-up.jsp" method="POST">
        	    <!--input type="hidden" name="action" value=""/ -->
        	    <input type="submit" value="Sign up"/>
       	</form>  
</body>
</html>