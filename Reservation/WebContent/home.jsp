<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.List,models.Person,models.Reviews,dao.ReviewsDAO"%>
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
	ReviewsDAO rev = new ReviewsDAO();
	List<Object[]> feed = rev.fetchNewsFeed(person.getUserName());
%>
<title>Home - FoodWorld</title>
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

<div style="margin-left: 1.2cm;margin-top: 0.1cm;float: left; width:900px">
	<h1 style="font-size:200%;text-indent: 20px;">NewsFeed</h1>
	<hr style="height:1px;background-color:#DDD;">
 	
 	<%
	for (int i=0; (i<feed.size() && i<12);i++)
	{
		Object[] obj = feed.get(i);
		String restaurant = (String) obj[0];
		String comment = (String) obj[1];
		String followingUser = (String) obj[2];
		String followingFirstName = (String) obj[3];
		int rid = (Integer) obj[4];
		String imageURL = (String) obj[5];
		
	%>
	<div style="margin-left: 0.3cm;box-shadow: 0.5px 0.5px 3px #888888;margin-top: 0.3cm;background-color: white;width:800px;padding-top:10px;padding-bottom:10px;padding-left:10px; float: left;position: relative;">
	<div style="float:left"><button class="btn btn-link" style="font-size:150%;outline:none;padding: 0;float:left" value ="<%= followingUser %>" onclick="userHandler(value)">
		<%=followingFirstName %></button> <div style="padding-top:2px;padding-left:4px;padding-right:4px;font-size:140%;float:left"> added a review for </div>
		<button class="btn btn-link" style="font-size:150%;outline:none;padding: 0;" value ="<%= rid %>" onclick="restaurantHandler(value)"><%=restaurant %>
		</button><br>
		<p style="font-style:italic;font-size:140%;">" <%=comment %> "</p></div>
	<div style="float:right; margin-right:10px"><image style="content:url(<%=imageURL%>);" width= "100" height="100"></image></div>
	
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

function userHandler(user){
	
 	$.ajax({
		url : "http://localhost:8080/Reservation/rest/user/view/"+user,
		type : "post",
		dataType : "text",
		async : false,
		success : function (response) {
			location.href = "/Reservation/otheruser.jsp";
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

</script>
</body>
</html>
