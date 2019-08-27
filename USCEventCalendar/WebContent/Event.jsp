<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="EventPackage.Event"
	import="java.util.Vector"%>
<%
	Event e = (Event) session.getAttribute("thisEvent");
	String arr[] = (e.getLocation()).split(" ");
	
	
	String adder =arr[0];
	for(int a=1;a<arr.length;a++){
		adder+="+"+arr[a];
	}
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Poppins"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Merriweather"
	rel="stylesheet">


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
<title>Event Details</title>
<script type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="styles/Event.css">
<link rel="icon" href="images/favicon.png">
</head>
<style>
#map {
	position: absolute !important;
	top: 20%;
	left: 56%;
	width: 40%;
	height: 40%;
	z-index: 99;
	background-color: gray;
	border-radius: 10px;
}
</style>
<body>
	<div class="col-md-6">
		<img src="images/partypeople-logo.png" id="logo" height="60"
			width="170" />
		<div class="banner"></div>
	</div>
	<form action="HomePage.jsp" class="headerforms">
		<button type="submit" class="btn btn-default btn-lg homebutton">
			<span class="glyphicon glyphicon-home"></span> Home
		</button>
	</form>
	<div id="eventbackground">
		<h1><%= e.getName() %></h1>
		<h2>Host: <%= e.getAffiliation() %></h2>
		<h2>Address: <%= e.getLocation() %></h2>
		<h2>Time: <%= e.getBegin() %> PM to <%= e.getEnd() %> PM</h2>
		<%if (e.getDetails()!=null){ %>
		<h2>Details: <%=e.getDetails() %></h2>
		<%} %>
		<h2>Tags: <%= e.getTags() %></h2>
		<h2>Interested: <%=e.getNumInterested()%> Attending: <%=e.getNumAttending()%> Not Attending: <%=e.getNumNotAttending() %></h2>
	</div>
	<div id="map"></div>
	<script>
      var geocoder;
      var map;
     var event=['<%= e.getLocation()%>','<%= e.getName() %><br>\
	    	<%= e.getLocation() %><br>\
	    	<a href="https://www.google.com/maps/dir/?api=1&origin=University+of+Southern+California&destination=<%=adder%>">Get Directions</a>']
      var i;
      function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 15,
          center: {lat: 34.0224, lng: -118.2851}
        });
        geocoder = new google.maps.Geocoder();
            codeAddress(geocoder, map,i);

        
      
      }

      function codeAddress(geocoder, map,i) {
        geocoder.geocode({'address': event[0]}, function(results, status) {
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
        	          infowindow.setContent(event[1])
        	          infowindow.open(map, marker)
        	        }
        	      })(marker, i)
        	    )
      }
      
    </script>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAyWDKKQJ4mIn-THGNgj7DWVdR2fTz-Weg&callback=initMap">
    </script>
	<div class="cat">
		<form action="EventDescision" class="forms" method="post">
			<button type="submit"
			class="btn btn-default btn-lg interestedbutton">
				<span class="glyphicon glyphicon-star-empty"></span><span class="cattag">
				Interested</span>
			</button>
			<input type="hidden" name="eventID" value="<%= e.getEventID() %>">
			<input type="hidden" name="type" value="interested">
		</form>
		<form action="EventDescision" class="forms" method="post">
			<button type="submit"
			class="btn btn-default btn-lg attendingbutton">
				<span class="glyphicon glyphicon-check"></span><span class="cattag">
				Attending</span>
			</button>
			<input type="hidden" name="eventID" value="<%= e.getEventID() %>">
			<input type="hidden" name="type" value="attending">
		</form>
		<form action="EventDescision" class="forms" method="post">
			<button type="submit"
			class="btn btn-default btn-lg notattendingbutton">
				<span class="glyphicon glyphicon-remove"></span><span class="cattag">
				Not Attending</span>
			</button>
			<input type="hidden" name="eventID" value="<%= e.getEventID() %>">
			<input type="hidden" name="type" value="notAttending">
		</form>
	</div>
</body>
</html>