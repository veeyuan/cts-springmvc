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
    color: #fff;
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


#success{
  border-style: solid;
  border-color: green;
  color:green;
  font-size:3rem;
  padding:30px;'
}

#success-icon{
	float: left;	
	margin-right:20px;
}

#failure{
  border-style: solid;
  border-color: #B90101;
  color:#B90101;
  font-size:3rem;
  padding:30px;'
}

#failure-icon{
	float: left;	
	margin-right:20px;
}

#smallMsg{
	font-size:1rem;
	color: #495057;
}
</style>
 
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
			 	 	<% if ("Y".equals(request.getAttribute("success"))){ %>
               		<div id="success">               		
               		<i id="success-icon" class="fa fa-check-circle fa-2x"> </i>               		
               		<p>Successfully changed!</p>
               	 	<p id="smallMsg">You may login using new password now.</p>
               		</div>
               		<%}else{ %>
               		<div id="failure"> 
               		<i id="failure-icon" class="fa fa-times-circle fa-2x"> </i>
               		<p>Failed to change</p>
               	 	<p id="smallMsg">The old password is incorrect. Please try again.</p>
               		</div>
               		<%} %>
				    </div>
				    
              
              
              <!-- /.card-body -->
              
            </div>
	         </div>                           
				 
            <!-- /.card -->
            </section> 
</body>    
</html>    