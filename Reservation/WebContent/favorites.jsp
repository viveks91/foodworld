<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.List,models.User,models.Address,models.Favorites,managers.AddressManager,dao.FavoritesDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Favorites</title>
<script type="text/javascript" src="js/jquery.js"></script>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>
<%
    User user = (User)session.getAttribute("user");
	FavoritesDAO fav = new FavoritesDAO();
	List<Object[]> favs = fav.findByUserName(user.getUserName());
	
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
<div style="margin-left: 1.2cm;margin-top: 0.1cm;float: left; width:700px">
	<h1 style="font-size:300%;text-indent: 20px;">Favorites</h1>
	<hr style="height:1px;background-color:#DDD;">
	
<%
	if (favs.size()!=0)
	{
			for(int i=0;i< favs.size();i++)
				{
				Object[] obj = favs.get(i);
				String name = (String) obj[0];
				String ratings = (String) obj[1];
				int id = (Integer) obj[2];
			    String street = (String) obj[3];
			    String city = (String) obj[4];
			    String state = (String) obj[5];
			    String zip = (String) obj[6];
			    String imageURL = (String) obj[7];
%>

	<div style="margin-left: 0.5cm;box-shadow: 0.5px 0.5px 3px #888888;margin-top: 0.3cm;background-color: white;width:650px;padding-top:10px;padding-bottom:10px;padding-left:10px; clear:left;position: relative;">
	<div style="width:515px;float:left">
	<button class="btn btn-link" style='font-size:140%;outline:none;padding-right: 10px;' value ="<%=id %>" onclick="restaurantHandler(value)"> <%=name %></button><br>
		<p style="text-indent:14px;font-size:120%; "><%= street %>, <%= city %>, <%= state %></p>
		<p style="text-indent:14px;font-size:120%;font-style: italic; ">Rating: <%= ratings %></p></div>
		<image style="content:url(<%=imageURL%>);" width= "100" height="100"></image>
	</div>

<%
	}}
	else {
 %>
<div style="margin-left:0.3cm;">
<p style="text-indent:14px;font-size:120%; ">No favorites</p>
</div>
<%
}
%>
	</div>

<script>

	$(function(){

		$("#getFavorites").click(getFavoritesHandler);
		$("#logout").click(logoutHandler);
		
	});
	
	function logoutHandler(){
		
		$.ajax({
			url : "http://localhost:8080/Reservation/rest/user/logout",
			type : "post",
		});
		
		location.href= "/Reservation/login.jsp";
	}
	
	function getFavoritesHandler() {
		findFavorites($("#userName").val());
	}
	
	
	function findFavorites(userName) {
		
		$.ajax({
			url : "http://localhost:8080/Reservation/rest/user/"+userName,
			type:"get",
			contentType: "application/json",
			success:function(response) {
				
				responseHandler(response);

			}
		});
		
	}
	function responseHandler(response)
    {
		
		alert("response" + JSON.stringify(response));
		var Options = '';
		
		$.each(response, function(i, item) {
			alert("item" +item.name);	
			Options +='<li>'+item.name+'</li>';
			
        });
        $("#favoritesList").append(Options);
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
</div>

</body>
</html>