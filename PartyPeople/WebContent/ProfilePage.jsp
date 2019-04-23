<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="DatabasePackage.*, EventPackage.*, java.util.Vector" %>
<!DOCTYPE html>
<html>
	<script> 
		var pushSocket = new WebSocket("ws://10.26.250.81/CSCI201-Final-PartyPeople/push/")
		
		pushSocket.onmessage = function (event) {
			alert(event.data); 
		
		  console.log(event.data);
		};
	</script>
<%
	DatabaseManager.checkDatabase();
	if (session.getAttribute("loggedin") == null){
		session.setAttribute("loggedin",false);
	}
	if (!((Boolean)session.getAttribute("loggedin"))) {
		%> <jsp:forward page="Login.jsp" /> <%
	}
	String username = (String) session.getAttribute("username");
	Vector<Event> userEvents = DatabaseQuery.getUserEvents(username);
	Vector<Event> pastEvents = SortEvents.getPastEvents(userEvents);
	Vector<Event> futureEvents = SortEvents.getFutureEvents(userEvents);
	Vector<Rating> allRatings = DatabaseQuery.getAllUserRatings(username);
	String picPath = DatabaseQuery.getPicPath(username);
	String profileTitle = userEvents.size() > 0 ? "HOST" : "PARTYGOER";
	Double rating = DatabaseQuery.getUserRating(DatabaseQuery.getUserID(username));
	String ratingString = null;
	if (rating == -1.0) {
		ratingString = "None yet!";
	}
	else {
		ratingString = String.format("%.2f",rating) + " out of 5";
	}
%>
<head>
	<link href="https://fonts.googleapis.com/css?family=Poppins"
		rel="stylesheet">
	<link
		href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
		rel="stylesheet" id="bootstrap-css">
	<script
		src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<meta charset="UTF-8">
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<link rel="icon" href="images/favicon.png">
	<title>Profile Page</title>
	<link rel="stylesheet" type="text/css" href="styles/ProfilePage.css">
</head>
<script>
	$(document).ready(function() {
		$(".myratings").click(function() {
			$(".ratingspage").show();
			$(".settingspage").hide();
			$("#eventdisplay").hide();
			$(".myeventstitle").hide();
			$(".ratingtitle").show();

		});
		$(".first").click(function() {
			$("#eventdisplay").show();
			$(".ratingspage").hide();
			$(".settingspage").hide();
			$(".myeventstitle").show();
			$(".ratingtitle").hide();

		});
		$(".mysettings").click(function() {
			$(".settingspage").show();
			$(".ratingspage").hide();
			$("#eventdisplay").hide();
			$(".myeventstitle").hide();
			$(".ratingtitle").hide();
		});
		$("#seeAll").click(function() {
			$("#events-all").show();
			$("#events-past").hide();
			$("#events-future").hide();
		});
		$("#seePast").click(function() {
			$("#events-all").hide();
			$("#events-past").show();
			$("#events-future").hide();
		});
		$("#seeFuture").click(function() {
			$("#events-all").hide();
			$("#events-past").hide();
			$("#events-future").show();
		});
	});
	$(document).ready(function() {
	    $(".ratingspage").hide();
	    $(".ratingtitle").hide();
	    $(".settingspage").hide();
	    $("#events-past").hide();
	    $("#events-future").hide();
	});
	function rate() {
		window.location.replace("10.26.250.81:8080/CSCI201-Final-PartyPeople/RateEvent.jsp");
	}
