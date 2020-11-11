<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cts.model.Question" %>

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

#testdet{
	margin-top:20px;
	padding:20px;
}

.card-body{
	padding-left:50px;
}

img{
    max-width: 70%;
    max-height: 70%;
    display: block; /* remove extra space below image */
    }
    
.card-header>.card-tools {
    float: left;
    margin-left: 20px;
    }
    
.btn-questionNo{
	background-color: white;
  	color: black;
  	border: 2px solid #FED136;;
}
</style>
<script>
function preventBack() { 
    window.history.forward();  
} 
  
setTimeout("preventBack()", 0); 
 


var formHasChanged = false;
var submitted = false;

	$(document).on('change', 'form.confirm-navigation-form input, form.confirm-navigation-form select, form.confirm-navigation-form textarea', function (e) {
	    formHasChanged = true;
	});

	$(document).ready(function () {
	    window.onbeforeunload = function (e) {
	        if (formHasChanged && !submitted) {
	            var message = "You have not saved your changes.", e = e || window.event;
	            if (e) {
	                e.returnValue = message;
	            }
	            return message;
	        }
	    }
	 $("form").submit(function() {
	     submitted = true;
	     });
	}); 
  
function checkFilled(){
	var i;
	var currentQuestion =  document.getElementById("currentQuestion").value;
	for (i = 1; i < currentQuestion; i++) {	  
		var buttonid="btn-questionNo"+i;
		  document.getElementById(buttonid).style.background='#FED136';		  	  
	}
}
function checkTextareaFilled(){	
	var ans=document.getElementById('textanswer').value;
	$("#answerField").val(ans).change();
	checkFileFilled();
}

function checkFileFilled(){

	var file = document.getElementById("file"); 
	var input=document.getElementById("answerField").value;
	selectedTextarea = $("#textanswer")[0]; 
	var ans="Answer is attached in file...";
	if(file.files.length > 0 ){ 
         if (input.length == 0){        	  
        	  $("#textanswer").val(ans).change();        	  
        	  document.getElementById("textanswer").placeholder =   "Answer is attached in file...";            
          }
      }  else{
    	  $("textanswer").removeAttr('placeholder');    	
    	  if (input.length == 0){
    		  $("#textanswer").val('').change();
    	  }
      }
}

function checkFilledMCQ(selected){
	var ans=selected.value;
	$("#answerField").val(ans).change();
} 

function setInit(){
	checkFilled();
	var currentQuestion =  document.getElementById("currentQuestion").value;
	var totalQuestion =  document.getElementById("totalQuestion").value;
	if (currentQuestion==totalQuestion){
		 $("#submit-btn").html("Submit & Back to Section List");
	}
	var min = document.getElementById("timelimit").value;
	if (min>0){
		var timelimit = min*60;
	    display = document.querySelector('#time');
		startTimer(timelimit, display); 
		$('#showTimeLeft').css("display", "block");
	}
	
}   
addLoadEvent(setInit); 

function submit(){
	var input=document.getElementById("answerField").value;
	if (input.length == 0){
		alert("Please answer the question before submit");
	}else{
		document.getElementById("answerForm").submit();
	}
}

function startTimer(duration, display) {
    var start = Date.now(),
        diff,
        minutes,
        seconds;
    function timer() {
        diff = duration - (((Date.now() - start) / 1000) | 0);
        minutes = (diff / 60) | 0;
        seconds = (diff % 60) | 0;
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = minutes + ":" + seconds; 
		
        if (diff <= 0) {
        	var ismcq = document.getElementById("ismcq").value;
        	/* if (ismcq == 'n'){
            	checkTextareaFilled();
        	} */
			alert("Time's Up! It's time to submit.");
			document.getElementById("answerForm").submit();
            start = Date.now() + 1000;
        }
        if (diff<60){
        	$("#time").css({ 'color': 'red', 'font-size': '150%' });

        }
      
    };
    // we don't want to wait a full second before the timer starts
    timer();
    setInterval(timer, 1000);
} 


