<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="DatabasePackage.*,java.util.Vector,EventPackage.Event, ServletPackage.SearchServlet" %>
<!DOCTYPE html>
<html>

<%
	DatabaseManager.checkDatabase();
	if (session.getAttribute("loggedin") == null || session.getAttribute("username") == null){
		session.setAttribute("loggedin",false);
	}
%>
<head>
 	 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	
	<link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet">
	
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	
	<link rel="icon" href="images/favicon.png">
	
	<meta charset="UTF-8">
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	
	<meta charset="UTF-8">
	<!-- Calendar API scripts -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/script.js"></script>
	<link href='fullcalendar-3.10.0/fullcalendar.min.css' rel='stylesheet' />
	<link href='fullcalendar-3.10.0/fullcalendar.print.min.css' rel='stylesheet' media='print' />
	<script src='fullcalendar-3.10.0/lib/jquery.min.js'></script>
	<script src='fullcalendar-3.10.0/lib/moment.min.js'></script>
	<script src='fullcalendar-3.10.0/fullcalendar.min.js'></script>
	<!-- End of Calendar Tags -->
	<title>Home</title>
	<link rel="stylesheet" type="text/css" href="styles/HomePage.css">
	<script> 
		var pushSocket = new WebSocket("ws://10.26.250.81/CSCI201-Final-PartyPeople/push/")
		
		pushSocket.onmessage = function (event) {
			alert(event.data); 
		
		  console.log(event.data);
		};
	</script>
	<script>
	$(document).ready(function() {
		$(document).ready(function() {
		    $("#attending").hide();
		    $("#interested").hide();
		    $("#notattending").hide();
		    $("#all").show();
		});
		$("#interestB").click(function() {
			$("#all").hide();
			$("#attending").hide();
		    $("#notattending").hide();
			$("#interested").show();
		});
		$("#attendingB").click(function() {
			$("#all").hide();
		    $("#notattending").hide();
			$("#interested").hide();
			$("#attending").show();
		});
		$("#notattendingB").click(function() {
			$("#all").hide();
		    $("#attending").hide();
			$("#interested").hide();
			$("#notattending").show();
		});
		$("#reset").click(function() {
			$("#attending").hide();
		    $("#interested").hide();
		    $("#notattending").hide();
		    $("#all").show();
		});
	});
	function seeCalendar(){
		$("#calcover").toggle();
	}
	function seeMap(){
		$("#map").toggle();
	}
	$(document).ready(function() {
	    $("#calcover").hide();
	    $("#map").hide();
	    
	});
	$( document ).on( 'keydown', function ( e ) {
	    if ( e.keyCode === 27 ) { // ESC
	        $( "#calcover" ).hide();
	    	$("#map").hide();
	    }
	});
	</script>
	<!-- Full Calendar API Insertion -->
	<script>
	<%Vector<Event> curEvents = DatabaseQuery.getCurrentEvents();%>
  $(document).ready(function() {

    $('#calendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,basicWeek,basicDay'
      },
      contentHeight: 600,
      defaultDate: '2019-04-18',
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      events: [
    	<%if (curEvents.size() > 0) {
  			for(Event e : curEvents){ 
  			%>
    	{
          title: '<%=e.getName()%>',
         start:'<%=e.getDate()%> <%=e.getBegin()%> PM',
         url: 'GoEvent?eventID=<%=e.getEventID()%>'
        },
        <%}}%>
      ]
    });

  });

</script>
	<style>
#map {
	display:none;
	position: fixed	!important;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index:99;
    background-color:gray;
}
  #calcover {
    margin: 40px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
  }

 #calendar {
    position:fixed;
    left:0;
    top:0;
    max-width: 1500px;
    min-height:100%;
    margin: 0 auto;
    background-color:white;
    z-index:100;
  }
