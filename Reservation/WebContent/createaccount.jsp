<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New Account</title>
<script type="text/javascript" src="js/jquery.js"></script>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>


<body style = "background-color:#F3F3F3">
<div style= "background-color: #006699;font-size:150%;text-indent: 20px;font-weight: bold;color:white;padding-top:5px;padding-bottom:5px">Food World</div>
<div style="margin-left: 0.7cm;" class="col-lg-6">
<h1 style="font-size:300%;text-indent: 30px;">Create Account</h1><hr style="height:1px;background-color:#DDD;">


<form class="form-horizontal" role="form">

    <label class="col-xs-4" for="lg" style="font-size:120%;text-indent: 40px;">Account Type</label>
    
        <div class="form-group form-group-lg">
          <label class="col-xs-2" for="lg" style="font-size:110%;">User<div class="col-xs-1"><input type="radio" id="usertype" name="accountType" value="user" checked></div></label>

          <label style="font-size:110%;">Admin<div class="col-xs-1" ><input type="radio" id="admintype" name="accountType" value="admin"></div></label>
        </div>
</form><hr style="height:1px;background-color:#DDD;">

<input type="hidden" id="type" value="user">

<form class="form-horizontal" role="form">
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">First Name</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="text" id="firstName" placeholder="Enter your first name" class="form-control" maxlength="225"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Last Name</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="text" id="lastName" placeholder="Enter your last name" class="form-control" maxlength="225"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Username</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="text" id="userName" placeholder="Enter a username" class="form-control" maxlength="225"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Password</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="password" id="password" placeholder="Enter a password" class="form-control" maxlength="225"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Address</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="text" id="apt_No" placeholder="Apartment Number" class="form-control" maxlength="10"/>
	  <INPUT style="font-size:17px" TYPE="text" id="street" placeholder="Street" class="form-control" maxlength="225"/>
	  <INPUT style="font-size:17px" TYPE="text" id="city" placeholder="City" class="form-control" maxlength="20"/>
	  <INPUT style="font-size:17px" TYPE="text" id="state" placeholder="State" class="form-control" maxlength="20"/>
	  <INPUT style="font-size:17px" TYPE="text" id="zip" placeholder="ZIP code" class="form-control" maxlength="20"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Phone Number</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px" TYPE="text" id="phoneNo" placeholder="Enter your phone number" class="form-control" maxlength="19"/>
    </div>
  </div>
  
  <div class="form-group form-group-lg">
    <label class="col-sm-3 control-label" for="lg" style="height: 1cm;font-size:17px">Email ID</label>
    <div class="col-sm-9">
      <INPUT style="font-size:17px;" TYPE="text" id="emailId" placeholder="Enter your email id" class="form-control" maxlength="225"/>
      <hr style="height:1px;background-color:#DDD;">
      <button id="create" class="btn btn-success btn-block" style="height: 1cm;font-size:18px">Create</button>
    </div>
  </div>
  
</form>

<script>

	$(function(){

		 $('#usertype').click(function()
				 {
				   $('#apt_No').removeAttr("disabled");
				   $('#street').removeAttr("disabled");
				   $('#city').removeAttr("disabled");
				   $('#state').removeAttr("disabled");
				   $('#zip').removeAttr("disabled");
				   $('#phoneNo').removeAttr("disabled");
				   $('#emailId').removeAttr("disabled");
				   $('#type').val("user");
				 });
		 $('#admintype').click(function()
				 {
				   $('#apt_No').attr("disabled","disabled");
				   $('#street').attr("disabled","disabled");
				   $('#city').attr("disabled","disabled");
				   $('#state').attr("disabled","disabled");
				   $('#zip').attr("disabled","disabled");
				   $('#phoneNo').attr("disabled","disabled");
				   $('#emailId').attr("disabled","disabled");
				   $('#type').val("admin");
				 });
		$("#create").click(createHandler);
		
	});
	   
	function createHandler() {
		if ($("#type").val() === "user") 
		{
			
			var newAddr = {
					"street":$("#street").val(),
					"apt_No":$("#apt_No").val(),
					"city":$("#city").val(),
					"state":$("#state").val(),
					"zip":$("#zip").val()
			};
			var addrId = createAddress(newAddr);

			var newUser = {
					"firstName":$("#firstName").val(),
					"lastName":$("#lastName").val(),
					"userName":$("#userName").val(),
					"password":$("#password").val(),
					"addressId":addrId,
					"phoneNo":$("#phoneNo").val(),
					"emailId":$("#emailId").val()
			};
			createUser(newUser);

	} else {
			var newAdmin = {
				"firstName" : $("#firstName").val(),
				"lastName" : $("#lastName").val(),
				"userName" : $("#userName").val(),
				"password" : $("#password").val(),
			};
            createAdmin(newAdmin);
	}
    return false;
	}

	function createAddress(address) {
		var id = -1;
		$.ajax({
			url : "http://localhost:8080/Reservation/rest/address/create",
			type : "post",
			data : JSON.stringify(address),
			dataType : "json",
			contentType : "application/json",
			async : false,
			success : function(response) {
				id = response.id;
			}
		});
		return id;
	}

	function createUser(user) {

		$.ajax({
			url : "http://localhost:8080/Reservation/rest/user/create",
			type : "post",
			data : JSON.stringify(user),
			dataType : 'text',
			contentType : "application/json",
			async : false,
			success : function(response) {
				if (response == "exists") alert("Username already exists. Try again!"); 
				else location.href = "/Reservation/home.jsp";
				//return false;
		    }
		});
	}

	function createAdmin(admin) {
		
		$.ajax({
			url : "http://localhost:8080/Reservation/rest/user/createAdmin",
			type : "post",
			data : JSON.stringify(admin),
			dataType : 'text',
			contentType : 'application/json',
			async : false,
			success : function(response) {
				if (response == "exists") alert("Username already exists. Try again!"); 
				else location.href = "/Reservation/home.jsp";
				//return false;
			}
		});
	}
	
	
</script>
</div>

</body>
</html>
