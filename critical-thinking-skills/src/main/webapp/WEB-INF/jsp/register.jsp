<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.cts.ind.DictionaryManager" %>
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
	}
}

function checkEmail(){
	var val=document.getElementById("emailaddr").value;
	var mssg_required = document.getElementById("email-error-req-msg");
	var mssg_invalid = document.getElementById("email-error-inv-msg");
	if (val==""){
		document.getElementById("emailaddr").className = "form-control is-invalid";
		mssg_required.style.display = "block";
		mssg_invalid.style.display  = "none";
	}else{
		mssg_required.style.display  = "none";
		if(emailIsValid(val)){
			document.getElementById("emailaddr").className = "form-control is-valid";
			mssg_invalid.style.display  = "none";
		}else{
			document.getElementById("emailaddr").className = "form-control is-invalid";
			mssg_invalid.style.display = "block";
		}
	}
}

function emailIsValid (email) {
	  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
	}
	
function checkStaffID(){
	var val=document.getElementById("staff").value;
	alert(val);
	var mssg_required = document.getElementById("staff-error-req-msg");
	var mssg_invalid = document.getElementById("staff-error-inv-msg");
	if (val==""){
		document.getElementById("staffid").className = "form-control is-invalid";
		mssg_required.style.display = "block";
		mssg_invalid.style.display  = "none";
	}else{
		mssg_required.style.display  = "none";

		if(isValidCharacter(val)){
			document.getElementById("staffid").className = "form-control is-valid";
			mssg_invalid.style.display  = "none";

		}else{
			document.getElementById("staffid").className = "form-control is-invalid";
			mssg_invalid.style.display = "block";

		}
	}
}

function checkUserNm(){
	var val=document.getElementById("usernm").value;
	var mssg_required = document.getElementById("usernm-error-req-msg");
	if (val==""){
		document.getElementById("usernm").className = "form-control is-invalid";
		mssg_required.style.display = "block";
	}else{
		document.getElementById("usernm").className = "form-control is-valid";
		mssg_required.style.display = "none";
	}
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
		}else{
			document.getElementById("pswd").className = "form-control is-invalid";
			mssg_invalid.style.display = "block";
		}
	}
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
		}else{
			document.getElementById("confpswd").className = "form-control is-invalid";
			mssg_invalid.style.display = "block";
		}
	}

}



</script>
<%
    DictionaryManager dictionaryManager = new DictionaryManager();
    String strLang="ENG";
    if ("BM".equals(request.getParameter("language"))){
    	strLang="BM";
    }
   
    %>
