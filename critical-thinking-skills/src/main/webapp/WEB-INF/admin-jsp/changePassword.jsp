<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.Admin" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>


<html>    
<head>    
<style>
.searchfilter{
	width:80%;
	border-radius: 5px;
	margin-left:3%;
	margin-top:50px;
	background: rgba(0, 0, 0, 0.5);
	padding-top:16px;
	padding-left:40px;
	padding-bottom:0;
	padding-right:0;
	justify-content:space-between;
	
}
#manageOptLink{
	background-color: transparent;
    color: #6c757d;
}

#manageLink{
	background-color: transparent;
    color: #6c757d;
}

#dashboardLink{
    background-color: transparent;
    color: #6c757d;
}

#addLink{
   background-color: transparent;
    color: #6c757d;
}

#gradeLink{
   background-color: transparent;
    color: #6c757d;
}

#manageAdminLink{
	background-color: transparent;
    color: #6c757d;
}

#changePswdLink{
	background-color: #FED136;
    color: #14171a;
}

a {
  color: inherit; /* blue colors for links too */
  text-decoration: inherit; /* no underline */
}

#checkboxCol{
	width: 30px;
  	overflow: hidden;
}

.form-check{
	margin:3px;
	font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color:white;
}
.form-check-label{
	margin-left:3px;
	margin-top:2px;
}
.form-check-input{
	width: 20px; 
    height: 20px; 
}
#checkboxCol{
	width: 30px;
  	overflow: hidden;
}

button{
	margin-right:5px;
}

.card-body{
	margin-left:3%;
}
</style>
<script>

function checkPswd(){
	var val=document.getElementById("pswd").value;
	var mssg_required = document.getElementById("pswd-error-req-msg");
	var mssg_invalid = document.getElementById("pswd-error-inv-msg");
	if (val==""){
		document.getElementById("pswd").className = "form-control is-invalid";
		mssg_required.style.display = "block";
		mssg_invalid.style.display  = "none";
	}else{
		mssg_required.style.display  = "none";
		if(val.match(/^[0-9a-z]+$/)){
			document.getElementById("pswd").className = "form-control is-valid";
			mssg_invalid.style.display  = "none";
			checkConfPswd();
			return true;

		}else{
			document.getElementById("pswd").className = "form-control is-invalid";
			mssg_invalid.style.display = "block";
		}
	}
	checkConfPswd();
	return false;
}

function checkConfPswd(){
	var val=document.getElementById("confpswd").value;
	var pswd=document.getElementById("pswd").value;
	var mssg_required = document.getElementById("confpswd-error-req-msg");
	var mssg_invalid = document.getElementById("confpswd-error-inv-msg");
	if (val==""){
		document.getElementById("confpswd").className = "form-control is-invalid";
		mssg_required.style.display = "block";
		mssg_invalid.style.display  = "none";
	}else{
		mssg_required.style.display  = "none";
		if(val==pswd){
			document.getElementById("confpswd").className = "form-control is-valid";
			mssg_invalid.style.display  = "none";
			return true;
		}else{
			document.getElementById("confpswd").className = "form-control is-invalid";
			mssg_invalid.style.display = "block";
		}
	}
	return false;

}

function checkOldPswd(){
	var val=document.getElementById("oldpswd").value;
	var mssg_required = document.getElementById("oldpswd-error-req-msg");
	if (val==""){
		document.getElementById("oldpswd").className = "form-control is-invalid";
		mssg_required.style.display = "block";
		return false;
	}else{
		document.getElementById("oldpswd").className = "form-control is-valid";
		mssg_required.style.display = "none";
		return true;
	}
}

function submitChange(){
	if (checkOldPswd() && checkPswd() && checkConfPswd()){
		document.getElementById("changePswdForm").submit();
	}else{
		alert("Please make sure all fields are filled correctly.");
	}
}

</script>  
</head>    
<body> 

  <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">Change Password</h1>
          </div>
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->
    <section class="content">
	<div class="container-fluid">
           
             <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                 Change Password
                </h3>

              </div>
              <!-- /.card-header -->
             
              
			 	 <div class="card-body"> 
			 	 <form id="changePswdForm" action ="changePassword.html"  method="post"  >
			 	 
			 	<div class="form-row">
			 	<div class="form-group col-md-2">
	  				  <label >Old Password</label>
	                     <input type="password" name="oldpswd"  id="oldpswd" class="form-control" onchange="checkOldPswd()"/>	 
	                    <div style="display:none;text-align: left;}" id="oldpswd-error-req-msg" class="invalid-feedback">Old Password is required</div>
	                    
                                                              	                   	
				 </div>
				 </div>
				 <div class="form-row">
				 <div class="form-group col-md-2">
	  				  <label >New Password</label>
	                     <input type="password" name="newpswd"  id="pswd" class="form-control" onchange="checkPswd()"/>	
	                      <div style="display:none;text-align: left;}" id="pswd-error-req-msg" class="invalid-feedback">Password is required</div>
                          <div style="display:none;text-align: left;}" id="pswd-error-inv-msg" class="invalid-feedback">Special Character is not allowed</div>                       	                   	
				 </div>
				 </div>
				 <div class="form-row">
				 <div class="form-group col-md-2">
				 <label >Confirm Password</label>
				 <input type="password" name="confPswd" class="form-control" value="" id="confpswd" onchange="checkConfPswd()"/>
					<div style="display:none;text-align: left;}" id="confpswd-error-req-msg" class="invalid-feedback">Confirm Password is required</div>
					<div style="display:none;text-align: left;}" id="confpswd-error-inv-msg" class="invalid-feedback">Should be the same as Password</div>
                                       
				 </div>
	           		 
				    </div>
				    </form>
				    </div>
				    <div class="card-footer clearfix">              
                <button id="btn-addquestionset" type="submit" class="btn btn-info float-right" onclick="submitChange()"><i class="fas fa-edit"></i> Change Password</button>
              </div>
              
              
              <!-- /.card-body -->
              
            </div>
	         </div>                           
				 
            <!-- /.card -->
            </section> 
</body>    
</html>    