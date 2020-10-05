<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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

#testLink{
	background-color: #FED136;
    color: #fff;
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

.question-division{
	display: none;
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
  
window.onunload = function () { null }; 
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
			alert("Time's Up! It's time to submit.");
			submitAns();
            start = Date.now() + 1000;
        }
    };
    // we don't want to wait a full second before the timer starts
    timer();
    setInterval(timer, 1000);
} 



function setInit(){
	//setUserName
	var username = document.getElementById("username").value;
	$('#usernameDisplay').html(username);
	var onehour = 60 * 60,
     display = document.querySelector('#time');
	startTimer(onehour, display); 
	document.getElementById("div-question-ind0").style.display = "block";
	$("#btn-questionNo1").css("border","2px solid black");
	
}

function checkFilledMCQ(selected,questionNum){
	var ans=selected.value;
	questionNum--; //according to index varstatus 
	var id="#inputAns"+questionNum;
	$(id).val(ans).change();
} 

function getPageNum(objButton){
	var target=objButton.value;
	target--;		
	$('#targetPageInd').val(target);
	goToPage();
}


function getNextPage(){
	var target=document.getElementById("targetPageInd").value;
	var max=document.getElementById("maxPageNum").value;
	target++;
	if (target>=max){
		target--;
	}
	$('#targetPageInd').val(target);
	goToPage();
	
}

function getPreviousPage(){
	var target=document.getElementById("targetPageInd").value;
	target--;
	if (target<0){
		target=0;
	}
	$('#targetPageInd').val(target);
	goToPage();
	
}

function goToPage(){
	//for text answer
/* 	var current=document.getElementById("currentPageInd").value;
	var textid="textanswer"+current;
	var ans=document.getElementById(textid).value;
	
	var ansid="#inputAns"+current;
	$(ansid).val(ans).change(); */
	//go to page
	var target=document.getElementById("targetPageInd").value;
	$('#currentPageInd').val(target);
	var id="#div-question-ind"+target;
	$('.question-division').css("display", "none");
	$(id).css("display", "block");
	checkFilled();
	 $(".btn-questionNo").css("border","2px solid #FED136");
	target++;
	var buttonid="#btn-questionNo"+target;
	 $(buttonid).css("border","2px solid black");
}

function checkFilled(){
	var i;
	var max=document.getElementById("maxPageNum").value;
	for (i = 0; i < max; i++) {
	  var id="inputAns"+i;
	  var input =  document.getElementById(id).value;
	   var ind=i+1;
	  //var checkboxid = "#answeredCheckbox"+ind;
	  var buttonid="btn-questionNo"+ind;
	  if (input.length > 0){
		 // $(checkboxid). prop("checked", true);		  
		  document.getElementById(buttonid).style.background='#FED136';		  
	  }else{
		//  $(checkboxid). prop("checked", false);
		  document.getElementById(buttonid).style.background='white';
	  }   
	  
	}
}

function checkTextareaFilled(){	
	var questionNum=document.getElementById("currentPageInd").value;
	var id="#inputAns"+questionNum;
	var ansid="textanswer"+questionNum;
	var ans=document.getElementById(ansid).value;
	$(id).val(ans).change();
	checkFileFilled();
}

function checkFileFilled(){
	var questionNum=document.getElementById("currentPageInd").value;
	var fileid="file"+questionNum;
	var file = document.getElementById(fileid); 
	var id1="inputAns"+questionNum;
	var id2="#inputAns"+questionNum;
	var input=document.getElementById(id1).value;
	var textareaid="#textanswer"+questionNum;
	selectedTextarea = $(textareaid)[0]; 
	var ans="Answer is attached in file...";
	if(file.files.length > 0 ){ 
         if (input.length == 0){        	  
        	  $(id2).val(ans).change();        	  
        	  selectedTextarea.placeholder =   "Answer is attached in file...";            
          }
      }  else{
    	  $(textareaid).removeAttr('placeholder');    	
    	  if (input.length == 0){
    	  	$(id2).val('').change(); 
    	  }
      }
}

function getSubmitConfirmation() {
    var retVal = confirm("There is/are question(s) unanswered. Are you sure to submit?");
    if( retVal == true ) {
       return true;
    } else {
       return false;
    }
 }
 
function hasEmptyAnswerField(){
	var i;
	var max=document.getElementById("maxPageNum").value;
	for (i = 0; i < max; i++) {
	  var id="inputAns"+i;
	  var input =  document.getElementById(id).value;
	  if (input.length == 0){
		 return true;
	  }	  
	}
	return false;
}
function submitWithValidation(){
	if (hasEmptyAnswerField()){
		 if(getSubmitConfirmation()){
			 submitAns();
		 }	
	 }else{
		 submitAns();
	 }
	
}

function submitAns(){
	document.getElementById('answerForm').submit();
}

addLoadEvent(setInit); 


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
   