<body>
<div class="container register">
                <div class="row">
                    <div class="col-md-3 register-left">
                        <img src="https://image.ibb.co/n7oTvU/logo_white.png" alt=""/>
                        <h3><%=dictionaryManager.getTerm("index.authentication.title",strLang) %></h3>
                        <p><%=dictionaryManager.getTerm("index.authentication.dscp",strLang) %></p>
                    </div>
                    <div class="col-md-9 register-right">
                        <ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#login" role="tab" aria-controls="home" aria-selected="true"><%=dictionaryManager.getTerm("index.authentication.login",strLang) %></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#register" role="tab" aria-controls="profile" aria-selected="false"><%=dictionaryManager.getTerm("index.authentication.register",strLang) %></a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="home-tab">
                                <h3 class="register-heading"><%=dictionaryManager.getTerm("index.authentication.login",strLang) %></h3>
                                <div class="row register-form">
                                    <div class="">
                                     <form id="loginForm" action="loginProcess.html" method="post">
                                        <div class="form-group">
                                            <input type="text" class="form-control" placeholder="<%=dictionaryManager.getTerm("index.authentication.username",strLang) %> " value="" id="login-usernm" onchange="loginUserNm()" name="username"/>
                                            <div style="display:none;text-align: left;}" id="login-usernm-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.usernm",strLang) %></div>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control" placeholder=<%=dictionaryManager.getTerm("index.authentication.pswd",strLang) %> value=""  id="login-pswd" onchange="loginPswd()" name="password"/>
                                            <div style="display:none;text-align: left;}" id="login-pswd-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.pswd",strLang) %></div>
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
									     <input type="submit" class="btnRegister"  value="<%=dictionaryManager.getTerm("index.authentication.login",strLang) %> "/>
									 </form>
									 </div>
									
                                </div>
                            </div>
                            <div class="tab-pane fade show" id="register" role="tabpanel" aria-labelledby="profile-tab">
                                <h3  class="register-heading"><%=dictionaryManager.getTerm("index.authentication.register",strLang) %></h3>
                                <div class="row register-form">
                                    <div class="col-md-10">
                                    	
                                        <div class="form-group">
                                            <input type="text"  class="form-control" id="fullname" onchange="checkName()" placeholder="<%=dictionaryManager.getTerm("index.authentication.fullname",strLang) %> *" required value="" />
                                            <div style="display:none;text-align: left;}" id="name-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.nm",strLang) %></div>
                                        </div>
                                        
                                       
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="emailaddr" onchange="checkEmail()"placeholder="<%=dictionaryManager.getTerm("index.authentication.email",strLang) %> *" value=""  />
                                            <div style="display:none;text-align: left;}" id="email-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.email",strLang) %></div>
                                            <div style="display:none;text-align: left;}" id="email-error-inv-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.inv.email",strLang) %></div>
                                            
                                        </div>
                                         <div class="form-group">
                                            <select   class="form-control" >
                                                <option class="hidden" selected disabled>Discipline</option>
                                                  <c:forEach items="${listUni}" var="uni">
												        <option value="${uni.id}">${uni.name}</option>
												    </c:forEach> 
										<option id="other-university" value='others'>Other discipline</option>
                                            </select>
                                            
                                           
                                        </div>
                                     
                                        <div class="form-group">
                                            <select  class="form-control">
                                                <option class="hidden"  selected disabled>Category</option>
                                                <c:forEach items="${listDep}" var="dep">
												        <option value="${dep.id}">${dep.name}</option>
												    </c:forEach>
                                            </select>
                                        </div>

                                        
                                        
										
                                     </div>


                                    
                                    <div class="col-md-10">
<%-- 									<div class="form-group">	
                                    	<div class="custom-control custom-radio custom-control-inline">
										  <input type="radio" onclick="changeRole(this);" id="customRadioInline2" name="customRadioInline1" class="custom-control-input" value="stu" checked>
										  <label class="custom-control-label" for="customRadioInline2"><%=dictionaryManager.getTerm("index.authentication.student",strLang) %></label>
										</div>
                                    	 <div class="custom-control custom-radio custom-control-inline">
										  <input type="radio" onclick="changeRole(this);" id="customRadioInline1" name="customRadioInline1" class="custom-control-input" value="lec">
										  <label class="custom-control-label" for="customRadioInline1"><%=dictionaryManager.getTerm("index.authentication.lecturer",strLang) %></label>
										</div>
 									</div> 
--%>
											
                                    	<div class="form-group">
                                            <input type="text" maxlength="10" minlength="10" class="form-control" placeholder="<%=dictionaryManager.getTerm("index.authentication.username",strLang) %>  *" value="" id="usernm" onchange="checkUserNm()"/>
                                            <div style="display:none;text-align: left;}" id="usernm-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.usernm",strLang) %></div>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" maxlength="10" minlength="10" class="form-control" placeholder="<%=dictionaryManager.getTerm("index.authentication.pswd",strLang) %>  *" value="" id="pswd" onchange="checkPswd()"/>
                                            <div style="display:none;text-align: left;}" id="pswd-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.pswd",strLang) %></div>
                                            <div style="display:none;text-align: left;}" id="pswd-error-inv-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.inv.specialChar",strLang) %></div>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control" placeholder="<%=dictionaryManager.getTerm("index.authentication.confirmpswd",strLang) %>  *" value="" id="confpswd" onchange="checkConfPswd()"/>
                                             <div style="display:none;text-align: left;}" id="confpswd-error-req-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.req.confirmpswd",strLang) %></div>
                                            <div style="display:none;text-align: left;}" id="confpswd-error-inv-msg" class="invalid-feedback"><%=dictionaryManager.getTerm("index.errormsg.inv.confirmpswd",strLang) %></div>
                                        </div>
                                        
                                        <input type="submit" class="btnRegister"  value="<%=dictionaryManager.getTerm("index.authentication.register",strLang) %> "/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            
   </body>
   </html>