<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="models.User,models.Following,dao.FollowingDAO,java.util.List,dao.UserDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="js/jquery.js"></script>
<%
	User user = (User)session.getAttribute("user");
    UserDAO userdao = new UserDAO();
	FollowingDAO folldao = new FollowingDAO();
	List<Following> following = folldao.findByUserName(user.getUserName());
	
	String view;
	if (following.isEmpty()) view = "block";
	else view = "none";

%>
<title>Following</title>
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
	<h1 style="font-size:300%;text-indent: 20px;">Following</h1>
	<hr style="height:1px;background-color:#DDD;">
	<div style="margin-left:20px; display:<%=view %>"><p> You are not following anyone</p></div>
	<%
	User user1 = null;
	for (int i=0; i<following.size();i++)
	{
	%>
	<div style="margin-left: 0.3cm;box-shadow: 0.5px 0.5px 3px #888888;margin-top: 0.3cm;background-color: white;width:430px;padding-top:10px;padding-bottom:10px;padding-left:10px; float: left;position: relative;">
	<%
	user1 = userdao.findByUserName(following.get(i).getFollowing());
	%>
		<button class="btn btn-link" style="font-size:170%;outline:none;" value ="<%= user1.getUserName() %>" onclick="userHandler(value)">
		<%=user1.getFirstName() %> <%=user1.getLastName() %>
		</button>
		<br>
	
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


</script>
</body>
</html>