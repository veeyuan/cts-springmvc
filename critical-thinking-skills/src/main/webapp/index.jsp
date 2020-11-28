<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.cts.ind.DictionaryManager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>HOTS Assessment</title>
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.12.1/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/index.css" rel="stylesheet" />
    </head>
    
    <%
    DictionaryManager dictionaryManager = new DictionaryManager();
    int langCd=dictionaryManager.getLanguageCd("English");

    String langDscp =  "ENG";
    if ("BM".equals(request.getParameter("language"))){
    	langCd=dictionaryManager.getLanguageCd("Bahasa Melayu");;
    	langDscp ="BM";
    }
   
    %>
    <script>
    function changeLang(lang){
    	document.getElementById("language").value=lang;
    	document.getElementById('langForm').submit(); 
	   }
    
    function setInit(){
    	var registerStatus = getUrlVars()["register"];
    	if(registerStatus=='success'){
    		alert("Successfully registered! Please proceed to login.")
    	}
    	if (registerStatus=='fail'){
    		alert("Failed to register. Please try again.")
    	}

    	var loginStatus = getUrlVars()["login"];
    	if (loginStatus=='fail'){
    		alert("Invalid login details. Please try again.")
    	}
		
	}
    function getUrlVars() {
        var vars = {};
        var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
            vars[key] = value;
        });
        return vars;
    }
	function addLoadEvent(func) { 
		var oldonload = window.onload; 
		if (typeof window.onload != 'function') { 
			window.onload = func; 
		} else { 
			window.onload = function() { 
				if (oldonload) { 
					oldonload(); 
				} 
				func(); 
			} 
		} 
	} 

	addLoadEvent(setInit); 
    
    </script>
    
    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <!-- <a class="navbar-brand js-scroll-trigger" href="#page-top"><img src="assets/img/index/idea-icon.png" /></a> --><button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">Menu<i class="fas fa-bars ml-1"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ml-auto">
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#portfolio"><%=dictionaryManager.getTerm("index.constructs.title",langCd) %></a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#about"><%=dictionaryManager.getTerm("index.nav.importance",langCd) %></a></li>
                      <li class="nav-item"><a class="nav-link portfolio-link" data-toggle="modal" href="#registerModal">Register / Login</a></li>
                        <li class="nav-item">
                        	<div class="dropdown">
							  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img class="global" src="assets/img/index/global-icon-lang.png" /> <%=langDscp %></button>
							  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
							    <button  onclick="changeLang('ENG')" class="dropdown-item" href="#">English</button>
<!-- 							    <button  onclick="changeLang('BM')" class="dropdown-item" href="#">Bahasa Melayu</button>
 -->							  </div>
							  <form id="langForm" method="post" action="/critical-thinking-skills/"><input type="hidden" name="language" id="language"></form>
							</div> 
						</li>
                    </ul>
                </div>
            </div>
        </nav>

        <header class="masthead">
            <div class="container">
                 <div class="masthead-subheading"><span style="background-color: #fed136 ">Assess your thinking critically!</span></div>
