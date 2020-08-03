<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<% %>
<html>    
<head>    
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
    color: #fff;s
}

#btn-addquestionset-back{
	margin-right:10px;
}

#btn-icon{
	margin-right:5px;
}

a {
  color: inherit; /* blue colors for links too */
  text-decoration: inherit; /* no underline */
}

#attachmentMsg{
  font-size:13px;
  color:red;
}
</style>
<script>

function setOption(selected){ //set number of options
	var x=selected.value;
	if (x=="2"){
		document.getElementById("opt3").value="";
		document.getElementById("opt4").value="";
		document.getElementById("opt5").value="";
		document.getElementById("opt3").disabled  =true;
		document.getElementById("opt4").disabled = true;
		document.getElementById("opt5").disabled = true;
	}else if (x=="3"){
		document.getElementById("opt3").disabled  =false;
		document.getElementById("opt4").value="";
		document.getElementById("opt5").value="";
		document.getElementById("opt4").disabled = true;
		document.getElementById("opt5").disabled = true;
	}else if (x=="4"){
		document.getElementById("opt3").disabled  = false;
		document.getElementById("opt4").disabled = false;
		document.getElementById("opt5").value="";
		document.getElementById("opt5").disabled = true;
	}else if (x=="5"){
		document.getElementById("opt3").disabled  = false;
		document.getElementById("opt4").disabled = false;
		document.getElementById("opt5").disabled = false;
	}
	else{
		document.getElementById("opt3").value="";
		document.getElementById("opt4").value="";
		document.getElementById("opt5").value="";
		document.getElementById("opt3").disabled  = false;
		document.getElementById("opt4").disabled = false;
		document.getElementById("opt5").disabled = false;
	}
} 

function setInitOption(selected){ //set number of options
	var x=selected;
	document.getElementById("optionNum").value=x;
	if (x=="2"){
		document.getElementById("opt3").value="";
		document.getElementById("opt4").value="";
		document.getElementById("opt5").value="";
		document.getElementById("opt3").disabled  =true;
		document.getElementById("opt4").disabled = true;
		document.getElementById("opt5").disabled = true;
	}else if (x=="3"){
		document.getElementById("opt3").disabled  =false;
		document.getElementById("opt4").value="";
		document.getElementById("opt5").value="";
		document.getElementById("opt4").disabled = true;
		document.getElementById("opt5").disabled = true;
	}else if (x=="4"){
		document.getElementById("opt3").disabled  = false;
		document.getElementById("opt4").disabled = false;
		document.getElementById("opt5").value="";
		document.getElementById("opt5").disabled = true;
	}else if (x=="5"){
		document.getElementById("opt3").disabled  = false;
		document.getElementById("opt4").disabled = false;
		document.getElementById("opt5").disabled = false;
	}
	else{
		document.getElementById("opt3").value="";
		document.getElementById("opt4").value="";
		document.getElementById("opt5").value="";
		document.getElementById("opt3").disabled  = false;
		document.getElementById("opt4").disabled = false;
		document.getElementById("opt5").disabled = false;
	}
}
	
function setMCQ(selected){ //if it is discipline-specific
	var x=selected.value;
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
		var num = <%=request.getAttribute("numberOfOptions")%>;
		if (num !== undefined){
			setInitOption(num);			
		}
		var mcqans = document.getElementById("mcqanswer").value;
		document.getElementById("numChoice").value = mcqans;
	}else{
		document.getElementById("mcq1").checked = false;
		document.getElementById("mcq2").checked = true;	
		document.getElementById("mcqDiv").style.display = "none";
		document.getElementById("structuredDiv").style.display = "block";	
		
	}
}



addLoadEvent(setInit); 

