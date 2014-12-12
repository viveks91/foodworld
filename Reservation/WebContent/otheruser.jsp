<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.List,models.User,models.Address,managers.AddressManager,dao.FollowingDAO,models.Favorites,dao.FavoritesDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="js/jquery.js"></script>
<%
	User user = (User)session.getAttribute("user");
    User viewuser = (User)session.getAttribute("viewuser");
	AddressManager addrmgr = new AddressManager();
	Address addr = addrmgr.findAddressById(viewuser.getAddressId());
	FollowingDAO folldao = new FollowingDAO();
	boolean isFollowing = folldao.findBy2UserName(user.getUserName(), viewuser.getUserName());
	FavoritesDAO fav = new FavoritesDAO();
	List<Object[]> favs = fav.findByUserName(viewuser.getUserName());

%>
<title>
<%= viewuser.getFirstName()%> <%= viewuser.getLastName()%>
</title>

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

<div style="margin-left: 0.3cm;" class="col-lg-8">
	<h1 style="font-size:300%;text-indent: 20px;">
	<%= viewuser.getFirstName()%> <%= viewuser.getLastName()%>
	</h1><hr style="height:1px;background-color:#DDD;">
	<div style="margin-left: 0.1cm;margin-bottom: 0.55cm;background-color: white;width:440px; float:left;position: relative;box-shadow: 0.5px 0.5px 3px #888888;">
		<p style="text-indent:20px;padding-top:20px;font-weight: bold;font-size:120%;text-decoration: underline;">ABOUT</p>
		<p style="text-indent:20px;padding-top:10px;font-size:100%;">Address :
		<%= addr.getStreet()%>,<%= addr.getapt_No()%>,<%= addr.getCity()%>,<%= addr.getState()%></p>
		<p style="text-indent:31px;font-size:100%;"> Phone :
		<%= viewuser.getPhoneNo()%></p>
		<p style="text-indent:20px;padding-down:30px;font-size:100%;">Email ID :
		<%= viewuser.getEmailId()%></p><br>
	
	</div>
	<%
	if (isFollowing) {
	%>
	<div style="margin-left: 0.6cm;width:400px;float:left;position: relative;">
		<button id="unfollow" class="btn btn-success btn-block" style="height: 1cm;font-size:18px">Already following. Click to unfollow</button><br>
	</div>
	<%
	} else {
	%>
	<div style="margin-left: 0.6cm;width:400px;float:left;position: relative;">
		<button id="follow" class="btn btn-info btn-block" style="height: 1cm;font-size:18px">Follow this user</button><br>
	</div>
	<%
	}
	
	%>

<div style="clear:both">
	<hr style="height:1px;background-color:#DDD;">
</div>
<div style="margin-left: 0.1cm;background-color: white;width:864px;padding-bottom:12px; float: left;position: relative;clear:both;box-shadow: 0.5px 0.5px 3px #888888;">
<p style="text-indent:20px;padding-top:20px;font-weight: bold;font-size:120%;text-decoration: underline;">FAVORITES</p>
<hr style="margin-left:20px;width:800px">

<%
if (favs.size()!=0)
{
for(int i=0;i< favs.size();i++)
{
	Object[] obj = favs.get(i);
	String name = (String) obj[0];
	int id = (Integer) obj[2];
	String street = (String) obj[3];
	String city = (String) obj[4];
	String state = (String) obj[5];
	
	String imageURL = (String) obj[7];
%>
<div style="margin-left:0.3cm;margin-top:0.3cm;">
<div style="width:615px;float:left"><button class="btn btn-link" style='font-size:140%;outline:none;' value ="<%=id %>" onclick='restaurantHandler(value)'> <%=name %></button>
<p style="text-indent:14px;font-size:120%; "><%= street %>, <%= city %>, <%= state %></p></div>
<image style="content:url(<%=imageURL%>);" width= "100" height="100"></image>
</div><hr style="margin-left:20px;width:800px">
<%
}}
else
{
%>
<div style="margin-left:0.3cm;">
<p style="text-indent:14px;font-size:120%; ">No favorites</p>
</div>
<%
}
%>
</div>
</div>
<script>

$(function(){
	
	$("#logout").click(logoutHandler);
	$("#follow").click(followHandler);
	$("#unfollow").click(unfollowHandler);
	
});

function logoutHandler(){
	
	$.ajax({
		url : "http://localhost:8080/Reservation/rest/user/logout",
		type : "post",
	});
	
	location.href= "/Reservation/login.jsp";
}

function unfollowHandler(){
	$.ajax({
		url : "http://localhost:8080/Reservation/rest/user/unfollow/"+ "<%= viewuser.getUserName()%>",
		type : "post",
		async : false
	});
	
	location.href= "/Reservation/otheruser.jsp";
}

function followHandler(){
	$.ajax({
		url : "http://localhost:8080/Reservation/rest/user/follow/"+ "<%= viewuser.getUserName()%>",
		type : "post",
		async : false
	});
	
	location.href= "/Reservation/otheruser.jsp";
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