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
#changePswdLink{
	background-color: transparent;
    color: #6c757d;
}

#manageAdminLink{
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
</style>
<script>
function setOption(){
	var checked = $("#tbloption input[type=checkbox]:checked").length;	 
    if (checked == 0) {
    	alert("Please select at least one admin to access the system.");
    }else{
    	document.getElementById('hideGroupForm').submit(); 
    }
}

function addAdmin(){
	var input = document.getElementById('newusername').value;
	var input2 = document.getElementById('password').value;
	if (input == "" || input2 ==""){
		alert("Please fill in to add new admin.");
	}else{
		document.getElementById('addAdminForm').submit(); 
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
            <h1 id="title" class="m-0 text-dark">Manage Admin</h1>
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
                 View Admin
                </h3>
			   
			   

              </div>
              <!-- /.card-header -->
              <div class="card-body">
               <form id="hideGroupForm" method="post" action="setAdminAccessibility.html"> 
               <table id="tbloption" class="table table-hover">
				  <thead>
				    <tr>
				      
				      
				      <th scope="col">No</th>
				      <th scope="col">User Name</th>
				      <th scope="col">Role</th>				      
				      <th style="width:30%"scope="col">Enable Access</th>
				    </tr>
				  </thead>
				  <tbody> 
				  <%List<Admin> listAdmin = (List<Admin>) request.getAttribute("listAdmin"); 
				  	int ind = 0;
				  	int num=1;%>
				   <c:forEach items="${listAdmin}" var="listAdmin">				
				  
				  	 <tr>
				  	 <td><%=num %></td>
				  	 <td>${listAdmin.username}</td>
				  	 <td>${listAdmin.roleCd}</td>
				  	 
				  	 	
				  	 <td id="checkboxCol">	
					 	<div class="icheck-primary d-inline ml-2">
					 	<% if (listAdmin.get(ind).isHidden()) {%>
					 	<input type="checkbox" name="hideGroupList" value="${listAdmin.id}" id="${listAdmin.id}" >
					 	<%}else{ %>
					 	<input type="checkbox" name="hideGroupList" value="${listAdmin.id}" id="${listAdmin.id}" checked>
					 	<%} %>
					 	
					 	<label  for="${listAdmin.id}"> </label>
					 	</div>					 	
					 </td>	   
					 </tr> 
					 <%ind++; 
					 num++;%>
				  </c:forEach>
					          
                 </tbody>
				</table> 
			 </form> 
			 		 
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button id="btn-addquestionset" onclick ="setOption()" type="submit" class="btn btn-info float-right"><i class="fas fa-edit"></i> Set Admin Accessibility</button>
                            </div>
            </div>
             <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                 Add Admin
                </h3>

              </div>
              <!-- /.card-header -->
             
              
			 	 <div class="card-body"> 
			 	 <form:form id="addAdminForm" action ="addAdmin.html"  method="post" modelAttribute="newAdmin" >
			 	 
			 	<div class="form-row">
			 	<div class="form-group col-md-2">
	  				  <label >New Admin</label>
	                     <form:input path="username"  id="newusername" class="form-control"/>	                       	                   	
				 </div>
				 <div class="form-group col-md-2">
	  				  <label >Temporary Password</label>
	                     <form:input path="password"  id="password" class="form-control" />	                       	                   	
				 </div>
	           	- <div class="form-group col-md-2">
	  				  <label >Role</label>
	                     <form:select path="roleCd"  class="form-control" id="roleCd" >
	                       <c:forEach items="${listRole}" var="listRole">
					      	  <form:option value ="${listRole.code}" label="${listRole.code}" />
				              </c:forEach>
	                       </form:select>
	                   </div>	 
				    </div>
				    </form:form>
				    </div>
				    <div class="card-footer clearfix">              
                <button id="btn-addquestionset" type="submit" class="btn btn-info float-right" onclick="addAdmin()"><i class="fas fa-plus"></i> Add Admin</button>
              </div>
              
              
              <!-- /.card-body -->
              
            </div>
	         </div>                           
				 
            <!-- /.card -->
            </section> 
</body>    
</html>    