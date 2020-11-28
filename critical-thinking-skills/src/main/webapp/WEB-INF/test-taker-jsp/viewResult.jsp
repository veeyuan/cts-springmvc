<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="com.cts.model.Submission" %>
<%@ page import="java.util.*" %>


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
	
     background-color: transparent;
    color: #6c757d;
}

#dashboardLink{
    background-color: transparent;
    color: #6c757d;
}

#viewRstLink{
  background-color: #FED136;
    color:#14171a;
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

* {box-sizing: border-box}

.container {
  width: 70%;
  background-color: #ddd;
}

.skills {
  text-align: right;
  padding-top: 10px;
  padding-bottom: 10px;
  color: white;
}


#instruction{
	line-height: 2.5;
}
</style>
<script>

function getQuestions(){
	document.getElementById('questionForm').submit();
} 

function setCd(){
	var discipline = document.getElementById("discipline").value;
	$('#disciplineCd').val(discipline).change();
	var category = document.getElementById("category").value;
	$('#categoryCd').val(category).change();
	var language = document.getElementById("language").value;
	$('#languageCd').val(language).change();
	}
	
 function loadChart() {
	 
	var dps = [[]];
	var chart = new CanvasJS.Chart("chartContainer", {
		theme: "light1", // "light1", "light2", "dark1"
		animationEnabled: true,
		title: {
			text: "Thinking Skills Analysis"
		},
		axisY: {
			title: "",
			includeZero: true,
			prefix: "",
			suffix: "",
			maximum: 100
		},
		data: [{
			type: "bar",
			yValueFormatString: "#,##0.0#\"%\"",
			indexLabel: "{y}",
			dataPoints: dps[0]
		}]
	});
	 
	var yValue;
	var label;
	 
	<c:forEach items="${dataPointsList}" var="dataPoints" varStatus="loop">	
		<c:forEach items="${dataPoints}" var="dataPoint">
			yValue = parseFloat("${dataPoint.y}");
			label = "${dataPoint.label}";
			dps[parseInt("${loop.index}")].push({
				label : label,
				y : yValue
			});		
		</c:forEach>	
	</c:forEach> 
	 
	chart.render();
	 
	}
addLoadEvent(loadChart); 
addLoadEvent(setCd);
   


