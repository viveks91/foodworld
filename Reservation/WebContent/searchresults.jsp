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
<title>Search results</title>
<script type="text/javascript" src="js/jquery.js"></script>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>
<body style= "background-color:#F3F3F3;">

<div style= "background-color: #006699;color:white;text-indent:20px;padding-top:5px;padding-bottom:5px;">
  <span style="font-size:150%;font-weight: bold;">Food World</span>
  <span style="float:right;padding-right:20px;padding-top:5px;">
     <button id="logout" class="btn btn-link btn-xs" style="color:#FFF" onclick="logoutHandler()">Logout</button>
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
<%
List<RestaurantSearch> results = (List<RestaurantSearch>)session.getAttribute("searchResults");
%>
<div style="margin-left: 1.2cm;margin-top: 0.1cm;float: left; width:700px">
<h1 style="font-size:300%;text-indent: 20px;float:left;">Search a restaurant</h1>

<div id="div2" style="margin-left: 3.2cm;margin-top: 0.5cm;float: left; width:100px;display:block;">
<button id="back" class="btn btn-info btn-block" style="height: 1cm; width:5cm;font-size:18px" onclick="stateRevert()">Back to search</button><br>
</div>
<hr style="height:1px;background-color:#DDD;clear:both">

<div>
<%
for(int i=0;i<results.size();i++){
%>
<div style="margin-left: 0.3cm;box-shadow: 0.5px 0.5px 3px #888888;margin-top: 0.3cm;background-color: white;width:685px;padding-top:10px;padding-bottom:10px;padding-left:10px; float:left;position: relative;">
<div style="width:545px;float:left;padding-right: 10px;">
<button class="btn btn-link" style="font-size:170%;outline:none;" value ="<%= results.get(i).getPlaceId() %>" onclick="restaurantHandler(value)">
<%= results.get(i).getName() %></button><br>
<p style="float:left; margin-left:0.5cm; font-size:130%">Rating: <%= results.get(i).getRatings() %></p>
<p style="float:left; margin-left:1.5cm; font-size:130%">Price Level: <%= results.get(i).getPriceLevel() %></p><br>
<p style="clear:left; margin-left:0.5cm"><%= results.get(i).getAddress() %></p>
</div><image style="content:url(<%=results.get(i).getImageURL() %>);margin-top:5px" width= "100" height="100"></image></div>
<%
}
%>
</div>
</div>


<script>

function logoutHandler(){
	
	$.ajax({
		url : "http://localhost:8080/Reservation/rest/user/logout",
		type : "post",
	});
	
	location.href= "/Reservation/login.jsp";
}

function stateRevert() {
	location.href="/Reservation/search.jsp";
}

function restaurantHandler(placeId) {
	$.ajax({
		url : "http://localhost:8080/Reservation/rest/search/details/"+placeId,
		type : "get",
		async : false,
		success : redirectHandler
	});

}

function redirectHandler() {
	location.href= "/Reservation/restaurantdetails.jsp";
}

</script>
</body>
</html>