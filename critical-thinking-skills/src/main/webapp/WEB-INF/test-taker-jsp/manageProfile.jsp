<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cts.model.SurveyForm" %>
<%@ page import="com.cts.model.User" %>

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

#testLink{
	background-color: transparent;
    color: #6c757d;
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
   
    background-color: #FED136;
    color: #14171a;
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

function getForm(id){
	document.getElementById('formid').value=id;
	document.getElementById('surveyForm').submit();
}

function submitChange(){
	document.getElementById('testSpecForm').submit();
	
	
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

function changeSelected(){
	  var checkBox = document.getElementById("defaultCheck1");
	  if (checkBox.checked == true){
		  document.getElementById("consentToTakeSurvey").value = "Y";
	  }else{
		  document.getElementById("consentToTakeSurvey").value = "N";
	  }
	  
}

function submitConsent(){
	var consent =  document.getElementById("consentToTakeSurvey").value ;
	if (consent=='Y'){
		document.getElementById('consentForm').submit();
	}else{
		alert("You have not signed the consent form.");
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
            <h1 id="title" class="m-0 text-dark">Manage Profile</h1>
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
           <%User user = (User)request.getAttribute("user"); %>
            <%if (user.isJoinSurvey()){ %>
              <div class="card">
              
              <!-- /.card-header -->
             
              <%if (user.isConsentGrantedToSurvey()){ %>
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  Survey Form
                </h3>
               
              </div>
              <div class="card-body">
                 <table class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col">Section</th>
				      <th scope="col">Title</th>
				      <th scope="col">Submitted</th>
				      
				    </tr>
				  </thead>
				  <tbody>                 
				  <%
				  List<SurveyForm> formlist = (List<SurveyForm>) request.getAttribute("formLst"); 
				  int ind=0;
				  char no='A';%>
                 <c:forEach items="${listForm}" var="form">		
                 <input type="hidden" id="id${form.id}" value="${form.id}"/>	
                 <% 
                 if (!formlist.get(ind).isCompleted()){
                	%>	 		
					 <tr onclick="getForm(document.getElementById('id${form.id}').value)" >
					 <%}else{ %> 
					 <tr>
				<%} %>
			 			<td><%=no%></td>
      					<td>  											  
  				             	
		                     <c:out value="${form.formName}" />		               
                  		</td>
                  		<% if (formlist.get(ind).isCompleted()){ %>
					      <td><i class="fas fa-check"></i></span></td>
					      <%}else{ %>
					      <td ><span><i class="fas fa-times"></i><span></td>
					      <%} %>
   					 </tr>	 
   					 <% no+=1;
   					 ind++;%>                
                </c:forEach>
                 </tbody>
				</table>
			 <form id="surveyForm" method="post" action="fillSurvey.html">
			 <input type="hidden" name="formid" id="formid"/>
			 </form>
              </div>
              <!-- /.card-body -->
             
            </div>
             
	          <%}else{ %>      
	          <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  Consent of Participation
                </h3>
               
              </div>
	          <div class="card-body">
             <form:form id="consentForm" action ="manageProfile.html" method="post"  >
             <input type="hidden" id="consentToTakeSurvey" name="consentToTakeSurvey" value="N">		
             <div style="margin-left:5%;margin-right:5%;text-align: justify;line-height: 2;">
             <p> Dear UM Students,  </p>
			 <p> I am a final year student from the Department of Software Engineering, Faculty of Computer Science & Information Technology, University of Malaya. Currently, I am working on a research project under the supervision of Associate Prof. Dr. Ow Siew Hock, for my final year project. The title of my project is: &lsquo;Assessing Higher Order Thinking Skills (HOTS) and Academic Performance of University Students&rsquo;. I would like to invite you to participate in this study by answering the HOTS assessment questions which will take <b>45 to 50 minutes</b>.
				<br>The data collected will be kept confidential. No personal details of individuals such as name will be revealed, and all data in the final project report will only be group data. Raw data for this study will be collected primarily through a simple assessment of HOTS which consists of <b>TWO (2)</b> sections. It is hoped that the findings of the study will help the university students to know their level of HOTS. 
				<br>Your participation in this study is entirely voluntary. You may choose to discontinue your participation in this study at any time during the data collection phase. If you agree to participate fully, however, kindly tick (&check;) the box in the consent section before answering the HOTS assessment questions. 
				<br>Feel free to contact us if you need more clarification. We can be contacted via email as follows: 
				<p>
				<p>
				Associate Professor Dr. Ow Siew Hock (Supervisor)<br>
				Email	: show@um.edu.my<br>
				
				Wong Vee Yuan (Final year project student)<br>
				Email	: veeyuan_0307@siswa.um.edu.my

              </p>
             <div class="form-check">
                					       
				<input style="margin-top:10px;"onclick="changeSelected()" class="form-check-input" type="checkbox" value="" id="defaultCheck1">
				<label class="form-check-label" for="defaultCheck1">
				I agree to participate in the HOTS assessment study entitled &lsquo;Assessing Higher Order Thinking Skills (HOTS) and Academic Performance of University Students&rsquo;.
				</label>
			</div>	
			</div>			     
             </form:form>
             </div>
             <div class="card-footer clearfix">
                <button onclick="submitConsent()" class="btn btn-info float-right"><i id="btn-icon" class="fas fa-check"></i> Submit Consent Form</button>             
              </div>
	          <%}} %>  
	          
	          <%if (user.isCompleteSurvey()||!user.isJoinSurvey()){ %>
             <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  Test Specification
                </h3>
               
              </div>
              <!-- /.card-header -->
             
              <div class="card-body">
             <form:form id="testSpecForm" action ="processTestSpec.html"  method="post" modelAttribute="user" >
             <input type="hidden" id="userid" value="${user.id}"> 
             <input type="hidden" id="enableEdit" value="no"> 
              <div class="form-row">					  
	  				  <div class="form-group col-md-3">
	  				  <label >Discipline</label>
	  				  	 <input type="hidden" id="discipline" value="${user.disciplineCd}">  
	                     <form:select path="disciplineCd" id="disciplineCd" class="form-control" >
	                       <c:forEach items="${listDiscipline}" var="discipline">
					      	  <form:option value ="${discipline.code}" label="${discipline.name}" />
				              </c:forEach>
	                       </form:select>
	                   </div>
	                   
	               
	                <div class="form-group col-md-3">
					      <label >Suitable Category</label>
					      <input type="hidden" id="category" value="${user.categoryCd}"> 
					      <form:select path="categoryCd" id="categoryCd" class="form-control" >
					      	<c:forEach items="${listCategory}" var="category">
					      	  <form:option value ="${category.code}" label="${category.name}" />
				              </c:forEach>
	                       </form:select>
					  </div>
					 <div class="form-group col-md-2">
					  <label >Language</label>
	  				  	 <input type="hidden" id="language" value="${user.languageCd}">  
	                     <form:select path="languageCd" id="languageCd" class="form-control" >
	                       <c:forEach items="${listLanguage}" var="language">
					      	  <form:option value ="${language.code}" label="${language.name}" />
				              </c:forEach>
	                       </form:select>
	                   </div>
					  
					 </div>
               </form:form>   
             
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
              <%if (user.isReadyToTakeTest()){ %>
                <button  id="btn-submit-spec"  onclick="submitChange()" type="button" class="btn btn-info float-right"><i class="fas fa-check"></i> Submit Change</button>  
               <%}else{ %>
                 <button  id="btn-submit-spec"  onclick="submitChange()" type="button" class="btn btn-info float-right"><i class="fas fa-check"></i> Submit </button>                
               <%} %>
              </div>
            </div>
            <%} %>     
				 
            <!-- /.card -->
            </section>
            
           
</body>    
</html>    