</script> 
</head>  
<% Submission submission = (Submission)request.getAttribute("submission"); %>  
<body>   
 <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">View Result</h1>
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
	<%if (submission.isHasTakenTest()){ %>
		
           <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  View Result
                </h3>
               
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              <div class="form-row">
              	 <div class="form-group col-md-8">
				    <label >Full Name</label>
				    <input type="text" class="form-control" value="${submission.testTakerName}" readonly/>
				 </div>
				 
	               </div>
	               <div class="form-row">    
	                <div class="form-group col-md-3">
	  				  <label >Discipline</label>
	  				  	 <input type="hidden" id="discipline" value="${submission.disciplineCd}">  
	                     <select  id="disciplineCd" class="form-control" >
	                       <c:forEach items="${listDiscipline}" var="discipline">
					      	  <option value ="${discipline.code}" label="${discipline.name}" disabled=/>
				              </c:forEach>
	                       </select>
	                   </div>
	                <div class="form-group col-md-3">
					      <label >Suitable Category</label>
					      <input type="hidden" id="category" value="${submission.categoryCd}"> 
					      <select  id="categoryCd" class="form-control" >
					      	<c:forEach items="${listCategory}" var="category">
					      	  <option value ="${category.code}" label="${category.name}" disabled/>
				              </c:forEach>
	                       </select>
					  </div>
					 <div class="form-group col-md-2">
					      <label >Language</label>
					      <input type="hidden" id="language" value="${submission.languageCd}"> 
					      <select  id="languageCd" class="form-control" name="questionsetlang">
					      <c:forEach items="${listLanguage}" var="language">
					      	  <option value ="${language.code}" label="${language.name}" disabled/>
				              </c:forEach>
	                       </select>
					  </div> 
				 </div>
				  <div class="form-row">
				  <div class="form-group col-md-3">
				    <label >Submitted Date</label>
				    <input type="text" class="form-control" value="${submission.submitDt}" readonly/>
				 </div>
				 <div class="form-group col-md-2">
				    <label >Participated in Survey</label>
				    <%if (submission.isJoinSurvey()){ %>
				    <input type="text" class="form-control" value="Yes" readonly/>
				    <%}else{ %>
				    <input type="text" class="form-control" value="No" readonly/>
				    
				    <%} %>
				 </div>
				  </div> 
				  <br>
				  <br>
              	  
              		
					
					
						<div id="chartContainer" style="height: 450px; width: 80%; display: block; "></div>
						<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
              	<% Submission submissionDataList = (Submission)request.getAttribute("submissionRst");  
                 HashMap<String, Integer> scores = new HashMap<String, Integer>();
				scores.put("Analysis & Evaluation",submission.getScoresLst().get(0).getAnalysisScore());
				scores.put("Logical Thinking",submission.getScoresLst().get(0).getLogicScore());
				scores.put("Judgement",submission.getScoresLst().get(0).getJudgementScore());
				scores.put("Problem-solving",submission.getScoresLst().get(0).getProbSolveScore());
				scores.put("Creative Thinking",submission.getScoresLst().get(0).getCreativeScore());
				ArrayList<String> highest = new ArrayList<>();			
				int maxValueInMap=(Collections.max(scores.values()));  // This will return max value in the Hashmap
		        for (Map.Entry<String, Integer> entry : scores.entrySet()) {  // Itrate through hashmap
		            if (entry.getValue()==maxValueInMap) {
		            	highest.add(entry.getKey());
		            }
		        } 
				
		        ArrayList<String> lowest = new ArrayList<>();			
				int minValueInMap=(Collections.min(scores.values()));  // This will return max value in the Hashmap
		        for (Map.Entry<String, Integer> entry : scores.entrySet()) {  // Itrate through hashmap
		            if (entry.getValue()==minValueInMap) {
		            	lowest.add(entry.getKey());
		            }
		        }              	
                %>
                      <div style="margin-top: 70px;margin-left:50px;" class="form-row">    
	                <div class="form-group col-md-10">
	  				  <label >Comments</label><br>
	  				  <p id="instruction">
	  				   <% String improve = "You are encouraged to put more efforts to improve the thinking skills especially "+lowest.get(0); %>
	  				  
	  				  <%if (highest.size()==5){ %>
	  				  		Your thinking skills are developed averagely. Boost them to gain higher achievements.
	  				  <%}else{ %>
              		 <%=highest.get(0)%>
              		 <%for (int i =1;i<highest.size();i++){ %>
              			<% if (i==highest.size()-1){ %>
              			and <%= highest.get(i)%> 
              			<%}else{ %>
              		    , <%=highest.get(i)%>
              		 <%}}%>
              		 is/are your strength(s). Utilise the thinking skills will make you go further.
              		 <%for (int i =1;i<lowest.size();i++){ 
              		 	if (i==lowest.size()-1){              		 	
              		 		improve+=" and "+lowest.get(i);
						}else{ 
							improve+=", "+lowest.get(i);
						}
              		 }
              		 	improve+=".";%>
              		 <%} %>
              		 <br><%=improve%>
              		 
              		 </p>
              		 </div>
              		 </div>
              </div>
              <!-- /.card-body -->
               <div class="card-footer clearfix">
              	<button onclick="history.back(-1)"  class="btn btn-info float-right"><i id="btn-icon" class="fas fa fa-arrow-left"></i>Back</button>
               
              </div>
            </div>
            
	 <%}else{ %>   
	 <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                  View Results
                </h3>
               
              </div>
	  <div class="card-body">
	   <p id="instruction">You have not taken any test yet. Please go to <a href="takeTest.html">Take Test</a> to assess your critical thinking skills.<p>
              </div>
	 <%} %>                   
				 
            <!-- /.card -->
            </section>
            
           
</body>    
</html>    