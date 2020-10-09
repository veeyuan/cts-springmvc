<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.Question" %>
<%@ page import="java.util.List" %>

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

.form-check{
	margin:3px;
	font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color:white;
}
.form-check-label{
	margin-left:3px;
	margin-top:2px;
}
.form-check-input{
	width: 20px; 
    height: 20px; 
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

function getPageNum(objButton){
	var target=objButton.value;
	document.getElementById('targetPage').value=target;
	document.getElementById('filterForm').submit();
	
}

function search(){
	document.getElementById('targetPage').value = "1";
	document.getElementById('filterForm').submit();
}

function changeSelected(){
	  var checkBox = document.getElementById("defaultCheck1");
	  if (checkBox.checked == true){
		  document.getElementById("strIsSelectedToAsk").value = "Y";
	  }else{
		  document.getElementById("strIsSelectedToAsk").value = "N";
	  }
	  
}
</script>  
</head>    
<body> 
<% 
int currentPage=0;
int totalPage=0;
int previousPage=0;
int nextPage=0;
if ("POST".equalsIgnoreCase(request.getMethod())) {
	   currentPage = Integer.parseInt((String)request.getAttribute("currentPage"));	   
	   previousPage = currentPage-1;
	   nextPage = currentPage+1; 
} else{
	currentPage=1;
}
totalPage = Integer.parseInt((String)request.getAttribute("totalPages"));

                  	 
%>    
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
			      <input type="hidden" name="targetPage" id="targetPage" value="1"/>
			         <div class="form-row">
			         <div class="form-group col-md-4">
			         		<form:input path="questionDscp" id="search"  class="form-control"  placeholder="Search question..." />	
			         </div>
			         <div class="form-group col-md-2">
					      <form:select path="hotsComponentCd"  class="form-control" name="hotsComponentCd">
					      <form:option value = "all" label="All"/>		
					      <c:forEach items="${listHotsComponent}" var="hots">
					      	  <form:option value ="${hots.code}" label="${hots.name}"/>
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
	                <div class="form-group col-md-2">
					       <div class="form-check">
					       <form:hidden path = "strIsSelectedToAsk" id="strIsSelectedToAsk" value = "N"/>				       
							  <input onclick="changeSelected()" class="form-check-input" type="checkbox" value="" id="defaultCheck1">
							  <label class="form-check-label" for="defaultCheck1">
							    Only selected 
							  </label>
							</div>				       
					  </div>
					  
					 
					 <span><button onclick="search()" class="btn btn-info float-right"><i class="fas fa-search"></i> Search</button></span>
					  					  
					 </div>
			          
			        
			      </form:form>
			    </div>

                <div class="card-tools">
                  <ul class="pagination pagination-sm">
                   <%if (currentPage==1){ %>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='1' class="page-link" /></li>
                    	<%if (totalPage>1){ %>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='2' class="page-link" /></li>
                    		<%if (totalPage>2){ %>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='3' class="page-link" /></li>
                    		<%} %>
                    <li class="page-item"><button onclick="getPageNum(this)" type='button' value='<%=currentPage+1%>' class="page-link" />&raquo;</button></li>
                    	<%} %>
                    <%}else if (currentPage==totalPage){ %>
                    <li class="page-item"><button onclick="getPageNum(this)" type='button' value='<%=currentPage-1%>' class="page-link" />&laquo;</button></li>
                    	<%if (currentPage-2>0){ %>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=currentPage-2%>' class="page-link" /></li>
                    	<%} %>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=currentPage-1%>' class="page-link" /></li>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=currentPage%>' class="page-link" /></li>
                    <%}else{ %>
                    <li class="page-item"><button onclick="getPageNum(this)" type='button' value='<%=currentPage-1%>' class="page-link" />&laquo;</button></li>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=previousPage%>' class="page-link" /></li>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=currentPage%>' class="page-link" /></li>
                    <li class="page-item"><input onclick="getPageNum(this)" type='button' value='<%=nextPage%>' class="page-link" /></li>
                    <li class="page-item"><button onclick="getPageNum(this)" type='button' value='<%=currentPage+1%>' class="page-link" />&raquo;</button></li>
                    <%} %>
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
				      <th scope="col">HOTS Component</th>
				      <th scope="col">Language</th>				      
				      <th scope="col">Is Selected</th>
				      <th scope="col">MCQ</th>
				    </tr>
				  </thead>
				  <tbody>    
				  <% List<Question> questionlst = (List<Question>) request.getAttribute("listQuestion");
				 int i=0;%>             
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
					      <td>${question.hotsDSCP}</td>
					      <td>${question.languageCd}</td>
					      <%if (questionlst.get(i).isSelectedToAsk()){ %>
					      <td>Yes</td>
					      <%}else{ %>
					      <td>No</td>
					      <%} %>
					      
					      <%if (questionlst.get(i).isMcq()){ %>
					      <td>Yes</td>
					      <%}else{ %>
					      <td>No</td>
					      <%} i++; %>
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