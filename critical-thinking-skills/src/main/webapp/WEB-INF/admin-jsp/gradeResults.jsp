<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.Submission" %>
<%@ page import="com.cts.model.Question" %>
<%@ page import="com.cts.model.Answer" %>

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

a {
  color: inherit; /* blue colors for links too */
  text-decoration: inherit; /* no underline */
}

.input-group-text {
	font-size: 0.95rem;
}

.question-division{
	display: none;
}

.btn{
margin-left:5px;
}

</style>
<script>

   
function getPageNum(objButton){
	var target=objButton.value;
	document.getElementById('targetPage').value=target;
	document.getElementById('filterForm').submit();
	
}

function submitForm(){
	document.getElementById('answerForm').submit();
}

function getNextPage(){
	var target=document.getElementById("currentPageInd").value;	
	target++;
	
	var maxInd=document.getElementById("maxPageNum").value;
	if (target<maxInd){
		var id="#div-question-ind"+target;
		$('.question-division').css("display", "none");

		$(id).css("display", "block");
		$('#currentPageInd').val(target);
		showNextPreviousBtn();
	}
	maxInd--;
	if (target==maxInd){
		$('#submitbtn').css("display", "block");
	}
	
	
}

function getPreviousPage(){
	var target=document.getElementById("currentPageInd").value;	
	target--;
	if (target>=0){
		var id="#div-question-ind"+target;
		$('.question-division').css("display", "none");
		$(id).css("display", "block");
		$('#currentPageInd').val(target);
		showNextPreviousBtn();
	}	
}

function showNextPreviousBtn(){
	$('#previousbtn').css("display", "block");
	$('#nextbtn').css("display", "block");
	var current=document.getElementById("currentPageInd").value;
	if (current==0){				
		$('#previousbtn').css("display", "none");
	}
	var maxInd=document.getElementById("maxPageNum").value;
	maxInd--;
	if (current==maxInd){
		$('#nextbtn').css("display", "none");
	}
	
}



function setInit(){
	document.getElementById("div-question-ind0").style.display = "block";
	showNextPreviousBtn();
}
addLoadEvent(setInit); 