function submitChange(){
	document.getElementById('questionForm').submit();
}

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
                  Modify Question
                </h3>
                </div>
                <form:form id="questionForm" action ="modifyProcess.html"  method="post" modelAttribute="question" enctype="multipart/form-data">                			 
                <input type="hidden" name="questionID" id="questionID" value="${question.id}"/>   
                <input type="hidden" name="quesAttachmentID" id="quesAttachmentID" value="${question.questionAttachment.id}"/>
                <input type="hidden" name="ansAttachmentID" id="ansAttachmentID" value="${question.sampleAnsAttachment.id}"/>            
                <div class="card-tools">
                 <div class="form-row">
				  <div class="form-group col-md-8">
				    <label >Question</label>
				    <form:textarea path="questionDscp" class="form-control" id="" rows="2" placeholder="Question" value="${question.questionDscp}" />
				 </div>
				  <div class="form-group col-md-2">
				 		<label >Attachment (for Question)</label>
				 		<input type="file" class="form-control-file" id="exampleFormControlFile1" name="questionAttachment">
				  </div>
				  <%if ("Y".equals(request.getAttribute("hasQuestionAttachment"))){ %>
				  <div class="form-group col-md-1">
				 		<p id="attachmentMsg">${question.questionAttachment.fileName} is uploaded. New attachment will replace it.</p>
				  </div>
				  <%} %>
				 </div>
			
				 
				  
				  <div class="form-row">
					  
	  				  <div class="form-group col-md-3">
	  				  <label >Discipline</label>
	  				  	 <input type="hidden" id="discipline" value="${question.disciplineCd}">  
	                     <form:select path="disciplineCd" id="disciplineCd" class="form-control" >
	                       <c:forEach items="${listDiscipline}" var="discipline">
					      	  <form:option value ="${discipline.code}" label="${discipline.name}" />
				              </c:forEach>
	                       </form:select>
	                   </div>
	                   
	               
	                <div class="form-group col-md-2">
					      <label >Suitable Category</label>
					      <input type="hidden" id="category" value="${question.categoryCd}"> 
					      <form:select path="categoryCd" id="categoryCd" class="form-control" >
					      	<c:forEach items="${listCategory}" var="category">
					      	  <form:option value ="${category.code}" label="${category.name}" />
				              </c:forEach>
	                       </form:select>
					  </div>
					 <div class="form-group col-md-2">
					      <label >Language</label>
					      <input type="hidden" id="language" value="${question.languageCd}"> 
					      <form:select path="languageCd" id="languageCd" class="form-control" name="questionsetlang">
					      <c:forEach items="${listLanguage}" var="language">
					      	  <form:option value ="${language.code}" label="${language.name}" />
				              </c:forEach>
	                       </form:select>
					  </div>
					  <div class="form-group col-md-3">
					    <label >Multi-choiced Question?</label><br>
					    <input type="hidden" id="isMcq" value="${question.mcq}">  
							<div class="custom-control custom-radio custom-control-inline">
							  <input onclick="setMCQ(this);" type="radio"  id="mcq1" name="radio-all-mcq" class="custom-control-input" value="yes" >
							  <label class="custom-control-label" for="mcq1">Yes</label>
							</div>
							<div class="custom-control custom-radio custom-control-inline">
							  <input onclick="setMCQ(this);" type="radio" id="mcq2" name="radio-all-mcq" class="custom-control-input" value="no" >
							  <label class="custom-control-label" for="mcq2">No</label>
							</div>				 
					   </div>
					 </div>
					 
					 <div id="mcqDiv">
					 <div class="form-row">					
					    <div  class="form-group col-md-3" >
	                   		<label >Number of Choices</label>
							<select onchange="setOption(this)" class="form-control" id="optionNum" >
							<option value="2">2</option>
					      	<option value="3">3</option>
	                        <option value="4">4</option>
	                        <option value="5">5</option>
	                       </select>	                   </div>
	                   <div  class="form-group col-md-2" >
	                   		<label >Correct Answer</label>
	                   		<input type="hidden" id="mcqanswer" value="${question.sampleAns}">
	                   		<form:input path="mcqAns" class="form-control" id="numChoice" placeholder="Option Number (eg. 1)" value=""  />                			               		
	                   </div>			 
					 </div>
					 
					
					 <div class="form-group row">
					    <label class="col-sm-1 col-form-label">Option 1</label>
					    <div class="col-sm-9">
    					 	<form:textarea path="option1" class="form-control" id="opt1" rows="1" placeholder="Option 1" />
				   		</div>
				  </div>
					<div class="form-group row">
					    <label class="col-sm-1 col-form-label">Option 2</label>
					    <div class="col-sm-9">
    					 	<form:textarea path="option2"  class="form-control" id="opt2" rows="1" placeholder="Option 2"  />
				   		</div>
				  </div>
					<div  class="form-group row">
					    <label class="col-sm-1 col-form-label">Option 3</label>
					    <div class="col-sm-9">
    					 	<form:textarea path="option3"  class="form-control" id="opt3" rows="1" placeholder="Option 3"  />
				   		</div>
				  </div>
				  <div class="form-group row">
					    <label class="col-sm-1 col-form-label">Option 4</label>
					    <div class="col-sm-9">
    					 	<form:textarea path="option4"  class="form-control" id="opt4" rows="1" placeholder="Option 4" />
				   		</div>
				  </div>
				  <div class="form-group row">
					    <label class="col-sm-1 col-form-label">Option 5</label>
					    <div class="col-sm-9">
    					 	<form:textarea path="option5"  class="form-control" id="opt5" rows="1" placeholder="Option 5"   />
				   		</div>
				  </div>
				  
				  </div>
				  <div id="structuredDiv" style="display:none">
				   <div class="form-row">
					  <div class="form-group col-md-8">
					    <label >Sample Answer</label>
					    <form:textarea path="sampleAns" class="form-control" id="" rows="1" placeholder="as marking scheme" />
					 </div>
					 <div class="form-group col-md-2">
				 		<label >Attachment (for Sample Answer)</label>
				 		<input type="file" class="form-control-file" id="exampleFormControlFile1" name="sampleAnsAttachment">
				  </div>
				   <%if ("Y".equals(request.getAttribute("hasAnswerAttachment"))){ %>
				  <div class="form-group col-md-1">
				 		<p id="attachmentMsg">${question.sampleAnsAttachment.fileName} is uploaded. New attachment will replace it.</p>
				  </div>
				  <%} %>
					 </div>
					 
				  
				  </div>

					<br><label >Scores Weightage</label>
					<div class="form-row align-items-center">
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Analysis &  Evaluation</div>
				        </div>
				        <form:input path="analysisScore" class="form-control" id="" placeholder="0" name="" />
				      </div>
				    </div>
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Logic & Reasoning</div>
				        </div>
				        <form:input path="logicScore" class="form-control" id="" placeholder="0" name="" />
				      </div>
				      </div>
				      <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Judgement</div>
				        </div>
				        <form:input path="judgementScore" class="form-control" id="" placeholder="0" name="" />
				      </div>
				    </div>
				    </div>
				    <div class="form-row align-items-center">
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Problem Solving</div>
				        </div>
				        <form:input path="probSolveScore" class="form-control" id="" placeholder="0" name="" />
				      </div>
				    </div>
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Creative Thinking</div>
				        </div>
				        <form:input path="creativeScore" class="form-control" id="" placeholder="0" name="" />
				      </div>
				    </div>
				    </div>

				   
					   
				  
				  
					 
					</div>
	                  </form:form>
	                                    
				   </div>
              
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button onclick="submitChange()" id="btn-addquestionset" class="btn btn-info float-right"><i id="btn-icon" class="fas fa-edit"></i> Submit Change</button>             
                <button Onclick="history.back(-1)" id="btn-addquestionset-back"  class="btn btn-info float-right"><i id="btn-icon" class="fas fa fa-arrow-left"></i>Back</button>
              </div>
            </div>
            <!-- /.card -->
            </section>  
</body>    
</html>    