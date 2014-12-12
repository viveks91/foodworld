<%@page import="dao.FavoritesDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="managers.ReservationManager,models.Reservation,java.util.*,java.text.*,dao.ReviewsDAO,models.User,models.Address,rest.RestaurantSearch, models.Restaurant, managers.RestaurantManager, managers.AddressManager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit account</title>
<script type="text/javascript" src="js/jquery.js"></script>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>
<%
User user = (User)session.getAttribute("user");
Reservation currentReservation = (Reservation)session.getAttribute("reservationDetails");
RestaurantManager restaurantMgr = new RestaurantManager();
Restaurant selected = restaurantMgr.findRestaurantById(currentReservation.getRestaurantId());
AddressManager addrMgr = new AddressManager();
Address address = addrMgr.findAddressById(selected.getAddressId());
String restaurantAddress=address.getapt_No()+" "+address.getStreet()+", "+address.getCity()+", "+address.getState()+" "+address.getZip();
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date date = new Date();

%>

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
<div style="margin-left: 1.2cm;margin-top: 0.1cm;float: left;width:800px;" >
<h1 style="font-size:300%;text-indent: 15px;">Make Reservation</h1><hr style="height:1px;background-color:#DDD;">


<form class="form-horizontal" role="form">
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Restaurant Details</label>
    <div class="col-sm-9" style="margin-left:0.4cm;width:590px;box-shadow: 0.5px 0.5px 3px #888888;background-color: white;padding-top:10px;padding-bottom:10px;padding-left:10px; position: relative;">
      <p style="height: 1cm;font-size:17px"><span style="font-size:120%"><%= selected.getName()%></span><br> <%= restaurantAddress%> </p>
    </div>
  </div>

  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Number of people</label>
    <div class="col-sm-9">
      <INPUT TYPE="text" id="people_count" placeholder="eg. 5" class="form-control" maxlength="225" style="height: 1cm;font-size:17px" value="<%=currentReservation.getPeople_count() %>"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Date</label>
    <div class="col-sm-9">
      <INPUT TYPE="date" id="datepicker" min="<%=dateFormat.format(date).toString() %>" style="width:590px;height: 1cm;font-size:17px"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
 	<label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Time Slot</label>
 		<div class="col-sm-9">
 			<select id="timepicker"  class="form-control" maxlength="225" style="height: 1cm;font-size:17px">
				<option value="18:00">06:00 PM - 07:00 PM</option>
				<option value="19:00">07:00 PM - 08:00 PM</option>
				<option value="20:00">08:00 PM - 09:00 PM</option>
				<option value="21:00">09:00 PM - 10:00 PM</option>
				
			</select><hr style="height:1px;background-color:#DDD;">
			<button class="btn btn-warning btn-block" id="makeit" style="height: 1cm;font-size:17px" onclick="return confirm('Confirm your reservation?')">Update Reservation</button>
		</div>	
 </div>

</form>

  <script>
  $(function(){
		
		$("#makeit").click(updateReservationHandler);
		$("#logout").click(logoutHandler);
		
	});

function logoutHandler(){
		
		$.ajax({
			url : "http://localhost:8080/Reservation/rest/user/logout",
			type : "post",
		});
		
		location.href= "/Reservation/login.jsp";
}
  
function updateReservationHandler() {
			
		var newReservation = {
				"id": "<%= currentReservation.getId() %>",
				"userName": "<%= currentReservation.getUserName()%>",
				"restaurantId" : "<%=currentReservation.getRestaurantId() %>",
				"people_count":$("#people_count").val(),
				"date": $("#datepicker").val(),
				"time": $("#timepicker").val(),
				};
		updateReservation(newReservation);
		return false;
}

		
	function updateReservation(newReservation) {

		$.ajax({
			url : "http://localhost:8080/Reservation/rest/user/updatereservation",
			type : "put",
			data : JSON.stringify(newReservation),
			contentType : "application/json",
			async : false,
			success : responseHandler
		});
		
	}
	
	function responseHandler() {
		alert("Update successful");
		location.href = "/Reservation/reservation.jsp";
	}
  
  </script>
</div>
</body>

</html>