</style>
</head>
<body>
<div id="map"></div>
 <div id="calcover">
  <div id='calendar'></div>
 </div>
    <script>
      var geocoder;
      var map;
      var locations=[];
      <%if (curEvents.size() > 0) {
			for(Event e : curEvents){ 
			%>
		     	var adder =  '<strong><%=e.getName()%></strong><br>\
        	    	<%=e.getAffiliation()%><br>\
        	    	<%=e.getLocation()%><br>\
        	    	<a href="GoEvent?eventID=<%=e.getEventID()%>">More Details</a>';
				var event1 = ["<%=e.getLocation()%>",adder];
		    		
		  
      
				locations.push(event1);
     <%}
			}%>
      var i;
      function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 15,
          center: {lat: 34.021441, lng: -118.2897157}
        });
        geocoder = new google.maps.Geocoder();
        for( i=0;i<locations.length;i++){
            codeAddress(geocoder, map,i);

        }
      
      }

      function codeAddress(geocoder, map,i) {
        geocoder.geocode({'address': locations[i][0]}, function(results, status) {
          if (status === 'OK') {
            map.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location
            });
            addInfoWindow(i,marker);
          } else {
            alert('Geocode was not successful for the following reason: ' + status);
          }
        });
      }
      function addInfoWindow(i,marker){
    	  var infowindow = new google.maps.InfoWindow({})
    	  google.maps.event.addListener(
        	      marker,
        	      'click',
        	      (function(marker, i) {
        	        return function() {
        	          infowindow.setContent(locations[i][1])
        	          infowindow.open(map, marker) };
        	        }
        	      )(marker, i)
        	    )
      }
      
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAyWDKKQJ4mIn-THGNgj7DWVdR2fTz-Weg&callback=initMap">
    </script>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-6">
				<img src="images/partypeople-logo.png" id="logo" height="60" width="170" />
				<div class="banner"></div>
			</div>
			<div class="col-md-6" id="header">
				<%
				if ((boolean)session.getAttribute("loggedin")) {
				%>
				<form action="ProfilePage.jsp" class="headerforms">
					<button type="submit" class="btn btn-default btn-lg userbutton">
						<span class="glyphicon glyphicon-user"></span> My Account
					</button>
				</form>
				<form action="Logout.jsp" class="headerforms">
					<button type="submit" class="btn btn-default btn-lg logoutbutton">
						<span class="glyphicon glyphicon-log-out"></span> Log Out
					</button>
				</form>
				<% } else { %>
				<form action="Login.jsp" class="headerforms">
					<button type="submit" class="btn btn-default btn-lg loginbutton">
						<span class="glyphicon glyphicon-log-in"></span> Sign In
					</button>
				</form>
				<form action="Register.jsp" class="headerforms">
					<button type="submit" class="btn btn-default btn-lg registerbutton">
						<span class="glyphicon glyphicon-user"></span> Register
					</button>
				</form>
				<% } %>
			</div>
			<div class="row">
				<div class="col-md-7">
					<% if ((boolean)session.getAttribute("loggedin")) {%>
					<div class="profilePic">
						<img src=<%= DatabaseQuery.getPicPath((String)session.getAttribute("username")) %>>
					</div>
					<div class="userinfo">
						<div class="profilename"><%= (String)session.getAttribute("username")  %></div>
					</div>
					<% } else { %>
					<div class="filler"></div>
					<% } %>
					<div class="col-md-5">
						<h1>Upcoming Events</h1>
					</div>
					<form action="SearchServlet" method="POST">
						<input type="text" class="form-control" id="search"
							aria-describedby="search" placeholder="Search Event by Name or Tags" value="">
						<button type="submit" class="btn btn-default btn-lg searchglass">
						<span class="glyphicon glyphicon-search"></span></button>
						<input type="submit" class="btn btn-default btn-lg searchglass" value="">
						<span class="glyphicon glyphicon-search"></span>
					</form>
				</div>
				<div class="row1">
					<div class="col-md-3">
						<p>
							<button type="button" class="btn btn-default btn-lg listview">
								<span class="glyphicon glyphicon-th-list"></span>
							</button>
						</p>
					</div>

					<div class="col-md-3">
						<p>
							<button type="button" class="btn btn-default btn-lg calendarview"onclick="seeCalendar()">
								<span class="glyphicon glyphicon-calendar"></span>
							</button>
						</p>
					</div>
					<div class="col-md-3">
						<p>
							<button type="button" class="btn btn-default btn-lg mapview"onclick="seeMap()">
								<span class="glyphicon glyphicon-map-marker"></span>
							</button>
						</p>
					</div>
				</div>
				<div class=row2>
					<div class="container">
						<div class="events-all" id="all">
							<table id="event-table">
							<% 
							if (curEvents.size() > 0) {%>
								<tr>
									<th>
										<div class="solo-table">
										<%for(Event e : curEvents){ %>
											<span class="breaker"></span>
											<table>
												<tr>
													<th><%= e.getName() %></th>
													<th>Host Rating: 3.20 out of 5</th>
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
						<div class="events-all" id="interested">
							<table id="event-table">
							<% Vector<Event> interestedEvents = DatabaseQuery.getInterested_User((String)session.getAttribute("username"), curEvents);
							if (interestedEvents.size() > 0) {%>
								<tr>
									<th>
										<div class="solo-table">
										<%for(Event e : interestedEvents){ %>
											<span class="breaker"></span>
											<table>
												<tr>
													<th><%= e.getName() %></th>
													<th>Host Rating: 3.20 out of 5</th>
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
													<th><%= e.getBegin() %> to <%= e.getEnd() %></th>
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
						<div class="events-all" id="attending">
							<table id="event-table">
							<% Vector<Event> attendingEvents = DatabaseQuery.getAttending_User((String)session.getAttribute("username"), curEvents);
							if (attendingEvents.size() > 0) {%>
								<tr>
									<th>
										<div class="solo-table">
										<%for(Event e : attendingEvents){ %>
											<span class="breaker"></span>
											<table>
												<tr>
													<th><%= e.getName() %></th>
													<th>Host Rating: 3.20 out of 5</th>
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
													<th><%= e.getBegin() %> to <%= e.getEnd() %></th>
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
						<div class="events-all" id="notattending">
							<table id="event-table">
							<% Vector<Event> notAttendingEvents = DatabaseQuery.getNotAttending_User((String)session.getAttribute("username"), curEvents);
							if (notAttendingEvents.size() > 0) {%>
								<tr>
									<th>
										<div class="solo-table">
										<%for(Event e : notAttendingEvents){ %>
											<span class="breaker"></span>
											<table>
												<tr>
													<th><%= e.getName() %></th>
													<th>Host Rating: 3.20 out of 5</th>
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
													<th><%= e.getBegin() %> to <%= e.getEnd() %></th>
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
						<%
				if ((boolean)session.getAttribute("loggedin")) {
				%>
					<div class="sortbycat" id="reset">Filters</div>
					<div class="cat">
						<button type="button" id="interestB" class="btn btn-default btn-lg interestedbutton">
						<span class="glyphicon glyphicon-star-empty"></span><span class="cattag"> Interested</span>
						</button><br> 
						<button type="button" id="attendingB" class="btn btn-default btn-lg attendingbutton">
							<span class="glyphicon glyphicon-check"></span><span class="cattag"> Attending</span>
						</button> <br> 
						<button type="button" id="notattendingB" class="btn btn-default btn-lg notattendingbutton">
							<span class="glyphicon glyphicon-remove"></span><span class="cattag"> Not Attending</span>
						</button>
					</div>
					<div class="backgroundcat"></div>
					<%} %>
				</div>
			</div>
		</div>
	</div>
	</div>
	<script>
	</script>
</body>
</html>