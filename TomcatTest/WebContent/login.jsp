<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
	<form class = "form" method = "GET" action="LoginControlServlet">
            <div class="login wrap">
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
            <button class="button">Sign up</button>
        </form>
</body>
</html>