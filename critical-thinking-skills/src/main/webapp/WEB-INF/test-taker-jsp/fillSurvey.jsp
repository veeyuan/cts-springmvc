<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cts.model.SurveyForm" %>
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
   background-color: transparent;
    color: #6c757d;
}

#manageProfileLink{
   
    background-color: #FED136;
    color: #14171a;
}

#instruction{
	line-height: 2.5;
}

@media (min-width: 1200px) {
   .modal-xlg {
      width: 90%; 
   }
}

.custom-control-label{
	margin-right:5px;
}
.custom-control-input{
margin-right:10px;
}

.rating-scale {
  display: block;
  margin-left: auto;
  margin-right: auto;
}

</style>
<script>

function submitForm(){
	
	var max=document.getElementById("totalquetionNo").value;
	var isEmpty = false;
	for (i = 0; i < max; i++){
		
		var name = "answerLst["+i+"].strAnswer";
		if (validateRadio(name)){
			
		}else{
			alert("Please make sure all fields are filled.");
			isEmpty = true;
			break;
		}
	}
	if (!isEmpty){
		document.getElementById('surveyForm').submit();
	}
	
}
function validateRadio(name){
	var option=document.getElementsByName(name);	
	for ( var j = 0; j < option.length; j++) {
		if (option[j].checked){
			return true;
		}
	}
	return false;
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
                   ${survey.formName}
                </h3>
               
              </div>
              <div class="card-body">
              <img class="rating-scale" src=" ${survey.ratingScaleImgDir}" alt="ratingscale">
              </div>
              <div class="card-body">
             <form:form id="surveyForm" action ="processSurvey.html"  method="post" modelAttribute="survey" >
             <input type="hidden" id="totalquetionNo" value="<%=request.getAttribute("questionLstSize").toString()%>"/>  
             <form:hidden path="id" value="${survey.id}"/>  
             <table class="table table-hover">
				  <thead>
				    <tr>
				     <th scope="col">No</th>
				      <th scope="col">Question</th>
				      <th scope="col" style="width: 25%;">Ratings</th>
				     
				      
				    </tr>
				  </thead>
				  <tbody>   
             <c:forEach items="${survey.quetionLst}" var="question" varStatus="status">	
              <form:hidden path="quetionLst[${status.index}].id" value="${question.id}"/>  
             <tr>
             <td> ${status.index+1}</td>
              <td> ${question.questionDscp}</td>
              <td>
			  	  <div class="custom-control custom-radio custom-control-inline">	
	              <form:radiobutton path="answerLst[${status.index}].strAnswer"  id="option1${status.index}" class="custom-control-input" value="1" />
	              <label class="custom-control-label" for="option1${status.index}">1</label>
	              </div>
	              <div class="custom-control custom-radio custom-control-inline">	
	              <form:radiobutton path="answerLst[${status.index}].strAnswer" id="option2${status.index}" class="custom-control-input" value="2" />
	              <label class="custom-control-label" for="option2${status.index}">2</label>
	              </div>
	              <div class="custom-control custom-radio custom-control-inline">	
	              <form:radiobutton path="answerLst[${status.index}].strAnswer"  id="option3${status.index}" class="custom-control-input" value="3" />
	              <label class="custom-control-label" for="option3${status.index}">3</label>
	              </div>
	              <div class="custom-control custom-radio custom-control-inline">	
	              <form:radiobutton path="answerLst[${status.index}].strAnswer" id="option4${status.index}" class="custom-control-input" value="4" />
	              <label class="custom-control-label" for="option4${status.index}">4</label>
	              </div>
	              <div class="custom-control custom-radio custom-control-inline">	
	              <form:radiobutton path="answerLst[${status.index}].strAnswer"  id="option5${status.index}" class="custom-control-input" value="5" />
	              <label class="custom-control-label" for="option5${status.index}">5</label>
              	</div>
              </td>
              </tr>
             </c:forEach>
             </tbody>
				</table>
               </form:form>   
             
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button  id="btn-submit-spec"   onclick="submitForm()" type="button" class="btn btn-info float-right"><i class="fas fa-check"></i> Submit</button>  
               
              </div>
            </div>
	                       
				 
            <!-- /.card -->
            </section>
            
           
</body>    
</html>    