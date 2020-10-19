<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.Submission" %>

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
    color: #fff;
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

function getQuestions(){
	document.getElementById('questionForm').submit();
} 

function setInit(){
	//setUserName
	var analysisScore = ${submission.scoresLst[0].analysisScore}+"%";
	if ( analysisScore == "0%"){
		 $('.analysisScore').width("3%");
		 $(".analysisScore").css("color","black");
		 $(".analysisScore").css("background-color","#ddd");

	}else{
		$('.analysisScore').width(analysisScore);
	}
	

	var logicScore = ${submission.scoresLst[0].logicScore}+"%";
	if ( logicScore == "0%"){
		$('.logicScore').width("3%");
		 $(".logicScore").css("color","black");
		 $(".logicScore").css("background-color","#ddd");
	}else{
		$('.logicScore').width(logicScore);
	}
	var judgementScore = ${submission.scoresLst[0].judgementScore}+"%";
	if ( judgementScore == "0%"){
		$('.judgementScore').width("3%");
		 $(".judgementScore").css("color","black");
		 $(".judgementScore").css("background-color","#ddd");
	}else{
		$('.judgementScore').width(judgementScore);
	}
	var probSolveScore = ${submission.scoresLst[0].probSolveScore}+"%";
	if ( probSolveScore == "0%"){
		$('.probSolveScore').width("3%");
		 $(".probSolveScore").css("color","black");
		 $(".probSolveScore").css("background-color","#ddd");
	}else{
		$('.probSolveScore').width(probSolveScore);
	}
	var creativeScore = ${submission.scoresLst[0].creativeScore}+"%";
	if ( creativeScore == "0%"){
		$('.creativeScore').width("3%");
		 $(".creativeScore").css("color","black");
		 $(".creativeScore").css("background-color","#ddd");
	}else{
		$('.creativeScore').width(creativeScore);
	}
	var username = document.getElementById("username").value;
	$('#usernameDisplay').html(username);
	var discipline = document.getElementById("discipline").value;
	$('#disciplineCd').val(discipline).change();
	var category = document.getElementById("category").value;
	$('#categoryCd').val(category).change();
	var language = document.getElementById("language").value;
	$('#languageCd').val(language).change(); 
}


addLoadEvent(setInit); 

   


</script> 
</head>  
<% Submission submission = (Submission)request.getAttribute("submission"); %>  
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
	<%if (submission.isHasTakenTest()){ %>
		
           <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  View Result
                </h3>
               
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              <div class="form-row">
              	 <div class="form-group col-md-7">
				    <label >Full Name</label>
				    <input type="text" class="form-control" value="${submission.testTakerName}" readonly/>
				 </div>
				 
	               </div>
	               <div class="form-row">    
	                <div class="form-group col-md-3">
	  				  <label >Discipline</label>
	  				  	 <input type="hidden" id="discipline" value="${submission.disciplineCd}">  
	                     <select  id="disciplineCd" class="form-control" >
	                       <c:forEach items="${listDiscipline}" var="discipline">
					      	  <option value ="${discipline.code}" label="${discipline.name}" disabled=/>
				              </c:forEach>
	                       </select>
	                   </div>
	                <div class="form-group col-md-2">
					      <label >Suitable Category</label>
					      <input type="hidden" id="category" value="${submission.categoryCd}"> 
					      <select  id="categoryCd" class="form-control" >
					      	<c:forEach items="${listCategory}" var="category">
					      	  <option value ="${category.code}" label="${category.name}" disabled/>
				              </c:forEach>
	                       </select>
					  </div>
					 <div class="form-group col-md-2">
					      <label >Language</label>
					      <input type="hidden" id="language" value="${submission.languageCd}"> 
					      <select  id="languageCd" class="form-control" name="questionsetlang">
					      <c:forEach items="${listLanguage}" var="language">
					      	  <option value ="${language.code}" label="${language.name}" disabled/>
				              </c:forEach>
	                       </select>
					  </div> 
				 </div>
				  <div class="form-row">
				  <div class="form-group col-md-3">
				    <label >Submitted Date</label>
				    <input type="text" class="form-control" value="${submission.submitDt}" readonly/>
				 </div>
				  </div> 
				  <br>
				  <div class="form-row">
					   <div class="form-group col-md-3">
		              <label >Thinking Skills Analysis Chart</label>
		              </div>
              		</div>
              	  
              		<p>Analysis &  Evaluation</p>
					<div class="container">
					  <div class="skills analysisScore" style="background-color: red"> ${submission.scoresLst[0].analysisScore} &#37;</div>
					</div>
					
					<p>Logic & Reasoning</p>
					<div class="container">
					  <div class="skills logicScore" style="background-color: orange"> ${submission.scoresLst[0].logicScore} &#37;</div>
					</div>
					
					<p>Judgement</p>
					<div class="container">
					  <div class="skills judgementScore" style="background-color: #4CAF50"> ${submission.scoresLst[0].judgementScore} &#37;</div>
					</div>
					
					<p>Problem Solving</p>
					<div class="container">
					  <div class="skills probSolveScore" style="background-color: #2196F3"> ${submission.scoresLst[0].probSolveScore} &#37;</div>
					</div>
              		
              		<p>Creative Thinking</p>
					<div class="container">
					  <div class="skills creativeScore" style="background-color: purple"> ${submission.scoresLst[0].creativeScore}&#37;</div>
					</div>
              	
              		
              </div>
              <!-- /.card-body -->
               <div class="card-footer clearfix">
              	<button onclick="history.back(-1)"  class="btn btn-info float-right"><i id="btn-icon" class="fas fa fa-arrow-left"></i>Back</button>
               
              </div>
            </div>
            
	 <%}else{ %>   
	 <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  View Results
                </h3>
               
              </div>
	  <div class="card-body">
	   <p id="instruction">You have not taken any test yet. Please go to <a href="takeTest.html">Take Test</a> to assess your critical thinking skills.<p>
              </div>
	 <%} %>                   
				 
            <!-- /.card -->
            </section>
            
           
</body>    
</html>    