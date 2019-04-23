<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String login_err = (String) session.getAttribute("login_err");
	if (login_err == null) {
		login_err = "";
	}
%>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Poppins"
		rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Merriweather" rel="stylesheet">
	<link rel="icon" href="images/favicon.png">
	
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
		crossorigin="anonymous">
	
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<title>Login</title>
	<link rel="stylesheet" type="text/css" href="styles/Login.css">
</head>
<body>
	<div class="col-md-6">
		<img src="images/partypeople-logo.png" id="logo" height="60" width="170" />
		<div class="banner"></div>
	</div>
	<form action="HomePage.jsp" class="headerforms">
		<button type="submit" class="btn btn-default btn-lg homebutton">
			<span class="glyphicon glyphicon-home"></span> Home
		</button>
	</form>
	<div class="container">
		<div class="card rounded">
			<form action="ValidateUser" method="POST">
				<h3>Sign in</h3>
				<label for="email" class="sr-only">Email</label>
				<input type="email" id="email" class="form-control" placeholder="Email" name="email">
				<label for="password" class="sr-only">Password</label> 
				<input type="password" id="password" class="form-control" placeholder="Password" name="password">
				<span id="login_error"><%= login_err %></span> 
				<div class="checkbox">
					<label id="remember">
					<input type="checkbox" name="remember">
					Remember me</label>
				</div>
				<div id="reg">Don't Have an Account? <a href="Register.jsp"><u>Create Account</u></a></div>
				<input type="submit" class="btn btn-default submitbutton">
			</form>
		</div>
		
	</div>
</body>
<% session.setAttribute("login_err", null); %>
</html>