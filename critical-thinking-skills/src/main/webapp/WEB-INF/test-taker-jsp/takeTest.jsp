<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>

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

#instruction{
	line-height: 2.5;
}

@media (min-width: 1200px) {
   .modal-xlg {
      width: 90%; 
   }
}
</style>
<script>

function getQuestions(){
	document.getElementById('questionForm').submit();
} 

function setInit(){
	//setUserName
	var username = document.getElementById("username").value;
	$('#usernameDisplay').html(username);
	var discipline = document.getElementById("discipline").value;
	$('#disciplineCd').val(discipline).change();
	var category = document.getElementById("category").value;
	$('#categoryCd').val(category).change();
	var language = document.getElementById("language").value;
	$('#languageCd').val(language).change(); 
}


addLoadEvent(setInit); 

   


</script> 
</head>  
<% User user = (User)request.getAttribute("user"); 
String lastTestDate = request.getAttribute("lastTestDate").toString(); 
boolean hasTakenTestRecently = false;
if (!"noRecords".equalsIgnoreCase(lastTestDate)){
	String[] values = lastTestDate.split("-");
	int year = Integer.parseInt(values[0]);
	int month = Integer.parseInt(values[1]);
	int day = Integer.parseInt(values[2]);
	Calendar sixMonthsAgo = Calendar.getInstance();             
	sixMonthsAgo.add(Calendar.MONTH, -6);                       
	Calendar newDate = new GregorianCalendar(year, month, day);
	if (!newDate.before(sixMonthsAgo)) {
		hasTakenTestRecently = true;
	}
}



%>  
<body>   
 <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">Take Test</h1>
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
	<%if (user.isReadyToTakeTest()){ %>
		
           <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  Start Test
                </h3>
               
              </div>
              <%if (!hasTakenTestRecently){ %>
              <div class="card-body">
              
             <form:form id="questionForm" action ="takeTest.html"  method="post" modelAttribute="user" >
             <input type="hidden" id="username" value="<%=request.getSession().getAttribute("username").toString()%>">
             <input type="hidden" id="userid" value="${user.id}"> 
              <div class="form-row">					  
	  				  <div class="form-group col-md-3">
	  				  <label >Discipline</label>
	  				  	 <input type="hidden" id="discipline" value="${user.disciplineCd}">  
	                     <form:select path="disciplineCd" id="disciplineCd" class="form-control" >
	                       <c:forEach items="${listDiscipline}" var="discipline">
					      	  <form:option value ="${discipline.code}" label="${discipline.name}" disabled="true"/>
				              </c:forEach>
	                       </form:select>
	                   </div>
	                   
	               
	                <div class="form-group col-md-2">
					      <label >Suitable Category</label>
					      <input type="hidden" id="category" value="${user.categoryCd}"> 
					      <form:select path="categoryCd" id="categoryCd" class="form-control" >
					      	<c:forEach items="${listCategory}" var="category">
					      	  <form:option value ="${category.code}" label="${category.name}" disabled="true"/>
				              </c:forEach>
	                       </form:select>
					  </div>
					  <div class="form-group col-md-2">
					  <label >Language</label>
	  				  	 <input type="hidden" id="language" value="${user.languageCd}">  
	                     <form:select path="languageCd" id="languageCd" class="form-control" >
	                       <c:forEach items="${listLanguage}" var="language">
					      	  <form:option value ="${language.code}" label="${language.name}" disabled="true" />
				              </c:forEach>
	                       </form:select>
	                   </div>
					  
					 </div>
               </form:form>   
              <p id="instruction">Please make sure the above details is accurate, for questions will be generated according to the criteria. 
              If you want to make change, please change the test specification in Manage Profile.        
              <br>Once you are ready, you may click on the button to start the test. <p>
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
                <button  id="btn-start" onclick="getQuestions()" type="button" class="btn btn-info float-right"><i class="far fa-edit"></i> Start Test</button>  
               
              </div>
            
            <%}else{ %>
            <div class="card-body">
            <p id="instruction">You have just completed your test on <%=lastTestDate %>.    
              <br>You can only test yourself again six months after your last test.  <p>
            </div>
            
            <%} %>
            </div>
	 <%}else{ %>   
	 <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  Start Test
                </h3>
               
              </div>
	  <div class="card-body">
	   <p id="instruction">You are required to complete the survey form in <a href="manageProfile.html">Manage Profile</a> and select your test specification to start test.<p>
              </div>
	 <%} %>                   
				 
            <!-- /.card -->
            </section>
            
           
</body>    
</html>    