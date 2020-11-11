<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cts.model.SurveyForm" %>
<%@ page import="com.cts.model.Faculty" %>
<%@ page import="com.cts.model.Department" %>

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
    color:#14171a;
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
	document.getElementById('personalDetForm').submit();
}



$(function(){
	$("#facCd").on("change", function(){
        var $target = $("#deptCd").val(""),facCd = $(this).val();
        
        $target
            .toggleClass("hidden", facCd === "")
            .find("option:gt(0)").addClass("hidden")
        	.siblings().filter("[data-type="+facCd+"]").removeClass("hidden"); 
    });
});



</script> 
</head>   
 <% List<Faculty> facultyList = (List<Faculty>) request.getAttribute("listFaculty");  %>
                                                                             	                                        
 
<body> 
		 <input type="hidden" id="list" value=<%=facultyList%> />  


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
             <form:form id="personalDetForm" action ="processDISurvey.html"  method="post" modelAttribute="user" >
             <input type="hidden" name="formid" id="formid" value="${form.id}"/>  
             <div class="form-row">	
                <div class="form-group col-md-2">
                <label >New Matric Number</label>
	                     <form:input path="newMatricNum"  class="form-control" />	                      
	             </div>
	             <div class="form-group col-md-2">
                <label >Old Matric Number</label>
	                     <form:input path="oldMatricNum"  class="form-control"/>	                      
	             </div>
	              <div class="form-group col-md-2">
	  				  <label >Age Group</label>
	                     <form:select path="ageGroupCd"  class="form-control" >
	                       <c:forEach items="${listAgeGroup}" var="listAgeGroup">
					      	  <form:option value ="${listAgeGroup.code}" label="${listAgeGroup.name}" />
				              </c:forEach>
	                       </form:select>
	                   </div>
	              <div class="form-group col-md-2">
                <label >Year of Study</label>
	                    <form:select path="yearOfStudy"  class="form-control" >
	                       <%for(int i=2;i<7;i++){ 
	                       		String val = "Year "+i;
	                       		if (i==6){
	                       			val =  "Year 6 or above";
	                       		}
	                       %>
	                       		
					      	  <form:option value ="<%=i %>" label="<%=val %>" />
				           <%} %>
	                       </form:select>
	             </div>
	             
             </div>
              <div class="form-row">	
              <div class="form-group col-md-2">
					    <label >Gender</label><br>
							<div class="custom-control custom-radio custom-control-inline">
							  <form:radiobutton path="gender"   id="mcq1" name="radio-all-mcq" class="custom-control-input" value="M" checked="true"/>
							  <label class="custom-control-label" for="mcq1">Male</label>
							</div>
							<div class="custom-control custom-radio custom-control-inline">
							  <form:radiobutton path="gender"  id="mcq2" name="radio-all-mcq" class="custom-control-input" value="F"  />
							  <label class="custom-control-label" for="mcq2">Female</label>
							</div>				 
					   </div>
              <div class="form-group col-md-2">
	  				  <label >Ethnic</label>
	                     <form:select path="ethnicCd"  class="form-control" >
	                       <c:forEach items="${listEthnic}" var="listEthnic">
					      	  <form:option value ="${listEthnic.code}" label="${listEthnic.name}" />
				              </c:forEach>
	                       </form:select>
	                   </div>			
              
              			  
					   <div class="form-group col-md-2">
	  				  <label >Nationality</label>
	                     <form:select path="nationalityCd"  class="form-control" >
	                       <c:forEach items="${listNationality}" var="listNationality">
					      	  <form:option value ="${listNationality.code}" label="${listNationality.name}" />
				              </c:forEach>
	                       </form:select>
	                   </div>				  
	  				 
	         </div>    
	          <div class="form-row">
	           <div class="form-group col-md-3">
	  				  <label >Faculty</label>
	                     <form:select path="faculty.code"  class="form-control" id="facCd" >
	                        <form:option value="" disabled="true" selected="true">Select faculty (if relevant)</form:option>
	                         <c:forEach items="${listFaculty}" var="listFaculty">
					      	  <form:option value ="${listFaculty.code}" label="${listFaculty.name}" />
				              </c:forEach>
	                       </form:select>
	                   </div>	
	                   
	             <div class="form-group col-md-3">
	  				  <label >Department</label>
	                     <form:select path="department.code"  class="form-control" id="deptCd">
	                     <form:option value="" disabled="true" selected="true">Select department (if relevant)</form:option>
	                     <% for (int i=0;i<facultyList.size();i++){ 
	                     	List<Department> deptList = facultyList.get(i).getDepartmentList();
	                     	for (int j=0;j<deptList.size();j++){
	                     	%>
	                     	 <form:option value ="<%=deptList.get(j).getCode()%>" data-type="<%=facultyList.get(i).getCode() %>" label="<%=deptList.get(j).getName()%>" />
	                     <%}} %>
	                     
	                       </form:select>
	                   </div>
	                 
	                   
    	 
	          </div>    
	          <div class="form-row">
	           <div class="form-group col-md-2">
	  				  <label >Latest GPA </label>
	                     <form:select path="gpa.code"  class="form-control"  >
	                       <c:forEach items="${listRstRange}" var="listRstRange">
					      	  <form:option value ="${listRstRange.code}" label="${listRstRange.name}" />
				              </c:forEach>
	                       </form:select>
	                   </div>	
	           <div class="form-group col-md-2">
	  				  <label >Latest CGPA </label>
	                     <form:select path="cgpa.code"  class="form-control"  >
	                       <c:forEach items="${listRstRange}" var="listRstRange">
					      	  <form:option value ="${listRstRange.code}" label="${listRstRange.name}" />
				              </c:forEach>
	                       </form:select>
	                   </div>	
	           </div>  
	         
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