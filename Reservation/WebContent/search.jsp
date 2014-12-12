<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="models.Person,rest.RestaurantSearch,java.util.ArrayList,java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="js/jquery.js"></script>
<%
	Person person = (Person)session.getAttribute("user");
	if (person == null) {
%>
<script>alert("Please login");</script>
<jsp:forward page="/login.jsp" />
<%
	};
%>
<title>Search</title>
<script type="text/javascript" src="js/jquery.js"></script>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>
<body style= "background-color:#F3F3F3;">

<div style= "background-color: #006699;color:white;text-indent:20px;padding-top:5px;padding-bottom:5px;">
  <span style="font-size:150%;font-weight: bold;">Food World</span>
  <span style="float:right;padding-right:20px;padding-top:5px;">
     <button id="logout" class="btn btn-link btn-xs" style="color:#FFF">Logout</button>
  </span>
  <span style="float:right;padding-right:10px;padding-top:5px;font-weight: bold;font-size:12pt;">
     <a href="/Reservation/home.jsp" style="color:#FFF">Home</a>
  </span>
  <span style="float:right;padding-right:20px;font-weight: bold;font-size:150%;">
     <a href="/Reservation/profile.jsp" style="color:#FFF"><%= person.getFirstName() %></a>
  </span>
</div>
  
<div style= "background-color: #83888E;padding-right:10px;padding-top:20px;padding-bottom:5px; width:200px; height:330px;float:left;"> 
<p style="text-indent:20px;font-size:120%;font-weight: bold;"><a href="/Reservation/search.jsp" style="color:#FFF"> Search restaurants</a></p>
<p style="text-indent:20px;font-size:120%;font-weight: bold;padding-top:5px;"> <a href="/Reservation/reservation.jsp" style="color:#FFF"> My reservations</a> </p>
<p style="text-indent:20px;font-size:120%;font-weight: bold;padding-top:5px;"> <a href="/Reservation/favorites.jsp" style="color:#FFF"> My favorites</a> </p>
<p style="text-indent:20px;font-size:120%;font-weight: bold;padding-top:5px;"> <a href="/Reservation/reviews.jsp" style="color:#FFF"> My reviews</a> </p>
<p style="text-indent:20px;font-size:120%;font-weight: bold;padding-top:5px;"> <a href="/Reservation/following.jsp" style="color:#FFF"> Following</a> </p>
<p style="text-indent:20px;font-size:120%;font-weight: bold;padding-top:5px;"> <a href="/Reservation/finduser.jsp" style="color:#FFF"> Find a user</a> </p>
<p style="text-indent:20px;font-size:120%;font-weight: bold;padding-top:5px;"> <a href="/Reservation/editprofile.jsp" style="color:#FFF"> Edit profile</a> </p>
</div>
<div style="margin-left: 1.2cm;margin-top: 0.1cm;float: left; width:700px">
<h1 style="font-size:300%;text-indent: 20px;float:left;">Search a restaurant</h1>

<hr style="height:1px;background-color:#DDD;clear:both">

<div id="div1" style="display:block;">

   <div style="margin-left: 0.2cm;">
       <INPUT style="font-size:17px;height: 1cm;" TYPE="text" id="name" placeholder="Restaurant name" class="form-control" maxlength="225"/>
   </div>
   <div style="margin-left: 0.2cm;margin-top: 0.2cm;">
       <INPUT style="font-size:17px;height: 1cm;" TYPE="text" id="location" placeholder="Location or place" class="form-control" maxlength="225"/>
   </div>
   <div style="margin-left: 0.2cm;margin-top: 0.3cm;">
       <button id="search" class="btn btn-primary btn-block" style="height: 1cm;font-size:18px" onclick = "searchRestaurant()">Search restaurant</button>
   </div>
	  <hr style="height:1px;background-color:#DDD;">
</div>

</div>

<script>

$(function(){

	$("#logout").click(logoutHandler);
	
});

function logoutHandler(){
	
	$.ajax({
		url : "http://localhost:8080/Reservation/rest/user/logout",
		type : "post",
	});
	
	location.href= "/Reservation/login.jsp";
}
	
	function searchRestaurant() {
		var restaurantName = $("#name").val();
		var location = $("#location").val();
		var searchParameters = restaurantName+","+location;
		
		if ((restaurantName == "") && (location == "")) {
			//Do nothing
		} else  {

		$.ajax({
			url : "http://localhost:8080/Reservation/rest/search/"+searchParameters,
			type:"get",
			async:false,
			success : responseHandler
		});
		}
	}
	
	function responseHandler() {
		location.href = "/Reservation/searchresults.jsp";
	}
	

</script>
</body>
</html>