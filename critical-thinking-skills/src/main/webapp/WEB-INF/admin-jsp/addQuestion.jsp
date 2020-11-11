<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
	background-color: #FED136;
    color:#14171a;
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
   background-color: transparent;
    color: #6c757d;
}
#manageOptLink{
	background-color: transparent;
    color: #6c757d;
}
#manageAdminLink{
	background-color: transparent;
    color: #6c757d;
}
#changePswdLink{
	background-color: transparent;
    color: #6c757d;
}
</style>
<script>
/* function setDiscipline(selected){ //if it is discipline-specific
	var x=selected.value;
	if (x=="yes"){
		document.getElementById("chooseDiscipline").disabled  = false;
		
	}else{
		document.getElementById("chooseDiscipline").value  = "";
		document.getElementById("chooseDiscipline").disabled  = true;
		document.getElementById("other-discipline").value="";
		document.getElementById("other-discipline").disabled = true;
	}
}
function changeDiscipline(selected){ //if discipline not in the list
	var x=selected.value;
	if (x=="others"){
		document.getElementById("other-discipline").disabled  = false;
	}else{
		document.getElementById("other-discipline").value="";
		document.getElementById("other-discipline").disabled = true;
	}
} */

function setOption(selected){ //set number of options
	var x=selected.value;
	 for (var i = 10; i > x ; i--) {
		 var id = "opt"+i;
		  document.getElementById(id).value="";
	      document.getElementById(id).disabled  =true;
	    }
	 for (var i = 1; i <= x ; i++) {
		 var id = "opt"+i;
	      document.getElementById(id).disabled = false;
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
	 for (var i = 1; i <=10 ; i++) {
		 var id = "opt"+i;
		  document.getElementById(id).value="";
	      document.getElementById(id).disabled  =true;
	    }
	 document.getElementById("opt1").disabled = false;
	 document.getElementById("opt2").disabled = false;
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
            <h1 id="title" class="m-0 text-dark">Add Question</h1>
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
                  Add Question
                </h3>
                </div>
                <form:form id="questionForm" action ="addProcess.html"  method="post" modelAttribute="question" enctype="multipart/form-data">
                <div class="card-tools">
                 <div class="form-row">
				  <div class="form-group col-md-8">
				    <label >Question</label>
				    <form:textarea path="questionDscp" class="form-control" id="" rows="2" placeholder="Question"/>
				 </div>
				 <div class="form-group col-md-2">
				 		<label >Attachment (for Question)</label>
				 		<input type="file" class="form-control-file" id="exampleFormControlFile1" name="questionAttachment">
				  </div>
				  </div>
				  <div class="form-row">
					  
	  				  <div class="form-group col-md-3">
	  				  <label >Discipline</label>
	                     <form:select path="disciplineCd"  class="form-control" >
	                       <c:forEach items="${listDiscipline}" var="discipline">
					      	  <form:option value ="${discipline.code}" label="${discipline.name}"/>
				              </c:forEach>
	                       </form:select>
	                   </div>
	                   
	               
	                <div class="form-group col-md-2">
					      <label >Suitable Category</label>
					      <form:select path="categoryCd" class="form-control" >
					      	<c:forEach items="${listCategory}" var="category">
					      	  <form:option value ="${category.code}" label="${category.name}"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					 <div class="form-group col-md-2">
					      <label >Language</label>
					      <form:select path="languageCd"  class="form-control" name="questionsetlang">
					      <c:forEach items="${listLanguage}" var="language">
					      	  <form:option value ="${language.code}" label="${language.name}"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					  </div>
					  <div class="form-row">
					  <div class="form-group col-md-3">
					      <label >HOTS Component</label>
					      <form:select path="hotsComponentCd"  class="form-control" name="hotsComponentCd">
					      <c:forEach items="${listHotsComponent}" var="hots">
					      	  <form:option value ="${hots.code}" label="${hots.name}"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					  <div class="form-group col-md-2">
					    <label >Display for answering?</label><br>
							<div class="custom-control custom-radio custom-control-inline">
							  <form:radiobutton path="strIsSelectedToAsk" id="mcqA" name="radio-all-mcq" class="custom-control-input" value="Y" checked="Yes"/>
							  <label class="custom-control-label" for="mcqA">Yes</label>
							</div>
							<div class="custom-control custom-radio custom-control-inline">
							  <form:radiobutton path="strIsSelectedToAsk"  id="mcqB" name="radio-all-mcq" class="custom-control-input" value="N"  />
							  <label class="custom-control-label" for="mcqB">No</label>
							</div>				 
					   </div>
					  <div class="form-group col-md-2">
					    <label >Multi-choiced Question?</label><br>
							<div class="custom-control custom-radio custom-control-inline">
							  <input onclick="setMCQ(this);" type="radio"  id="mcq1" name="radio-all-mcq" class="custom-control-input" value="yes" checked>
							  <label class="custom-control-label" for="mcq1">Yes</label>
							</div>
							<div class="custom-control custom-radio custom-control-inline">
							  <input onclick="setMCQ(this);" type="radio" id="mcq2" name="radio-all-mcq" class="custom-control-input" value="no"  >
							  <label class="custom-control-label" for="mcq2">No</label>
							</div>				 
					   </div>	
					   <div class="form-group col-md-2">
				    <label >Time Limit (Minute)</label>
				    <form:input path="timeLimitMin" class="form-control"  placeholder="0"/>
				 </div>
					 </div>
					 
					 <div id="mcqDiv">
					 <div class="form-row">	
					 			
					    <div  class="form-group col-md-3" >
	                   		<label >Number of Choices</label>
							<form:select path="optionArrSize" class="form-control" onchange="setOption(this)" id="optionArrSize" >
							<%for (int i=2;i<=10;i++){ %>
							<form:option value="<%=i%>"><%=i%></form:option>					      
	                        <%} %>
	                       </form:select>                 </div>
	                   <div  class="form-group col-md-2" >
	                   		<label >Answer</label>
	                   		<form:input path="mcqAns" class="form-control" id="numChoice" placeholder="Option Number (eg. 1)" value="" />                			               		
	                   </div>			 
					 </div>
					<c:forEach begin="0" end="9" varStatus="status">
			    	<div class="form-group row">
					    <label class="col-sm-1 col-form-label">Option ${status.index+1}</label>
					    <div class="col-sm-9">
    					 	<form:textarea path="optionArr[${status.index}]"  class="form-control" id="opt${status.index+1}" rows="1" placeholder="-"  value="" />
				   		</div>
				  </div>
			</c:forEach>
				  
				  </div>
				  <div id="structuredDiv" style="display:none">
				   <div class="form-row">
					  <div class="form-group col-md-8">
					    <label >Answer</label>
					    <form:textarea path="sampleAns" class="form-control" id="" rows="1" placeholder="as marking scheme"/>
					 </div>
					  <div class="form-group col-md-2">
				 		<label >Attachment (for Answer)</label>
				 		<input type="file" class="form-control-file" id="exampleFormControlFile1" name="sampleAnsAttachment">
				  </div>
				  </div>
				  </div>

					<br><label >Scores</label>
					<div class="form-row align-items-center">
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Analysis &  Evaluation</div>
				        </div>
				        <form:input path="analysisScore" class="form-control" id="" placeholder="0" name=""/>
				      </div>
				    </div>
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Logic & Reasoning</div>
				        </div>
				        <form:input path="logicScore" class="form-control" id="" placeholder="0" name=""/>
				      </div>
				      </div>
				      <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Judgement</div>
				        </div>
				        <form:input path="judgementScore" class="form-control" id="" placeholder="0" name=""/>
				      </div>
				    </div>
				    </div>
				    <div class="form-row align-items-center">
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Problem Solving</div>
				        </div>
				        <form:input path="probSolveScore" class="form-control" id="" placeholder="0" name=""/>
				      </div>
				    </div>
				    <div class="col-sm-3 my-1">
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <div class="input-group-text">Creative Thinking</div>
				        </div>
				        <form:input path="creativeScore" class="form-control" id="" placeholder="0" name=""/>
				      </div>
				    </div>
				    </div>

				   
					   
				  
				  
					 
					</div>
	                                    
				   </div>
              
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button id="btn-addquestionset" type="submit" class="btn btn-info float-right"><i class="fas fa-plus"></i> Create</button>
              </div>
              </form:form>
            </div>
            <!-- /.card -->
            </section>  
</body>    
</html>    