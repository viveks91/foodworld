<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.List,models.User,models.Reviews,rest.RestaurantSearch,dao.ReviewsDAO,dao.FavoritesDAO,models.Restaurant,dao.RestaurantDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="js/jquery.js"></script>
<%
	User user = (User)session.getAttribute("user");
    FavoritesDAO favdao = new FavoritesDAO();
    ReviewsDAO revdao = new ReviewsDAO();
    
    RestaurantSearch selected = (RestaurantSearch)session.getAttribute("selectedRestaurant");
%>
<title>
<%= selected.getName()%>
</title>

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
     <a href="/Reservation/profile.jsp" style="color:#FFF"><%= user.getFirstName() %></a>
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

<div style="margin-left: 0.3cm;margin-top: 0.3cm;" class="col-lg-8">
	<div style="float:left;width:640px;margin-top: 0.5cm;"><h1 style="font-size:310%;text-indent: 20px;">
	<%= selected.getName()%>
	</h1>
	<p style="font-size:140%;text-indent:0.8cm;padding-top:5px"><%= selected.getAddress()%></p></div>
	<image style="content:url(<%=selected.getImageURL() %>);margin-top:5px;border: 3px solid #a1a1a1;" width= "200" height="200" ></image>
	<hr style="height:1px;background-color:#DDD;">
	
	<div style="margin-left: 0.1cm;margin-bottom: 0.55cm;background-color: white;width:460px; float:left;position: relative;box-shadow: 0.5px 0.5px 3px #888888;">
		<p style="text-indent:20px;padding-top:20px;font-weight: bold;font-size:120%;text-decoration: underline;">MORE INFO</p>
		<p style="font-size:110%;text-indent:0.8cm;float:left">Rating: <span style="font-weight: bold"><%= selected.getRatings()%></span></p>
		<p style="font-size:110%;text-indent:0.8cm"> Price Level:<span style="font-weight: bold"> <%= selected.getPriceLevel()%></span></p>
		<p style="padding-down:30px;font-size:110%;text-indent:0.8cm">
		Website: <a href="<%= selected.getWebsite()%>"><%= selected.getWebsite()%></a>
		</p>
		<p style="font-size:110%;text-indent:0.8cm;float:left"> Opening Time:<span style="font-weight: bold"> <%= selected.getOpeningTime()%></span></p>
		<p style="font-size:110%;text-indent:0.8cm"> Closing Time:<span style="font-weight: bold"> <%= selected.getClosingTime()%></span></p>
		<p style="font-size:110%;text-indent:0.8cm"> Phone: <%= selected.getPhoneNo()%></p>
		<br>
	
	</div>
	
	<div style="margin-left: 0.6cm;width:360px;float:left;position: relative;">
	<button id="reservation" class="btn btn-primary btn-block" style="height: 1cm;font-size:18px;" onclick="reservationHandler()">Make a reservation</button><br>
	<%
	   int path = (Integer)session.getAttribute("path");
	   if (path == 0 ){
		   if (favdao.isFav(user.getUserName(), selected.getRestaurantId())) {

	%>
	<button id="fav" class="btn btn-success btn-block disabled" style="height: 1cm;font-size:18px">Already added to favorites</button><br>
	<button id="rev" class="btn btn-warning btn-block" style="height: 1cm;font-size:18px" onclick="addReview()">Add a review</button><br>
	<%
		   }else {
	%>
	<button id="fav" class="btn btn-info btn-block" style="height: 1cm;font-size:18px" onclick="favouriteHandler()">Add to favorites</button><br>
	<button id="rev" class="btn btn-warning btn-block" style="height: 1cm;font-size:18px" onclick="addReview()">Add a review</button><br>
	<%
		   }
	   }
	%>
	
	</div><hr style="height:1px;background-color:#DDD;clear:both">
	
	
	<div id="review" style="display:none">
	<INPUT style="font-size:17px;height: 2cm;" TYPE="text" id="comments" placeholder="Write a review" class="form-control" maxlength="500"/><br>
	<label>Rating</label><input id="rating" type="number" min="1" max="5" style="height:1cm;margin-left:0.3cm;width:3cm"></input>
	<button id="submit" class="btn btn-primary" style="height: 1cm;font-size:18px;margin-left:14.4cm" onclick="handleData()">Submit review</button><br>
	<hr style="height:1px;background-color:#DDD;clear:both"></div>
	
	<%
	if (path == 0 ){
		
		List<Object[]> reviews = revdao.findWithRestaurantId(selected.getRestaurantId());
		if (!(reviews.isEmpty()))
		{
	%>
	<div style="margin-left: 0.1cm;background-color: white;width:844px;padding-bottom:12px; float: left;position: relative;clear:both;box-shadow: 0.5px 0.5px 3px #888888;">
    <p style="text-indent:20px;padding-top:20px;font-weight: bold;font-size:120%;text-decoration: underline;">REVIEWS</p>
    <hr style="margin-left:20px;width:800px">
    <%
    for(int i=0;i<reviews.size();i++) {
    	
    	Object[] obj = reviews.get(i);
    	String name = (String) obj[0];
    	String comments = (String) obj[1];
    	String ratings = (String) obj[2];
    %>
	
	<div style="margin-left:0.9cm;">
   <div style="float:left;font-size:120%;margin-bottom:0.4cm"><span style="font-size:110%;"><%=name %></span>  -   (Rating : <%= ratings %>) 
    <span style="text-indent:14px;font-size:110%;clear:right;font-style: italic; ">" <%= comments %> "</span></div>

</div><hr style="margin-left:20px;width:800px">
	<%
		} 
    
    %>
    </div>
    <%
	}}
	%>
	
	
	
</div>
<script>

function logoutHandler(){
	
	$.ajax({
		url : "http://localhost:8080/Reservation/rest/user/logout",
		type : "post",
	});
	
	location.href= "/Reservation/login.jsp";
}

function handleData() {
	var msg = $("#comments").val();
	var rating = $("#rating").val();

	
	reviewHandler(msg,rating);
	return false;
}

function reviewHandler(msg,rating){
	
	$.ajax({
		url : "http://localhost:8080/Reservation/rest/search/addreview/"+msg+"/"+rating,
		type : "post",
		async:false,
		success : redirectHandler
	});
	
}

function redirectHandler() {
	location.href= "/Reservation/restaurantdetails.jsp";
}

function favouriteHandler() {
	
	$.ajax({
		url : "http://localhost:8080/Reservation/rest/search/addtofav",
		type : "post",
	});
	
	location.href= "/Reservation/restaurantdetails.jsp";
	
}

function reservationHandler() {
	location.href="/Reservation/makeReservation.jsp";
}

function addReview() {
	$( "#review" ).toggle();
}


</script>

</body>
</html>