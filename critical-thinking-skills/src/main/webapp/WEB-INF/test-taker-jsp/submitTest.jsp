<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>    
<head>  
  
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

</style>

</head>    

<body>    
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
                  Submit Test
                </h3>
                </div>
                <div class="card-tools">
                 <% if ("Y".equals(request.getAttribute("success"))){ %>
               		<div id="success">               		
               		<i id="success-icon" class="fa fa-check-circle fa-2x"> </i>               		
               		<p>Successfully submitted!</p>
               	 	<p id="smallMsg">You may check your results in View Result once it is graded.</p>
               		</div>
               		<%}else{ %>
               		<div id="failure"> 
               		<i id="failure-icon" class="fa fa-times-circle fa-2x"> </i>
               		<p>Failed to submit</p>
               	 	<p id="smallMsg">You may go back to previous page to submit again.</p>
               		</div>
               		<%} %> 
				
					</div>
	                                    
				   </div>
              
              <!-- /.card-body -->
              <div class="card-footer clearfix">
              	<% if (!"Y".equals(request.getAttribute("success"))){ %>
              	<button onclick="history.back(-1)"   class="btn btn-info float-right"><i id="btn-icon" class="fas fa fa-arrow-left"></i>Back</button>
              	<%} %> 
              </div>
            </div>
            <!-- /.card -->
            </section>  
</body>    
</html>    