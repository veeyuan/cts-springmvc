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
#gradeLink{
	background-color: #FED136;
    color: #fff;
}

#dashboardLink{
    background-color: transparent;
    color: #6c757d;
}

#addLink{
   background-color: transparent;
    color: #6c757d;
}

#manageLink{
   background-color: transparent;
    color: #6c757d;
}
</style>
<script>
$(document).ready(function(){
    var date_input=$('input[name="date"]'); //our date input has the name "date"
    var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
    var options={
      format: 'mm/dd/yyyy',
      container: container,
      todayHighlight: true,
      autoclose: true,
    };
    date_input.datepicker(options);
  })
  
function gradeQuestion(){
	document.getElementById('gradeQuestionForm').submit(); 
   }
   


</script> 
</head>    
<body>    
 <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">Grade Results</h1>
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
                  Submissions
                </h3>
			   
			    <div class="searchfilter">
			      <form>			        
			         <div class="form-row">
			         <div class="form-group col-md-4">
			         		<input id="search"  class="form-control" type="text" placeholder="Search submission..." />			         
			         </div>
			         <div class="form-group col-md-2">
					      	<select class="form-control" name="">					      	
	                        <option value="general">General</option>
	                        <option value="">Primary School</option>
	                       	</select>
					  </div>
			        
	                <div class="form-group col-md-2">
					      <select class="form-control" name="">
					      	  <option placeholder="">All disciplines</option>
				              <option>Computer Science</option>
				              <option>Biology</option>
				              <option>Mathematics</option>
	                       </select>
					  </div>
					 <div class="form-group col-md-2">
				        <input class="form-control" id="date" name="date" placeholder="Submitted By" type="text"/>
				      </div>
					     
				
					 <span><button id="" onclick="" type="button" class="btn btn-info float-right"><i class="fas fa-search"></i> Search</button></span>
					  					  
					 </div>
			          
			        
			      </form>
			    </div>

                <div class="card-tools">
                  <ul class="pagination pagination-sm">
                    <li class="page-item"><a href="#" class="page-link">&laquo;</a></li>
                    <li class="page-item"><a href="#" class="page-link">1</a></li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">&raquo;</a></li>
                  </ul>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              <table class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col">Username</th>
				      <th scope="col">Category</th>
				      <th scope="col">Discipline</th>
				      <th scope="col">Number of Questions</th>
				      <th scope="col">Submitted Date</th>
				    </tr>
				  </thead>
				  <tbody>
                 <c:forEach items="${listQuestionCreated}" var="questset">
				<form id="gradeQuestionForm" method="post" action="gradeSubmissionDet.jsp"><input type="hidden" name="submissionid" id="submissionid" value="${submission.id}"></form>
					 <tr onclick="gradeQuestion()" class="text">
      					<th scope="row">
      					<!-- checkbox -->
		                    <div class="icheck-primary d-inline ml-2">
		                      <input type="checkbox" value="" name="todo1" id="todoCheck1">
		                      <label for="todoCheck1"></label>
		                    </div>						                     
							<!-- General tools such as edit or delete-->
		                    <span id="editdiv" class="tools">
		                      <i class="fas fa-edit"></i>
		                      <i class="fas fa-trash-o"></i>
		                    </span> 
		                   
		                    <!-- todo text -->
		                    <span > ${submission.title}</span>
		                    
		
		                                   
                  		</th>
					      <td>${submission.category}</td>
					      <td>${submission.discipline}</td>
					      <td>${submission.questionNo}</td>
					      <td>${submission.submitdt}</td>
   					 </tr>	
                 
               
                </c:forEach>
                 </ul>
                 </tbody>
				</table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button  id="btn-delete" onclick="" type="button" class="btn btn-info float-right"><i class="fas fa-trash"></i> Delete</button>  
               
              </div>
            </div>
	                                    
				 
            <!-- /.card -->
            </section>
</body>    
</html>    