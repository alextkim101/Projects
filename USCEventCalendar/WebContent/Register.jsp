<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="DatabasePackage.DatabaseManager"%>
<!doctype html>
<html lang="en">
<head>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Poppins"
	rel="stylesheet">

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="google-signin-client_id"
	content="991256507664-e2e8h7mtklem1d2qsk0lslvsvidu5lv5.apps.googleusercontent.com">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://apis.google.com/js/platform.js" async defer>    </script>

<title>Register</title>
<link rel="stylesheet" type="text/css" href="styles/Register.css">
<link rel="icon" href="images/favicon.png">
</head>
<body>
	<%	
		DatabaseManager.checkDatabase();
		String reg_err = (String) session.getAttribute("reg_error");
		if (reg_err == null) {
			reg_err = "";
		}
	%>
	<div class="container-fluid">

		<div class="row">
			<div class="col-md-12">
				<img src="images/partypeople-logo.png" id="logo" height="60"
					width="170" />
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
						<h3>Sign Up</h3>
						<form method="post" action="RegisterUser" enctype="multipart/form-data">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="fname">Your First Name</label> 
										<input type="text" class="form-control" name="fname" id="fname" aria-describedby="fname" placeholder="Enter First Name">
									</div>
								</div>

								<div class="col-md-6">
									<div class="form-group">
										<label for="lname">Your Last Name</label> <input type="text"
											class="form-control" name="lname" id="lname" 
											aria-describedby="lname" placeholder="Enter Last Name">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="email">Your Email</label> 
								<input type="email" class="form-control" id="email" name="email" aria-describedby="email" placeholder="Enter Email" value="">
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="password">Password</label> <input type="password" class="form-control" id="password" name="password" aria-describedby="password" placeholder="Enter Password">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="Cpassword">Confirm Password</label> 
										<input type="password" class="form-control" id="Cpassword" aria-describedby="Cpassword" name="Cpassword" placeholder="Confirm Password">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="bio">Your Short Bio</label>
								<textarea rows="3" class="form-control" id="bio" name="bio" aria-describedby="bio" placeholder="Enter Bio"></textarea>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="profilePic">Upload Profile Picture</label> 
										<input type="file" class="form-control" id="profilePic" name="profilePic" aria-describedby="profilePic"	accept="image/*">
									</div>
								</div>
								<div class="col-md-6">
									<span id="reg_error"><%= reg_err %></span> 
								</div>
							</div>
							
							<div class="row">
								<div class="col-md-6">
									<div class="g-signin2" data-onsuccess="onSignIn"
										data-theme="dark"></div>
									<script>
									var array;
									var full;
									var myemail;
									var first;
									var last;
									function onSignIn(googleUser) {
										signOut();	
										// Useful data for your client-side scripts:
											var profile = googleUser.getBasicProfile();
											console.log("ID: "+ profile.getId()); // Don't send this directly to your server!
											console.log('Full Name: '+ profile.getName());
											console.log('Given Name: '+ profile.getGivenName());
											console.log('Family Name: '+ profile.getFamilyName());
											console.log("Image URL: "+ profile.getImageUrl());
											console.log("Email: "+ profile.getEmail());

											// The ID token you need to pass to your backend:
											var id_token = googleUser.getAuthResponse().id_token;
											console.log("ID Token: "+ id_token);
											full=profile.getName();
											myemail=profile.getEmail();
											array=full.split(" ",2);
											first=array[0];
											last=array[1];
											getData();
								
										}
										function getData(){
											$('#email').val(myemail);
											$('#fname').val(first);
											$('#lname').val(last);
										}	
									
										 function signOut() {
											    var auth2 = gapi.auth2.getAuthInstance();
											    auth2.signOut().then(function () {
											      console.log('User signed out already.');
											    });
										  }
								
									</script>

								</div>
								
							</div>
							<div class="form-group ">
								<button type="submit" class="btn btn-primary btn-lg btn-block login-button">Register</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<% session.setAttribute("reg_error", null); %>
</html>