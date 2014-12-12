<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

    pageEncoding="ISO-8859-1" import="java.util.*,models.User,models.Address,models.Reservation,managers.AddressManager,dao.ReservationDAO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>My reservations</title>

<script type="text/javascript" src="js/jquery.js"></script>

<link href="css/bootstrap.css" rel="stylesheet"/>

</head>

<%

    User user = (User)session.getAttribute("user");

ReservationDAO revs = new ReservationDAO();

Reservation rev = new Reservation();

List<Object[]> reserve = revs.findDetailsByUserName(user.getUserName());

String view;
if (reserve.isEmpty()) view = "block";
else view = "none";


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

<div style="margin-left: 1.2cm;margin-top: 0.1cm;float: left; width:900px">
	<h1 style="font-size:300%;text-indent: 20px;">My reservations</h1>
	<hr style="height:1px;background-color:#DDD;">


<div style="margin-left:20px; display:<%= view%>"><p> You don't have any reservations</p></div>

<%

for(int i=0;i< reserve.size();i++)

{


Object[] obj = reserve.get(i);

String restName = (String) obj[0];

int ppl = (Integer) obj[1];

    String time = (String) obj[2];

    String date = (String) obj[3];

    int Id = (Integer)obj[4];
    
    String imageURL = (String)obj[5];
    int restaurantId = (Integer)obj[6];

%>

  <div style="margin-left: 0.9cm;box-shadow: 0.5px 0.5px 3px #888888;margin-top: 0.3cm;background-color: white;width:800px;padding-top:10px;padding-bottom:10px;padding-left:10px; float: left;position: relative;">
	<div style="float:left">
	<button class="btn btn-link" style="font-size:150%;outline:none;padding: 0;float:left" value ="<%=restaurantId %>" onclick="restaurantHandler(value)">
		<%= restName%></button><br> 
	<div style="margin-top:20px"><p style="text-indent:10px;font-size:110%;">Date: <span style="font-weight: bold"><%=date %></span></p>
	<p style="text-indent:10px;font-size:110%;">Time: <span style="font-weight: bold"><%=time %></span></p>
	<p style="text-indent:10px;font-size:110%;margin-bottom:0.4cm">People count: <span style="font-weight: bold"><%=ppl %></span></p></div>
	<button class="btn btn-warning" style="margin-left:10px;font-size:120%;width:250px" value="<%=Id %>" onclick="updateReservationHandler(value)">Edit Reservation
	</button>
	<button class="btn btn-danger" style="margin-left:10px;font-size:120%;width:250px" value="<%=Id %>" onclick="deleteReservationHandler(value)">Delete Reservation
	</button>
	
	<br></div>
	<div style="float:right; margin-right:10px"><image style="content:url(<%=imageURL%>);" width= "150" height="150"></image></div>
	
	
	</div>

<%

}

 	%>

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

function deleteReservationHandler(Id){

	confirm('Are you sure?');

 	$.ajax({

	url : "http://localhost:8080/Reservation/rest/user/reservation/"+Id,

	type : "delete",

	dataType : "text",

	async : false,

	success : function (response) {


location.href = "/Reservation/reservation.jsp";

}

}); 

return false;

}

function restaurantHandler(value) {
	$.ajax({
		url : "http://localhost:8080/Reservation/rest/search/fav/"+value,
		type:"post",
		contentType: "application/json",
		async : false,
		success:function(response) {
			redirectHandler();
		}
	});
}

function redirectHandler() {
	location.href = "/Reservation/restaurantdetails.jsp";
}

function updateReservationHandler(Id){

 	$.ajax({

url : "http://localhost:8080/Reservation/rest/user/forupdateReservation/"+Id,
type : "put",
async : false,
success : editRedirect
});
 	
return false;

}

function editRedirect(){
	
	location.href = "/Reservation/updateReservation.jsp";
}


</script>


</body>

</html>