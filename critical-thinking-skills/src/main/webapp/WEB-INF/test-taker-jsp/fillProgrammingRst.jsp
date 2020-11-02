<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cts.model.ProgrammingResults" %>


<html>    
<head>
<!--  jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- Isolated Version of Bootstrap, not needed if your site already uses Bootstrap -->
<link rel="stylesheet" href="https://formden.com/static/cdn/bootstrap-iso.css" />

<!-- Bootstrap Date-Picker Plugin -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>
    
 <style>

#testLink{
	background-color: transparent;
    color: #6c757d;
}

#dashboardLink{
    background-color: transparent;
    color: #6c757d;
}

#viewRstLink{
   background-color: transparent;
    color: #6c757d;
}

#manageProfileLink{
   
    background-color: #FED136;
    color: #fff;
}

#instruction{
	line-height: 2.5;
}

@media (min-width: 1200px) {
   .modal-xlg {
      width: 90%; 
   }
}
.hidden{
    display:none;
}
</style>
<script>

function submit(){
	document.getElementById('rstForm').submit();
}


</script> 
</head>   
                                                                             	                                        
 
<body> 


 <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">Manage Profile</h1>
          </div><!-- /.col -->
          <!-- <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard v1</li>
            </ol>
          </div> --><!-- /.col -->
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
                  ${form.formName}
                </h3>
               
              </div>
              <!-- /.card-header -->
              <div class="card-body">
             <form:form id="rstForm" action ="processRstSurvey.html"  method="post" modelAttribute="form" >
             <form:hidden path = "id" value = "${form.id}" />
            <table class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col">Course Code</th>
				      <th scope="col">Course Name</th>
				      <th scope="col">Results</th>
				      
				    </tr>
				  </thead>
				  <tbody>                 
				 
                 <c:forEach items="${listProgrammingRst}" var="course" varStatus="status">		
             
					 <tr>
						<form:hidden path = "programmingRstList[${status.index}].code" value = "${course.code}" />
			 			<td>${course.code}</td>
      					<td> ${course.name}</td>
                  		<td>
                  		<form:select path="programmingRstList[${status.index}].result"  class="form-control">
	                       <form:option value ="A+" label="A+" />
	                       <form:option value ="A" label="A" />
	                       <form:option value ="A-" label="A-" />
	                       <form:option value ="B+" label="B+" />	                       
	                       <form:option value ="B" label="B" />
	                       <form:option value ="B-" label="B-" />
                           <form:option value ="C+" label="C+" />
	                       <form:option value ="C" label="C" />	                       
	                       <form:option value ="C-" label="C-" />
	                       <form:option value ="D+" label="D+" />	    
	                       <form:option value ="D" label="D" />	                       
	                       <form:option value ="F" label="F" />	                       
	                       <form:option value ="NOT TAKEN" label="Not taken yet" />	                       	                                          
	                       </form:select>
                  		</td>
                  		
   					 </tr>	 
                </c:forEach>
                 </tbody>
				</table>
	         
               </form:form>   
             
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button  id="btn-submit-spec"  onclick="submit()" type="button" class="btn btn-info float-right"><i class="fas fa-check"></i> Submit </button>  
               
              </div>
            </div>
	                       
				 
            <!-- /.card -->
            </section>
            
           
</body>    
</html>    