</script> 
</head>    
<body>  
<%
int questionNo = 1;
int questionInd = 0;
List<Question> questionLst = (List<Question>) request.getAttribute("questionLst"); 
List<Answer> answerLst = new ArrayList<Answer>();
int totalQuestionNum = questionLst.size();
request.setAttribute("questionLst", questionLst);
%> 
 <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">Take Test</h1>
          </div><!-- /.col -->
         
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
                  Start Test
                </h3>
                <div id="testdet">
                <p>You have <span id="time"></span> minutes left.</p>
                <% for (int i=1;i<=totalQuestionNum;i++){ %>
                <div class="form-check form-check-inline">
<%-- 				  <input class="form-check-input" type="checkbox" id="answeredCheckbox<%=i%>" disabled>
 --%>				  <button class="btn-questionNo" id="btn-questionNo<%=i%>" onclick="getPageNum(this)" type='button' value="<%=i%> "for="answeredCheckbox<%=i%>"><%=i%></button>
				</div>
					<%if (i %10==0){ %>
					<br>				
					<%}} %>
                
                </div>
               
                          
              </div>
              <!-- /.card-header -->
              <form:form method="post" id="answerForm" action="submitTest.html" modelAttribute="submission" enctype="multipart/form-data"> 
              
              <div class="card-body">
                 <input type="hidden" name="currentPageInd" id="currentPageInd" value="0"/>  
                 <input type="hidden" name="targetPageInd" id="targetPageInd" value="0"/>   
                 <input type="hidden" name="maxPageNum" id="maxPageNum" value="<%=totalQuestionNum%>"/>         
            	<c:forEach items="${submission.questionLst}" var="question" varStatus="status">	
            	<div class="question-division" id="div-question-ind${status.index}">
            	<p><b>Question <%=questionNo%></b></p>
            	<%  Question question=questionLst.get(questionInd);
            	if (question.getQuestionAttachment()!=null) {
            			if (question.getQuestionAttachment().getFormat().toLowerCase().contains("image".toLowerCase())) {       						
            	%>
            			<img src="data:image/jpg;base64,${question.questionAttachment.base64Image}"/>
            			<%}else{ %>
            			<a href="downloadAttachment.html?id=${question.questionAttachment.id}">${question.questionAttachment.fileName}</a>
            	<%}} %>
			    <p>${question.questionDscp}</p>
			    <form:hidden path="questionLst[${status.index}].mcq"  value="<%=question.isMcq()%>" />
			    <form:hidden path="answerLst[${status.index}].questionId"  value="<%=question.getId()%>" />
			    <form:hidden path="answerLst[${status.index}].strAnswer"   id="inputAns${status.index}"/>
			    
            	 <%if (questionLst.get(questionInd).isMcq()){ 
            	%>
            	 <div class="form-check">
				  <input onclick="checkFilledMCQ(this,<%=questionNo%>);" class="form-check-input" type="radio" name="questionRad<%=questionNo%>" id="exampleRadios1" value="1" >
				  <label class="form-check-label" for="exampleRadios1">
				    <%=question.getOption1()%>
				  </label>
				</div>
				<div class="form-check">
				  <input onclick="checkFilledMCQ(this,<%=questionNo%>);" class="form-check-input" type="radio" name="questionRad<%=questionNo%>" id="exampleRadios2" value="2">
				  <label class="form-check-label" for="exampleRadios2">
				    <%=question.getOption2()%>
				  </label>
				</div>
				<%if (question.getOption3()!=null) {%>
				<div class="form-check">
				  <input onclick="checkFilledMCQ(this,<%=questionNo%>);" class="form-check-input" type="radio" name="questionRad<%=questionNo%>" id="exampleRadios3" value="3" >
				  <label class="form-check-label" for="exampleRadios3">
				   <%=question.getOption3()%>
				  </label>
				</div>
					<%if (question.getOption4()!=null) {%>
					<div class="form-check">
					  <input onclick="checkFilledMCQ(this,<%=questionNo%>);" class="form-check-input" type="radio" name="questionRad<%=questionNo%>" id="exampleRadios4" value="4" >
					  <label class="form-check-label" for="exampleRadios4">
					   <%=question.getOption4()%>
					  </label>
					</div>
						<%if (question.getOption5()!=null) {%>
						<div class="form-check">
						  <input onclick="checkFilledMCQ(this,<%=questionNo%>);" class="form-check-input" type="radio" name="questionRad<%=questionNo%>" id="exampleRadios5" value="5" >
						  <label class="form-check-label" for="exampleRadios5">
						   <%=question.getOption5()%>
						  </label>
						</div>
		          
			          <%}}}}else{  %>
					 <div class="form-row">
			         <div class="form-group col-md-8">
					    <label for="exampleFormControlTextarea1">Answer</label>
					    <textarea onchange="checkTextareaFilled()" class="form-control" id="textanswer${status.index}" rows="3"></textarea>
					  </div>
			           <div class="form-group col-md-3">
				 		<label >Answer Attachment (if required)</label>
				 		<form:input path="answerLst[${status.index}].oriFile" onchange="checkFileFilled()"  type="file" class="form-control-file"  id="file${status.index}" name="sampleAnsAttachment"/>
				  	</div>
				  	</div>
			         
			          <%}
            	 		questionNo++;
            	 		questionInd++;
            	 		%>
            	 	</div>
			        </c:forEach>
			        
			         <div class="card-tools">
                  <ul class="pagination pagination-sm">
                   <li class="page-item"><button onclick="getPreviousPage()" type='button' class="page-link" />&laquo; previous</button></li>
                   <li class="page-item"><button onclick="getNextPage()" type='button'  class="page-link" />next &raquo;</button></li>
                   
                  </ul>
                </div>
              </div>
              </form:form>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button  id="btn-delete" onclick="submitWithValidation()" type="button" class="btn btn-info float-right" data-toggle="modal" data-target="#testModal"><i class="far fa-edit"></i> Submit</button>  
               
              </div>
            </div>
	                                  
				 
            <!-- /.card -->
            </section>
            
      
</body>    
</html>    