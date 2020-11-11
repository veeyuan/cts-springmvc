<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.Option" %>
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
	background-color: #FED136;
    color:#14171a;
}

#manageLink{
	background-color: transparent;
    color: #6c757d;
}

#dashboardLink{
    background-color: transparent;
    color: #6c757d;
}
#changePswdLink{
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
    	alert("Please select at least one option to be shown");
    }else{
    	document.getElementById('hideGroupForm').submit(); 
    }
}

function addOption(){
	var input = document.getElementById('optionDscp').value;
	if (input == ""){
		alert("Please fill in to add new option.")
	}else{
		document.getElementById('addOptionForm').submit(); 
	}
}

function addDeptOption(){
	var input = document.getElementById('deptDscp').value;
	if (input == ""){
		alert("Please fill in to add new department.")
	}else{
		document.getElementById('addDeptForm').submit(); 
	}
}

function addCourseOption(){
	var input = document.getElementById('courseCd').value;
	var input2 = document.getElementById('courseNm').value;
	if (input == "" || input2 ==""){
		alert("Please fill in to add new Programming Course.")
	}else{
		document.getElementById('addCourseForm').submit(); 
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
                 ${title}
                </h3>
			   
			   

              </div>
              <!-- /.card-header -->
              <div class="card-body">
               <form id="hideGroupForm" method="post" action="hideOptions.html"> 
			   <input type="hidden" name="varName" id="varName" value="${varName}"/>
              <table id="tbloption" class="table table-hover">
				  <thead>
				    <tr>
				      
				      
				      <% if (StringUtils.containsIgnoreCase(request.getAttribute("title").toString(),"department")){ %>				      
				      <th scope="col">Faculty</th>
				      <th scope="col">Department Code</th>
				      <th scope="col">Department</th>
				      <%}else{ %>
				      <th scope="col">Code</th>
				      <th scope="col">Description</th>
				      <%} %>
				      <th style="width:30%"scope="col">Show Option</th>
				    </tr>
				  </thead>
				  <tbody> 
				  <%List<Option> optionList = (List<Option>) request.getAttribute("listOption"); 
				  	int ind = 0;%>
				   <c:forEach items="${listOption}" var="option">				
				  
				  	 <tr>
				  	 <% if (StringUtils.containsIgnoreCase(request.getAttribute("title").toString(),"department")){ %>
				  	 <td>${option.facultyDscp}</td>
				  	 <td>${option.code}</td>
				  	 <td>${option.name}</td>
				  	 <%}else{ %>
				  	 <td>${option.code}</td>
				  	 <td>${option.name}</td>
				  	 <%} %>
				  	 	
				  	 <td id="checkboxCol">	
					 	<div class="icheck-primary d-inline ml-2">
					 	<% if (optionList.get(ind).isHidden()) {%>
					 	<input type="checkbox" name="hideGroupList" value="${option.code}" id="${option.code}" >
					 	<%}else{ %>
					 	<input type="checkbox" name="hideGroupList" value="${option.code}" id="${option.code}" checked>
					 	<%} %>
					 	
					 	<label  for="${option.code}"> </label>
					 	</div>					 	
					 </td>	   
					 </tr> 
					 <%ind++; %>
				  </c:forEach>
					          
                 </tbody>
				</table>
			 </form> 
			 		 
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button id="btn-addquestionset" onclick ="setOption()" type="submit" class="btn btn-info float-right"><i class="fas fa-edit"></i> Set Options</button>
                            </div>
            </div>
             <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                 Add Option
                </h3>

              </div>
              <!-- /.card-header -->
             
              
			 	<% if (StringUtils.containsIgnoreCase(request.getAttribute("title").toString(),"department")){ %>	
			 	 <div class="card-body"> 
			 	 <form id="addDeptForm" method="post" action="addDepartment.html"> 
			 	 <input type="hidden" name="varName" id="varName" value="${varName}"/>	
			 	<div class="form-row">
			 	<div class="form-group col-md-4">
	  				  <label >New Department</label>
	                     <input name="deptDscp"  id="deptDscp" class="form-control"  >	                       	                   	
				    </div>
	           	<div class="form-group col-md-3">
	  				  <label >Faculty</label>
	                     <select name="facultyCd"  class="form-control" id="facCd" >
	                       <c:forEach items="${listFaculty}" var="listFaculty">
					      	  <option value ="${listFaculty.code}" label="${listFaculty.name}" />
				              </c:forEach>
	                       </select>
	                   </div>	
				    </div>
				    </form>
				    </div>
				    <div class="card-footer clearfix">              
                <button id="btn-addquestionset" type="submit" class="btn btn-info float-right" onclick="addDeptOption()"><i class="fas fa-plus"></i> Add Option</button>
              </div>
              <%}else if (StringUtils.containsIgnoreCase(request.getAttribute("title").toString(),"programming")){ %>
               <div class="card-body"> 
			 	 <form id="addCourseForm" method="post" action="addCourse.html"> 
			 	 <input type="hidden" name="varName" id="varName" value="${varName}"/>			 	 
			 	<div class="form-row">
			 	<div class="form-group col-md-2">
	  				  <label >Course Code</label>
	                     <input name="courseCd"  id="courseCd" class="form-control"  >	                       	                   	
				    </div>
	           	<div class="form-group col-md-4">
	  				  <label >Course Name</label>
	                     <input name="courseNm"  id="courseNm" class="form-control"  >	                       	                   	
				    </div>	
				    </div>
				    </form>
				    </div>
				    <div class="card-footer clearfix">              
                <button id="btn-addquestionset" type="submit" class="btn btn-info float-right" onclick="addCourseOption()"><i class="fas fa-plus"></i> Add Programming Course</button>
              </div>
			 	<%} else{%>
			 	<div class="card-body"> 
			 	 <form id="addOptionForm" method="post" action="addOption.html"> 
			   <input type="hidden" name="varName" id="varName" value="${varName}"/>
			   <div class="form-row">
				   <label  class="col-sm-1 col-form-label col-form-label" >New Option</label>
				    <div class="col-5">
				      <input name="optionDscp" id="optionDscp"  class="form-control"  placeholder="Description" />
				    </div>
				   
				  </div>
             		
			        
			 </form> 
			 </div>
			 <div class="card-footer clearfix">              
                <button id="btn-addquestionset" type="submit" class="btn btn-info float-right" onclick="addOption()"><i class="fas fa-plus"></i> Add Option</button>
              </div>
			 	<%} %>
              
              <!-- /.card-body -->
              
            </div>
	         </div>                           
				 
            <!-- /.card -->
            </section> 
</body>    
</html>    