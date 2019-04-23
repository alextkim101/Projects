<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="DatabasePackage.*,java.util.Vector,EventPackage.*"%>
<!DOCTYPE html>
<% DatabaseManager.checkDatabase();
	Vector<Event> pastEvents = DatabaseQuery.getPastEvents();%>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Poppins"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Merriweather" rel="stylesheet">


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
<link rel="icon" href="images/favicon.png">
<title>Rate Event</title>
<link rel="stylesheet" type="text/css" href="styles/RateEvent.css">
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
			<form action="RatingServlet" method="POST">
				<h3>Rate Event</h3>
				<label for="event">Choose Event</label>
				<select id="dropdown" name="event">
					<% if(pastEvents.size() > 0) {
							for (Event e : pastEvents) {%>
						<option value="<%= e.getEventID() %>"><%= e.getEventName() %> - <%= e.getAffiliation() %> - <%= e.getDate() %></option>
					<% }} else { %>
						<option value="none">No events to rate!</option>
						<% } %>
				</select>
				<fieldset>
					<div class="form-group" id="radio">
						<label>Rating</label>
						<input type="radio" class="radio" name="rate" value="1" id="1" />
	   					<label for="rate1">1</label>
	   					<input type="radio" class="radio" name="rate" value="2" id="2" />
	    				<label for="2">2</label>
	    				<input type="radio" class="radio" name="rate" value="3" id="3" />
	    				<label for="3">3</label>
	    				<input type="radio" class="radio" name="rate" value="4" id="4" />
	    				<label for="4">4</label>
	    				<input type="radio" class="radio" name="rate" value="5" id="5" />
	    				<label for="5">5</label>
					</div>
				</fieldset>
				<div class="form-group">
					<label for="comments">Comments</label>
					<textarea rows="3" class="form-control" id="comments" name="comments" aria-describedby="comments" placeholder="Enter Comments"></textarea>
				</div>
				<button type="submit" class="btn btn-default submitbutton">Rate</button>
			</form>
		</div>
		
	</div>
</body>
</html>