<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% session.setAttribute("loggedin", false); %>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Logging Out</title>
	</head>
	<body>
		<jsp:forward page="HomePage.jsp" />
	</body>
</html>