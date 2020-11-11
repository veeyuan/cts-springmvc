<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.Submission" %>
<%@ page import="java.util.List" %>

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
#testLink{
	
     background-color: transparent;
    color: #6c757d;
}

#dashboardLink{
    background-color: transparent;
    color: #6c757d;
}

#viewRstLink{
  background-color: #FED136;
    color: #14171a;
}

#manageProfileLink{
   background-color: transparent;
    color: #6c757d;
}

#instruction{
	line-height: 2.5;
}

@media (min-width: 1200px) {
   .modal-xlg {
      width: 90%; 
   }
}

* {box-sizing: border-box}

.container {
  width: 70%;
  background-color: #ddd;
}

.skills {
  text-align: right;
  padding-top: 10px;
  padding-bottom: 10px;
  color: white;
}

</style>
<script>

function getResults(id){
	document.getElementById('submissionId').value = id;
	document.getElementById('resultForm').submit();
} 




   


</script> 
</head>  
<% List<Submission> submissionList = ( List<Submission> )request.getAttribute("submissionList");
int ind=0;
int no=1;%>  
<body>   
 <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">View Result</h1>
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
                  Submitted Tests
                </h3>
               
              </div>
              
              <% if (submissionList.size()>0){ %>
              <!-- /.card-header -->
              <div class="card-body">
              <table class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col">No</th>
				      <th scope="col">Submission Id</th>
				      <th scope="col">Submitted Date</th>
				      <th scope="col">Grading Status</th>
				      
				    </tr>
				  </thead>
				  <tbody>                 
				  
                 <c:forEach items="${submissionList}" var="submission">	
                 <input type="hidden" id="id${submission.submissionId}" value="${submission.submissionId}"/>	
                 <% 
                 if (submissionList.get(ind).isRstReady()){
                	%>	 		
					 <tr onclick="getResults(document.getElementById('id${submission.submissionId}').value)" >
					 <%}else{ %> 
					 <tr>
				<%} %>
			 			<td><%=no%></td>
      					<td>  											  
  				             	
		                     <c:out value="${submission.submissionId}" />		               
                  		</td>
                  		<td>${submission.submitDt}</td>
                  		<% if (submissionList.get(ind).isRstReady()){ %>
					      <td><span><i class="fas fa-check"> </i> Completed</span></td>
					      <%}else{ %>
					      <td ><span><i class="fas fa-times"></i> Pending<span></td>
					      <%} %>
   					 </tr>	 
   					 <% no+=1;
   					 ind++;%>                
                </c:forEach>
                 </tbody>
				</table>
			 <form id="resultForm" method="post" action="viewResult.html">
			 <input type="hidden" name="submissionId" id="submissionId"/>
			 </form>
              </div>
              <%}else{ %>
               <div class="card-body">
              	   <p id="instruction">You have not completed any test yet. Please go to <a href="takeTest.html">Take Test</a> to complete the test.<p>
              </div>
              <%} %>
              
	</div>  
	</div>             
				 
            <!-- /.card -->
            </section>
            
           
</body>    
</html>    