<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.Question" %>
<%@ page import="java.util.List" %>

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
	background-color: #FED136;
    color: #fff;
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
</style>
<script>
function getOptionDetails(group){
	document.getElementById('group').value=group;
	document.getElementById('optionDetForm').submit();
}
</script>  
</head>    
<body> 

  <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">Manage Option</h1>
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
                  Option Category
                </h3>
			   
			   

              </div>
              <!-- /.card-header -->
              <div class="card-body">
               <form id="optionDetForm" method="post" action="listOption.html"> 
			   <input type="hidden" name="group" id="group"/>
                
              <table class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col">Option Group</th>
				     
				    </tr>
				  </thead>
				  <tbody> 
				  	 <tr><td  onclick="getOptionDetails(this.innerHTML)" >Discipline (Test Specification) </td></tr>	
				  	 <tr><td  onclick="getOptionDetails(this.innerHTML)" >Category (Test Specification) </td></tr>				     				  	 			     
					 <tr><td  onclick="getOptionDetails(this.innerHTML)" >High Order Thinking Skills Component</td></tr>
					 <tr><td  onclick="getOptionDetails(this.innerHTML)" >Faculty</td></tr>	
					 <tr><td  onclick="getOptionDetails(this.innerHTML)" >Department </td></tr>	 
					 <tr><td  onclick="getOptionDetails(this.innerHTML)" >Programming Course </td></tr>	                 
                 </tbody>
				</table>
			 </form> 
			 		 
              </div>
              <!-- /.card-body -->
              
            </div>
	         </div>                           
				 
            <!-- /.card -->
            </section> 
</body>    
</html>    