<%--                  <div class="masthead-heading text-uppercase"><%=dictionaryManager.getTerm("index.main.cts.title",langCd) %></div>
 --%>                 <div class="masthead-heading text-uppercase"><span style="background-color: #fed136 ">High Order Thinking Skills (HOTS) </span></div>
                <a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger" href="#portfolio"><%=dictionaryManager.getTerm("index.main.cts.tellmemore",langCd) %></a>
            </div>
        </header>
      
        <!-- Assessment Constructs-->
        <section class="page-section bg-light" id="portfolio">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase"><%=dictionaryManager.getTerm("index.constructs.title",langCd) %></h2>
                    <h3 class="section-subheading text-muted">Mapping of Main Components of HOTS with Critical Thinking Skills (CTS)</h3>
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal1"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"></div>
                                </div>
                                <img class="img-fluid-constructs" src="assets/img/index/analysis.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=dictionaryManager.getTerm("index.constructs.ana.title",langCd) %></div>
                             <!--    <div class="portfolio-caption-subheading text-muted">Illustration</div> -->
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal2"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"></div>
                                </div>
                                <img class="img-fluid-constructs" src="assets/img/index/sudoku.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=dictionaryManager.getTerm("index.constructs.log.title",langCd) %></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal3"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"></div>
                                </div>
                                <img class="img-fluid-constructs" src="assets/img/index/judgement.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=dictionaryManager.getTerm("index.constructs.judgement.title",langCd) %></div>
                            </div>
                        </div>
                    </div>
                   
                    <div class="col-lg-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal4"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"></div>
                                </div>
                                <img class="img-fluid-constructs" src="assets/img/index/solution.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=dictionaryManager.getTerm("index.constructs.probsolve.title",langCd) %></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 mb-sm-0">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal5"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"></div>
                                </div>
                                <img class="img-fluid-constructs" src="assets/img/index/explore.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading"><%=dictionaryManager.getTerm("index.constructs.creative.title",langCd) %></div>
                            </div>
                        </div>
                    </div>
                   
            </div>
        </section>
        <!-- About-->
        <section class="page-section" id="about">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">IMPORTANCE OF HOTS</h2>
                    <h3 class="section-subheading text-muted">HOTS is important to different life stages.</h3>
                </div>
                <ul class="timeline">
                
                     <li>
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="assets/img/index/child.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                            <h6><%=dictionaryManager.getTerm("index.importance.constructivism.subtitle",langCd) %></h6>
                                 <h4 class="subheading"><%=dictionaryManager.getTerm("index.importance.constructivism",langCd) %></h4>
                            </div>
                            <div class="timeline-body">
                            <p class="text-muted"><%=dictionaryManager.getTerm("index.importance.constructivism.dscp",langCd) %></p>
                            <p class="text-muted" style="font-size: 10px;text-align: justify;">Reference: Flores, K. L., Matkin, G. S., Burbach, M. E., Quinn, C. E., & Harding, H. (2012). 
                            <cite>Deficient critical thinking skills among college graduates: Implications for leadership.</cite> Educational Philosophy and Theory, 44(2), 212-230.
                            </p></div>
                        </div>
                    </li>
                    
                    <li class="timeline-inverted">
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="assets/img/index/exam.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                               <h6><%=dictionaryManager.getTerm("index.importance.academic.subtitle",langCd) %></h6>
                               <h4 class="subheading"><%=dictionaryManager.getTerm("index.importance.academic",langCd) %></h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted">
							HOTS gives one the right direction in thinking and helps in determining the relevance of something with others more accurately. It also helps identify own weaknesses and ways to improve themselves.

                            </p>
                            <p class="text-muted" style="font-size: 10px;text-align: justify;">Reference: Walid, A., Sajidan, S., Ramli, M., & Kusumah, R. G. T. (2019). <cite>Construction of the assessment concept to measure students' high order thinking skills.</cite> Journal for the Education of Gifted Young Scientists, 7(2), 237-251.</p></div>
                        </div>
                    </li>
                    
                    <li>
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="assets/img/index/grow.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                            <h6><%=dictionaryManager.getTerm("index.importance.maturity.subtitle",langCd) %></h6>
                                <h4 class="subheading"><%=dictionaryManager.getTerm("index.importance.maturity",langCd) %></h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted"><%=dictionaryManager.getTerm("index.importance.maturity.dscp",langCd) %>
                            </p>
                            <p class="text-muted" style="font-size: 10px;text-align: justify;">Reference: Flores, K. L., Matkin, G. S., Burbach, M. E., Quinn, C. E., & Harding, H. (2012). 
                            <cite>Deficient critical thinking skills among college graduates: Implications for leadership.</cite> Educational Philosophy and Theory, 44(2), 212-230.
                            </p> </div>
                        </div>
                    </li>
                    <li class="timeline-inverted">
                        <div class="timeline-image"><img class="rounded-circle img-fluid" src="assets/img/index/goal.jpg" alt="" /></div>
                        <div class="timeline-panel">
                            <div class="timeline-heading">
                                <h6><%=dictionaryManager.getTerm("index.importance.personalities.subtitle",langCd) %></h6> 
                                <h4 class="subheading"><%=dictionaryManager.getTerm("index.importance.personalities",langCd) %></h4>
                            </div>
                            <div class="timeline-body"><p class="text-muted"><%=dictionaryManager.getTerm("index.importance.personalities.dscp",langCd) %>
                            </p>
                            <p class="text-muted" style="font-size: 10px;text-align: justify;">Reference: Puolimatka, T. (1997). <cite>The problem of democratic values education.</cite> Journal of Philosophy of Education, 31(3), 461-476.
                            </p></div>
                        </div>
                    </li>
                    
                </ul>
            </div>
        </section>
        
      
        
        
        
   <!-- Portfolio Modals--><!-- Modal 1-->
        <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <h2 class="text-uppercase"><%=dictionaryManager.getTerm("index.constructs.ana.title",langCd) %></h2>
                                    <p class="item-intro text-muted"><%=dictionaryManager.getTerm("index.constructs.ana.subtitle",langCd) %></p>
                                    <p style="text-align: justify;"> <%=dictionaryManager.getTerm("index.constructs.ana.dscp",langCd) %></p>
                                    
                                    <p style="font-size: 13px;text-align: justify;">Reference:  Brookhart, S. M. (2010). <cite>How to assess higher-order thinking skills in your classroom.</cite> ASCD.</p>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
   <!-- Portfolio Modals--><!-- Modal 2-->
        <div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <h2 class="text-uppercase"><%=dictionaryManager.getTerm("index.constructs.log.title",langCd)%></h2>
                                    <p class="item-intro text-muted"><%=dictionaryManager.getTerm("index.constructs.log.subtitle",langCd) %></p>
                                    <p style="text-align: justify;"> <%=dictionaryManager.getTerm("index.constructs.log.dscp",langCd) %></p>
                                    <p style="font-size: 13px;text-align: justify;">Reference:  Brookhart, S. M. (2010). <cite>How to assess higher-order thinking skills in your classroom.</cite> ASCD.</p>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>   
        
  <!-- Portfolio Modals--><!-- Modal 3-->
        <div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <h2 class="text-uppercase"><%=dictionaryManager.getTerm("index.constructs.judgement.title",langCd)%></h2>
                                    <p class="item-intro text-muted"><%=dictionaryManager.getTerm("index.constructs.judgement.subtitle",langCd) %></p>
                                    <p style="text-align: justify;"> <%=dictionaryManager.getTerm("index.constructs.judgement.dscp",langCd) %></p>
                                    <p style="font-size: 13px;text-align: justify;">Reference:  Brookhart, S. M. (2010). <cite>How to assess higher-order thinking skills in your classroom.</cite> ASCD.</p>
								</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
   
   <!-- Portfolio Modals--><!-- Modal 4-->
        <div class="portfolio-modal modal fade" id="portfolioModal4" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <h2 class="text-uppercase"><%=dictionaryManager.getTerm("index.constructs.probsolve.title",langCd)%></h2>
                                    <p class="item-intro text-muted"><%=dictionaryManager.getTerm("index.constructs.probsolve.subtitle",langCd) %></p>
                                    <p style="text-align: justify;"> <%=dictionaryManager.getTerm("index.constructs.probsolve.dscp",langCd) %></p>
                                    <p style="font-size: 13px;text-align: justify;">Reference:  Brookhart, S. M. (2010). <cite>How to assess higher-order thinking skills in your classroom.</cite> ASCD.</p>
								</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
        
    <!-- Portfolio Modals--><!-- Modal 5-->
        <div class="portfolio-modal modal fade" id="portfolioModal5" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                    <div class="container" >
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body" >
                                    <h2 class="text-uppercase"><%=dictionaryManager.getTerm("index.constructs.creative.title",langCd)%></h2>
                                    <p class="item-intro text-muted"><%=dictionaryManager.getTerm("index.constructs.creative.subtitle",langCd) %></p>
                                    <p   style="text-align: justify;"> <%=dictionaryManager.getTerm("index.constructs.creative.dscp",langCd) %></p>
                                    <p style="font-size: 13px;text-align: justify;">Reference:  Brookhart, S. M. (2010). <cite>How to assess higher-order thinking skills in your classroom.</cite> ASCD.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
        
            <!-- Register-->
           
        <div class="portfolio-modal modal fade" id="registerModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="padding-top:40px;">
                    <div class="close-modal" data-dismiss="modal"><button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i></button></div>
                       <jsp:include page="/WEB-INF/jsp/register.jsp" />   
               </div>
            </div>
        </div>  
       
        
        <!-- Bootstrap core JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <!-- Third party plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        <!-- Contact form JS-->
        <script src="assets/mail/jqBootstrapValidation.js"></script>
        <script src="assets/mail/contact_me.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        
    </body>
</html>