</script> 
</head>    
<body>    
<%
Submission submission = (Submission)request.getAttribute("submission"); 
int questionInd = 0;
int questionNo = 1;
int totalQuestionNum = submission.getQuestionLst().size();
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
			   

              </div>
              <!-- /.card-header -->
            <form:form method="post" id="answerForm" action="submitGrades.html" modelAttribute="submission" enctype="multipart/form-data"> 
              	<form:hidden path = "submissionId"  />
              
              <div class="card-body">
               <input type="hidden" name="currentPageInd" id="currentPageInd" value="0"/>  
                 <input type="hidden" name="maxPageNum" id="maxPageNum" value="<%=totalQuestionNum%>"/>         
              
              <c:forEach items="${submission.questionLst}" var="question" varStatus="status">	
              <% Question question = submission.getQuestionLst().get(questionInd); %>
           <div class="question-division" id="div-question-ind${status.index}">
			   	<div class="form-row">
				  <div class="form-group col-md-8">
				    <label >Question <%=questionNo %></label>
				    <form:textarea path="questionLst[${status.index}].questionDscp" class="form-control" id="" rows="2" placeholder="Question" value="${question.questionDscp}" readonly="true"/>
				 </div>
			  <% if (question.getQuestionAttachment()!=null){ 
			  		if (!question.getQuestionAttachment().getFormat().toLowerCase().contains("image".toLowerCase())){%>
				  	<div class="form-group col-md-2">
					 		<label >Question Attachment</label>
            			<a href="downloadAttachment.html?id=${question.questionAttachment.id}">${question.questionAttachment.fileName}</a>
					  	</div>
					  	</div>
					  	<%}else{ %>	
					  	</div>
					  	<div class="form-row">				  
							<div  class="form-group col-md-8">
					 		<label >Question Attachment</label><br>
					 		<img src="data:image/jpg;base64,${question.questionAttachment.base64Image}"/>
					 		</div>
				 		</div>
				 		
			  
			  <%}}else{ %>
			  
			  	</div>	
			  <%} %>
				
				 
				 
				 		
				 
				   <div class="form-row">
					  <div class="form-group col-md-8">
					    <label >Sample Answer</label>
					    <form:textarea path="questionLst[${status.index}].sampleAns" class="form-control" rows="2" placeholder="as marking scheme" readonly="true"/>
					 </div>
					<% if (question.getSampleAnsAttachment()!=null){ 
			  		if (!question.getSampleAnsAttachment().getFormat().toLowerCase().contains("image".toLowerCase())){%>
				  	<div class="form-group col-md-2">
					 		<label >Sample Answer Attachment</label>
            			<a href="downloadAttachment.html?id=${question.sampleAnsAttachment.id}">${question.sampleAnsAttachment.fileName}</a>
					  	</div>
					  	</div>
					  	<%}else{ %>	
					  	</div>
					  	<div class="form-row">				  
							<div  class="form-group col-md-8">
					 		<label >Sample Answer Attachment</label><br>
					 		<img src="data:image/jpg;base64,${question.sampleAnsAttachment.base64Image}"/>
					 		</div>
				 		</div>
				 		
			  
			  <%}}else{ %>
			  
			  	</div>	
			  <%} %>
				  
				  <label >Scores Weightage</label>
					<div class="form-row align-items-center">
				    <div class="col-sm-2 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Analysis &  Evaluation</div>
				        </div>
				        <form:input path="questionLst[${status.index}].analysisScore" class="form-control" id="" placeholder="0" name="" readonly="true"/>
				      </div>
				    </div>
				    <div class="col-sm-2 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Logic & Reasoning</div>
				        </div>
				        <form:input path="questionLst[${status.index}].logicScore" class="form-control" id="" placeholder="0" name="" readonly="true"/>
				      </div>
				      </div>
				      <div class="col-sm-2 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Judgement</div>
				        </div>
				        <form:input path="questionLst[${status.index}].judgementScore" class="form-control" id="" placeholder="0" name="" readonly="true"/>
				      </div>
				    </div>
				    <div class="col-sm-2 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Problem Solving</div>
				        </div>
				        <form:input path="questionLst[${status.index}].probSolveScore" class="form-control" id="" placeholder="0" name="" readonly="true"/>
				      </div>
				    </div>
				    <div class="col-sm-2 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Creative Thinking</div>
				        </div>
				        <form:input path="questionLst[${status.index}].creativeScore" class="form-control" id="" placeholder="0" name="" readonly="true"/>
				      </div>
				    </div>
				    </div>
				    
				    <div class="form-row" style="margin-top:10px;">
					  <div class="form-group col-md-8">
					    <label >Answer</label>
					    <form:textarea path="answerLst[${status.index}].strAnswer" class="form-control" rows="2" readonly="true"/>
					 </div>
					 <%Answer answer = submission.getAnswerLst().get(questionInd); %>
					 <% if (answer.getAttachment()!=null){ 
			  		if (!answer.getAttachment().getFormat().toLowerCase().contains("image".toLowerCase())){%>
				  	<div class="form-group col-md-2">
					 		<label >Answer Attachment</label><br>
            			<a href="downloadAttachment.html?id=<%=answer.getAttachment().getId() %>"><%=answer.getAttachment().getFileName() %></a>
					  	</div>
					  	</div>
					  	<%}else{ %>	
					  	</div>
					  	<div class="form-row">				  
							<div  class="form-group col-md-8">
					 		<label >Answer Attachment</label><br>
					 		<img src="data:image/jpg;base64,<%=answer.getAttachment().getBase64Image() %>"/>
					 		</div>
				 		</div>
				 		
			  
			  <%}}else{ %>
			  
			  	</div>	
			  <%} %>
					 
					 <label style="margin-top:30px;">Scores </label>
					 <form:hidden path = "answerLst[${status.index}].submittedAnsId"  />
					<div class="form-row align-items-center">
					 <% if (question.getAnalysisScore()>0){   %>
					   <div class="col-sm-2 my-1">
					 <div class="input-group mb-3">
					  <div class="input-group-prepend">
					    <label class="input-group-text" for="inputGroupSelect01">Analysis &  Evaluation</label>
					  </div>
					 <form:select path="scoresLst[${status.index}].analysisScore"  class="custom-select" id="inputGroupSelect01" >	
					 	<%	for (int i=0;i<=question.getAnalysisScore();i++){%>
					 		<form:option value ="<%=Integer.toString(i) %>" label="<%=Integer.toString(i) %>"/>
					 	<%}%>
					 </form:select>
					 </div>
					 </div>
					 <%} %>
					  <% if (question.getLogicScore()>0){   %>
					   <div class="col-sm-2 my-1">
					 <div class="input-group mb-3">
					  <div class="input-group-prepend">
					    <label class="input-group-text" for="inputGroupSelect02">Logic & Reasoning</label>
					  </div>
					 <form:select path="scoresLst[${status.index}].logicScore"  class="custom-select" id="inputGroupSelect02" >	
					 	<%	for (int i=0;i<=question.getLogicScore();i++){%>
					 		<form:option value ="<%=Integer.toString(i) %>" label="<%=Integer.toString(i) %>"/>
					 	<%}%>
					 </form:select>
					 </div>
					 </div>
					 <%} %>
					  <% if (question.getJudgementScore()>0){   %>
					   <div class="col-sm-2 my-1">
					 <div class="input-group mb-3">
					  <div class="input-group-prepend">
					    <label class="input-group-text" for="inputGroupSelect03">Judgement</label>
					  </div>
					 <form:select path="scoresLst[${status.index}].judgementScore"  class="custom-select" id="inputGroupSelect03" >	
					 	<%	for (int i=0;i<=question.getJudgementScore();i++){%>
					 		<form:option value ="<%=Integer.toString(i) %>" label="<%=Integer.toString(i) %>"/>
					 	<%}%>
					 </form:select>
					 </div>
					 </div>
					 <%} %>
					 <% if (question.getProbSolveScore()>0){   %>
					   <div class="col-sm-2 my-1">
					 <div class="input-group mb-3">
					  <div class="input-group-prepend">
					    <label class="input-group-text" for="inputGroupSelect04">Problem Solving</label>
					  </div>
					 <form:select path="scoresLst[${status.index}].probSolveScore"  class="custom-select" id="inputGroupSelect04" >	
					 	<%	for (int i=0;i<=question.getProbSolveScore();i++){%>
					 		<form:option value ="<%=Integer.toString(i) %>" label="<%=Integer.toString(i) %>"/>
					 	<%}%>
					 </form:select>
					 </div>
					 </div>
					 <%} %>
					 <% if (question.getCreativeScore()>0){   %>
					   <div class="col-sm-2 my-1">
					 <div class="input-group mb-3">
					  <div class="input-group-prepend">
					    <label class="input-group-text" for="inputGroupSelect05">Creative Thinking</label>
					  </div>
					 <form:select path="scoresLst[${status.index}].creativeScore"  class="custom-select" id="inputGroupSelect05" >	
					 	<%	for (int i=0;i<=question.getCreativeScore();i++){%>
					 		<form:option value ="<%=Integer.toString(i) %>" label="<%=Integer.toString(i) %>"/>
					 	<%}%>
					 </form:select>
					 </div>
					 </div>
					 <%} %>
					 </div>
					 
				  <%questionInd++; 
				  questionNo++;%>
				</div>
			        </c:forEach>
			        
              </div>
              </form:form>
               
              <!-- /.card-body -->
              <div class="card-footer clearfix">
				<button style="display: none;" id="submitbtn" onclick="submitForm()" class="btn btn-info float-right"><i id="btn-icon" class="fas fa-edit"></i> Submit</button>   
                <button id="nextbtn" onclick="getNextPage()" type="button" class="btn btn-info float-right"><i style="margin-right:3px;"class="fa fa-chevron-circle-right"></i> Next</button>          
                <button id="previousbtn" onclick="getPreviousPage()" class="btn btn-info float-right"><i style="margin-right:3px;" id="btn-icon" class="fa fa-chevron-circle-left"></i>Previous</button>
                                  
              </div>
	                                    
				 
            <!-- /.card -->
            </section>
</body>    
</html>    