</script> 
</head>  
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
	
           <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  Section - ${question.hotsDSCP}
                </h3>
               <div id="testdet">
              	<p>Questions that have been answered: </p>
                <% 
                int totalQuestionNum = (Integer)request.getAttribute("totalquestionNum");
                for (int i=1;i<=totalQuestionNum;i++){ %>
                <input type="hidden" id="currentQuestion" value="${currentQuestionNum}"/>	
                 <input type="hidden" id="totalQuestion" value="${totalquestionNum}"/>	
                <div class="form-check form-check-inline">
				  <button class="btn-questionNo" id="btn-questionNo<%=i%>"  type='button' value="<%=i%> "for="answeredCheckbox<%=i%>"><%=i%></button>
				</div>
					<%if (i %10==0){ %>
					<br>				
					<%}} %>
                <br><br><p id="showTimeLeft" style="display:none">You have <span id="time"></span> minutes left.</p>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              <form:form id="answerForm" action ="submitAnswer.html"  method="post" modelAttribute="answer" enctype="multipart/form-data" >
               <input type="hidden" name="hotsCd" value="${question.hotsComponentCd}"/>
              <form:hidden path ="strAnswer" id="answerField" />
               
              <%  Question question= (Question) request.getAttribute("question");
            	if (question.getQuestionAttachment()!=null) {
            			if (question.getQuestionAttachment().getFormat().toLowerCase().contains("image".toLowerCase())) {       						
            	%>
            			<img src="data:image/jpg;base64,${question.questionAttachment.base64Image}"/>
            			<%}else{ %>
            			<a href="downloadAttachment.html?id=${question.questionAttachment.id}">${question.questionAttachment.fileName}</a>
            	<%}} %>
            	<form:hidden path ="questionId" value="<%=question.getId()%>" />
            	<input type="hidden" id="timelimit" value="<%=Integer.toString(question.getTimeLimitMin())%>"/>	
			    <p>${question.questionDscp}</p>
			     <%if (question.isMcq()){ %>
			     <input type="hidden" id="ismcq" value="y"/>	
			      <%-- <div class="form-check">
				  <input onclick="checkFilledMCQ(this);" class="form-check-input" type="radio" name="radio" id="exampleRadios1" value="1" >
				  <label class="form-check-label" for="exampleRadios1">
				    <%=question.getOption1()%>
				  </label>
				</div>
				<div class="form-check">
				  <input onclick="checkFilledMCQ(this);" class="form-check-input" type="radio"  name="radio" id="exampleRadios2" value="2">
				  <label class="form-check-label" for="exampleRadios2">
				    <%=question.getOption2()%>
				  </label>
				</div>
					<%if (question.getOption3()!=null) {%>
					<div class="form-check">
					  <input onclick="checkFilledMCQ(this);" class="form-check-input" type="radio" name="radio" id="exampleRadios3" value="3" >
					  <label class="form-check-label" for="exampleRadios3">
					   <%=question.getOption3()%>
					  </label>
					</div>
						<%if (question.getOption4()!=null) {%>
						<div class="form-check">
						  <input onclick="checkFilledMCQ(this);" class="form-check-input" type="radio" name="radio"  id="exampleRadios4" value="4" >
						  <label class="form-check-label" for="exampleRadios4">
						   <%=question.getOption4()%>
						  </label>
						</div>
							<%if (question.getOption5()!=null) { %>
							<div class="form-check">
								  <input onclick="checkFilledMCQ(this);" class="form-check-input" type="radio" name="radio"  id="exampleRadios5" value="5" >
								  <label class="form-check-label" for="exampleRadios5">
								   <%=question.getOption5()%>
								  </label>
								</div>
							<%} %>
						<%} %>
					<%} %> --%>
					
				    <c:forEach var="optionArr" items="${question.optionArr}" varStatus="status">
				    <div class="form-check">
				  <input onclick="checkFilledMCQ(this);" class="form-check-input" type="radio" name="radio" id="exampleRadios${status.index+1}" value="${status.index+1}" >
				  <label class="form-check-label" for="exampleRadios${status.index+1}">
    				<c:out value="${optionArr}"/> 
				  </label>
				</div>
					</c:forEach>
            	<%}else{ %>
            	<input type="hidden" id="ismcq" value="n"/>	
            	
            	<div class="form-row">
			         <div class="form-group col-md-8">
					    <label for="exampleFormControlTextarea1">Answer</label>
					    <textarea onchange="checkTextareaFilled()" class="form-control" id="textanswer" rows="3"></textarea>
					  </div>
			           <div class="form-group col-md-3">
				 		<label >Answer Attachment (if required)</label>
				 		<form:input path="oriFile" onchange="checkFileFilled()"  type="file" class="form-control-file"  id="file" name="sampleAnsAttachment"/>
				  	</div>
				  	</div>
            	<%} %>
              </form:form>
              </div>
              <!-- /.card-body -->
              
            </div>
	              <div class="card-footer clearfix">
                <button id="submit-btn" onclick="submit()" class="btn btn-info float-right"><i id="btn-icon" class="fas fa-check"></i> Submit & Next Question</button>             
              </div>  
				 
            <!-- /.card -->
            </section>
            
           
</body>    
</html>    