<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.ArrayList"%>
<html>    
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">   
<style>
.form-group{
	border-radius: 2px;
    color: #495057;
    margin:5px;
    margin-top:0px;
    padding: 10px;
    padding-top:5px;
    }
.card-tools{
	margin-left:30px;
 	padding: 25px;
}
#addLink{

    background-color: transparent;
    color: #6c757d;
}

#dashboardLink{
    background-color: transparent;
    color: #6c757d;
}

#gradeLink{
   background-color: transparent;
    color: #6c757d;
}

#manageLink{
	background-color: #FED136;
    color: #14171a;
}
#manageOptLink{
	background-color: transparent;
    color: #6c757d;
}
#changePswdLink{
	background-color: transparent;
    color: #6c757d;
}
#btn-addquestionset-back{
	margin-right:10px;
}
#manageAdminLink{
	background-color: transparent;
    color: #6c757d;
}
#btn-icon{
	margin-right:5px;
}
img{
    max-width: 70%;
    max-height: 70%;
    display: block; /* remove extra space below image */
    }
    
a {
  color: inherit; /* blue colors for links too */
  text-decoration: inherit; /* no underline */
}
</style>
<script>


function setOption(selected){ //set number of options
	var x=selected;
	document.getElementById("optionArrSize").value=x;
	
}
	
function setMCQ(selected){ //if it is discipline-specific
	var x=selected.value;
	alert(x);
	if (x=="yes"){
		document.getElementById("mcqDiv").style.display = "block";
		document.getElementById("structuredDiv").style.display = "none";
	}else{
		document.getElementById("mcqDiv").style.display = "none";
		document.getElementById("structuredDiv").style.display = "block";		
	}
}

function setInit(){
	
	var discipline = document.getElementById("discipline").value;
	$('#disciplineCd').val(discipline).change();
	var category = document.getElementById("category").value;
	$('#categoryCd').val(category).change();
	var language = document.getElementById("language").value;
	$('#languageCd').val(language).change();
	var isMcq = document.getElementById("isMcq").value;
	if (isMcq == "true"){
		document.getElementById("mcq1").checked = true;
		document.getElementById("mcq2").checked = false;
		document.getElementById("mcqDiv").style.display = "block";
		document.getElementById("structuredDiv").style.display = "none";
		var mcqans = document.getElementById("mcqanswer").value;
		document.getElementById("numChoice").value = mcqans;
	}else{
		document.getElementById("mcq1").checked = false;
		document.getElementById("mcq2").checked = true;	
		document.getElementById("mcqDiv").style.display = "none";
		document.getElementById("structuredDiv").style.display = "block";	
		
	}
}
function delQuestions(){
	document.getElementById('delQuestionForm').submit(); 
}


addLoadEvent(setInit); 


</script>  
</head>  

