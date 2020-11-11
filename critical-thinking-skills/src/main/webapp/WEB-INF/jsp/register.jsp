<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.cts.ind.DictionaryManager" %>
<%@ page import="com.cts.ind.UserNameChecker" %>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Register</title>
<!--  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
 -->
 <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="css/register.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        
        <!-- Third party plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        <!-- Contact form JS-->
        <script src="assets/mail/jqBootstrapValidation.js"></script>
        <script src="assets/mail/contact_me.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
</head>
<%
    DictionaryManager dictionaryManager = new DictionaryManager();
	int langCd=dictionaryManager.getLanguageCd("English");
	String langDscp =  "ENG";
	if ("BM".equals(request.getParameter("language"))){
		langCd=dictionaryManager.getLanguageCd("Bahasa Melayu");;
		langDscp ="BM";
	}
    UserNameChecker userNameChecker = new UserNameChecker();
    String usernameList = userNameChecker.getUsernameList();
    String emailList = userNameChecker.getEmailList();
   
    %>
<script>
function loginUserNm(){
	var val=document.getElementById("login-usernm").value;
	var mssg_required = document.getElementById("login-usernm-error-req-msg");
	if (val==""){
		document.getElementById("login-usernm").className = "form-control is-invalid";
		mssg_required.style.display = "block";
	}else{
		document.getElementById("login-usernm").className = "form-control";
		mssg_required.style.display = "none";
	}
} 
function loginPswd(){
	var val=document.getElementById("login-pswd").value;
	var mssg_required = document.getElementById("login-pswd-error-req-msg");
	if (val==""){
		document.getElementById("login-pswd").className = "form-control is-invalid";
		mssg_required.style.display = "block";
		mssg_invalid.style.display  = "none";
	}else{
		document.getElementById("login-pswd").className = "form-control";
		mssg_required.style.display = "none";
	}
}
function checkName(){
	var val=document.getElementById("fullname").value;
	var mssg_required = document.getElementById("name-error-req-msg");
	if (val==""){
		document.getElementById("fullname").className = "form-control is-invalid";
		mssg_required.style.display = "block";
	}else{
		document.getElementById("fullname").className = "form-control is-valid";
		mssg_required.style.display = "none";
		return true;

	}
	return false;
}

function checkEmail(){
	var val=document.getElementById("emailaddr").value;
	var mssg_required = document.getElementById("email-error-req-msg");
	var mssg_invalid = document.getElementById("email-error-inv-msg");
	var mssg_unique = document.getElementById("email-used-msg");

	if (val==""){
		document.getElementById("emailaddr").className = "form-control is-invalid";
		mssg_required.style.display = "block";
		mssg_invalid.style.display  = "none";
		mssg_unique.style.display = "none";
		return false;
	}else{
		mssg_required.style.display  = "none";
		if(emailIsValid(val)){
			mssg_invalid.style.display  = "none";
			if (!isUnique(val,"emaillist")){
				document.getElementById("emailaddr").className = "form-control is-invalid";
				mssg_unique.style.display = "block";
			}else{
				mssg_unique.style.display = "none";
				document.getElementById("emailaddr").className = "form-control is-valid";
				return true;
			}
			
		}else{
			document.getElementById("emailaddr").className = "form-control is-invalid";
			mssg_invalid.style.display = "block";
		}
	}
	return false;
}

function emailIsValid (email) {
	  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
	}


function checkUserNm(){
	var val=document.getElementById("usernm").value;
	var mssg_required = document.getElementById("usernm-error-req-msg");
	var mssg_unique = document.getElementById("usernm-used-msg");

	if (val==""){
		mssg_unique.style.display = "none";
		document.getElementById("usernm").className = "form-control is-invalid";
		mssg_required.style.display = "block";
	}else{
		mssg_required.style.display = "none";
		
		if (!isUnique(val,"usernmlist")){
			document.getElementById("usernm").className = "form-control is-invalid";
			mssg_unique.style.display = "block";
		}else{
			mssg_unique.style.display = "none";
			document.getElementById("usernm").className = "form-control is-valid";
			return true;

		}
			
		
		
	}
	return false;
} 

function isUnique(value,list){
	var str = document.getElementById(list).value;
	var arr = str.split(",");
	for(i = 0;i < arr.length;i++){
		if (arr[i]==value){
			return false;
		}		
	}
	return true;
	 
}

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

function register(){
	if ( checkEmail() && checkUserNm() && checkPswd() && checkConfPswd()){
		return true;
	}else{
		alert("Please make sure all fields are filled correctly.");
		return false;
	}
}

</script>

