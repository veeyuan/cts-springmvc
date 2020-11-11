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
#manageOptLink{
	background-color: transparent;
    color: #6c757d;
}
#manageLink{
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
a {
  color: inherit; /* blue colors for links too */
  text-decoration: inherit; /* no underline */
}
</style>
<script>


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
              <button id="btn-addquestionset"  class="btn btn-info float-right"><a href="addQuestion.html"><i id="btn-icon" class="fas fa-plus"></i> Create New</a></button> 
              	<% if (!"Y".equals(request.getAttribute("success"))){ %>
              	<button onclick="history.back(-1)"  id="btn-addquestionset-back"  class="btn btn-info float-right"><i id="btn-icon" class="fas fa fa-arrow-left"></i>Back</button>
              	<%} %>
              </div>
            </div>
            <!-- /.card -->
            </section>  
</body>    
</html>    