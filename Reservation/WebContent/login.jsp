<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>FoodWorld.com</title>
<script type="text/javascript" src="js/jquery.js"></script>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>
<body style="background-color: #F3F3F3;">
<div class="container" style="width:600px;">

	<h1 style="text-align: center; font-size:500%; padding-top:90px;font-family:verdana;text-shadow: 4px 2.5px #A8A8A8;">FOOD WORLD</h1><br>
	<p style="text-align: center; font-size:150%; font-weight: bold; "> Connecting foodies</p><hr style="height:1px;background-color:#DDD;">
</div>
<div class="container" style="width:500px;">
<!-- <form action="/Reservation/loginAction" method="post">  -->
    <div style="padding-bottom:5px;"><INPUT style="height: 1cm;font-size:17px" TYPE="text" id="userName" placeholder="Enter username" class="form-control" maxlength="225"/></div>
    <div style="padding-bottom:7px;"><INPUT style="height: 1cm;font-size:17px" TYPE="password" id="password" placeholder="Enter password" class="form-control" maxlength="225"/></div>
	
	<div class="form-group form-group-lg">
    <button class="btn btn-primary col-xs-1" id="login" style="width:227px;height: 1cm;font-size:18px">Login</button>
    <div class="col-xs-1">
      <button class="btn btn-primary btn-block" style="width:226px;height: 1cm;font-size:18px" onclick="location.href = '/Reservation/createaccount.jsp';">Register</button>
    </div>
  </div>
  <script>

   $(function(){

		$("#login").click(loginHandler);
		
	});

function loginHandler() {
	var username = $("#userName").val();
	var password = $("#password").val();
	if ((username == "") && (password == ""))
		location.href="/Reservation/login.jsp";
	else {
	var newLogin = {
			"userName":username,
			"password":password,
	};
	handleLogin(newLogin);
	}
	return false;
}

function handleLogin(login) {

	$.ajax({
		url : "http://localhost:8080/Reservation/rest/user/login",
		type : "post",
		data : JSON.stringify(login),
		dataType : "text",
		async : false,
		contentType : "application/json",
		success : function(response) {
			  if(response == "pass") location.href = "/Reservation/home.jsp";
				else alert("Username/Password is incorrect"); 
		}
	});
} 


</script>
  
</div>
<div class="container" style="width:600px;"><hr style="height:1px;background-color:#DDD;"></div>
</body>
</html>