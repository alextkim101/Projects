<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="DatabasePackage.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>New Event</title>
	<% DatabaseManager.checkDatabase();
	if (session.getAttribute("loggedin") == null){
		session.setAttribute("loggedin",false);
	}
	if (!((Boolean)session.getAttribute("loggedin"))) {
		%> <jsp:forward page="Login.jsp" /> <%
	} %>
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="styles/NewEvent.css">
    <link rel="icon" href="images/favicon.png">
    <script>
		var pushSocket = new WebSocket("ws://10.26.250.81/CSCI201-Final-PartyPeople/push/")
		
	    function new_event() {
			var event_name = document.getElementById("name").value;
			console.log("ASDFASDF");
			pushSocket.send("A new event, " + event_name + ", has been created!"); 
		}
    </script>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<img src="images/partypeople-logo.png" id="logo" height="60" width="170" />
			<div class="banner"></div>
		</div>
		<form action="HomePage.jsp" class="headerforms">
			<button type="submit" class="btn btn-default btn-lg homebutton">
				<span class="glyphicon glyphicon-home"></span> Home
			</button>
		</form>
		</div>
		<div class="row justify-content-center">
			<div class="col-md-6">
				<div class="card bg-secondary mb-3">
					<div class="card-body">
						<h3>Create Event</h3>
						<form method="post" action="EventServlet">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="fname">Event Name</label> <input type="text"
											class="form-control" name="name" id="name" aria-describedby="name"
											placeholder="Enter Name">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="location">Location</label> <input type="text"
											class="form-control" name="location" id="location" aria-describedby="location"
											placeholder="Enter Event Address">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="affiliation">Affiliation</label> <input type="text"
											class="form-control" id="affiliation" name="affiliation" aria-describedby="affiliation"
											placeholder="Enter Affiliation (Username used if left blank)">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="date">Date</label> <input
											type="date" class="form-control" id="date"
											aria-describedby="date" name="date" placeholder="Enter Date of Event">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="start_time">Start Time</label> <input type="time"
											class="form-control" id="start_time" name="start_time" aria-describedby="start_time"
											placeholder="Enter Start Time">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="end_date">End Time</label> <input
											type="time" class="form-control" id="end_time"
											aria-describedby="end_time" name="end_time" placeholder="Enter End Time">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="tags">Tags</label> <input type="text"
									class="form-control" id="tags" name="tags" aria-describedby="tags"
									placeholder="Enter Event Hashtags">
							</div>
							<div class="form-group">
								<label for="bio">Event Details</label> <textarea rows="3"
									class="form-control" id="details" name="details" aria-describedby="details"
									placeholder="Enter Event Details"></textarea>
							</div>
							<div class="form-group ">
								<button onclick="new_event()" type="submit"
									class="btn btn-primary btn-lg btn-block login-button">Create</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>