</script>

	<div class="container-fluid">

		<div class="row" id="header">
			<form action="HomePage.jsp" class="headerforms" id="homebutton">
				<button type="submit" class="btn btn-default btn-lg homebutton">
					<span class="glyphicon glyphicon-home"></span> Home
				</button>
			</form>
			<form action="Logout.jsp" class="headerforms" id="outbutton">
				<button type="submit" class="btn btn-default btn-lg logoutbutton">
					<span class="glyphicon glyphicon-log-out"></span> Log Out
				</button>
			</form>
			<div class="col-md-12">
				<img src="images/partypeople-logo.png" id="logo" height="60" width="170" />
				<div class="banner"></div>
			</div>
			
		</div>
		
		<div class="row">
			<div class="sideprofile">
				<div class="col-md-4">
					<div class="sider">
						<div class="profilePic">
							<img src=<%= picPath %>>
						</div>
						<div class="userinfo">
							<div class="profilename"><%= username %></div>
							<div class="profiletitle"><%= profileTitle %></div>
							<div class="ratings">
								My Rating: <%= ratingString %>
							</div>
						</div>

						<div class="useroptions">
							<ul class="bar">
								<li class="first" style="list-style-type: none;"><span
									class="glyphicon glyphicon-th-list"></span> My Events</li>
								<li class="myratings" style="list-style-type: none;"
									onclick="ratings()"><span class="glyphicon glyphicon-star"></span>
									My Ratings</li>
								<li class="mysettings" style="list-style-type: none;"><span
									class="glyphicon glyphicon-user" style="outline: none;"></span>
									Account Settings</li>
								<li class="mysettings" style="list-style-type: none;"">
									<form action="RateEvent.jsp">
										<button type="submit" class="btn btn-default btn-lg ratebutton">
										<span class="glyphicon glyphicon-check" style="outline: none;"></span>
									Rate a Past Event</button></form></li>
									
								
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<h1 class="ratingtitle">My Ratings</h1>
		<div class="ratingspage">
			<table id="rating-table">
					<% 
					if (allRatings.size() > 0) { %>
						<tr>
							<th>
								<div class="solo-table">
								<%for(Rating r : allRatings) { %>
									<span class="breaker"></span>
									<table>
										<tr>
											<th>Event: <%= r.getEventName() %></th>
											<th></th>
										</tr>
										<tr>
											<th>Rated By: <%= r.getRaterName() %></th>
											<th></th>
										</tr>
										<tr>
											<th>Rating: <% for(int i=0; i < r.getRating(); i++) {%><span class="glyphicon glyphicon-star"/></span><% } %></th>
											<th></th>
										</tr>
										<tr>
											<th>Comments: <%= r.getComments() %></th>
										</tr>
									</table>
								<%} %>
								</div>
							</th>
						</tr>
						<% } else { %>
					<div class="noEvents">
						No ratings to display
					</div>
					<% } %>
					</table>
		</div>
		<div class="settingspage">
			<h1 class="settitle">My Account Info</h1>
			<form>
				<h3>Change Password?</h3>
				<table class="changePW">
					<tr>
						<th>Old Password</th>
						<th><input type="password" class="form-control"
							id="Opassword" aria-describedby="password"
							placeholder="Enter Old Password"></th>
					</tr>
					<tr>
						<th>New Password</th>
						<th><input type="password" class="form-control"
							id="Npassword" aria-describedby="password"
							placeholder="Enter New Password"></th>
					</tr>
					<tr>
						<th>Confirm New Password</th>
						<th><input type="password" class="form-control"
							id="CNpassword" aria-describedby="password"
							placeholder="Confirm Password"></th>
					</tr>
				</table>
				<h4>Change Email</h4>
				<table class="changeEmail">
					<tr>
						<th>New Email</th>
						<th><th><input type="email" class="form-control" id="Nemail"
							aria-describedby="email" placeholder="Enter New Email"></th></th>
					</tr>
					<tr>
						<th>Confirm New Email</th>
						<th><th><input type="email" class="form-control" id="CNemail"
							aria-describedby="email" placeholder="Confirm New Email"></th></th>
					</tr>
				</table>
			</form>
		</div>
		<h1 class="myeventstitle">My Events</h1>
		<div id="eventdisplay">
			<form action="NewEvent.jsp">
				<button type="submit" class="myeventstitle" id="plus" style="border: none;">
						<span class="glyphicon glyphicon-plus-sign" style="font-size: 30px;"></span>
				</button>
			</form>
			<div class="menbar">
				<ul>
					<li><span id="seeAll">All</span></li>
					<li><span id="seePast">Past</span></li>
					<li><span id="seeFuture">Future</span></li>
				</ul>
			</div>

			<div class="container">
				<div class="eventDiv" id="events-future">
					<table id="event-table">
					<% 
					if (futureEvents.size() > 0) {%>
						<tr>
							<th>
								<div class="solo-table">
								<%for(Event e : futureEvents){ %>
									<span class="breaker"></span>
									<table>
										<tr>
											<th><%= e.getName() %></th>
											<th></th>
											<th></th>
										</tr>
										<tr>
											<th><%= e.getAffiliation() %></th>
											<th>Attending: <%= e.getNumAttending() %></th>
										</tr>
										<tr>
											<th><%= e.getLocation() %></th>
											<th>Interested: <%= e.getNumInterested() %></th>
											<th>
												<form action="GoEvent" method="post">
													<button type="submit"
													class="btn btn-default btn-lg expand">
														<span class="glyphicon glyphicon-expand"></span>
													</button>
													<input type="hidden" name="eventID" value="<%= e.getEventID() %>">
												</form>
											</th>
										</tr>
										<tr>
											<th><%= e.getDate() %></th>
											<th>Not Attending: <%= e.getNumNotAttending() %></th>
										</tr>
										<tr>
											<th><%= e.getBegin() %> PM to <%= e.getEnd() %> PM</th>
											<th>Tags:  <%= e.getTags() %></th>

										</tr>
									</table>
								<%} %>
								</div>
							</th>
						</tr>
						<% } else { %>
					<div class="noEvents">
						No events to display
					</div>
					<% } %>
					</table>
				</div>
				<div class="eventDiv" id="events-all">
					<table id="event-table">
					<% 
					if (userEvents.size() > 0) {%>
						<tr>
							<th>
								<div class="solo-table">
								<%for(Event e : userEvents){ %>
									<span class="breaker"></span>
									<table>
										<tr>
											<th><%= e.getName() %></th>
											<th></th>
											<th></th>
										</tr>
										<tr>
											<th><%= e.getAffiliation() %></th>
											<th>Attending: <%= e.getNumAttending() %></th>
										</tr>
										<tr>
											<th><%= e.getLocation() %></th>
											<th>Interested: <%= e.getNumInterested() %></th>
											<th>
												<form action="GoEvent" method="post">
													<button type="submit"
													class="btn btn-default btn-lg expand">
														<span class="glyphicon glyphicon-expand"></span>
													</button>
													<input type="hidden" name="eventID" value="<%= e.getEventID() %>">
												</form>
											</th>
										</tr>
										<tr>
											<th><%= e.getDate() %></th>
											<th>Not Attending: <%= e.getNumNotAttending() %></th>
										</tr>
										<tr>
											<th><%= e.getBegin() %> PM to <%= e.getEnd() %> PM</th>
											<th>Tags:  <%= e.getTags() %></th>
	
										</tr>
									</table>
								<%} %>
								</div>
							</th>
						</tr>
						<% } else { %>
					<div class="noEvents">
						No events to display
					</div>
					<% } %>
				</table>
			</div>
			<div class="eventDiv" id="events-past">
				<table id="event-table">
					<% 
					if (pastEvents.size() > 0) {%>
						<tr>
							<th>
								<div class="solo-table">
								<%for(Event e : pastEvents){ %>
									<span class="breaker"></span>
									<table>
										<tr>
											<th><%= e.getName() %></th>
											<th></th>
											<th></th>
										</tr>
										<tr>
											<th><%= e.getAffiliation() %></th>
											<th>Attending: <%= e.getNumAttending() %></th>
										</tr>
										<tr>
											<th><%= e.getLocation() %></th>
											<th>Interested: <%= e.getNumInterested() %></th>
											<th>
												<form action="GoEvent" method="post">
													<button type="submit"
													class="btn btn-default btn-lg expand">
														<span class="glyphicon glyphicon-expand"></span>
													</button>
													<input type="hidden" name="eventID" value="<%= e.getEventID() %>">
												</form>
											</th>
										</tr>
										<tr>
											<th><%= e.getDate() %></th>
											<th>Not Attending: <%= e.getNumNotAttending() %></th>
										</tr>
										<tr>
											<th><%= e.getBegin() %> PM to <%= e.getEnd() %> PM</th>
											<th>Tags:  <%= e.getTags() %></th>

										</tr>
									</table>
								<%} %>
								</div>
							</th>
						</tr>
						<% } else { %>
					<div class="noEvents">
						No events to display
					</div>
					<% } %>
					</table>
				</div>
	</div>
</div>
</body>
</html>