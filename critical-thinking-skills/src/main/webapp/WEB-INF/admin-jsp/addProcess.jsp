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
    color: #fff;
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

#success{
  border-style: solid;
  border-color: green;
  color:green;
  font-size:3rem;
  padding:30px;'
}

#success-icon{
	float: left;	
	margin-right:20px;
}

#failure{
  border-style: solid;
  border-color: #B90101;
  color:#B90101;
  font-size:3rem;
  padding:30px;'
}

#failure-icon{
	float: left;	
	margin-right:20px;
}

#smallMsg{
	font-size:1rem;
	color: #495057;
}

#btn-addquestionset-back{
	margin-right:10px;
}

#btn-icon{
	margin-right:5px;
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
                <div class="card-tools">
                 	<% if ("Y".equals(request.getAttribute("success"))){ %>
               		<div id="success">               		
               		<i id="success-icon" class="fa fa-check-circle fa-2x"> </i>               		
               		<p>Successfully added!</p>
               	 	<p id="smallMsg">You may make change on the question in Manage Question.</p>
               		</div>
               		<%}else{ %>
               		<div id="failure"> 
               		<i id="failure-icon" class="fa fa-times-circle fa-2x"> </i>
               		<p>Failed to add</p>
               	 	<p id="smallMsg">Please make sure all fields are filled. You may go back to previous page to submit request again.</p>
               		</div>
               		<%} %>
				
					</div>
	                                    
				   </div>
              
              <!-- /.card-body -->
              <div class="card-footer clearfix">
              <a href="addQuestion.html"><button id="btn-addquestionset"  class="btn btn-info float-right"><i id="btn-icon" class="fas fa-plus"></i> Create New</button></a> 
              	<% if (!"Y".equals(request.getAttribute("success"))){ %>
              	<button onclick="history.back(-1)"  id="btn-addquestionset-back"  class="btn btn-info float-right"><i id="btn-icon" class="fas fa fa-arrow-left"></i>Back</button>
              	<%} %>
              </div>
            </div>
            <!-- /.card -->
            </section>  
</body>    
</html>    