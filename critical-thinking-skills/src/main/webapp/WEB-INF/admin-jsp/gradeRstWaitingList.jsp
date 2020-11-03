<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

.ui-datepicker-title{
	text-align: center;
}
#ui-datepicker-div {
	background-color: white;
}
#gradeLink{
	background-color: #FED136;
    color: #fff;
}

#dashboardLink{
    background-color: transparent;
    color: #6c757d;
}

#addLink{
   background-color: transparent;
    color: #6c757d;
}

#manageLink{
   background-color: transparent;
    color: #6c757d;
}
#manageOptLink{
	background-color: transparent;
    color: #6c757d;
}
a {
  color: inherit; /* blue colors for links too */
  text-decoration: inherit; /* no underline */
}
</style>
<script>

$(document).ready(function() {
	   $(function() {
	   $("#datepick").datepicker({dateFormat: 'yy/mm/dd'});
	   });
	   });
function gradeQuestion(){
	document.getElementById('gradeQuestionForm').submit(); 
   }
   
function getPageNum(objButton){
	var target=objButton.value;
	document.getElementById('targetPage').value=target;
	document.getElementById('filterForm').submit();
	
}

function getSubmission(id){
	document.getElementById('submissionID').value=id;
	document.getElementById('viewSubmissionForm').submit();
}

function changeDate(){
	var date = document.getElementById('datepick').value;
	document.getElementById('submitDt').value=date;
}
</script> 
</head>    
<body>    
<% 
int currentPage=0;
int totalPage=0;
int previousPage=0;
int nextPage=0;
if ("POST".equalsIgnoreCase(request.getMethod())) {
	   currentPage = Integer.parseInt((String)request.getAttribute("currentPage"));	   
	   previousPage = currentPage-1;
	   nextPage = currentPage+1; 
} else{
	currentPage=1;
}
totalPage = Integer.parseInt((String)request.getAttribute("totalPages"));

                  	 
%>
 <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">Grade Results</h1>
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
                  Submissions
                </h3>
			   
			    <div class="searchfilter">
			      <form:form id="filterForm" action ="gradeRstWaitingList.html"  method="post" modelAttribute="filterSubmission" >
			      <input type="hidden" name="targetPage" id="targetPage" value="1"/>
			         <div class="form-row">
			         <div class="form-group col-md-4">
			         		<form:input path="testTakerName" id="search"  class="form-control"  placeholder="Search test-taker's name..." />	
			         			         
			         </div>
			        
			        
	               <div class="form-group col-md-2">
	                        <form:select path="categoryCd" class="form-control" >
	                        <form:option value = "all" label="All"/>
					      	<c:forEach items="${listCategory}" var="category">
					      	  <form:option value ="${category.code}" label="${category.name}"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					  
					   <div class="form-group col-md-2">
					       <form:select path="languageCd"  class="form-control" name="questionsetlang">
					       <form:option value = "all" label="All"/>  
					      <c:forEach items="${listLanguage}" var="language">
					      	  <form:option value ="${language.code}" label="${language.name}"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					 <div class="form-group col-md-2">
					 <% if ((String)request.getAttribute("filterSubmitDt")!=null){ %>
					 <input onchange="changeDate()" id="datepick"  class="form-control"  placeholder="Submitted By" value="<%=(String)request.getAttribute("filterSubmitDt")%>"/>	
					 <%}else{ %> 
					 <input onchange="changeDate()" id="datepick"  class="form-control"  placeholder="Submitted By" />	
					 <%} %>
					 <input type="hidden" name="submitDt" id="submitDt"/>
					 </div>
					     
				
					 <span><button onclick="search()" class="btn btn-info float-right"><i class="fas fa-search"></i> Search</button></span>
					  					  
					 </div>
			          
			        
					</form:form>			  
					  </div>

                <div class="card-tools">
                  <ul class="pagination pagination-sm">
                    <%if (currentPage==1){ %>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='1' class="page-link" /></li>
                    	<%if (totalPage>1){ %>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='2' class="page-link" /></li>
                    		<%if (totalPage>2){ %>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='3' class="page-link" /></li>
                    		<%} %>
                    <li class="page-item"><button onclick="getPageNum(this)" type='button' value='<%=currentPage+1%>' class="page-link" />&raquo;</button></li>
                    	<%} %>
                    <%}else if (currentPage==totalPage){ %>
                    <li class="page-item"><button onclick="getPageNum(this)" type='button' value='<%=currentPage-1%>' class="page-link" />&laquo;</button></li>
                    	<%if (currentPage-2>0){ %>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=currentPage-2%>' class="page-link" /></li>
                    	<%} %>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=currentPage-1%>' class="page-link" /></li>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=currentPage%>' class="page-link" /></li>
                    <%}else{ %>
                    <li class="page-item"><button onclick="getPageNum(this)" type='button' value='<%=currentPage-1%>' class="page-link" />&laquo;</button></li>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=previousPage%>' class="page-link" /></li>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=currentPage%>' class="page-link" /></li>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=nextPage%>' class="page-link" /></li>
                    <li class="page-item"><button onclick="getPageNum(this)" type='button' value='<%=currentPage+1%>' class="page-link" />&raquo;</button></li>
                    <%} %>
                  </ul>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              <table class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col">Name</th>
				      <th scope="col">Category</th>
				      <th scope="col">Discipline</th> 
				      <th scope="col">Language</th>
				      <th scope="col">Require Marking</th>
				      <th scope="col">Submitted Date</th>
				    </tr>
				  </thead>
				  <tbody>                 
                 <c:forEach items="${listSubmission}" var="submission">		
                 <input type="hidden" id="id${submission.submissionId}" value="${submission.submissionId}"/>		 		
					 <tr onclick="getSubmission(document.getElementById('id${submission.submissionId}').value)" >
			 			
      					<td>  											  
  				             <span id="editdiv" class="tools">
		                      <i class="fas fa-edit"></i>
		                    </span>  	
		                     <c:out value="${submission.testTakerName}" />		               
                  		</td>
					      <td>${submission.categoryDscp}</td>
					      <td>${submission.disciplineDscp}</td> 
					      <td>${submission.languageDscp}</td> 
					      <td>${submission.noReqManualGrading}</td>
					      <td>${submission.submitDt}</td>
   					 </tr>	                 
                </c:forEach>
                 </tbody>
				</table>
			 <form id="viewSubmissionForm" method="post" action="gradeResults.html">
			 <input type="hidden" name="submissionID" id="submissionID"/>
			 </form>			 
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
             
            </div>
	                                    
				 
            <!-- /.card -->
            </section>
</body>    
</html>    