<body>
<div class="container register">
                <div class="row">
                    <div class="col-md-3 register-left">
                        <img style="width:80px; height:80px" src="assets/img/index/idea-icon.png" alt=""/>
                        <h3><%=dictionaryManager.getTerm("index.authentication.title",langCd) %></h3>
                        <p><%=dictionaryManager.getTerm("index.authentication.dscp",langCd) %>
                        <br> - Thomas A. Edison -</p>
                       
                    </div>
                    <div class="col-md-9 register-right">
                        <ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#login" role="tab" aria-controls="home" aria-selected="true"><%=dictionaryManager.getTerm("index.authentication.login",langCd) %></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#register" role="tab" aria-controls="profile" aria-selected="false"><%=dictionaryManager.getTerm("index.authentication.register",langCd) %></a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="home-tab">
                                <h3 class="register-heading"><%=dictionaryManager.getTerm("index.authentication.login",langCd) %></h3>
                                <div class="row register-form">
                                    <div class="">
                                     <form id="loginForm" action="loginProcess.html" method="post">
                                        <div class="form-group">
                                            <input type="text" class="form-control" placeholder="<%=dictionaryManager.getTerm("index.authentication.username",langCd) %> " value="" id="login-usernm" onchange="loginUserNm()" name="username"/>
                                            <div style="display:none;text-align: left;}" id="login-usernm-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.usernm",langCd) %></div>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control" placeholder=<%=dictionaryManager.getTerm("index.authentication.pswd",langCd) %> value=""  id="login-pswd" onchange="loginPswd()" name="password"/>
                                            <div style="display:none;text-align: left;}" id="login-pswd-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.pswd",langCd) %></div>
                                        </div>
                                        <div class="form-group">	
                                    	<div class="custom-control custom-radio custom-control-inline">
										  <input type="radio"  id="customRadio2" name="roleCd" class="custom-control-input" value="TEST-TAKER" checked>
										  <label class="custom-control-label" for="customRadio2">Normal</label>
										</div>
                                    	 <div class="custom-control custom-radio custom-control-inline">
										  <input type="radio"  id="customRadio1" name="roleCd" class="custom-control-input" value="ADMIN">
										  <label class="custom-control-label" for="customRadio1">Admin</label>
										</div>
 										</div>
									     <input type="submit" class="btnRegister"  value="<%=dictionaryManager.getTerm("index.authentication.login",langCd) %> "/>
									 </form>
									 </div>
									
                                </div>
                            </div>
                            <div class="tab-pane fade show" id="register" role="tabpanel" aria-labelledby="profile-tab">
                                <h3  class="register-heading"><%=dictionaryManager.getTerm("index.authentication.register",langCd) %></h3>
                                <div class="row register-form">
                                <form id="registerForm" action="registerProcess.html" onsubmit="return register()" method="post">
                                    <div class="col-md-10">
                                    	
                                        <div class="form-group">
                                            <input type="text" name="fullname" class="form-control" id="fullname" placeholder="<%=dictionaryManager.getTerm("index.authentication.fullname",langCd) %>"   />
<%--                                             <div style="display:none;text-align: left;}" id="name-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.nm",langCd) %></div>
 --%>                                        </div>
                                        
                                       
                                        <div class="form-group">
                                            <input type="hidden" id="emaillist" value=<%=emailList%> />                                   	                                        
                                            <input type="text" class="form-control" id="emailaddr" name="emailaddr" onchange="checkEmail()"placeholder="<%=dictionaryManager.getTerm("index.authentication.email",langCd) %> *" value=""  />
                                            <div style="display:none;text-align: left;}" id="email-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.email",langCd) %></div>
                                            <div style="display:none;text-align: left;}" id="email-error-inv-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.inv.email",langCd) %></div>
                                            <div style="display:none;text-align: left;}" id="email-used-msg" class="invalid-feedback">This email has been registered</div>
                                            
                                        </div>


                                        
                                        
										
                                     </div>


                                    
                                    <div class="col-md-10">
											
                                    	<div class="form-group">
                                    	     <input type="hidden" id="usernmlist" value=<%=usernameList%> />                                   	
                                            <input type="text" onchange="checkUserNm();" name="registerUserName" maxlength="45" minlength="3" class="form-control" placeholder="<%=dictionaryManager.getTerm("index.authentication.username",langCd) %>  *" value="" id="usernm" onchange="isUnique()"/>
                                            <div style="display:none;text-align: left;}" id="usernm-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.usernm",langCd) %></div>
                                            <div style="display:none;text-align: left;}" id="usernm-used-msg" class="invalid-feedback">This username has been used</div>
                                            
                                        </div>
                                        <div class="form-group">
                                            <input type="password" name="registerPswd" maxlength="45" class="form-control" placeholder="<%=dictionaryManager.getTerm("index.authentication.pswd",langCd) %>  *" value="" id="pswd" onchange="checkPswd()"/>
                                            <div style="display:none;text-align: left;}" id="pswd-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.pswd",langCd) %></div>
                                            <div style="display:none;text-align: left;}" id="pswd-error-inv-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.inv.specialChar",langCd) %></div>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" name="confPswd" class="form-control" placeholder="<%=dictionaryManager.getTerm("index.authentication.confirmpswd",langCd) %>  *" value="" id="confpswd" onchange="checkConfPswd()"/>
                                             <div style="display:none;text-align: left;}" id="confpswd-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.confirmpswd",langCd) %></div>
                                            <div style="display:none;text-align: left;}" id="confpswd-error-inv-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.inv.confirmpswd",langCd) %></div>
                                        </div>
                                        <div class="form-group">
                                         <input class="form-check-input" type="checkbox" value="" id="isUmStudent" name="isGuest" >
										  <label class="form-check-label" for="isGuest">
										    Participate as Guest
										  </label>
                                    	</div>
                                    	
                                       <button class="btnRegister" type="submit" ><%=dictionaryManager.getTerm("index.authentication.register",langCd) %></button>
                                    </form>
                                    </div>
                                    
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            
   </body>
   </html>