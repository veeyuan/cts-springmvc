<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>    
<head>    
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
#manageLink{
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

#gradeLink{
   background-color: transparent;
    color: #6c757d;
}

a {
  color: inherit; /* blue colors for links too */
  text-decoration: inherit; /* no underline */
}

#checkboxCol{
	width: 30px;
  	overflow: hidden;
}
</style>
<script>

function delQuestions(){
	document.getElementById('delQuestionForm').submit(); 
}

function getQuestionDet(id){
	document.getElementById('questionID').value=id;
	document.getElementById('viewQuestionForm').submit();
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
                  Questions
                </h3>
			   
			    <div class="searchfilter">
			      <form:form id="filterForm" action ="manageQuestion.html"  method="post" modelAttribute="question" >			        
			         <div class="form-row">
			         <div class="form-group col-md-4">
			         		<form:input path="questionDscp" id="search"  class="form-control"  placeholder="Search question..." />			         
			         </div>
			         <div class="form-group col-md-2">
	                        <form:select path="categoryCd" class="form-control" >
	                        <form:option value = "all" label="All"/>
					      	<c:forEach items="${listCategory}" var="category">
					      	  <form:option value ="${category.code}" label="${category.name}"/>
				              </c:forEach>
	                       </form:select>
					  </div>
			        
	                <div class="form-group col-md-2">
					       <form:select path="disciplineCd"  class="form-control" >
					       <form:option value = "all" label="All"/>					       
	                       <c:forEach items="${listDiscipline}" var="discipline">
					      	  <form:option value ="${discipline.code}" label="${discipline.name}"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					  
					 <div class="form-group col-md-2">
					       <form:select path="languageCd"  class="form-control" name="questionsetlang">
					       <form:option value = "all" label="All"/>  
					      <c:forEach items="${listLanguage}" var="language">
					      	  <form:option value ="${language.code}" label="${language.name}"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					 <span><button type="submit" class="btn btn-info float-right"><i class="fas fa-search"></i> Search</button></span>
					  					  
					 </div>
			          
			        
			      </form:form>
			    </div>

                <div class="card-tools">
                  <ul class="pagination pagination-sm">
                    <li class="page-item"><a href="#" class="page-link">&laquo;</a></li>
                    <li class="page-item"><a href="manageQuestion.html/1" class="page-link">1</a></li>
                    <li class="page-item"><a href="manageQuestion.html/2" class="page-link">2</a></li>
                    <li class="page-item"><a href="manageQuestion.html/3" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">&raquo;</a></li>
                  </ul>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              <form id="delQuestionForm" method="post" action="deleteProcess.html">  
              <table class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col"> </th>
				      <th scope="col">Question</th>
				      <th scope="col">Category</th>
				      <th scope="col">Discipline</th>
				      <th scope="col">Language</th>
				      <th scope="col">MCQ</th>
				    </tr>
				  </thead>
				  <tbody>                 
                 <c:forEach items="${listQuestion}" var="question">				
					 <tr >
					 	<td id="checkboxCol">					 	
					 	<div class="icheck-primary d-inline ml-2">
					 	<input type="checkbox" name="delQuestionList" value="${question.id}" id="${question.id}">
					 	<label  for="${question.id}"> </label>
					 	</div>					 	
					 	</td>					 					 
      					<td onclick="getQuestionDet(document.getElementById('id${question.id}').value)" >  
							<input type="hidden" id="id${question.id}" value="${question.id}"/>					  
   	
      					<a href="javascript:document.getElementById('request_form${question.id}').submit();" >				
  				             <span id="editdiv" class="tools">
		                      <i class="fas fa-edit"></i>
		                    </span>  	
		                     <c:out value="${question.questionDscp}" />		               
		                </a>                   
                  		</td>
					      <td>${question.categoryCd}</td>
					      <td>${question.disciplineCd}</td>
					      <td>${question.languageCd}</td>
					      <td>${question.mcq}</td>
   					 </tr>	                 
                </c:forEach>
                 </tbody>
				</table>
			 </form>
			 <form id="viewQuestionForm" method="post" action="viewQuestionDet.html">
			 <input type="hidden" name="questionID" id="questionID"/>
			 </form>			 
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button  id="btn-delete" onclick="delQuestions()" type="button" class="btn btn-info float-right"><i class="fas fa-trash"></i> Delete</button>  
               
              </div>
            </div>
	         </div>                           
				 
            <!-- /.card -->
            </section> 
</body>    
</html>    