<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="models.User,models.Address,managers.AddressManager"%>
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
	AddressManager addrmgr = new AddressManager();
	Address addr = addrmgr.findAddressById(user.getAddressId());
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
<div style="margin-left: 0.7cm;float: left;" class="col-lg-6">
<h1 style="font-size:300%;text-indent: 30px;">Edit Profile</h1><hr style="height:1px;background-color:#DDD;">


<form class="form-horizontal" role="form">
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">First Name</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="text" id="firstName" value= "<%=user.getFirstName()%>" class="form-control" maxlength="225"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Last Name</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="text" id="lastName" value= "<%=user.getLastName()%>" class="form-control" maxlength="225"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Address</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="text" id="apt_No" value= "<%=addr.getapt_No()%>" class="form-control" maxlength="10"/>
	  <INPUT style="font-size:17px" TYPE="text" id="street" value= "<%=addr.getStreet()%>" class="form-control" maxlength="225"/>
	  <INPUT style="font-size:17px" TYPE="text" id="city" value= "<%=addr.getCity()%>" class="form-control" maxlength="20"/>
	  <INPUT style="font-size:17px" TYPE="text" id="state" value= "<%=addr.getState()%>" class="form-control" maxlength="20"/>
	  <INPUT style="font-size:17px" TYPE="text" id="zip" value= "<%=addr.getZip()%>" class="form-control" maxlength="20"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Phone Number</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="text" id="phoneNo" value= "<%=user.getPhoneNo()%>" class="form-control" maxlength="19"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Email ID</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="text" id="emailId" value= "<%=user.getEmailId()%>" class="form-control" maxlength="225"/>
       <center id="notice" style="margin-top: 0.1cm;color:green;font-size:18px"></center>
    </div>
  </div> <hr style= "margin-left: 4.5cm;height:1px;background-color:#DDD;">

 <div style="margin-left: 4.5cm;float:left;">
         <button class="btn btn-warning col-xs-5" id="update" style="width:232px;height: 1cm;font-size:18px">Update</button>
         <button class="btn btn-danger btn-block" id="delete" style="margin-left: 0.45cm;height: 1cm;font-size:18px;width:232px;float:left;" onclick="return confirm('Are you sure?')">Delete</button>
 </div>

</form>

<script>

	$(function(){

		$("#update").click(updateHandler);
		$("#delete").click(deleteHandler);
		$("#logout").click(logoutHandler);
		
	});
	

	function logoutHandler(){
		
		$.ajax({
			url : "http://localhost:8080/Reservation/rest/user/logout",
			type : "post",
		});
		
		location.href= "/Reservation/login.jsp";
	}
	   
	function updateHandler() {
		var addrId = "<%= user.getAddressId()%>";
			var newAddr = {
					"id":addrId,
					"street":$("#street").val(),
					"apt_No":$("#apt_No").val(),
					"city":$("#city").val(),
					"state":$("#state").val(),
					"zip":$("#zip").val()
			};
			updateAddress(newAddr);

			var newUser = {
					"userName": "<%= user.getUserName()%>",
					"password": "<%= user.getPassword()%>",
					"firstName":$("#firstName").val(),
					"lastName":$("#lastName").val(),
					"addressId":addrId,
					"phoneNo":$("#phoneNo").val(),
					"emailId":$("#emailId").val()
			};
			updateUser(newUser);

    return false;
	}
	
	function deleteHandler() {
		$.ajax({
			url : "http://localhost:8080/Reservation/rest/user/delete",
			type : "delete",
			success : function () {
				location.href= "/Reservation/login.jsp";
			}
		});

    return false;
	}

	function updateAddress(address) {
		$.ajax({
			url : "http://localhost:8080/Reservation/rest/address/update",
			type : "put",
			data : JSON.stringify(address),
			async : false,
			contentType : "application/json"
		});
	}

	function updateUser(user) {

		$.ajax({
			url : "http://localhost:8080/Reservation/rest/user/update",
			type : "put",
			data : JSON.stringify(user),
			contentType : "application/json",
			success : function () {
				document.getElementById("notice").innerHTML = "Successfully updated!";
			}
		});
	}



</script>
</div>

</body>
</html>