<body>    
 <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">Manage Question</h1>
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
                  View Question 
                </h3>
                </div>
                 <form id="delQuestionForm" method="post" action="deleteProcess.html">
                   <input type="hidden" name="delQuestionList" value="${question.id}"/>                                
                 </form>
                <form:form id="questionForm" action ="modifyQuestion.html"  method="post" modelAttribute="question" >                			 
                <input type="hidden" name="questionID" id="questionID" value="${question.id}"/>               
                <div class="card-tools">
                 <div class="form-row">
				  <div class="form-group col-md-8">
				    <label >Question</label>
				    <form:textarea path="questionDscp" class="form-control" id="" rows="2" placeholder="Question" value="${question.questionDscp}" readonly="true"/>
				 </div>
				 <%if ("Y".equals(request.getAttribute("hasQuestionAttachment"))&& "N".equals(request.getAttribute("isQuesAttachmentIMG"))){ %>
				 <div class="form-group col-md-2">
				 		<label >Attachment (for Question)</label>
				 		<a   href="downloadAttachment.html?id=${question.questionAttachment.id}">${question.questionAttachment.fileName}</a>
				  </div>
				 <%} %>
				 </div>
				  <%if ("Y".equals(request.getAttribute("hasQuestionAttachment"))&& "Y".equals(request.getAttribute("isQuesAttachmentIMG"))){ %>	
					 <div class="form-row">				 
					  <div class="form-group col-md-8">
				 		<label >Attachment (for Question)</label><br>
				 		<img  src="data:image/jpg;base64,${question.questionAttachment.base64Image}" />
				 		</div>
				 		</div>
				 		<%} %>
				 
				  
				  <div class="form-row">
					  
	  				  <div class="form-group col-md-3">
	  				  <label >Discipline</label>
	  				  	 <input type="hidden" id="discipline" value="${question.disciplineCd}">  
	                     <form:select path="disciplineCd" id="disciplineCd" class="form-control" >
	                       <c:forEach items="${listDiscipline}" var="discipline">
					      	  <form:option value ="${discipline.code}" label="${discipline.name}" disabled="true"/>
				              </c:forEach>
	                       </form:select>
	                   </div>
	                   
	               
	                <div class="form-group col-md-2">
					      <label >Suitable Category</label>
					      <input type="hidden" id="category" value="${question.categoryCd}"> 
					      <form:select path="categoryCd" id="categoryCd" class="form-control" >
					      	<c:forEach items="${listCategory}" var="category">
					      	  <form:option value ="${category.code}" label="${category.name}" disabled="true"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					 <div class="form-group col-md-2">
					      <label >Language</label>
					      <input type="hidden" id="language" value="${question.languageCd}"> 
					      <form:select path="languageCd" id="languageCd" class="form-control" name="questionsetlang">
					      <c:forEach items="${listLanguage}" var="language">
					      	  <form:option value ="${language.code}" label="${language.name}" disabled="true"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					  </div>
					  <div class="form-row">
					  <div class="form-group col-md-3">
					      <label >HOTS Component</label>
					      <form:select path="hotsComponentCd"  class="form-control" name="hotsComponentCd">
					      <c:forEach items="${listHotsComponent}" var="hots">
					      	  <form:option value ="${hots.code}" label="${hots.name}" disabled="true"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					  <div class="form-group col-md-2">
					    <label >Display for answering?</label><br>
							<div class="custom-control custom-radio custom-control-inline">
							  <form:radiobutton path="strIsSelectedToAsk" id="mcqA" name="radio-all-mcq" class="custom-control-input" value="Y" disabled="true"/>
							  <label class="custom-control-label" for="mcqA">Yes</label>
							</div>
							<div class="custom-control custom-radio custom-control-inline">
							  <form:radiobutton path="strIsSelectedToAsk"  id="mcqB" name="radio-all-mcq" class="custom-control-input" value="N"  disabled="true"/>
							  <label class="custom-control-label" for="mcqB">No</label>
							</div>				 
					   </div>
					  <div class="form-group col-md-2">
					    <label >Multi-choiced Question?</label><br>
					    <input type="hidden" id="isMcq" value="${question.mcq}">  
							<div class="custom-control custom-radio custom-control-inline">
							  <input type="radio"  id="mcq1" name="radio-all-mcq" class="custom-control-input" value="yes" disabled>
							  <label class="custom-control-label" for="mcq1">Yes</label>
							</div>
							<div class="custom-control custom-radio custom-control-inline">
							  <input type="radio" id="mcq2" name="radio-all-mcq" class="custom-control-input" value="no" disabled>
							  <label class="custom-control-label" for="mcq2">No</label>
							</div>				 
					   </div>
					   <div class="form-group col-md-2">
				    <label >Time Limit (Minute)</label>
				    <form:input path="timeLimitMin" class="form-control"  placeholder="0" readonly="true"/>
				 </div>
					 </div>
					 
					 <div id="mcqDiv">
					 <div class="form-row">					
					    <div  class="form-group col-md-3" >
	                   		<label >Number of Choices</label>
							<form:select path="optionArrSize" class="form-control" onchange="setOption(this)" id="optionArrSize" disabled="true">
							<%for (int i=2;i<=10;i++){ %>
							<form:option value="<%=i%>"><%=i%></form:option>					      
	                        <%} %>
	                       </form:select>	            
	                    </div>
	                   <div  class="form-group col-md-2" >
	                   		<label >Answer</label>
	                   		<input type="hidden" id="mcqanswer" value="${question.sampleAns}">
	                   		<form:input path="mcqAns" class="form-control" id="numChoice" placeholder="Option Number (eg. 1)" value="" readonly="true" />                			               		
	                   </div>			 
					 </div>
		

				  <c:forEach var="optionArr" items="${question.optionArr}" varStatus="status">
				   <div class="form-group row">
					    <label class="col-sm-1 col-form-label">Option ${status.index+1}</label>
					    <div class="col-sm-9">
    					 	<form:textarea path="optionArr[${status.index}]"  class="form-control" id="opt${status.index+1}" rows="1" placeholder="-"   readonly="true" />
				   		</div>
				  </div>
				  </c:forEach>
				
				  </div>
				  <div id="structuredDiv" style="display:none">
				   <div class="form-row">
					  <div class="form-group col-md-8">
					    <label >Answer</label>
					    <form:textarea path="sampleAns" class="form-control" id="" rows="1" placeholder="as marking scheme" readonly="true"/>
					 </div>
					 <%if ("Y".equals(request.getAttribute("hasAnswerAttachment")) && "N".equals(request.getAttribute("isAnsAttachmentIMG"))){ %>	
						 <div class="form-group col-md-2">
					 		<label >Attachment (for Answer)</label>
					 		<a   href="downloadAttachment.html?id=${question.sampleAnsAttachment.id}">${question.sampleAnsAttachment.fileName}</a>					 		
					  	</div>
					 <%} %>
					 </div>
					 <%if ("Y".equals(request.getAttribute("hasAnswerAttachment")) && "Y".equals(request.getAttribute("isAnsAttachmentIMG"))){ %>	
					 <div class="form-row">				 
					  <div  class="form-group col-md-8">
				 		<label >Attachment (for Sample Answer)</label><br>
				 		<img src="data:image/jpg;base64,${question.sampleAnsAttachment.base64Image}"/>
				 		</div>
				 		</div>
				 		<%} %>
				  
				  </div>

					<br><label >Scores</label>
					<div class="form-row align-items-center">
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Analysis &  Evaluation</div>
				        </div>
				        <form:input path="analysisScore" class="form-control" id="" placeholder="0" name="" readonly="true"/>
				      </div>
				    </div>
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Logic & Reasoning</div>
				        </div>
				        <form:input path="logicScore" class="form-control" id="" placeholder="0" name="" readonly="true"/>
				      </div>
				      </div>
				      <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Judgement</div>
				        </div>
				        <form:input path="judgementScore" class="form-control" id="" placeholder="0" name="" readonly="true"/>
				      </div>
				    </div>
				    </div>
				    <div class="form-row align-items-center">
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Problem-solving</div>
				        </div>
				        <form:input path="probSolveScore" class="form-control" id="" placeholder="0" name="" readonly="true"/>
				      </div>
				    </div>
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Creative Thinking</div>
				        </div>
				        <form:input path="creativeScore" class="form-control" id="" placeholder="0" name="" readonly="true"/>
				      </div>
				    </div>
				    </div>

				   
					   
				  
				  
					 
					</div>
	                                    
				   </div>
              
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button onclick="modifyQuestion()" id="btn-addquestionset" class="btn btn-info float-right"><i id="btn-icon" class="fas fa-edit"></i> Modify</button>   
                <button  id="btn-addquestionset-back" onclick="delQuestions()" type="button" class="btn btn-info float-right"><i class="fas fa-trash"></i> Delete</button>          
                <button  id="btn-addquestionset-back"  class="btn btn-info float-right"><a href="manageQuestion.html"><i id="btn-icon" class="fas fa fa-arrow-left"></i>Back</a></button>
              </div>
              </form:form>
            </div>
            <!-- /.card -->
            </section>  
</body>    
</html>    