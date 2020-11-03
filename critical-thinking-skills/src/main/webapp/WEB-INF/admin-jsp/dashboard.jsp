<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>    
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
   
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
	background-color: transparent;
    color: #6c757d;
}

#dashboardLink{
    background-color: #FED136;
    color: #fff;
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
#instruction{
	line-height: 2.5;
}

a {
  color: inherit; /* blue colors for links too */
  text-decoration: inherit; /* no underline */
}

</style>

<script>
window.onload = function() {
	
	var dps = [[]];
	var chart = new CanvasJS.Chart("chartContainer", {
		exportEnabled: true,
		animationEnabled: true,
		theme: "light2", // "light1", "dark1", "dark2"
		title: {
			text: ""
		},
		subtitles: [{
			text: ""
		}],
		data: [{
			type: "pie",
			yValueFormatString: "#,##0\"%\"",
			indexLabel: "{label} - {y}",
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
				y : yValue,
			});
		</c:forEach>
	</c:forEach>
	 
	chart.render();
	
	var dps2 = [[]];
	var chart2 = new CanvasJS.Chart("chartContainer2", {
		exportEnabled: true,
		animationEnabled: true,
		theme: "light2", // "light1", "dark1", "dark2"
		title: {
			text: ""
		},
		subtitles: [{
			text: ""
		}],
		data: [{
			type: "pie",
			yValueFormatString: "#,##0\"%\"",
			indexLabel: "{label2} - {y2}",
			dataPoints: dps2[0]
		}]
	});
	 
	var yValue2;
	var label2;
	
	<c:forEach items="${dataPointsList2}" var="dataPoints" varStatus="loop">
	<c:forEach items="${dataPoints}" var="dataPoint">
		yValue2 = parseFloat("${dataPoint.y}");
		label2 = "${dataPoint.label}";
		dps2[parseInt("${loop.index}")].push({
			label : label2,
			y : yValue2,
		});
	</c:forEach>
	</c:forEach>
	 
	chart2.render();
	
	 
	}

</script>  
</head>    
<body>    
 <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 id="title" class="m-0 text-dark">Dashboard</h1>
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
                  Submission Status
                </h3>
                </div>
                                   
				   
				    <div class="card-body">
				    <div style="height: 300px; width: 48%;float:right;">
				    <p id="instruction">There are ${totalSubmissionNum} submissions where:<br>
				    ${gradedSubmissionNum} submission(s) has been graded by the admin<br>
				    ${closeSubmissionNum} test-taker(s) has completed the test, but the results has not been graded by admins yet<br>				    
				    ${openSubmissionNum} test-taker(s) has started the test, but have not completed all the sections yet.
				    </p>
				    </div>
				    <div id="chartContainer" style="height: 300px; width: 50%;float:left;"></div>
					<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
				    </div>
				    
				    
				    </div>
				    </div>
				 <div class="card">
	              <div class="card-header">
	                <h3 class="card-title">
	                  <i class="ion ion-clipboard mr-1"></i>
	                  Completed Submission Group By Faculty
	                </h3>
	                </div>
	                <div class="card-body">
				    <div style="height: 300px; width: 48%;float:right;">
				    <p id="instruction">There are ${totalCompletedSubmissionNum} submissions completed by test-takers where:<br>
				     <c:forEach items="${listFacSubmission}" var="fac" varStatus="status">	
				     ${fac.amount} submission(s) from ${fac.facultyDscp}<br>
				     </c:forEach>
				    </p>
				    </div>
				    <div id="chartContainer2" style="height: 300px; width: 50%;float:left;"></div>
				   </div>
              </div>
               <div class="card">
	              <div class="card-header">
	                <h3 class="card-title">
	                  <i class="ion ion-clipboard mr-1"></i>
	                  Download Survey Data
	                </h3>
	                </div>
	                <div class="card-body">
	                <p id="instruction">You may download <b>${reportName}</b> for data analysis in SPSS.</p>
	                </div>
              <div class="card-footer clearfix">
               </a><button id="btn-addquestionset" type="submit" class="btn btn-info float-right"> <a href="downloadData.html"><i class="fas fa-download"></i> Download</a></button>
              </div>
               </div>
            </div>
            <!-- /.card -->
            </section>  
</body>    
</html>    