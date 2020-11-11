<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cts.model.Section" %>

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
	background-color: #FED136;
    color: #14171a;
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
</style>
<script>

function getQuestion(hotscd){
	document.getElementById('hotsCd').value = hotscd;
	document.getElementById('sectionForm').submit();
} 

function preventBack() { 
    window.history.forward();  
} 
  
setTimeout("preventBack()", 0);    


</script> 
</head>  
<% User user = (User)request.getAttribute("user"); %>  
<body>   
 <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">Take Test</h1>
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
	<% List<Section> sectionlist = (List<Section>) request.getAttribute("listSection"); 
	   int ind=0;
	   char no='A';
	   boolean isAllCompleted = true;
	   for (int i=0;i<sectionlist.size();i++){
		   if (!sectionlist.get(i).isCompleted()){
			   isAllCompleted = false;
			   break;
		   }
	   }
	   %>
	   <%if (!isAllCompleted){ %>
	 <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  Instruction
                </h3>
               
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              
              <p id="instruction">There are <%=Integer.toString(sectionlist.size()) %> sections consisting of several questions which can be multi-choiced question or short-structured question. 
              <br>Some questions may have a time limit to answer. Please submit the answer before the time ends or your answer will be submitted automatically once the time is up.
              <br><span style="background-color: #FFFF00">ONCE the answering time is over, respondents cannot answer the question any more and also cannot return to any previous questions (that had not been answered, if any) even if there are remaining time.</span>
              <br>You are required to complete all the questions. 
              <br>Once you are ready, you may click on the section to start answering. <p>
              
              </div>
              <!-- /.card-body -->
              
            </div>
            
            <%} %>
           <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  Test Section
                </h3>
               
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              
              <table class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col">Section</th>
				      <th scope="col">Title</th>
				      <th scope="col">Total Questions</th>
				      <th scope="col">Submitted</th>
				      
				    </tr>
				  </thead>
				  <tbody>                 
				  
                 <c:forEach items="${listSection}" var="section">	
                 <input type="hidden" id="id${section.hots.code}" value="${section.hots.code}"/>	
                 <% 
                 if (!sectionlist.get(ind).isCompleted()){
                	%>	 		
					 <tr onclick="getQuestion(document.getElementById('id${section.hots.code}').value)" >
					 <%}else{ %> 
					 <tr>
				<%} %>
			 			<td><%=no%></td>
      					<td>  											  
  				             	
		                     <c:out value="${section.hots.name}" />		               
                  		</td>
                  		<td><%=Integer.toString(sectionlist.get(ind).getQuestionList().size())%></td>
                  		<% if (sectionlist.get(ind).isCompleted()){ %>
					      <td><i class="fas fa-check"></i></span></td>
					      <%}else{ %>
					      <td ><span><i class="fas fa-times"></i><span></td>
					      <%} %>
   					 </tr>	 
   					 <% no+=1;
   					 ind++;%>                
                </c:forEach>
                 </tbody>
				</table>
			 <form id="sectionForm" method="post" action="answerQuestion.html">
			 <input type="hidden" name="hotsCd" id="hotsCd"/>
			 </form>
              
              </div>
              <!-- /.card-body -->
              
            </div>
            <%if (isAllCompleted){ %>
	 		<div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  Reminder
                </h3>
               
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              
              <p id="instruction">You have completed the test. You may view your results in <a href="viewResultList.html">View Result</a> once it is ready. <p>
              
              </div>
              <!-- /.card-body -->
              
            </div>
            
            <%} %>
	 </div>   
	            
				 
            <!-- /.card -->
            </section>
            
           
</body>    
</html>    